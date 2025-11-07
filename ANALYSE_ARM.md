# Analyse du code Rust compilé en ARM32

## Contexte
Code source Rust utilisant des enums avec pattern matching, compilé pour ARMv7 (32-bit) avec optimisations.

## Code assembleur généré (enum_example_export_opt.s)

```asm
value_in_cents:
    .fnstart
    lsl     r1, r0, #3          ; r1 = r0 << 3 (multiplie par 8)
    movw    r2, #1281           ; r2 = partie basse de la constante
    movt    r2, #6410           ; r2 = partie haute | 0x190A0501
    mov     r3, #1              ; r3 = 1 (valeur par défaut)
    cmp     r0, #4              ; Compare r0 avec 4
    lsrlo   r3, r2, r1          ; Si r0 < 4: r3 = r2 >> r1
    uxtb    r0, r3              ; Extrait le byte et retourne dans r0
    bx      lr                  ; Retourne à l'appelant
```

## Analyse détaillée

### 1. Convention d'appel ARM
- **r0**: Premier paramètre (coin_type) et valeur de retour
- **r1**: Second paramètre (state) - utilisé comme registre temporaire
- **r2, r3**: Registres de travail temporaires
- **lr**: Link register (adresse de retour)

### 2. La constante magique: 0x190A0501

Cette constante hexadécimale encode TOUTES les valeurs de retour possibles !

```
0x190A0501 en binaire par groupes de 8 bits:
00011001 00001010 00000101 00000001
   25       10        5        1
Quarter   Dime    Nickel   Penny
```

### 3. Algorithme optimisé

L'algorithme remplace tout le pattern matching par:

1. **Multiplication par 8** (lsl r1, r0, #3)
   - Convertit l'index de l'enum (0-3) en décalage de bits (0, 8, 16, 24)

2. **Chargement de la constante** (movw/movt)
   - ARM 32-bit nécessite deux instructions pour charger une constante 32-bit
   - movw: charge les 16 bits bas
   - movt: charge les 16 bits hauts

3. **Extraction de la valeur** (lsrlo r3, r2, r1)
   - Décale la constante de r1 bits vers la droite
   - Ne s'exécute que si r0 < 4 (condition "lo" = lower)
   - Extrait le bon octet selon le type de pièce

4. **Retour** (uxtb r0, r3)
   - uxtb = "unsigned extend byte"
   - Masque tous les bits sauf les 8 bits bas
   - Place le résultat dans r0 pour le retour

### 4. Exemples d'exécution

**Cas 1: Penny (coin_type = 0)**
```
r1 = 0 << 3 = 0
r3 = 0x190A0501 >> 0 = 0x190A0501
r0 = r3 & 0xFF = 0x01 = 1 ✓
```

**Cas 2: Nickel (coin_type = 1)**
```
r1 = 1 << 3 = 8
r3 = 0x190A0501 >> 8 = 0x00190A05
r0 = r3 & 0xFF = 0x05 = 5 ✓
```

**Cas 3: Dime (coin_type = 2)**
```
r1 = 2 << 3 = 16
r3 = 0x190A0501 >> 16 = 0x0000190A
r0 = r3 & 0xFF = 0x0A = 10 ✓
```

**Cas 4: Quarter (coin_type = 3)**
```
r1 = 3 << 3 = 24
r3 = 0x190A0501 >> 24 = 0x00000019
r0 = r3 & 0xFF = 0x19 = 25 ✓
```

**Cas 5: Valeur invalide (coin_type >= 4)**
```
cmp r0, #4 -> condition "lo" est fausse
lsrlo ne s'exécute PAS
r3 reste à 1 (valeur par défaut)
r0 = 1
```

## Performance

### Métriques
- **Taille**: 9 instructions ARM (36 octets)
- **Cycles**: ~6-7 cycles CPU
- **Branches**: 0 branchement inconditionnel (très bon pour le pipeline)

### Comparaison avec du C non optimisé
Un switch/case classique en C générerait typiquement:
- 15-20 instructions
- 3-4 branches conditionnelles
- Risque de "branch misprediction"

### Optimisations du compilateur Rust

Le compilateur Rust (LLVM) a appliqué plusieurs transformations:

1. **Jump table elimination**: Pas de table de saut mémoire
2. **Constant folding**: Toutes les valeurs dans une seule constante
3. **Branchless programming**: Utilisation de l'exécution conditionnelle ARM
4. **Dead code elimination**: Le paramètre 'state' n'est jamais utilisé car le code ne fait que retourner 25 pour Quarter

## Instructions ARM utilisées

- **lsl** (Logical Shift Left): Décalage à gauche
- **movw** (Move Wide): Charge 16 bits bas
- **movt** (Move Top): Charge 16 bits hauts
- **cmp** (Compare): Compare deux valeurs
- **lsrlo** (Logical Shift Right if Lower): Décalage conditionnel
- **uxtb** (Unsigned Extend Byte): Extension d'octet non signé
- **bx** (Branch and Exchange): Retour de fonction

## Conclusion

C'est un excellent exemple de la puissance des optimisations modernes :
- Le pattern matching Rust est transformé en lookup dans une constante
- Aucun branchement conditionnel (meilleur pour le pipeline CPU)
- Code très compact et cache-friendly
- Démonstration de "branchless programming"
