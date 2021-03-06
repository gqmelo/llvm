; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=sse2 | FileCheck %s --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=avx2 | FileCheck %s --check-prefix=AVX2

; FIXME: Equality checks of 128/256-bit values can use PMOVMSK or PTEST to avoid scalarization.

define i32 @ne_i128(<2 x i64> %x, <2 x i64> %y) {
; SSE2-LABEL: ne_i128:
; SSE2:       # BB#0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[2,3,0,1]
; SSE2-NEXT:    movd %xmm2, %rax
; SSE2-NEXT:    movd %xmm0, %rcx
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE2-NEXT:    movd %xmm0, %rdx
; SSE2-NEXT:    movd %xmm1, %rsi
; SSE2-NEXT:    xorq %rcx, %rsi
; SSE2-NEXT:    xorq %rax, %rdx
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    orq %rsi, %rdx
; SSE2-NEXT:    setne %al
; SSE2-NEXT:    retq
;
; AVX2-LABEL: ne_i128:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    vpextrq $1, %xmm0, %rcx
; AVX2-NEXT:    vmovq %xmm1, %rdx
; AVX2-NEXT:    vpextrq $1, %xmm1, %rsi
; AVX2-NEXT:    xorq %rcx, %rsi
; AVX2-NEXT:    xorq %rax, %rdx
; AVX2-NEXT:    xorl %eax, %eax
; AVX2-NEXT:    orq %rsi, %rdx
; AVX2-NEXT:    setne %al
; AVX2-NEXT:    retq
  %bcx = bitcast <2 x i64> %x to i128
  %bcy = bitcast <2 x i64> %y to i128
  %cmp = icmp ne i128 %bcx, %bcy
  %zext = zext i1 %cmp to i32
  ret i32 %zext
}

define i32 @eq_i128(<2 x i64> %x, <2 x i64> %y) {
; SSE2-LABEL: eq_i128:
; SSE2:       # BB#0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[2,3,0,1]
; SSE2-NEXT:    movd %xmm2, %rax
; SSE2-NEXT:    movd %xmm0, %rcx
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE2-NEXT:    movd %xmm0, %rdx
; SSE2-NEXT:    movd %xmm1, %rsi
; SSE2-NEXT:    xorq %rcx, %rsi
; SSE2-NEXT:    xorq %rax, %rdx
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    orq %rsi, %rdx
; SSE2-NEXT:    sete %al
; SSE2-NEXT:    retq
;
; AVX2-LABEL: eq_i128:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    vpextrq $1, %xmm0, %rcx
; AVX2-NEXT:    vmovq %xmm1, %rdx
; AVX2-NEXT:    vpextrq $1, %xmm1, %rsi
; AVX2-NEXT:    xorq %rcx, %rsi
; AVX2-NEXT:    xorq %rax, %rdx
; AVX2-NEXT:    xorl %eax, %eax
; AVX2-NEXT:    orq %rsi, %rdx
; AVX2-NEXT:    sete %al
; AVX2-NEXT:    retq
  %bcx = bitcast <2 x i64> %x to i128
  %bcy = bitcast <2 x i64> %y to i128
  %cmp = icmp eq i128 %bcx, %bcy
  %zext = zext i1 %cmp to i32
  ret i32 %zext
}

define i32 @ne_i256(<4 x i64> %x, <4 x i64> %y) {
; SSE2-LABEL: ne_i256:
; SSE2:       # BB#0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm4 = xmm0[2,3,0,1]
; SSE2-NEXT:    movd %xmm4, %r8
; SSE2-NEXT:    pshufd {{.*#+}} xmm4 = xmm1[2,3,0,1]
; SSE2-NEXT:    movd %xmm4, %r9
; SSE2-NEXT:    movd %xmm0, %r10
; SSE2-NEXT:    movd %xmm1, %rsi
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[2,3,0,1]
; SSE2-NEXT:    movd %xmm0, %rdi
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm3[2,3,0,1]
; SSE2-NEXT:    movd %xmm0, %rax
; SSE2-NEXT:    movd %xmm2, %rcx
; SSE2-NEXT:    movd %xmm3, %rdx
; SSE2-NEXT:    xorq %rsi, %rdx
; SSE2-NEXT:    xorq %r10, %rcx
; SSE2-NEXT:    orq %rdx, %rcx
; SSE2-NEXT:    xorq %r9, %rax
; SSE2-NEXT:    xorq %r8, %rdi
; SSE2-NEXT:    orq %rax, %rdi
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    orq %rcx, %rdi
; SSE2-NEXT:    setne %al
; SSE2-NEXT:    retq
;
; AVX2-LABEL: ne_i256:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovq %xmm0, %r8
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm2
; AVX2-NEXT:    vmovq %xmm2, %r9
; AVX2-NEXT:    vpextrq $1, %xmm0, %r10
; AVX2-NEXT:    vpextrq $1, %xmm2, %rsi
; AVX2-NEXT:    vmovq %xmm1, %rdi
; AVX2-NEXT:    vextracti128 $1, %ymm1, %xmm0
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    vpextrq $1, %xmm1, %rcx
; AVX2-NEXT:    vpextrq $1, %xmm0, %rdx
; AVX2-NEXT:    xorq %rsi, %rdx
; AVX2-NEXT:    xorq %r10, %rcx
; AVX2-NEXT:    orq %rdx, %rcx
; AVX2-NEXT:    xorq %r9, %rax
; AVX2-NEXT:    xorq %r8, %rdi
; AVX2-NEXT:    orq %rax, %rdi
; AVX2-NEXT:    xorl %eax, %eax
; AVX2-NEXT:    orq %rcx, %rdi
; AVX2-NEXT:    setne %al
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
  %bcx = bitcast <4 x i64> %x to i256
  %bcy = bitcast <4 x i64> %y to i256
  %cmp = icmp ne i256 %bcx, %bcy
  %zext = zext i1 %cmp to i32
  ret i32 %zext
}

define i32 @eq_i256(<4 x i64> %x, <4 x i64> %y) {
; SSE2-LABEL: eq_i256:
; SSE2:       # BB#0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm4 = xmm0[2,3,0,1]
; SSE2-NEXT:    movd %xmm4, %r8
; SSE2-NEXT:    pshufd {{.*#+}} xmm4 = xmm1[2,3,0,1]
; SSE2-NEXT:    movd %xmm4, %r9
; SSE2-NEXT:    movd %xmm0, %r10
; SSE2-NEXT:    movd %xmm1, %rsi
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[2,3,0,1]
; SSE2-NEXT:    movd %xmm0, %rdi
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm3[2,3,0,1]
; SSE2-NEXT:    movd %xmm0, %rax
; SSE2-NEXT:    movd %xmm2, %rcx
; SSE2-NEXT:    movd %xmm3, %rdx
; SSE2-NEXT:    xorq %rsi, %rdx
; SSE2-NEXT:    xorq %r10, %rcx
; SSE2-NEXT:    orq %rdx, %rcx
; SSE2-NEXT:    xorq %r9, %rax
; SSE2-NEXT:    xorq %r8, %rdi
; SSE2-NEXT:    orq %rax, %rdi
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    orq %rcx, %rdi
; SSE2-NEXT:    sete %al
; SSE2-NEXT:    retq
;
; AVX2-LABEL: eq_i256:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovq %xmm0, %r8
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm2
; AVX2-NEXT:    vmovq %xmm2, %r9
; AVX2-NEXT:    vpextrq $1, %xmm0, %r10
; AVX2-NEXT:    vpextrq $1, %xmm2, %rsi
; AVX2-NEXT:    vmovq %xmm1, %rdi
; AVX2-NEXT:    vextracti128 $1, %ymm1, %xmm0
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    vpextrq $1, %xmm1, %rcx
; AVX2-NEXT:    vpextrq $1, %xmm0, %rdx
; AVX2-NEXT:    xorq %rsi, %rdx
; AVX2-NEXT:    xorq %r10, %rcx
; AVX2-NEXT:    orq %rdx, %rcx
; AVX2-NEXT:    xorq %r9, %rax
; AVX2-NEXT:    xorq %r8, %rdi
; AVX2-NEXT:    orq %rax, %rdi
; AVX2-NEXT:    xorl %eax, %eax
; AVX2-NEXT:    orq %rcx, %rdi
; AVX2-NEXT:    sete %al
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
  %bcx = bitcast <4 x i64> %x to i256
  %bcy = bitcast <4 x i64> %y to i256
  %cmp = icmp eq i256 %bcx, %bcy
  %zext = zext i1 %cmp to i32
  ret i32 %zext
}

