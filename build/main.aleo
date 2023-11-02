program tamagotchi.aleo;

struct Pet:
    secret_hash as field;
    hunger as u16;
    happiness as u16;
    health as u16;
    balance as u32;
    create_height as u32;
    feed_height as u32;


mapping pets:
	key as field.public;
	value as Pet.public;

function create:
    input r0 as scalar.private;
    input r1 as u32.private;
    hash.bhp1024 r0 into r2 as field;
    cast r2 8640u16 8640u16 8640u16 0u32 r1 r1 into r3 as Pet;
    async create r3 into r4;
    output r3 as Pet.private;
    output r4 as tamagotchi.aleo/create.future;

finalize create:
    input r0 as Pet.public;
    assert.eq r0.create_height block.height;
    contains pets[r0.secret_hash] into r1;
    assert.neq r1 true;
    set r0 into pets[r0.secret_hash];


function update:
    input r0 as scalar.private;
    async update r0 into r1;
    output r1 as tamagotchi.aleo/update.future;

finalize update:
    input r0 as scalar.public;
    hash.bhp1024 r0 into r1 as field;
    contains pets[r1] into r2;
    assert.eq r2 true;
    get pets[r1] into r3;
    sub block.height r3.feed_height into r4;
    cast r3.hunger into r5 as u32;
    gt r4 r5 into r6;
    cast r3.health into r7 as u32;
    gt r4 r7 into r8;
    cast r4 into r9 as u16;
    sub r9 r3.hunger into r10;
    sub r3.health r10 into r11;
    ternary r8 0u16 r11 into r12;
    cast r4 into r13 as u16;
    sub r3.hunger r13 into r14;
    ternary r6 0u16 r14 into r15;
    ternary r6 r12 r3.health into r16;
    sub r3.hunger r15 into r17;
    gt r17 r3.happiness into r18;
    sub r3.hunger r15 into r19;
    sub r3.happiness r19 into r20;
    ternary r18 0u16 r20 into r21;
    sub r3.health r16 into r22;
    mul r22 2u16 into r23;
    gt r23 r21 into r24;
    sub r3.health r16 into r25;
    mul r25 2u16 into r26;
    sub r21 r26 into r27;
    ternary r24 0u16 r27 into r28;
