Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA673194C98
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580797; cv=none; b=GtVgNndJCzh1wXWIBqD2Ufprt7lRDCMpl1KUGOCYZmE2MpIR31eBUkQ3BcHSwshy8K1gkiioiF+8ZnD4da+5WH8A3bwKgywU+Mh3ucKce0PQrKEpz2PxMReou/X2dXUSia8UittFPeo6eiZDf508Yr1fS/ZLMjZdXdCmUbId7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580797; c=relaxed/simple;
	bh=qtqCBjefR6rwi0q7bGOqYffF8HYy+4dIgPVv2g7kYpY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jko4EmWXXTNyOuvlgxz0brjq9SpdbuEXNFBZDssTUarqVk4/cLLTQp0VPZMA6wWpthZpyqI7/mhCoY+TV7+3vyny8gwCTZnO1dAKzqF9l5y4GBy0Rz7uuJdzJBN3+WtyLuIj3P/qGR9tQq0qCwmqJKL6rl07jYPaVUNwWiG5qms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ad2bN+R9; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ad2bN+R9"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848568a6f62so2116941b3a.0
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 17:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786580794; x=1787185594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/dfZJNnftySUH8TsJJxhZ+pr3drILFQwEYZcgIGHVgc=;
        b=ad2bN+R9fkAh0sCv3TDgBJ+WNs7seKtAC9fMU/d4KGJvfi6vqre/jv7TEaP8b0RXLx
         mnoW90Xym8mLgDEaOkgVSAQ6464hXQgbGhP4c9ubsERvBeTbAipi+oDDyiHWjbtJ9M+4
         1mOss5aCrNtRQfxQritNV8D2t3KGMP51z7/HETYfGt7PgAHO5j7UvTJfpx8pnmZg8h0J
         ReRhQtBK3w7wQ52uzNv1JMKV6myJX6v3KGLFZaf9ymkSG7JTIBSoXnywlwgZUpdwaO7j
         xKomcYcdCNK+U2HbsyYCAPHt3G9395Q85t2Bzu7vVVGRMUB9htWl624G+hyl3RvT+eO/
         knZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786580794; x=1787185594;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/dfZJNnftySUH8TsJJxhZ+pr3drILFQwEYZcgIGHVgc=;
        b=Hd32rau4GHLoQf1PckVFRlMUPYLfFam0RrWRYwpGH0ndNQtbL9TLretB/e3I5vMc3g
         cO9IC3wFUI8mzgBO6uNyZxpHv7BmyhkHrBqbDf/fC9LesYB7qKMvkbpIpJjl/racnie5
         IIw3/8VnrVKPCFFvFLJc85a/1ChkwWb0dHTLv05369F0kHhYqzck7L5EYsb8qpvVTBzh
         rj5slvn0Cs33dqwirYzp+TJsd5qSSqCJHkTyjpjY9QxtWrOV9HoE+tg8f/uNbobxPFrM
         0I7tw8FONN0Bkzs4S24iomnoPVvJQsMtG8rC3MvG6vNxe3O/VEBTYRXGPjRYtFcxw8aD
         VTVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpaF+4aV7gIexNIHdgNCII9A4kTRncLbROwBltZkANuDn1Y+4dVOAe2zd0PibaItttAs7XB0Yhe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60qgO3irdCeC01wIQED5y/G0WsjDR5yXvI0I6pMk+cgaIt56t
	KBFhIqO2845a5pBqQ4WWg16rLtjIO31WSFvhzBEqS8pK8o60LtGe3PA6ZQ69TK4V+R0hF6wC4fR
	Kxw==
X-Received: from pfbhm22.prod.google.com ([2002:a05:6a00:6716:b0:847:881c:7027])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:408e:b0:845:ce5f:c926
 with SMTP id d2e1a72fcca58-84fc7492a05mr1951249b3a.1.1786580793920; Wed, 12
 Aug 2026 17:26:33 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:26:13 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813002618.3755631-1-tweek@google.com>
Subject: [PATCH bpf-next 0/5] bpf: Introduce LOADER_LOAD_FD
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jeffrey Vander Stoep <jeffv@google.com>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Eric Suen <ericsu@linux.microsoft.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Sid Nayyar <sidnayyar@google.com>, 
	Neill Kapron <nkapron@google.com>, Eric Biggers <ebiggers@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The bpf subsystem supports a signed-bpf infrastructure to guarantee the
authenticity of programs [1, 2]. While this infrastructure is ideal for
dynamic environments or enterprise deployments where untrusted binaries
are loaded post-boot, it introduces unnecessary complexity for static
platform use cases.

In the Android ecosystem, platform BPF programs reside exclusively on
read-only partitions that are strictly verified at the block level via
dm-verity. Because the kernel has already guaranteed the authenticity of
the underlying file, parsing and validating a secondary signature inside
the BPF subsystem is redundant, complex (because it requires X509 and
PKCS#7 parsing) and necessitates introducing additional signing flows
during build.

Furthermore, relying on signatures forces the kernel to manage a
dedicated public key keyring. In a decentralized ecosystem comprising
various OEMs and SoC vendors, managing these keys specifically for
infrastructure BPF programs presents an operational hurdle.

Thanks to light skeletons, it is possible to embed the loading steps
within a wrapping BPF program (also known as loader). In turns, the
loading of the loader only requires a limited, well-defined number of
steps. This series introduces the bpf command LOADER_LOAD_FD for the
kernel to directly load an ELF file which contains a loader with its
data. By moving the loading within the kernel, the authenticity of the
loader and its content can be guaranteed by existing kernel mechanisms.

Kernel Modules Precedent
------------------------

Verification of authenticity for kernel modules is supported through
multiple options. Deployments may implement PKCS#7 signature validation
or, alternatively, leverage the fact that finit_module(2) retrieves
module data via kernel_read_file().

Android utilizes this latter method for kernel module verification. By
integrating kernel_read_file() with LSM hooks, security policies can
ensure that any loaded module is sourced from a read-only partition
protected by dm-verity, and therefore trusted.

This patch series adopts a similar design for BPF by introducing the
READING_BPF_LOADER constant to the kernel_read_file() enumeration.

The availability of multiple verification paths for kernel modules
reflects the diverse requirements of different environments. Providing
analogous options for the BPF subsystem maintains consistency with this
established kernel precedent.

This proposal again?
--------------------

Similar approaches were proposed in the past [3, 4]. There are
differences that make this proposal worth sharing. Namely, the loading
relies on light skeletons for the heavy lifting. It means that the UAPI
exposed by the kernel is limited: one file descriptor of an ELF with 3
sections; and an opaque context. It also means that the processing done
by the kernel is limited: the majority of the code in this patchset is
doing basic ELF validation and calling the BPF interface that is already
exposed to the rest of the kernel (kern_sys_bpf).=20

Design
------

The BPF_LOADER_LOAD_FD command provides a method for the kernel to load
and set up BPF programs and maps directly from an ELF file, guaranteeing
the authenticity of the loaded objects.

It builds upon the light skeleton approach which transfers the loading
logic (i.e., CO-RE, BTF parsing, etc) to a wrapping BPF program (called
loader), generated by libbpf. By relying on these, it is possible to
drastically reduce the expectations on the kernel interface that needs
to be declared and supported.

When loading a light skeleton, libbpf performs 4 actions:
  1. Create a map array.
  2. Populate the map array with the light skeleton=E2=80=99s data.
  3. Load the light skeleton program.
  4. Execute the light skeleton program.
These exact same steps are implemented in LOADER_LOAD_FD.

This new command takes a file descriptor and a context. The file
descriptor is expected to refer to an ELF file which contains 3
sections: __loader.prog, __loader.map and license. These sections are
used as-is in the steps above. The context is passed directly to
BPF_PROG_TEST_RUN. In the current libbpf implementation, that context
contains the file descriptors to the programs and maps that have been
created by the loader (for further processing by userland, such as
pinning). This context is opaque to the kernel in BPF_LOADER_LOAD_FD.

Compared to previous approaches [3] and because this approach relies on
light skeletons, only basic processing is done by the kernel when
loading the programs. CO-RE or BTF are explicitly not supported as these
are handled by the light skeleton loader.

This series also includes the corresponding SELinux changes. Namely, a
new loader_load_fd permission is added to gate the use of the syscall.
It can be used to guarantee that any userspace caller migrates to this
new command instead of the existing BPF_PROG_LOAD. Another permission,
named bpf_load is added to the system class. This permission can be used
to restrict the file allowed to be loaded. Effectively, these
permissions can be used to guarantee that the kernel loads BPF programs
originating from known locations only.

Notes
-----

- There are some limited duplications of the ELF validation between this
  patchset and the existing kernel module loading logic. This can be
  refactored.
- ELF was picked as a container for the loader=E2=80=99s instructions and m=
ap.
  There are very few expectations on the ELF, it is mainly a container
  for these opaque bytes.

References
----------

[1] https://lore.kernel.org/bpf/20250921160120.9711-1-kpsingh@kernel.org/
[2] https://lore.kernel.org/bpf/20260708075343.358712-1-daniel@iogearbox.ne=
t/
[3] https://lore.kernel.org/bpf/20250109214617.485144-1-bboscaccy@linux.mic=
rosoft.com/
[4] https://bpfconf.ebpf.io/bpfconf2024/bpfconf2024_material/LSFMMBPF24_kap=
ron_verified_boot.pdf

Thi=C3=A9baud Weksteen (5):
  fs/kernel_read_file,selinux: Add BPF_LOADER constant
  bpf: Introduce BPF_LOADER_LOAD_FD command
  selinux: use kernel sid in security_bpf_*
  selinux: Add BPF_LOADER_LOAD_FD syscall permission
  selftests/bpf: add loader_load_fd tests

 include/linux/kernel_read_file.h              |   1 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/syscall.c                          | 341 ++++++++++++++++-
 security/selinux/hooks.c                      |  22 +-
 security/selinux/include/classmap.h           |   4 +-
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/Makefile          |   8 +-
 tools/testing/selftests/bpf/loader_setup.sh   |  68 ++++
 .../selftests/bpf/prog_tests/loader_load_fd.c | 361 ++++++++++++++++++
 .../testing/selftests/bpf/progs/test_loader.c |  21 +
 10 files changed, 824 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/loader_setup.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/loader_load_fd.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_loader.c

--=20
2.55.0.691.gc56d675ccc-goog

