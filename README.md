# Non-Character

Excellent! You're asking about expressing the Chinese character **三 (three)** formed from the sum of **一 (one)** and **二 (two)** using **sum types** (also known as discriminated unions or tagged unions). This is a perfect example of how 會意 (associative compound) characters work in 六書.

Here's how to express **一 + 二 = 三** using sum types in TypeScript:

```typescript
// three.ts - Expressing "一 + 二 = 三" using sum types

// Base types for character components
type Stroke = {
  kind: 'stroke';
  count: number;
  direction?: 'horizontal' | 'vertical' | 'diagonal';
};

// Sum type representing character composition
type CharacterComponent = 
  | { type: 'one'; value: 1; representation: '一' }
  | { type: 'two'; value: 2; representation: '二' }
  | { type: 'three'; value: 3; representation: '三' };

// The principle of 會意 (Huiyi) - Associative compounds
// Where meaning is derived from combining components
type HuiyiComposition = {
  principle: '会意';  // Associative compound
  components: [CharacterComponent, CharacterComponent];
  formula: string;    // e.g., "一 + 二 = 三"
  derivedMeaning: string;
};

// Alternative: Using sum types for binary operations
type BinaryComposition = 
  | { operation: 'add'; left: CharacterComponent; right: CharacterComponent; result: CharacterComponent }
  | { operation: 'stack'; bottom: CharacterComponent; top: CharacterComponent; result: CharacterComponent };

// The character 三 expressed as a sum of 一 and 二
const one: CharacterComponent = { type: 'one', value: 1, representation: '一' };
const two: CharacterComponent = { type: 'two', value: 2, representation: '二' };
const three: CharacterComponent = { type: 'three', value: 3, representation: '三' };

// Expressing the relationship using 會意 principle
const sanAsHuiyi: HuiyiComposition = {
  principle: '会意',
  components: [one, two],
  formula: '一 + 二 = 三',
  derivedMeaning: 'Three horizontal lines represent the number three (sum of one and two)'
};

// Using sum type for binary composition
const sanAsBinary: BinaryComposition = {
  operation: 'stack',
  bottom: one,
  top: two,
  result: three
};

// Advanced: Generic character type with sum type for formation principles
type LiushuPrinciple = 
  | { kind: '象形'; description: 'pictogram' }
  | { kind: '指事'; description: 'indicative' }
  | { kind: '会意'; composition: { left: CharacterComponent; right: CharacterComponent; logic: string } }
  | { kind: '形声'; semantic: CharacterComponent; phonetic: CharacterComponent }
  | { kind: '转注'; description: 'mutual explanatory' }
  | { kind: '假借'; description: 'phonetic loan' };

interface ChineseCharacter {
  glyph: string;
  pinyin: string;
  meaning: string;
  formation: LiushuPrinciple;
  components?: CharacterComponent[];
}

// Create character 三 using 會意 sum type
const characterSan: ChineseCharacter = {
  glyph: '三',
  pinyin: 'sān',
  meaning: 'three',
  formation: {
    kind: '会意',
    composition: {
      left: one,
      right: two,
      logic: 'Three horizontal lines: one line (一) plus two lines (二) equals three (三)'
    }
  },
  components: [one, two, three]
};

// Function to demonstrate the sum type relationship
function demonstrateSumComposition(char: ChineseCharacter): string {
  if (char.formation.kind === '会意') {
    const { left, right, logic } = char.formation.composition;
    return `${left.representation} (${left.type}) + ${right.representation} (${right.type}) = ${char.glyph} (${char.meaning})\nLogic: ${logic}`;
  }
  return `${char.glyph} is not an associative compound character`;
}

// Type-safe function using exhaustive matching
function getCharacterValue(component: CharacterComponent): number {
  switch (component.type) {
    case 'one': return 1;
    case 'two': return 2;
    case 'three': return 3;
    default: {
      const exhaustive: never = component;
      return exhaustive;
    }
  }
}

// Function to verify the sum relationship
function verifySum(left: CharacterComponent, right: CharacterComponent, result: CharacterComponent): boolean {
  const sum = getCharacterValue(left) + getCharacterValue(right);
  return sum === getCharacterValue(result);
}

// Mathematical representation using algebraic data types
type NumberRepresentation = 
  | { kind: '一'; value: 1 }
  | { kind: '二'; value: 2 }
  | { kind: '三'; value: 3 }
  | { kind: '四'; value: 4 }
  | { kind: '五'; value: 5 };

// Binary operation sum type
type Addition = {
  operand1: NumberRepresentation;
  operand2: NumberRepresentation;
  result: NumberRepresentation;
};

// Example: 一 + 二 = 三 as algebraic structure
const addition: Addition = {
  operand1: { kind: '一', value: 1 },
  operand2: { kind: '二', value: 2 },
  result: { kind: '三', value: 3 }
};

// Function to validate addition using pattern matching
function validateAddition(add: Addition): boolean {
  const getValue = (n: NumberRepresentation): number => {
    switch (n.kind) {
      case '一': return 1;
      case '二': return 2;
      case '三': return 3;
      case '四': return 4;
      case '五': return 5;
    }
  };
  
  return getValue(add.operand1) + getValue(add.operand2) === getValue(add.result);
}

// Main demonstration
function main(): void {
  console.log('=== 一 + 二 = 三: Sum Type Demonstration ===\n');
  
  // Basic sum type demonstration
  console.log('Character Components:');
  console.log(`  ${one.representation}: ${one.type} (value: ${getCharacterValue(one)})`);
  console.log(`  ${two.representation}: ${two.type} (value: ${getCharacterValue(two)})`);
  console.log(`  ${three.representation}: ${three.type} (value: ${getCharacterValue(three)})`);
  
  console.log('\n--- 會意 (Associative Compound) Principle ---');
  console.log(demonstrateSumComposition(characterSan));
  
  console.log('\n--- Mathematical Verification ---');
  const isValid = verifySum(one, two, three);
  console.log(`Does ${one.representation} + ${two.representation} = ${three.representation}? ${isValid}`);
  
  console.log('\n--- Algebraic Data Type Validation ---');
  console.log(`Addition validation: ${validateAddition(addition)}`);
  
  console.log('\n--- Pattern Matching on Sum Types ---');
  const compositions: BinaryComposition[] = [
    { operation: 'add', left: one, right: two, result: three },
    { operation: 'stack', bottom: one, top: two, result: three }
  ];
  
  compositions.forEach(comp => {
    switch (comp.operation) {
      case 'add':
        console.log(`Addition: ${comp.left.representation} + ${comp.right.representation} = ${comp.result.representation}`);
        break;
      case 'stack':
        console.log(`Stacking: ${comp.bottom.representation} stacked with ${comp.top.representation} gives ${comp.result.representation}`);
        break;
    }
  });
  
  // Demonstrating exhaustive checking
  console.log('\n--- Exhaustive Pattern Matching ---');
  function describeNumber(n: NumberRepresentation): string {
    switch (n.kind) {
      case '一': return 'one';
      case '二': return 'two';
      case '三': return 'three';
      case '四': return 'four';
      case '五': return 'five';
      // If we add a new case without handling it, TypeScript will error
    }
  }
  
  console.log(`三 is ${describeNumber({ kind: '三', value: 3 })}`);
}

main();

// Export types for reuse
export type { 
  CharacterComponent, 
  HuiyiComposition, 
  BinaryComposition, 
  LiushuPrinciple, 
  ChineseCharacter,
  NumberRepresentation,
  Addition
};
```

---

## Key Concepts Demonstrated

### 1. **Sum Type for Character Components**
```typescript
type CharacterComponent = 
  | { type: 'one'; value: 1; representation: '一' }
  | { type: 'two'; value: 2; representation: '二' }
  | { type: 'three'; value: 3; representation: '三' };
```
Each variant represents a distinct possibility.

### 2. **會意 as a Discriminated Union**
```typescript
type LiushuPrinciple = 
  | { kind: '会意'; composition: { left: ...; right: ...; logic: string } }
  | { kind: '象形'; description: string }
  // ...
```

### 3. **Binary Operation as Sum Type**
```typescript
type BinaryComposition = 
  | { operation: 'add'; left: ...; right: ...; result: ... }
  | { operation: 'stack'; bottom: ...; top: ...; result: ... }
```

### 4. **Exhaustive Checking with `never`**
```typescript
const exhaustive: never = component; // Ensures all cases handled
```

### 5. **Pattern Matching with Switch**
TypeScript's switch works with discriminated unions to provide type safety in each branch.

---

## The Philosophy: 會意 (Associative Compounds)

The character **三** perfectly illustrates the **會意** principle:
- **一** (one horizontal line) + **二** (two horizontal lines) = **三** (three horizontal lines)
- The meaning is derived from the **sum** of the components
- This is a literal example of **sum type** in both linguistics and programming

In type theory, this is analogous to:
- **Sum types** (discriminated unions) combine variants
- The character itself is the **sum** of its parts
- TypeScript's union types mirror this linguistic composition

This demonstrates how traditional Chinese philology (六書) and modern type theory (sum types) share the same foundational concept: **combining simpler elements to form more complex ones** with well-defined semantics.
