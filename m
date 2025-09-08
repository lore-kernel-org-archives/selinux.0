Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CEF1CBEAA
	for <selinux@vger.kernel.org>; Mon,  8 Sep 2025 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295276; cv=none; b=FdcR2H40nO48A8Q0TkpO0uOzjz5b81A5T2ROXt2RbrWxyBwS0bGFP5ICDaJZiJ8OC2F3i277CW3bTLcyto3XG7AkhEt2KMavrrTvGlB7BA097VWQVgIBzw+AIWHTJPWFVChghClvPahg6oRXezKg8/Nz6eUQ0NYbm/7KziW4rhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295276; c=relaxed/simple;
	bh=hPgnGfP1mh5OffDYgCOtxvRWTZFqQur0hG40PXSiw1U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JnCN2HsX8Kf89/jlxapz6zaExw6CK58lQBpsxmG1JcF2K6jMmVCBrnjDzbG3P3HBhFPiMaWcHMYDZSJhRimV/YH/m6XuR+OaRyYOOZGy2Pf3VIBg1tO8r7w4eGy32hfNygSQTszKYT/ECeLQVraYb91hAIiCrvnG0osjfzu3qHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iou2mYHU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iou2mYHU"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329745d6b89so7830117a91.1
        for <selinux@vger.kernel.org>; Sun, 07 Sep 2025 18:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757295274; x=1757900074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JlhVnol+judhUzzwOogW+HmLUCIc8LS+J6IJKltRJA=;
        b=iou2mYHU6HjdMCJqmrP6Lzqfd90MEC1mIEolVmSVgw/lcGe3/c0ZeFhmNRELZQy0Ou
         800DyzBlpdw8XEBJOHmMRFmvCbYf12EFeTKuPK9ZRvMER+lRvsNlgCK35pNoSBeqvso5
         OyhY2ZvCy1XR0EdzjHNpY8N1k6uOr5sbIKCxY9M/mIe1W68kWyRZBF3HwfzB3oNSnc1d
         GttkoEMjXymVNl7Ca7A+2BtW1CM2MsmN+E+5mcUDrgGj9uKTkX7qHwzLHAVveT9dZXMm
         x0eUuHZmLS9gboiCPQHT5V/8t0RwsHQYxSBWOZoC1rSL+rHDNq5PyNMVUpnFmG9wm2G+
         Yf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757295274; x=1757900074;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JlhVnol+judhUzzwOogW+HmLUCIc8LS+J6IJKltRJA=;
        b=gNmW5OpEQlsJZu0dLbSaY2DsRXUGxIHuRHkvuuRu8JGfjjM2+0wGKWr37eRzS6kOiw
         J6gWTOuiAPCYrh4nQHJxzFgHKfTgULOvidRNuzQotxxmmr/GLUgQqcJCbgAn5Bk/4foR
         MQJ3py0VT1Vi4h3EXnwm/BrMKMGuinN6hvAcGs8vHed533ucTJ6L4GwQ67pfODWOjKba
         I2MDqbbuRcCXL6K1lGWgbjLV/GF+KRoTrCJ+Bu+nY90dm8HIMCdZXEol+BbKZLXpC64R
         Vrz14NurF0domxOdJOlvXWy8Zbnphs6YAVlGI5HhuGC3bDKH8o41cwRJxnIRCLqfT/oZ
         ystw==
X-Forwarded-Encrypted: i=1; AJvYcCX6GEozsc10+VBt0CLDpulo8xMkC4wGbppdF9MsK7ieWc5YXsomclWSo/LdbdW99ffqx6ys8nVq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38spX8KdtUNbXFVgGDiCQ+0zw6cqcuOBzdurHhF+53tmeG3UR
	+nRNcG4XRWJKIw2lQ62VrMVDLSbN3lfKO2XZ6FBSVys4RrvoMVk5f/Bmyb0kArzD6Gdp9F+AKYI
	auA==
X-Google-Smtp-Source: AGHT+IErnV8Y/Sanjw9YO0m3nEGzcg/9CpvlG17Upovdj3N1XyUdkWC1vRs0c4mbxBDPi5LS5Z2j0ehPGw==
X-Received: from pjtd14.prod.google.com ([2002:a17:90b:4e:b0:327:50fa:eff9])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:530b:b0:32b:d502:6ff2
 with SMTP id 98e67ed59e1d1-32d440d9ef6mr7330684a91.34.1757295274251; Sun, 07
 Sep 2025 18:34:34 -0700 (PDT)
Date: Mon,  8 Sep 2025 11:34:19 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908013419.4186627-1-tweek@google.com>
Subject: [PATCH v2] memfd,selinux: call security_inode_init_security_anon
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Hugh Dickins <hughd@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Prior to this change, no security hooks were called at the creation of a
memfd file. It means that, for SELinux as an example, it will receive
the default type of the filesystem that backs the in-memory inode. In
most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
be hugetlbfs. Both can be considered implementation details of memfd.

It also means that it is not possible to differentiate between a file
coming from memfd_create and a file coming from a standard tmpfs mount
point.

Additionally, no permission is validated at creation, which differs from
the similar memfd_secret syscall.

Call security_inode_init_security_anon during creation. This ensures
that the file is setup similarly to other anonymous inodes. On SELinux,
it means that the file will receive the security context of its task.

The ability to limit fexecve on memfd has been of interest to avoid
potential pitfalls where /proc/self/exe or similar would be executed
[1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
similarly to the file class. These access vectors may not make sense for
the existing "anon_inode" class. Therefore, define and assign a new
class "memfd_file" to support such access vectors.

Guard these changes behind a new policy capability named "memfd_class".

[1] https://crbug.com/1305267
[2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.com/

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
Changes since v1:
- Move test of class earlier in selinux_bprm_creds_for_exec
- Remove duplicate call to security_transition_sid

Changes since RFC:
- Remove enum argument, simply compare the anon inode name
- Introduce a policy capability for compatility
- Add validation of class in selinux_bprm_creds_for_exec

 include/linux/memfd.h                      |  2 ++
 mm/memfd.c                                 | 14 ++++++++++--
 security/selinux/hooks.c                   | 26 +++++++++++++++++-----
 security/selinux/include/classmap.h        |  2 ++
 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  1 +
 security/selinux/include/security.h        |  5 +++++
 7 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index 6f606d9573c3..cc74de3dbcfe 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -4,6 +4,8 @@
=20
 #include <linux/file.h>
=20
+#define MEMFD_ANON_NAME "[memfd]"
+
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int =
arg);
 struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
diff --git a/mm/memfd.c b/mm/memfd.c
index bbe679895ef6..63b439eb402a 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -433,6 +433,8 @@ static struct file *alloc_file(const char *name, unsign=
ed int flags)
 {
 	unsigned int *file_seals;
 	struct file *file;
+	struct inode *inode;
+	int err =3D 0;
=20
 	if (flags & MFD_HUGETLB) {
 		file =3D hugetlb_file_setup(name, 0, VM_NORESERVE,
@@ -444,12 +446,20 @@ static struct file *alloc_file(const char *name, unsi=
gned int flags)
 	}
 	if (IS_ERR(file))
 		return file;
+
+	inode =3D file_inode(file);
+	err =3D security_inode_init_security_anon(inode,
+			&QSTR(MEMFD_ANON_NAME), NULL);
+	if (err) {
+		fput(file);
+		file =3D ERR_PTR(err);
+		return file;
+	}
+
 	file->f_mode |=3D FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
 	file->f_flags |=3D O_LARGEFILE;
=20
 	if (flags & MFD_NOEXEC_SEAL) {
-		struct inode *inode =3D file_inode(file);
-
 		inode->i_mode &=3D ~0111;
 		file_seals =3D memfd_file_seals_ptr(file);
 		if (file_seals) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c95a5874bf7d..6adf2f393ed9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -93,6 +93,7 @@
 #include <linux/fanotify.h>
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
+#include <linux/memfd.h>
=20
 #include "avc.h"
 #include "objsec.h"
@@ -2315,6 +2316,9 @@ static int selinux_bprm_creds_for_exec(struct linux_b=
inprm *bprm)
 	new_tsec =3D selinux_cred(bprm->cred);
 	isec =3D inode_security(inode);
=20
+	if (isec->sclass !=3D SECCLASS_FILE && isec->sclass !=3D SECCLASS_MEMFD_F=
ILE)
+		return -EPERM;
+
 	/* Default to the current task SID. */
 	new_tsec->sid =3D old_tsec->sid;
 	new_tsec->osid =3D old_tsec->sid;
@@ -2366,9 +2370,10 @@ static int selinux_bprm_creds_for_exec(struct linux_=
binprm *bprm)
 	ad.type =3D LSM_AUDIT_DATA_FILE;
 	ad.u.file =3D bprm->file;
=20
+
 	if (new_tsec->sid =3D=3D old_tsec->sid) {
-		rc =3D avc_has_perm(old_tsec->sid, isec->sid,
-				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
+		rc =3D avc_has_perm(old_tsec->sid, isec->sid, isec->sclass,
+				  FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
@@ -2378,8 +2383,8 @@ static int selinux_bprm_creds_for_exec(struct linux_b=
inprm *bprm)
 		if (rc)
 			return rc;
=20
-		rc =3D avc_has_perm(new_tsec->sid, isec->sid,
-				  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
+		rc =3D avc_has_perm(new_tsec->sid, isec->sid, isec->sclass,
+				  FILE__ENTRYPOINT, &ad);
 		if (rc)
 			return rc;
=20
@@ -2974,10 +2979,18 @@ static int selinux_inode_init_security_anon(struct =
inode *inode,
 	struct common_audit_data ad;
 	struct inode_security_struct *isec;
 	int rc;
+	bool is_memfd =3D false;
=20
 	if (unlikely(!selinux_initialized()))
 		return 0;
=20
+	if (name !=3D NULL && name->name !=3D NULL &&
+	    !strcmp(name->name, MEMFD_ANON_NAME)) {
+		if (!selinux_policycap_memfd_class())
+			return 0;
+		is_memfd =3D true;
+	}
+
 	isec =3D selinux_inode(inode);
=20
 	/*
@@ -2997,7 +3010,10 @@ static int selinux_inode_init_security_anon(struct i=
node *inode,
 		isec->sclass =3D context_isec->sclass;
 		isec->sid =3D context_isec->sid;
 	} else {
-		isec->sclass =3D SECCLASS_ANON_INODE;
+		if (is_memfd)
+			isec->sclass =3D SECCLASS_MEMFD_FILE;
+		else
+			isec->sclass =3D SECCLASS_ANON_INODE;
 		rc =3D security_transition_sid(
 			sid, sid,
 			isec->sclass, name, &isec->sid);
diff --git a/security/selinux/include/classmap.h b/security/selinux/include=
/classmap.h
index 5665aa5e7853..3ec85142771f 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -179,6 +179,8 @@ const struct security_class_mapping secclass_map[] =3D =
{
 	{ "anon_inode", { COMMON_FILE_PERMS, NULL } },
 	{ "io_uring", { "override_creds", "sqpoll", "cmd", "allowed", NULL } },
 	{ "user_namespace", { "create", NULL } },
+	{ "memfd_file",
+	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
 	/* last one */ { NULL, {} }
 };
=20
diff --git a/security/selinux/include/policycap.h b/security/selinux/includ=
e/policycap.h
index 7405154e6c42..dabcc9f14dde 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -17,6 +17,7 @@ enum {
 	POLICYDB_CAP_NETLINK_XPERM,
 	POLICYDB_CAP_NETIF_WILDCARD,
 	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
+	POLICYDB_CAP_MEMFD_CLASS,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/=
include/policycap_names.h
index d8962fcf2ff9..8e96f2a816b6 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -20,6 +20,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_=
MAX] =3D {
 	"netlink_xperm",
 	"netif_wildcard",
 	"genfs_seclabel_wildcard",
+	"memfd_class",
 };
 /* clang-format on */
=20
diff --git a/security/selinux/include/security.h b/security/selinux/include=
/security.h
index 8201e6a3ac0f..72c963f54148 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -209,6 +209,11 @@ static inline bool selinux_policycap_netif_wildcard(vo=
id)
 		selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
 }
=20
+static inline bool selinux_policycap_memfd_class(void)
+{
+	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_MEMFD_CLASS]);
+}
+
 struct selinux_policy_convert_data;
=20
 struct selinux_load_state {
--=20
2.51.0.384.g4c02a37b29-goog

