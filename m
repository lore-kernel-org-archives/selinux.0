Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C682629D
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 02:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758161080; cv=none; b=l7CTWlWp5k6emXIS14XXztFv0tCJiHG9haaFY3Hc7OmrvZ7O6XUHZaZIiZ1yorZsN8nK7U2MFImA3OL6AqmHpIBRzSnBeN0IjQrdvJDzesEHfnnC0VgJN1HcNwSvsBydWeDdmIMGpi9BEBsnmKLJ9rTq6NX6sk8rGJLniu0Lmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758161080; c=relaxed/simple;
	bh=IKDvBc+x9Iwhb1lEpnYLCZyZRDaR1ojgTxoJq74Vzsk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q4rmzJZB3vdj0RQ7Vupbj/QgLgRIAtYtnUnvrhpEgnY3lK5t6E943QykCx4RDI2kcusXKhnRRIvv2OyKnYM9cb2+7iaXMU7xd7Z7WyuXegWnZtWgWtVrWAiNhV2JmQMSSthLxLiDf+c5K/wGqqU9H6pVK3WYbZtaNVbk36848Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oMKe8r1q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMKe8r1q"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4f93fe3831so519879a12.0
        for <selinux@vger.kernel.org>; Wed, 17 Sep 2025 19:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758161078; x=1758765878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pyki2P4YAjRDRPrSasQw3ooIaydaujpJ4Vt5rSyTrok=;
        b=oMKe8r1qSk/C0i6+NS/4H275UxDaDP/BixTse/eMBz/hnm4Pp6Zo8RzG1IWsV7fs8Y
         R98qYaUDjSOvJNC59u47gL0gsiVaGEWYX0G9naSFI/GlijpK4n9ztDYImGp47jEv3MDF
         e4v2ZHeXqD/EUpaQAL/X34ejwCPTFja7SbxkugvQouJAYZf4ITrJHjGkz8qNL6iboOao
         jVtBlDew41Mq38C1Qd0FIWnY6NYlvvBQOK2zy+bgS8qQdF1/ay799QRqQVk1Nf/esphD
         eYHgM0E7Y122IjpO4h5IOvq2BPZ1CZVIurYHdoht3lhyDHe7fFnRnMwysreocQKX9rx/
         V9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758161078; x=1758765878;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyki2P4YAjRDRPrSasQw3ooIaydaujpJ4Vt5rSyTrok=;
        b=OJ4KgZlonNTZh43TXEAqtN9X/6rlgqQczzzqhJXF+FWe34VhZ7kFx62szm7io7Yiza
         px0iZmGhkMUDmn7hgA1kaf/v3TvnmGnyW52NWbbGTZCjRqd9NzcZ3bsjUuwAHEhvow3F
         Np/VBNyNMfa6FIGBxn6VMyCFfZUsHk4qaHPs2g5t9SH3F6lZOWJLriZts5Z6ObdfV6/r
         x6HcwPTEDHoU9fWlUdXwhnP14T7+IA//W530b/eKW5GbQgc646R21jaiKuBgrePZBYH0
         lEvQsnGXxj40kbdyecsKPf5ZAHOIc39lDW0uSN1awTiGxJ+iC41rGtH8WUBlhOx5+O1a
         nVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXec5xqSK8xU5ToVvaadsDC7uzQfTRrPWXPNqKsTa6pOlKNXCVovb/1tj8AQz5UY6bWiTXuNjdk@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7ExkGsfvamCEAJ0hjnZ1ZRJDPK+xRlkxzVbPTO+l/LrV6YuA
	hmqv9xgaEYFz6Rvr6SjQAFL+LSqMNxyqNLtK/bsleg9+Lq4217VmrjGgmOLAR4A0qHbZxIQvadk
	oDQ==
X-Google-Smtp-Source: AGHT+IHxV2URVmDihcD64Mgho9pAFtZ0ZIdyPKpVqKKXetRCviLw6jUHqPxALm75Usf2v2582qjAQpR26Q==
X-Received: from pfbho3.prod.google.com ([2002:a05:6a00:8803:b0:776:169f:8da6])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a06:b0:24d:d206:699b
 with SMTP id adf61e73a8af0-27ab34e85femr6141261637.41.1758161078245; Wed, 17
 Sep 2025 19:04:38 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:04:34 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918020434.1612137-1-tweek@google.com>
Subject: [PATCH v3] memfd,selinux: call security_inode_init_security_anon
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
---
Changes since v2:
- Add WARN_ON when using unexpected class. Return -EACCES instead=20
  of -EPERM
- Remove extra new line
- Rebase on selinux/dev

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
index 0e47b4bb8d40..2b685f9dd61d 100644
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
@@ -2319,6 +2320,10 @@ static int selinux_bprm_creds_for_exec(struct linux_=
binprm *bprm)
 	new_tsec =3D selinux_cred(bprm->cred);
 	isec =3D inode_security(inode);
=20
+	if (WARN_ON(isec->sclass !=3D SECCLASS_FILE &&
+		    isec->sclass !=3D SECCLASS_MEMFD_FILE))
+		return -EACCES;
+
 	/* Default to the current task SID. */
 	new_tsec->sid =3D old_tsec->sid;
 	new_tsec->osid =3D old_tsec->sid;
@@ -2371,8 +2376,8 @@ static int selinux_bprm_creds_for_exec(struct linux_b=
inprm *bprm)
 	ad.u.file =3D bprm->file;
=20
 	if (new_tsec->sid =3D=3D old_tsec->sid) {
-		rc =3D avc_has_perm(old_tsec->sid, isec->sid,
-				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
+		rc =3D avc_has_perm(old_tsec->sid, isec->sid, isec->sclass,
+				  FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
@@ -2382,8 +2387,8 @@ static int selinux_bprm_creds_for_exec(struct linux_b=
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
@@ -2978,10 +2983,18 @@ static int selinux_inode_init_security_anon(struct =
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
@@ -3001,7 +3014,10 @@ static int selinux_inode_init_security_anon(struct i=
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
index 135a969f873c..231d02227e59 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -18,6 +18,7 @@ enum {
 	POLICYDB_CAP_NETIF_WILDCARD,
 	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
 	POLICYDB_CAP_FUNCTIONFS_SECLABEL,
+	POLICYDB_CAP_MEMFD_CLASS,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/=
include/policycap_names.h
index ff8882887651..454dab37bda3 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -21,6 +21,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_=
MAX] =3D {
 	"netif_wildcard",
 	"genfs_seclabel_wildcard",
 	"functionfs_seclabel",
+	"memfd_class",
 };
 /* clang-format on */
=20
diff --git a/security/selinux/include/security.h b/security/selinux/include=
/security.h
index 0f954a40d3fc..5d1dad8058b1 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -209,6 +209,11 @@ static inline bool selinux_policycap_functionfs_seclab=
el(void)
 		selinux_state.policycap[POLICYDB_CAP_FUNCTIONFS_SECLABEL]);
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

