Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4783305E10
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580816; cv=none; b=KFpCgw+9T+pSOHaZjJZiDB0HsydLyneLR36Rbh48HYLvkvFL0OjUqRtt/0fEIdaBxshtpGz0Y85sORLNHeMh8OWhfDdOjRfUPutSeoKp+LWwLphm8whI615zpSdf24Ikc5WxxtmEDDUvyGyGZhW2xYs6O2oBYzWF48vzzirpSFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580816; c=relaxed/simple;
	bh=ocN550/VLv+O+BfqZpdudHpDqckAILcNvv3v8RqAZrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qXjrtvzBYwsvX+vGxeFGvA8T+hohCUhaTRNLkLeyBQ3+Mab2COI4YNyEhbYNxB59eeMtj0pVXQMU4bJcXV6VbC1AkoZIGwTIKdUWrKAwUWbdpN+JJ3eetN1fkDLV3h+ZuYsQQ9/EQVLHRBekZMSLryPs8+BXabndgMKdEx/LR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSkYcYW/; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSkYcYW/"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d001671a54so4252825ad.2
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 17:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786580814; x=1787185614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ov/Vpx89xx+37QG1bG7v8iJU4ZfOlg8N8RktsscspuE=;
        b=pSkYcYW/mjoT83TuoBEPQhj6F+nYD8Kq3WCWBxvfN0LeiSqUq5TonX93eZKoPZE6ii
         u/JGlMgasZARVcvc4/BvDSnabv8iHhLNg7pazfyqDUbJ74tlbR5RkBP/Djg02X7JErBv
         HlFWPobEbKd0LopmCk8UuWiuTD04huJVzk/kJDU6ycFtXGxTEbcOskVfNXFbD4wADqSm
         VXchUQuqayFl6PlVYVmcQdw+6HiqvQY/ypH/6Oy2IBJ0iMVsm5hPS8U2xpVmgtBGZBKF
         E94lI8ykNjEhoRnVy5hkzpbuMxw4JGsmU19P51zgtUjvzrD8ogynC9tb+q+vIQkp0HQ0
         qOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786580814; x=1787185614;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ov/Vpx89xx+37QG1bG7v8iJU4ZfOlg8N8RktsscspuE=;
        b=OJ+gWGUttiKMJ2USZv75yK+LLYhSUFA41ZEf1cHRylpmDnlGPA4ZBAlxtwvNRRtK59
         iDjMru28tSqGtU4HtxwMnOgVaGzkX/ri8id/0NnCdOE8OgU5UDxiPbqlSwkDxjafOJ+5
         aAAZdWWAe/0m8cpincfcIr8tX7ale/mutsi2SQPKbcTeGr4+fuvM4F7mohtcDA4mQEbj
         y1jfYc23mjUH4d2mEe1lQ7Fz/Fr1q5sNUZP84n5COqzS5zd9ZPi2VXSVF/wWUqtVW3Nx
         qY/CwXOBqCBhb7moz+tVePuOaVJ1RojMMVFiqdsYaucwJQf32QklSZWiDwnAC8xh1x0O
         I6SA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2s7TT5Roq+8Vgq8y7gwVMGqrpHxM5kDDplSTB4w+TPi/kJR/wyYnG2Wc7L7mTqk0ps2H9S6bS@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmyjZgbfCOC8rJ2wUrT1meRfyio2lNQ5RJ/pJEyEe3PJ1xZ6d
	fRe2ZndhQo+atRLwYdwT7x+yl7WOmaDG6Gx6Bdmy39Mev3P8nVaI3ApHb1Cqy9IOQZZu1NlL0yA
	mwA==
X-Received: from plhi8.prod.google.com ([2002:a17:903:2ec8:b0:2cf:7e98:1aee])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f544:b0:2d0:cc92:f7b8
 with SMTP id d9443c01a7336-2d37d53b01amr16781025ad.2.1786580814030; Wed, 12
 Aug 2026 17:26:54 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:26:18 +1000
In-Reply-To: <20260813002618.3755631-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813002618.3755631-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813002618.3755631-6-tweek@google.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: add loader_load_fd tests
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

Add user-space selftests for BPF_LOADER_LOAD_FD command. The test ELF is
generated based on the existing light skeleton generator. An awk script
extracts the loader program and map. In the future, it is possible to
add an extra option to `bpftool gen skeleton` to output the ELF file
directly.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 tools/testing/selftests/bpf/Makefile          |   8 +-
 tools/testing/selftests/bpf/loader_setup.sh   |  68 ++++
 .../selftests/bpf/prog_tests/loader_load_fd.c | 361 ++++++++++++++++++
 .../testing/selftests/bpf/progs/test_loader.c |  21 +
 4 files changed, 456 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/loader_setup.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/loader_load_fd.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_loader.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index d3655a706482..6d881584abbc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -525,7 +525,7 @@ LINKED_SKELS :=3D test_static_linked.skel.h linked_func=
s.skel.h		\
 LSKELS :=3D fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
 	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
-	test_ringbuf_overwrite.c
+	test_ringbuf_overwrite.c test_loader.c
=20
 LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics.c
=20
@@ -577,7 +577,8 @@ TRUNNER_EXTRA_OBJS :=3D $$(patsubst %.c,$$(TRUNNER_OUTP=
UT)/%.o,		\
 				 $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
 TRUNNER_LIB_OBJS :=3D $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
 				 $$(filter %.c,$(TRUNNER_LIB_SOURCES)))
-TRUNNER_EXTRA_HDRS :=3D $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
+TRUNNER_EXTRA_HDRS :=3D $$(filter %.h,$(TRUNNER_EXTRA_SOURCES)) $$(TRUNNER=
_OUTPUT)/test_loader_processed.lskel.h
+
 TRUNNER_TESTS_HDR :=3D $(TRUNNER_TESTS_DIR)/tests.h
 TRUNNER_BPF_SRCS :=3D $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
 TRUNNER_BPF_OBJS :=3D $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.bpf.o, $$(TRUNN=
ER_BPF_SRCS))
@@ -663,6 +664,9 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | =
$(TRUNNER_OUTPUT)
 	}) && \
 	rm -f $$(<:.o=3D.llinked1.o) $$(<:.o=3D.llinked2.o) $$(<:.o=3D.llinked3.o=
)
=20
+$$(TRUNNER_OUTPUT)/test_loader_processed.lskel.h: $$(TRUNNER_OUTPUT)/test_=
loader.lskel.h loader_setup.sh
+	$$(Q)./loader_setup.sh $$< $$@
+
 $(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OU=
TPUT)
 	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
 		$$(RM) $$@;						\
diff --git a/tools/testing/selftests/bpf/loader_setup.sh b/tools/testing/se=
lftests/bpf/loader_setup.sh
new file mode 100755
index 000000000000..f86651b0718f
--- /dev/null
+++ b/tools/testing/selftests/bpf/loader_setup.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Google LLC
+#
+# loader_setup.sh - Light skeleton data extraction helper for selftests/bp=
f
+#
+# This script parses an autogenerated light skeleton header (.lskel.h) pro=
duced
+# by bpftool ('bpftool gen skeleton -L'). It extracts the embedded loader =
data
+# ('opts_data') and loader BPF instructions ('opts_insn') string literals =
and
+# generates a C header file containing:
+#   - loader_test_opts_data[]: Data for the '__loader.map' section.
+#   - loader_test_opts_data_sz: Size of opts_data.
+#   - loader_test_opts_insn[]: Instructions for the '__loader.prog' sectio=
n.
+#   - loader_test_opts_insn_sz: Size of opts_insn.
+#
+# These extracted sections are used by the 'loader_load_fd' selftest to po=
pulate
+# an in-memory ELF object file for kernel 'BPF_LOADER_LOAD_FD' testing.
+#
+# Usage:
+#   loader_setup.sh <input_lskel.h> <output_data.h>
+
+INPUT=3D"$1"
+OUTPUT=3D"$2"
+
+if [ -z "$INPUT" ] || [ -z "$OUTPUT" ]; then
+	echo "Usage: $0 <input_lskel.h> <output_data.h>" >&2
+	exit 1
+fi
+
+awk -v input=3D"$INPUT" '
+BEGIN {
+	print "/* Generated from " input " */"
+	in_data =3D 0
+	in_insn =3D 0
+}
+/opts_data\[\]/ {
+	in_data =3D 1
+	sub(/^.*opts_data\[\][^=3D"]*=3D\s*"/, "")
+	printf "static const char test_loader_opts_data[] __attribute__((__aligne=
d__(8))) =3D \""
+}
+in_data {
+	if (index($0, "\";") > 0) {
+		sub(/";.*/, "")
+		print $0 "\";"
+		print "static const size_t test_loader_opts_data_sz =3D " \
+		      "sizeof(test_loader_opts_data) - 1;\n"
+		in_data =3D 0
+	} else {
+		print $0
+	}
+}
+/opts_insn\[\]/ {
+	in_insn =3D 1
+	sub(/^.*opts_insn\[\][^=3D"]*=3D\s*"/, "")
+	printf "static const char test_loader_opts_insn[] __attribute__((__aligne=
d__(8))) =3D \""
+}
+in_insn {
+	if (index($0, "\";") > 0) {
+		sub(/";.*/, "")
+		print $0 "\";"
+		print "static const size_t test_loader_opts_insn_sz =3D " \
+		      "sizeof(test_loader_opts_insn) - 1;"
+		in_insn =3D 0
+	} else {
+		print $0
+	}
+}
+' "$INPUT" > "$OUTPUT"
diff --git a/tools/testing/selftests/bpf/prog_tests/loader_load_fd.c b/tool=
s/testing/selftests/bpf/prog_tests/loader_load_fd.c
new file mode 100644
index 000000000000..ab971662dd04
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/loader_load_fd.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Google LLC */
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <libelf.h>
+#include <gelf.h>
+#include <linux/bpf.h>
+
+#include "bpf/skel_internal.h"
+#include "test_loader_processed.lskel.h"
+
+/* Test helper to create an in-memory ELF */
+static int create_loader_elf(const void *insns, size_t insns_sz,
+			     const void *map_data, size_t map_data_sz,
+			     const char *license, size_t license_sz,
+			     bool omit_prog, bool omit_map, bool omit_license)
+{
+	char shstrtab[] =3D "\0__loader.prog\0__loader.map\0license\0.shstrtab";
+	size_t prog_off =3D 1;
+	size_t map_off =3D prog_off + strlen("__loader.prog") + 1;
+	size_t lic_off =3D map_off + strlen("__loader.map") + 1;
+	size_t shstr_off =3D lic_off + strlen("license") + 1;
+	size_t shstrtab_sz =3D sizeof(shstrtab);
+	Elf_Data *shstr_data, *data;
+	Elf64_Shdr *shstr_shdr, *shdr;
+	Elf_Scn *shstr_scn, *scn;
+	Elf64_Ehdr *ehdr;
+	Elf *elf;
+	int fd;
+
+	fd =3D memfd_create("loader_elf", 0);
+	if (!ASSERT_GE(fd, 0, "memfd_create"))
+		return -1;
+
+	elf_version(EV_CURRENT);
+	elf =3D elf_begin(fd, ELF_C_WRITE, NULL);
+	if (!ASSERT_OK_PTR(elf, "elf_begin")) {
+		close(fd);
+		return -1;
+	}
+
+	ehdr =3D elf64_newehdr(elf);
+	if (!ASSERT_OK_PTR(ehdr, "elf64_newehdr"))
+		goto err;
+
+	ehdr->e_ident[EI_MAG0] =3D ELFMAG0;
+	ehdr->e_ident[EI_MAG1] =3D ELFMAG1;
+	ehdr->e_ident[EI_MAG2] =3D ELFMAG2;
+	ehdr->e_ident[EI_MAG3] =3D ELFMAG3;
+	ehdr->e_ident[EI_CLASS] =3D ELFCLASS64;
+	ehdr->e_ident[EI_DATA] =3D ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] =3D EV_CURRENT;
+	ehdr->e_machine =3D EM_BPF;
+	ehdr->e_type =3D ET_REL;
+	ehdr->e_version =3D EV_CURRENT;
+
+	shstr_scn =3D elf_newscn(elf);
+	shstr_shdr =3D elf64_getshdr(shstr_scn);
+	shstr_shdr->sh_name =3D shstr_off;
+	shstr_shdr->sh_type =3D SHT_STRTAB;
+	shstr_shdr->sh_flags =3D 0;
+
+	shstr_data =3D elf_newdata(shstr_scn);
+	shstr_data->d_buf =3D shstrtab;
+	shstr_data->d_size =3D shstrtab_sz;
+	shstr_data->d_type =3D ELF_T_BYTE;
+	shstr_data->d_align =3D 1;
+
+	ehdr->e_shstrndx =3D elf_ndxscn(shstr_scn);
+
+	if (!omit_prog && insns && insns_sz > 0) {
+		scn =3D elf_newscn(elf);
+		shdr =3D elf64_getshdr(scn);
+		shdr->sh_name =3D prog_off;
+		shdr->sh_type =3D SHT_PROGBITS;
+		shdr->sh_flags =3D SHF_ALLOC | SHF_EXECINSTR;
+
+		data =3D elf_newdata(scn);
+		data->d_buf =3D (void *)insns;
+		data->d_size =3D insns_sz;
+		data->d_type =3D ELF_T_BYTE;
+		data->d_align =3D 8;
+	}
+
+	if (!omit_map && map_data && map_data_sz > 0) {
+		scn =3D elf_newscn(elf);
+		shdr =3D elf64_getshdr(scn);
+		shdr->sh_name =3D map_off;
+		shdr->sh_type =3D SHT_PROGBITS;
+		shdr->sh_flags =3D SHF_ALLOC;
+
+		data =3D elf_newdata(scn);
+		data->d_buf =3D (void *)map_data;
+		data->d_size =3D map_data_sz;
+		data->d_type =3D ELF_T_BYTE;
+		data->d_align =3D 8;
+	}
+
+	if (!omit_license && license && license_sz > 0) {
+		scn =3D elf_newscn(elf);
+		shdr =3D elf64_getshdr(scn);
+		shdr->sh_name =3D lic_off;
+		shdr->sh_type =3D SHT_PROGBITS;
+		shdr->sh_flags =3D 0;
+
+		data =3D elf_newdata(scn);
+		data->d_buf =3D (void *)license;
+		data->d_size =3D license_sz;
+		data->d_type =3D ELF_T_BYTE;
+		data->d_align =3D 1;
+	}
+
+	if (elf_update(elf, ELF_C_WRITE) < 0)
+		goto err;
+
+	elf_end(elf);
+	lseek(fd, 0, SEEK_SET);
+	return fd;
+
+err:
+	elf_end(elf);
+	close(fd);
+	return -1;
+}
+
+static int sys_bpf_loader_load_fd(int loader_fd, void *ctx, __u32 ctx_size=
)
+{
+	union bpf_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.load_fd.loader_fd =3D loader_fd;
+	attr.load_fd.ctx =3D ptr_to_u64(ctx);
+	attr.load_fd.ctx_size =3D ctx_size;
+
+	return syscall(__NR_bpf, BPF_LOADER_LOAD_FD, &attr, sizeof(attr));
+}
+
+static void test_loader_load_fd_invalid_fd(void)
+{
+	struct bpf_loader_ctx ctx =3D {};
+	int err;
+
+	err =3D sys_bpf_loader_load_fd(-1, &ctx, sizeof(ctx));
+	ASSERT_EQ(err, -1, "invalid fd sys_bpf return");
+	ASSERT_EQ(errno, EINVAL, "invalid fd errno");
+}
+
+static void test_loader_load_fd_oversized_ctx(void)
+{
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	char map_data[] =3D "data";
+	char license[] =3D "GPL";
+	struct bpf_loader_ctx ctx =3D {};
+	int elf_fd, err;
+
+	elf_fd =3D create_loader_elf(insns, sizeof(insns),
+				   map_data, sizeof(map_data),
+				   license, sizeof(license),
+				   false, false, false);
+
+	if (!ASSERT_GE(elf_fd, 0, "create_loader_elf"))
+		return;
+
+	err =3D sys_bpf_loader_load_fd(elf_fd, &ctx, 65536U);
+	ASSERT_EQ(err, -1, "oversized ctx sys_bpf return");
+	ASSERT_EQ(errno, EINVAL, "oversized ctx errno");
+
+	close(elf_fd);
+}
+
+static void test_loader_load_fd_invalid_elf(void)
+{
+	char garbage[] =3D "not_an_elf_file_content";
+	struct bpf_loader_ctx ctx =3D {};
+	int fd, err;
+
+	fd =3D memfd_create("garbage_file", 0);
+	if (!ASSERT_GE(fd, 0, "memfd_create"))
+		return;
+
+	if (!ASSERT_EQ(write(fd, garbage, sizeof(garbage)), sizeof(garbage), "wri=
te garbage")) {
+		close(fd);
+		return;
+	}
+	lseek(fd, 0, SEEK_SET);
+
+	err =3D sys_bpf_loader_load_fd(fd, &ctx, sizeof(ctx));
+	ASSERT_EQ(err, -1, "invalid elf sys_bpf return");
+	ASSERT_EQ(errno, ENOEXEC, "invalid elf errno");
+
+	close(fd);
+}
+
+static void test_loader_load_fd_missing_prog_sec(void)
+{
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	char map_data[] =3D "data";
+	char license[] =3D "GPL";
+	struct bpf_loader_ctx ctx =3D {};
+	int elf_fd, err;
+
+	elf_fd =3D create_loader_elf(insns, sizeof(insns),
+				   map_data, sizeof(map_data),
+				   license, sizeof(license),
+				   true, false, false);
+	if (!ASSERT_GE(elf_fd, 0, "create_loader_elf"))
+		return;
+
+	err =3D sys_bpf_loader_load_fd(elf_fd, &ctx, sizeof(ctx));
+	ASSERT_EQ(err, -1, "missing prog sec sys_bpf return");
+	ASSERT_EQ(errno, EINVAL, "missing prog sec errno");
+
+	close(elf_fd);
+}
+
+static void test_loader_load_fd_missing_map_sec(void)
+{
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	char map_data[] =3D "data";
+	char license[] =3D "GPL";
+	struct bpf_loader_ctx ctx =3D {};
+	int elf_fd, err;
+
+	elf_fd =3D create_loader_elf(insns, sizeof(insns),
+				   map_data, sizeof(map_data),
+				   license, sizeof(license),
+				   false, true, false);
+	if (!ASSERT_GE(elf_fd, 0, "create_loader_elf"))
+		return;
+
+	err =3D sys_bpf_loader_load_fd(elf_fd, &ctx, sizeof(ctx));
+	ASSERT_EQ(err, -1, "missing map sec sys_bpf return");
+	ASSERT_EQ(errno, EINVAL, "missing map sec errno");
+
+	close(elf_fd);
+}
+
+static void test_loader_load_fd_missing_license_sec(void)
+{
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	char map_data[] =3D "data";
+	char license[] =3D "GPL";
+	struct bpf_loader_ctx ctx =3D {};
+	int elf_fd, err;
+
+	elf_fd =3D create_loader_elf(insns, sizeof(insns),
+				   map_data, sizeof(map_data),
+				   license, sizeof(license),
+				   false, false, true);
+	if (!ASSERT_GE(elf_fd, 0, "create_loader_elf"))
+		return;
+
+	err =3D sys_bpf_loader_load_fd(elf_fd, &ctx, sizeof(ctx));
+	ASSERT_EQ(err, -1, "missing license sec sys_bpf return");
+	ASSERT_EQ(errno, EINVAL, "missing license sec errno");
+
+	close(elf_fd);
+}
+
+static void test_loader_load_fd_loader_failure(void)
+{
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, -EPERM),
+		BPF_EXIT_INSN(),
+	};
+	char map_data[] =3D "data";
+	char license[] =3D "GPL";
+	struct bpf_loader_ctx ctx =3D {};
+	int elf_fd, err;
+
+	elf_fd =3D create_loader_elf(insns, sizeof(insns),
+				   map_data, sizeof(map_data),
+				   license, sizeof(license),
+				   false, false, false);
+	if (!ASSERT_GE(elf_fd, 0, "create_loader_elf"))
+		return;
+
+	err =3D sys_bpf_loader_load_fd(elf_fd, &ctx, sizeof(ctx));
+	ASSERT_EQ(err, -1, "loader failure sys_bpf return");
+	ASSERT_EQ(errno, EPERM, "loader failure errno");
+
+	close(elf_fd);
+}
+
+struct test_loader_lskel {
+	struct bpf_loader_ctx ctx;
+	struct {
+		struct bpf_map_desc test_map;
+	} maps;
+	struct {
+		struct bpf_prog_desc probe;
+	} progs;
+	struct {
+		int probe_fd;
+	} links;
+};
+
+static void test_loader_load_fd_lskel(void)
+{
+	struct test_loader_lskel skel =3D {};
+	int elf_fd, err;
+
+	skel.ctx.sz =3D (char *)&skel.links - (char *)&skel;
+
+	/* Build fake ELF using extracted opts_insn (__loader.prog) and opts_data=
 (__loader.map) */
+	elf_fd =3D create_loader_elf(test_loader_opts_insn, test_loader_opts_insn=
_sz,
+				   test_loader_opts_data, test_loader_opts_data_sz,
+				   "GPL", sizeof("GPL"),
+				   false, false, false);
+	if (!ASSERT_GE(elf_fd, 0, "create_loader_elf_lskel"))
+		return;
+
+	err =3D sys_bpf_loader_load_fd(elf_fd, &skel.ctx, skel.ctx.sz);
+	ASSERT_OK(err, "sys_bpf_loader_load_fd lskel");
+
+	ASSERT_GT(skel.progs.probe.prog_fd, 0, "test_loader probe prog_fd > 0");
+	ASSERT_GT(skel.maps.test_map.map_fd, 0, "test_loader test_map map_fd > 0"=
);
+
+	if (skel.progs.probe.prog_fd > 0)
+		close(skel.progs.probe.prog_fd);
+	if (skel.maps.test_map.map_fd > 0)
+		close(skel.maps.test_map.map_fd);
+	close(elf_fd);
+}
+
+void test_loader_load_fd(void)
+{
+	if (test__start_subtest("invalid_fd"))
+		test_loader_load_fd_invalid_fd();
+	if (test__start_subtest("oversized_ctx"))
+		test_loader_load_fd_oversized_ctx();
+	if (test__start_subtest("invalid_elf"))
+		test_loader_load_fd_invalid_elf();
+	if (test__start_subtest("missing_prog_sec"))
+		test_loader_load_fd_missing_prog_sec();
+	if (test__start_subtest("missing_map_sec"))
+		test_loader_load_fd_missing_map_sec();
+	if (test__start_subtest("missing_license_sec"))
+		test_loader_load_fd_missing_license_sec();
+	if (test__start_subtest("loader_failure"))
+		test_loader_load_fd_loader_failure();
+	if (test__start_subtest("lskel"))
+		test_loader_load_fd_lskel();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_loader.c b/tools/testin=
g/selftests/bpf/progs/test_loader.c
new file mode 100644
index 000000000000..515e15ca042e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_loader.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 4);
+	__type(key, __u32);
+	__type(value, __u64);
+} test_map SEC(".maps");
+
+SEC("socket")
+int probe(void *ctx)
+{
+	__u32 key =3D 0;
+	__u64 *val =3D bpf_map_lookup_elem(&test_map, &key);
+
+	return val ? (int)*val : 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.55.0.691.gc56d675ccc-goog

