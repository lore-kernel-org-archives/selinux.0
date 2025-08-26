Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C7285C8F
	for <selinux@vger.kernel.org>; Tue, 26 Aug 2025 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178315; cv=none; b=IK2wS7TmW0UFF9YHr74SBF0WQH6/OO/SDm9xGeJ9kmglqVOXzezXmutJnkdVunMtIT6RPrFLgpLxXVX6SI543RJZ5ArXYHzyiJV/eO3AfuXEQQeuxsxbEKLA8frnuiD/5MKIHfiqK6CzG+9/PSrqrW844v4o5Mr52TlW/AjIipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178315; c=relaxed/simple;
	bh=JatW6I3Fu/JQ8nlJDTRagh9D0g8tCpN6qj86u41ro0k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KxqSCoO93Be6bCVfT3eM+MrIkDB7MTdbEx8jjNfE7zeqNFodLnPffMYlrD0LJKxfa3Y7qpElmtmLJZW20GWTkJa60vfB5+S1wXWih76e2AA6YWYxoNdafPuI8UVGF3TitMESTKmT6yk6H0TRRE4/0UBP8JIBUCaW3TAoCN3q8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W3i8/2+o; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3i8/2+o"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so5144367b3a.3
        for <selinux@vger.kernel.org>; Mon, 25 Aug 2025 20:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756178313; x=1756783113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia25Jaa7IaL0nffY5Ufyltoj6WxAaukUAWgd3CDsn9w=;
        b=W3i8/2+otvPKpc9gEhXirlS3J674I/3AhKBK93ZthTznONKeWIK1ugBvhhAq0ETGJp
         ei1h3i3YfSv+uW+CWZ3tfeAfolLzgByGO/FLJ4VxL1wd3DdlHD4WTaAKoyzLbps9V2nZ
         F2xRx55VPS4/4hlh7ZqRAlQb3iW6JLZSHjfjLHTUJqd/0C25qiEM0baJSFvqIAcr3dhA
         ooDg0q4N56Q5f8GVyt2UZCly5xdKjGPBGt/8adgKL3xagVsADrGYnCNB51dWVXGY2NuG
         32MTDhUtRwMNayTnTT3PQqxld1f+gBOrm7MK/aeIg6ruNLKziTvXS7/x33EkHVjZPdh0
         eFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756178313; x=1756783113;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia25Jaa7IaL0nffY5Ufyltoj6WxAaukUAWgd3CDsn9w=;
        b=FC5Pu9snqeiYvCo4nikSRY7qcnsyboUtbcQSHw8nBJ+BOuSKhdx+BGQbJywUSuKdKM
         oXmaCwDqNWUBLBR5XHDnvX+/vpZ+c6lXE9yf/nJLa5W1LD3YQUxYPkQq7+jHQs64D/xs
         UGz0O5M/1+NgmskflWCgbfSKO6+hbIYZSkKUHnypq2M1ZV8OSMhJaAIVuI1J3dj+zQ/s
         mZCcDTIJg7ffxQGEdd3Ivgt3NuG8IsYzT/9s2L/IqX0A5j/kHaY0BkOl5iEVUV4UjttA
         g8+imox55mcuGsUbnBLb7ovxTV4uKFQXDhzaG7PoCtBx4RpJjBaS7MMLrAwsOoZfs956
         hoWw==
X-Forwarded-Encrypted: i=1; AJvYcCXCphtU6WKUhR40fiOW3xak/B7CKjXnjT3zF94TvOu6iiUQWpikr9srYOnRxiWyYsKiTl/vcy57@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQr9vphTLQRCgwLsvvf5DBFfUmNjXEfqehxtO+WIOgodZjVX0
	SLE1BWAWoHQvVr7LpjImcvr4mrS0jZHCjaY9H+EMxgu/VBwbdA3cK2YFgAyonb+8WLnT4wqhdoc
	7tw==
X-Google-Smtp-Source: AGHT+IGXhlqnNu6ddaR+RH2PXtP+vJbdu5PRDLMQSy9xdeU5Lb5NRpAcP1D/ThqTrLRg2ieo22vV8cyK/A==
X-Received: from pfbcw11.prod.google.com ([2002:a05:6a00:450b:b0:770:58e0:741f])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a8e:b0:76c:1eae:fd30
 with SMTP id d2e1a72fcca58-7702fa02d0fmr18741407b3a.12.1756178312469; Mon, 25
 Aug 2025 20:18:32 -0700 (PDT)
Date: Tue, 26 Aug 2025 13:18:24 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826031824.1227551-1-tweek@google.com>
Subject: [PATCH] memfd,selinux: call security_inode_init_security_anon
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Hugh Dickins <hughd@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>
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
---
Changes since RFC:
- Remove enum argument, simply compare the anon inode name
- Introduce a policy capability for compatility
- Add validation of class in selinux_bprm_creds_for_exec

 include/linux/memfd.h                      |  2 ++
 mm/memfd.c                                 | 14 +++++++++--
 security/selinux/hooks.c                   | 27 ++++++++++++++++++----
 security/selinux/include/classmap.h        |  2 ++
 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  1 +
 security/selinux/include/security.h        |  5 ++++
 7 files changed, 46 insertions(+), 6 deletions(-)

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
index c95a5874bf7d..429b2269b35a 100644
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
@@ -2366,9 +2367,12 @@ static int selinux_bprm_creds_for_exec(struct linux_=
binprm *bprm)
 	ad.type =3D LSM_AUDIT_DATA_FILE;
 	ad.u.file =3D bprm->file;
=20
+	if (isec->sclass !=3D SECCLASS_FILE && isec->sclass !=3D SECCLASS_MEMFD_F=
ILE)
+		return -EPERM;
+
 	if (new_tsec->sid =3D=3D old_tsec->sid) {
-		rc =3D avc_has_perm(old_tsec->sid, isec->sid,
-				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
+		rc =3D avc_has_perm(old_tsec->sid, isec->sid, isec->sclass,
+				  FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
@@ -2378,8 +2382,8 @@ static int selinux_bprm_creds_for_exec(struct linux_b=
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
@@ -2974,10 +2978,18 @@ static int selinux_inode_init_security_anon(struct =
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
@@ -2996,6 +3008,13 @@ static int selinux_inode_init_security_anon(struct i=
node *inode,
=20
 		isec->sclass =3D context_isec->sclass;
 		isec->sid =3D context_isec->sid;
+	} else if (is_memfd) {
+		isec->sclass =3D SECCLASS_MEMFD_FILE;
+		rc =3D security_transition_sid(
+			sid, sid,
+			isec->sclass, name, &isec->sid);
+		if (rc)
+			return rc;
 	} else {
 		isec->sclass =3D SECCLASS_ANON_INODE;
 		rc =3D security_transition_sid(
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
2.51.0.261.g7ce5a0a67e-goog

