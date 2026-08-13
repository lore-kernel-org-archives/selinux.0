Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB92E2663
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580806; cv=none; b=mH5Bc8TD7DJzGF+IgRDk82FNbU7dR6allJBdKlWhSi8Uj/EbhKBZQbNg5g2kYRgLJFw07WYtAsQtxszqo4P6MEC0Ui0+tXm7MCw06g4q6CfXvtGTBxL1W2q/Iszaoc8TbcXZVNgaar/S/+z5TCgNgHHrl/ULQFOpMMEVDmc6vSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580806; c=relaxed/simple;
	bh=9bxv8IEOD63iIg3rz+IGLTgoL3q6t205C7kkxVZBBvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mUs4Sdxbf6651B1MI++7xlACQ6+TmJKx6pmzm+mETxSKKSFYf6ErWBmXzetzcgO1m8Ug8Cvb7XzKTCJCknJHQTGp6zWuTLxEESuDa9SWdKinCqJPHbx7uZx2lOpJRWi0vcclJtLcohR3abQd8aCHhtSQ1752ekdT5UfD50Uq9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnPMVMKS; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnPMVMKS"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc640dfde3so21273695ad.1
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 17:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786580803; x=1787185603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cGhr1ahZhPKPx2jrgbs/gggrNdkMmSlAjSDp4bCUAbU=;
        b=jnPMVMKSihwH/IjyNiWmWz4SPkS/zCPPHjVhLyiiX8zbxrDvgAMEGJvy9dZbAMLKp/
         KeMOkA54E2BihNyzaZJ9WmnZM07gwKr80QmI0qfStJ7ijcHXRPL//EPAUvkN8nuKtfcu
         o9HB/GHawvT65qTxWNlzP3HAlElrwAQZew0q+u0vZr0/xzpXNPzs7B0EZCiYj6Lr4Zvq
         NK5G2kdsTt2xVZ8c/febJDS5bi14L8uax+g0XFn91joEIJiYUe9zy/Edxz9eGZHWeVms
         /h9XG9KGzJUZ03aJWHd0DpqO2JppG3VgOGelkkrTO3FBRWZHo1PR7yEeGxO+XT3ZT0yu
         VwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786580803; x=1787185603;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGhr1ahZhPKPx2jrgbs/gggrNdkMmSlAjSDp4bCUAbU=;
        b=mo42oR9JzdRUkbv2UdnMur/ulOURFx+OEu0aWlP287e14BlEmsmG6Mxtwi45xdmfWu
         XpMTxysc4cwMJrqS+wYnT4slrJ2+J3OTD+VyEfataQ25M5AgC842+JDRkfsxANUA+sMD
         tyaZi802Ap6xb7Qz7UwWu9eQFmjmaQAONSzqu7+mXnIVRVw8cRqCyTdPwgDJDE9kwMUx
         w2Zu25X5fxXfIMAIF/OZKaaz/BSyeQhTqw50kvHt8oFJSk1Cbj3QDgYuqMGj3ns1i8P2
         /GvoWYYsIhLqMOvv9OI3eY65axXOF0CwkNvur3Faxz0uYu+5LMerrsqe5/28kADRimut
         GFiw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3JrhFwphjADEADg5Sw+701BT7wTn2MP+pn1NrjLQrgAnn/a1jXjg/ZwzXvPQCOiwcCXxKFZGa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywna1NzNdw66xMUZrqxHkLVfTD9DZcuLm1iVwCA6bXG9X6MefpE
	IobkgxarxtSzjT23ifZWd297SPEMwiPzCGwzI2SQgzMuQ1zz+qRpUCP1OnQHiMsqItZyIr9mNrH
	/zw==
X-Received: from plge13.prod.google.com ([2002:a17:902:cf4d:b0:2ca:f1f8:ea00])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b88:b0:2cf:b68a:340
 with SMTP id d9443c01a7336-2d37d884c75mr20405535ad.10.1786580802730; Wed, 12
 Aug 2026 17:26:42 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:26:15 +1000
In-Reply-To: <20260813002618.3755631-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813002618.3755631-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813002618.3755631-3-tweek@google.com>
Subject: [PATCH bpf-next 2/5] bpf: Introduce BPF_LOADER_LOAD_FD command
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

Introduce the BPF_LOADER_LOAD_FD command to allow loading and executing
loader BPF programs directly from an ELF file.

This command implements the equivalent of bpf_load_and_run within the
kernel. More specifically, it implements the four steps:
  1. Create an array map
  2. Populate the array with the loader data
  3. Load the loader, using BPF_PROG_LOAD
  4. Execute the loader using BPF_PROG_TEST_RUN

BPF_LOADER_LOAD_FD takes 3 arguments, a file descriptor to an open ELF
which contains the instructions, data and license of the loader; a
context and its size which are passed to BPF_PROG_TEST_RUN.

The kernel validates the ELF file and extracts three sections:
  1. __loader.prog: Contains the loader instructions.
  2. __loader.map: Contains the loader data.
  3. license

The caller is expected to use libbpf's light skeleton generator. The
loader program is responsible for managing any maps or programs included
in the original BPF object. CO-RE and BTF are explicitly not supported
by the kernel here; they are handled by the loader directly.

BPF_LOADER_LOAD_FD returns the updated context to userspace. The kernel
treats this context as an opaque blob passed to BPF_PROG_TEST_RUN. For
the userspace loader, this context typically contains the file
descriptors of the newly created maps and programs.

ELF validation borrows logic from the kernel module ELF validation
in kernel/module/main.c.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 include/uapi/linux/bpf.h       |   7 +
 kernel/bpf/syscall.c           | 341 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |   7 +
 3 files changed, 348 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ffd96e8b920b..05b070a489fc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -993,6 +993,7 @@ enum bpf_cmd {
 	BPF_TOKEN_CREATE,
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
+	BPF_LOADER_LOAD_FD,
 	__MAX_BPF_CMD,
 	BPF_COMMON_ATTRS =3D 1 << 16, /* Indicate carrying syscall common attrs. =
*/
 };
@@ -1950,6 +1951,12 @@ union bpf_attr {
 		__u32		flags;
 	} prog_assoc_struct_ops;
=20
+	struct { /* struct used by BPF_LOADER_LOAD_FD command */
+		__u32           loader_fd;
+		__aligned_u64   ctx;
+		__u32           ctx_size;
+	} load_fd;
+
 } __attribute__((aligned(8)));
=20
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8d111da88655..d79cd63f9f7c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -41,6 +41,7 @@
 #include <linux/overflow.h>
 #include <linux/cookie.h>
 #include <linux/btf_ids.h>
+#include <linux/kernel_read_file.h>
=20
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -6291,6 +6292,336 @@ static int prog_assoc_struct_ops(union bpf_attr *at=
tr)
 	return ret;
 }
=20
+#define BPF_LOADER_PROG_SEC "__loader.prog"
+#define BPF_LOADER_MAP_SEC "__loader.map"
+#define BPF_LOADER_LICENSE_SEC "license"
+#define BPF_LOADER_MAX_SIZE (8U << 20) /* 8MB */
+
+struct elf_info {
+	Elf64_Ehdr *hdr;
+	unsigned long len;
+	Elf64_Shdr *sechdrs;
+	char *secstrings;
+};
+
+static int bpf_validate_section_offset(const struct elf_info *info, Elf64_=
Shdr *shdr)
+{
+	unsigned long long secend;
+
+	/*
+	 * Check for both overflow and offset/size being
+	 * too large.
+	 */
+	secend =3D shdr->sh_offset + shdr->sh_size;
+	if (secend < shdr->sh_offset || secend > info->len)
+		return -ENOEXEC;
+
+	return 0;
+}
+
+static int bpf_elf_validity_ehdr(const struct elf_info *info)
+{
+	if (info->len < sizeof(*(info->hdr))) {
+		pr_err("Invalid ELF header len %lu\n", info->len);
+		return -ENOEXEC;
+	}
+	if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) !=3D 0) {
+		pr_err("Invalid ELF header magic: !=3D %s\n", ELFMAG);
+		return -ENOEXEC;
+	}
+	if (info->hdr->e_ident[EI_CLASS] !=3D ELFCLASS64) {
+		pr_err("Only 64-bit ELF is supported\n");
+		return -ENOEXEC;
+	}
+	if (info->hdr->e_type !=3D ET_REL) {
+		pr_err("Invalid ELF header type: %u !=3D %u\n",
+		       info->hdr->e_type, ET_REL);
+		return -ENOEXEC;
+	}
+	if (info->hdr->e_machine !=3D EM_BPF) {
+		pr_err("Invalid ELF machine type: %u !=3D %u\n",
+		       info->hdr->e_machine, EM_BPF);
+		return -ENOEXEC;
+	}
+	return 0;
+}
+
+static int bpf_elf_validity_cache_sechdrs(struct elf_info *info)
+{
+	Elf64_Shdr *sechdrs;
+	Elf64_Shdr *shdr;
+	int i;
+	int err;
+
+	err =3D bpf_elf_validity_ehdr(info);
+	if (err < 0)
+		return err;
+
+	if (info->hdr->e_shentsize !=3D sizeof(Elf64_Shdr)) {
+		pr_err("Invalid ELF section header size\n");
+		return -ENOEXEC;
+	}
+
+	/*
+	 * e_shnum is 16 bits, and sizeof(Elf64_Shdr) is
+	 * known and small. So e_shnum * sizeof(Elf64_Shdr)
+	 * will not overflow unsigned long on any platform.
+	 */
+	if (info->hdr->e_shoff >=3D info->len
+	    || (info->hdr->e_shnum * sizeof(Elf64_Shdr) >
+		info->len - info->hdr->e_shoff)) {
+		pr_err("Invalid ELF section header overflow\n");
+		return -ENOEXEC;
+	}
+
+	sechdrs =3D (void *)info->hdr + info->hdr->e_shoff;
+
+	/*
+	 * The code assumes that section 0 has a length of zero and
+	 * an addr of zero, so check for it.
+	 */
+	if (sechdrs[0].sh_type !=3D SHT_NULL
+	    || sechdrs[0].sh_size !=3D 0
+	    || sechdrs[0].sh_addr !=3D 0) {
+		pr_err("ELF Spec violation: section 0 type(%d)!=3DSH_NULL or non-zero le=
n or addr\n",
+		       sechdrs[0].sh_type);
+		return -ENOEXEC;
+	}
+
+	/* Validate contents are inbounds */
+	for (i =3D 1; i < info->hdr->e_shnum; i++) {
+		shdr =3D &sechdrs[i];
+		switch (shdr->sh_type) {
+		case SHT_NULL:
+		case SHT_NOBITS:
+			/* No contents, offset/size don't mean anything */
+			continue;
+		default:
+			err =3D bpf_validate_section_offset(info, shdr);
+			if (err < 0) {
+				pr_err("Invalid ELF section in BPF loader (section %u type %u)\n",
+				       i, shdr->sh_type);
+				return err;
+			}
+		}
+	}
+
+	info->sechdrs =3D sechdrs;
+
+	return 0;
+}
+
+static int bpf_elf_validity_cache_secstrings(struct elf_info *info)
+{
+	Elf64_Shdr *strhdr, *shdr;
+	char *secstrings;
+	int i;
+
+	/*
+	 * Verify if the section name table index is valid.
+	 */
+	if (info->hdr->e_shstrndx =3D=3D SHN_UNDEF
+	    || info->hdr->e_shstrndx >=3D info->hdr->e_shnum) {
+		pr_err("Invalid ELF section name index: %d || e_shstrndx (%d) >=3D e_shn=
um (%d)\n",
+		       info->hdr->e_shstrndx, info->hdr->e_shstrndx,
+		       info->hdr->e_shnum);
+		return -ENOEXEC;
+	}
+
+	strhdr =3D &info->sechdrs[info->hdr->e_shstrndx];
+
+	if (strhdr->sh_type !=3D SHT_STRTAB) {
+		pr_err("Invalid ELF section name table type: %u\n", strhdr->sh_type);
+		return -ENOEXEC;
+	}
+
+	/*
+	 * The section name table must be NUL-terminated, as required
+	 * by the spec. This makes strcmp and pr_* calls that access
+	 * strings in the section safe.
+	 */
+	secstrings =3D (void *)info->hdr + strhdr->sh_offset;
+	if (strhdr->sh_size =3D=3D 0) {
+		pr_err("empty section name table\n");
+		return -ENOEXEC;
+	}
+	if (secstrings[strhdr->sh_size - 1] !=3D '\0') {
+		pr_err("ELF Spec violation: section name table isn't null terminated\n")=
;
+		return -ENOEXEC;
+	}
+
+	for (i =3D 0; i < info->hdr->e_shnum; i++) {
+		shdr =3D &info->sechdrs[i];
+		/* SHT_NULL means sh_name has an undefined value */
+		if (shdr->sh_type =3D=3D SHT_NULL)
+			continue;
+		if (shdr->sh_name >=3D strhdr->sh_size) {
+			pr_err("Invalid ELF section name in BPF loader (section %u type %u)\n",
+			       i, shdr->sh_type);
+			return -ENOEXEC;
+		}
+	}
+
+	info->secstrings =3D secstrings;
+	return 0;
+}
+
+static int find_elf_section(const struct elf_info *info,
+			       const char *sect_name, void **sect, int *sect_sz)
+{
+	Elf64_Shdr *shdr;
+
+	for (int i =3D 1; i < info->hdr->e_shnum; i++) {
+		shdr =3D &info->sechdrs[i];
+		if (shdr->sh_type =3D=3D SHT_NULL || shdr->sh_type =3D=3D SHT_NOBITS)
+			continue;
+		if (strcmp(sect_name, info->secstrings + shdr->sh_name) =3D=3D 0) {
+			*sect =3D (void *)info->hdr + shdr->sh_offset;
+			*sect_sz =3D shdr->sh_size;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/* To shut up -Wmissing-prototypes.
+ * This function is used by the kernel light skeleton
+ * to load bpf programs when modules are loaded or during kernel boot.
+ * See tools/lib/bpf/skel_internal.h
+ */
+int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
+
+#define BPF_LOADER_LOAD_FD_LAST_FIELD load_fd.ctx_size
+
+static int loader_load_fd(union bpf_attr *attr)
+{
+	void *buf =3D NULL, *insns =3D NULL, *data =3D NULL, *license =3D NULL;
+	void *kctx =3D NULL;
+	int len, err =3D 0;
+	int insns_sz =3D 0, data_sz =3D 0, license_sz =3D 0;
+	int map_fd, prog_fd;
+	size_t ctx_sz;
+	union bpf_attr sattr =3D { 0 };
+	unsigned int zero =3D 0;
+
+	if (!capable(CAP_BPF))
+		return -EPERM;
+
+	if (CHECK_ATTR(BPF_LOADER_LOAD_FD))
+		return -EINVAL;
+
+	if (attr->load_fd.ctx_size > U16_MAX)
+		return -EINVAL;
+
+	CLASS(fd, f)(attr->load_fd.loader_fd);
+	if (fd_empty(f))
+		return -EINVAL;
+
+	len =3D kernel_read_file(fd_file(f), 0, &buf, BPF_LOADER_MAX_SIZE, NULL,
+			       READING_BPF_LOADER);
+	if (len < 0) {
+		err =3D len;
+		goto out;
+	}
+
+	struct elf_info elf_info =3D {
+		.hdr =3D (Elf64_Ehdr *) buf,
+		.len =3D len,
+	};
+
+	err =3D bpf_elf_validity_cache_sechdrs(&elf_info);
+	if (err)
+		goto out_free_buf;
+
+	err =3D bpf_elf_validity_cache_secstrings(&elf_info);
+	if (err)
+		goto out_free_buf;
+
+	err =3D find_elf_section(&elf_info, BPF_LOADER_PROG_SEC, &insns, &insns_s=
z);
+	if (err)
+		goto out_free_buf;
+
+	err =3D find_elf_section(&elf_info, BPF_LOADER_MAP_SEC, &data, &data_sz);
+	if (err)
+		goto out_free_buf;
+
+	err =3D find_elf_section(&elf_info, BPF_LOADER_LICENSE_SEC, &license, &li=
cense_sz);
+	if (err)
+		goto out_free_buf;
+
+	if (license_sz =3D=3D 0 || ((char *)license)[license_sz - 1] !=3D '\0') {
+		pr_err("ELF Spec violation: license section isn't null terminated\n");
+		err =3D -ENOEXEC;
+		goto out_free_buf;
+	}
+
+	memset(&sattr, 0, sizeof(sattr));
+	sattr.map_type =3D BPF_MAP_TYPE_ARRAY;
+	sattr.key_size =3D sizeof(unsigned int);
+	sattr.value_size =3D data_sz;
+	sattr.max_entries =3D 1;
+	map_fd =3D kern_sys_bpf(BPF_MAP_CREATE, &sattr, sizeof(sattr));
+	if (map_fd < 0) {
+		err =3D map_fd;
+		goto out_free_buf;
+	}
+
+	memset(&sattr, 0, sizeof(sattr));
+	sattr.map_fd =3D map_fd;
+	sattr.key =3D (unsigned long) &zero;
+	sattr.value =3D (unsigned long) data;
+	err =3D kern_sys_bpf(BPF_MAP_UPDATE_ELEM, &sattr, sizeof(sattr));
+	if (err < 0)
+		goto close_map_err;
+
+	memset(&sattr, 0, sizeof(sattr));
+	sattr.prog_type =3D BPF_PROG_TYPE_SYSCALL;
+	sattr.license =3D (unsigned long) license;
+	sattr.insns =3D (unsigned long) insns;
+	sattr.insn_cnt =3D insns_sz / sizeof(struct bpf_insn);
+	sattr.fd_array =3D (unsigned long) &map_fd;
+	sattr.prog_flags =3D BPF_F_SLEEPABLE;
+	strscpy(sattr.prog_name, BPF_LOADER_PROG_SEC, sizeof(BPF_LOADER_PROG_SEC)=
);
+	prog_fd =3D kern_sys_bpf(BPF_PROG_LOAD, &sattr, sizeof(sattr));
+	if (prog_fd < 0) {
+		err =3D prog_fd;
+		goto close_map_err;
+	}
+
+	memset(&sattr, 0, sizeof(sattr));
+	ctx_sz =3D attr->load_fd.ctx_size;
+	kctx =3D kzalloc(ctx_sz, GFP_KERNEL);
+	if (kctx =3D=3D NULL) {
+		err =3D -ENOMEM;
+		goto close_prog_err;
+	}
+	sattr.test.prog_fd =3D prog_fd;
+	sattr.test.ctx_in =3D (unsigned long) kctx;
+	sattr.test.ctx_size_in =3D ctx_sz;
+	err =3D kern_sys_bpf(BPF_PROG_TEST_RUN, &sattr, sizeof(sattr));
+	if (err < 0)
+		goto free_ctx;
+	err =3D sattr.test.retval;
+	if (err < 0)
+		goto free_ctx;
+
+	if (copy_to_user((void *) attr->load_fd.ctx, kctx, ctx_sz) !=3D 0)
+		err =3D -EFAULT;
+
+free_ctx:
+	kfree(kctx);
+close_prog_err:
+	close_fd(prog_fd);
+close_map_err:
+	close_fd(map_fd);
+out_free_buf:
+	vfree(buf);
+out:
+	return err;
+}
+
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
@@ -6463,6 +6794,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr=
, unsigned int size,
 	case BPF_PROG_ASSOC_STRUCT_OPS:
 		err =3D prog_assoc_struct_ops(&attr);
 		break;
+	case BPF_LOADER_LOAD_FD:
+		err =3D loader_load_fd(&attr);
+		break;
 	default:
 		err =3D -EINVAL;
 		break;
@@ -6508,13 +6842,6 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, =
attr, u32, attr_size)
 }
=20
=20
-/* To shut up -Wmissing-prototypes.
- * This function is used by the kernel light skeleton
- * to load bpf programs when modules are loaded or during kernel boot.
- * See tools/lib/bpf/skel_internal.h
- */
-int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
-
 int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 {
 	struct bpf_prog * __maybe_unused prog;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index ffd96e8b920b..470e3b575497 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -993,6 +993,7 @@ enum bpf_cmd {
 	BPF_TOKEN_CREATE,
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
+	BPF_LOADER_LOAD_FD,
 	__MAX_BPF_CMD,
 	BPF_COMMON_ATTRS =3D 1 << 16, /* Indicate carrying syscall common attrs. =
*/
 };
@@ -1950,6 +1951,12 @@ union bpf_attr {
 		__u32		flags;
 	} prog_assoc_struct_ops;
=20
+	struct { /* struct used by BPF_LOADER_LOAD_FD command */
+		__u32		loader_fd;
+		__aligned_u64	ctx;
+		__u32		ctx_size;
+	} load_fd;
+
 } __attribute__((aligned(8)));
=20
 /* The description below is an attempt at providing documentation to eBPF
--=20
2.55.0.691.gc56d675ccc-goog

