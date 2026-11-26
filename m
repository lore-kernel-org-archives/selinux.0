Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663784;
	b=xXCS9iR6eCixUg/U1G6MjBmdo6AlCUaZrxn5HvGRaBeFjK5nqSY+kiU2MMKl4DkFb5VD
	 YcbpGG+VywMx/wOuPFzkKWm1j/jb7DxHZRxdF4Vla+1dN+t12kQZ7vTV2cmwsOVcM17bN
	 z8m339Ziw+qhJNwIPFCgT6Zat4f0jT6yersUHDQIJcIijRmYxB/cokw1JHULjmEuzLgW6
	 fKW7m6TXIqAGaXfkoxFLl2mnFUBG3BonATk3RIWgyPTRKArNdB7iSd2Wob8KrGbBqExT/
	 M9zYoMlgIiKrsd9jpOOlpZcjJ/6bQ3vCQxDd0ASn/lRQF+D3kCJfAiM9WV+N68SPTIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j7NqusiEFK6IUlUhXnJ16u/VJ0Y4iKcO8c2TbfNbZjc=;
	b=Fj4q+dPEUkLpwWAL6CCb1QyoUE0Ed9KzzMDx6d1uR/cm9bSO/6wzGVYYMRQ9wPHSmSIZ
	 2jyWzcPMEpc7nxj52k/VP9RC3ryMHkS3ui2U5hKg/xAuiwULuydxVLPx78ZkVvTz9iO76
	 JY3TZYhxruJqnED1XbmbKROxFP0mgNj2jQ7b6jzHZyOFKdSYqvZOha/2noNPQTinT5UV9
	 WGo5WoMojHGjdxwKr8dgv2BOjCY6iDXtQcvI4RQzzq1bg4OUzdP9IkwC3i1EW7JadnTAG
	 if4OF1S/OIIctWqhaKY/JIng3greU1eIWPt39SyxXE85lmH0EqWpgWgM9VPYm8nX+EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tweek.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FhFNDoX6;
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE8606A31E
	for <selinux@vger.kernel.org>; Thu, 26 Nov 2026 03:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11CE8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FhFNDoX6
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-451d80641efso6918298fac.2
        for <selinux@vger.kernel.org>; Wed, 25 Nov 2026 19:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795663783; x=1796268583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j7NqusiEFK6IUlUhXnJ16u/VJ0Y4iKcO8c2TbfNbZjc=;
        b=FhFNDoX6SmUa/Tr+js5GlODQFtrSKf97UZidFsxg+NQrMX0v5Nte7N6ZmYwcb9Xxi6
         +Oj4iIw/NFAakIhi23p5Nq92GIVj+iPnVAb2dipHPimNhZ4+AZw/F0pVtJFjC/SyLXJH
         nCL+2bLRGqrLmEIjWUqrBNINpl0jyYZuwrB5P8tbLoPoQRUAYzz3zuztQq68rs00q4/5
         fhsOHMzJr9+Vrdc1m0yJ0kpsBeMP5s9jqdMggjItFergKFRGWmpgV7AnsYyFCUMCwVXr
         TdYVWuvoUp4O5ARBT/njkN1d04/LJO96TED4IvxeLkCzdA8tuZmu1jI4VlgY+ZGbj9aY
         9TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663783; x=1796268583;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j7NqusiEFK6IUlUhXnJ16u/VJ0Y4iKcO8c2TbfNbZjc=;
        b=1AcLb2czv5ErnDo1jax0/P/y39haqfoQZ5qmh6dt1I+uUUiViFcTxtxY1UAg3VQeJn
         PgEzjIvfnWCSV5xmGEHCB6CJ7rBFM5+HIf+jMwb6a3MpUqZi4CGQ5Gh6btR0Njsn3Tpn
         3J1YKOvjQ0IHVYzwEyL61uRqYfyl6nUqVHBEfsFwJ/P3d21hNmp8jwH88wrFIAvm4w5Q
         AD9s6NNpoHA5IRGc7cRVsyD/cE6wVphPdcIuPJIaZXVXdrvq1cjEWvD9jyX5TkLFScuY
         wfP95ADrOvR9kbTDrkG/3LpUDuGi+RG3tg7Y6rBtz9s2jBVqGEFOdCI5eb204Rpw8of5
         t08w==
X-Gm-Message-State: APuU4Z+i0gh0fuWd0GQoDQhePIgXPk9YY42C8HpYeS3kJGjZWEtayJ6U
	tLHp5irGLKdEzUbiVuWAC3kIg21bjcNSnanLRYaf9gUqwY2ueRgsAzD5mzC0GcVxW6VlpNEk41C
	5BdYgd9jKjOL0njtwQc6P/3aO2vp6O3FXfs1VtDtmYVJH6N7VBL0t909OKEeBgrrzU0OzqEzuGR
	YNHFnG3AbF38rURtZu5dcs/fys14TMwNuj
X-Received: from oasv20-n2.prod.google.com ([2002:a05:6871:c654:20b0:4a6:98a5:8dea])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:50a7:b0:571:846e:6f06
 with SMTP id 5614622812f47-57a0a60f070mr22352532b6e.21.1795663782270; Wed, 25
 Nov 2026 19:29:42 -0800 (PST)
Date: Thu, 26 Nov 2026 14:29:21 +1100
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126032924.1868720-1-tweek@google.com>
Subject: [PATCH userspace 0/2] Fix and warn on negative-only type sets
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	"=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Inseob Kim <inseob@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series addresses two related issues with negative-only type sets
such as "{ -TYPE1 }" (and "~{ -TYPE1 }"): a semantic divergence between
libsepol's expansion and CIL conversion paths, and a silent pitfall for
policy authors.

1. Divergence between expand.c and module_to_cil.c
--------------------------------------------------

In SELinux policy language, "-" performs set subtraction from the
positive types listed in the same set, rather than set complement ("~").
Currently, libsepol's monolithic expansion path (expand.c) and CIL
conversion path (module_to_cil.c) disagree on how negative-only type
sets are evaluated:

- libsepol/src/expand.c:type_set_expand() computes (empty \ {TYPE1}) =3D
  empty, so the rule is a no-op.
- libsepol/src/module_to_cil.c:cil_print_attr_strs() omits the
  "(and ...)" wrapper when the positive set is empty and emits
  "(typeattributeset base_typeattr_1 (not (TYPE1 )))", treating
  "{ -TYPE1 }" as "~TYPE1" (all types except TYPE1).

Beyond causing monolithic checkpolicy and checkpolicy -C / semodule to
disagree on the same policy, this also undermines checkpolicy's ban on
complemented allow rules: checkpolicy rejects "allow ~TYPE1 ...", yet
accepts "allow { -TYPE1 } ...", which grants nothing under expand.c but
grants access to every type except TYPE1 when converted to CIL.

Two related edge cases in cil_print_attr_strs() also diverge from
expand.c: "~{ -TYPE1 }" emits "(not (not (TYPE1 )))" instead of "(all)",
and TYPE_STAR with a non-empty negset emits invalid "(all)(not (...))"
instead of "(not (...))".

2. Silent pitfall for policy authors
------------------------------------

Because "{ attr -foo }" is a common idiom in SELinux policy, authors
occasionally omit the positive set and write "{ -foo }" when they intend
the set complement "~foo" (all types other than foo).  This mistake is
easy to miss in code review and has surprising, silent consequences:

- Checkpolicy accepts "{ -foo }" without any warning or error.
- Under expand.c (and under CIL once patch 1 aligns the two paths),
  "{ -foo }" evaluates to the empty set.  In a neverallow rule (e.g.
  "neverallow { -domain } ..."), the assertion silently becomes a no-op
  and provides no protection, while still looking like a valid invariant
  to readers.
- Previously, the bug in module_to_cil.c masked the mistake whenever
  policies were checked through CIL, while monolithic checkpolicy (and
  tools built on expand.c) silently ignored the rule.
- Similarly, "~{ -foo }" silently expands to all types rather than foo.

Warning when a parsed type set has a non-empty negative set without any
positive types (and without "*") catches this mistake at compile time,
while leaving standard cases that legitimately expand to an empty set
(such as "{ empty_attr -foo }", "{ foo -foo }", or "{ -self }")
unaffected.

Series overview
---------------

1. libsepol: align module_to_cil type/role set handling with expand.c
   Updates cil_print_attr_strs() to match type_set_expand() and
   role_set_expand() for empty/negative-only, complemented empty, and
   star-with-negset sets, and adds CUnit regression tests.

2. checkpolicy: warn on negative-only type sets
   Emits a warning via yywarn() when a type set has no positive types
   (and no "*") alongside a non-empty negative set, with regression
   tests.  yywarn() is used rather than yyerror() to avoid breaking
   existing/frozen policies on upgrade while still failing builds that
   pass -E / --werror (happy to switch to yyerror() if preferred).

Tested with `make test` across libsepol, checkpolicy, and secilc under
gcc, clang, and gcc with ASan/UBSan, as well as `make check-format`.

Minimal reproducer (expand.c vs module_to_cil.c divergence)
-----------------------------------------------------------

Given the following 11-line policy (poc.conf):

    class CLASS1
    sid kernel
    class CLASS1 { PERM1 }
    type TYPE1;
    type TYPE2;
    allow TYPE2 self:CLASS1 PERM1;
    neverallow { -TYPE1 } self:CLASS1 PERM1;
    role ROLE1;
    role ROLE1 types { TYPE1 TYPE2 };
    user USER1 roles ROLE1;
    sid kernel USER1:ROLE1:TYPE1

Before this series, compiling directly with checkpolicy (expand.c)
succeeds silently because the neverallow expands to the empty set:

    $ checkpolicy -o policy_mono.bin poc.conf
    $ echo $?
    0

Converting to CIL and compiling with secilc (module_to_cil.c) fails the
neverallow assertion because module_to_cil emitted "(not (TYPE1 ))":

    $ checkpolicy -C -o poc.cil poc.conf && \
      secilc -M false -f /dev/null -o policy_cil.bin poc.cil
    neverallow check failed at poc.cil:30 from poc.conf:7
      (neverallow base_typeattr_1 self (CLASS1 (PERM1)))
        <root>
        allow at poc.cil:27
          (allow TYPE2 self (CLASS1 (PERM1)))

    Failed to generate binary
    Failed to build policydb
    $ echo $?
    255

Thi=C3=A9baud Weksteen (2):
  libsepol: align module_to_cil type/role set handling with expand.c
  checkpolicy: warn on negative-only type sets

 checkpolicy/Makefile                          |   1 +
 checkpolicy/policy_define.c                   |  24 ++
 checkpolicy/tests/test_negative_typeset.sh    | 245 ++++++++++++++++
 libsepol/src/module_to_cil.c                  |  69 +++--
 libsepol/tests/libsepol-tests.c               |   2 +
 .../test-module-to-cil/typeset-comp.conf      |  24 ++
 .../policies/test-module-to-cil/typeset.conf  |  34 +++
 libsepol/tests/test-module-to-cil.c           | 268 ++++++++++++++++++
 libsepol/tests/test-module-to-cil.h           |  10 +
 9 files changed, 653 insertions(+), 24 deletions(-)
 create mode 100644 checkpolicy/tests/test_negative_typeset.sh
 create mode 100644 libsepol/tests/policies/test-module-to-cil/typeset-comp=
.conf
 create mode 100644 libsepol/tests/policies/test-module-to-cil/typeset.conf
 create mode 100644 libsepol/tests/test-module-to-cil.c
 create mode 100644 libsepol/tests/test-module-to-cil.h

--=20
2.56.1.839.g22a8290db9-goog

