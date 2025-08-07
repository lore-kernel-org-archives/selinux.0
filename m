Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC72242D6E
	for <selinux@vger.kernel.org>; Thu,  7 Aug 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553475; cv=none; b=ic01rOJhHWp/3D9C83TtB1uiG6hiuLHvukhnYljndseSmdvsfbYp0mp/i6h8+EQHfV0SnqIKZt/zbtvZzOdLhDNSxE60zYJcpmaxB5yB4xuQEV+R909hx9xazlCslNcPB0DIBsGtGl1Wdidi1kOknCboN7meX9crzL5CpnfrZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553475; c=relaxed/simple;
	bh=xN8SgTYjPE3paXbAT6wVrG1234fQaF1txx30pF6zyjk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GBFvFhfIHqeU4aPgkvVQbKV3WICz/p1tlfWQajpuarHOrfQ9LKj9gy56VLcLVUwSUBUbE/b3+0CwzO7Z2CTyjatgpvRdT9vrn10Y75AOf4JNcL/eP4gSEinW92qSYqNwXPnGGBRd75bWw7rVcY909finpNha9f471h/HvtOphUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXc6hT0J; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXc6hT0J"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24249098fd0so9660865ad.0
        for <selinux@vger.kernel.org>; Thu, 07 Aug 2025 00:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754553474; x=1755158274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlvLgISNZUMVd8V5cqfKKA37QM8euuKbf1YxDJ77g88=;
        b=kXc6hT0JRGZ1lOjKiZFx8sj8ckA6OaSMHbvDC8kwRxjUL2LZibIqhrGHp/mVfAKRDS
         7xT7/e5xnO0Rc2DVuFXDQkjAWgugClkLsTw2ObqZpaUNIKFYwLCF81/engmfByScty9W
         PgewgsHaDybdXp5BM/86FuUZU3rMrY0TLUmV4SMhtsjMo+2MJvqQ5BmDxe4ckOsHMps3
         bb13jywXSzPtiKyj46K/U6fBdK/NK/TTITrksh23bZq22boNbu87k2ZBeQNxbmGt/AEd
         r1a1q4laVE05fXTbjTopU6WHv4iiVoBRMua1k14KimfaL0ddUtQViW6xZNsCcS2tjqQY
         IC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553474; x=1755158274;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlvLgISNZUMVd8V5cqfKKA37QM8euuKbf1YxDJ77g88=;
        b=S+uj8oY1dmFpt/XWuFaLlauKhZN4/zTV/uIs9O++xqAO3/s6WC7x/fpqyMY0XmAHs4
         qte7T1Z/W2YYCGnkBHfCqjEAmtvexix76oOWCtOSJSokgOiwuaby+Lb5u8T/UzBSvoP+
         A/LvHcWTDurVdnnRej9n/BZ+kuq5y4m5S6HMHbKtHmWTMe5dvI1And+xPfCSNbAs0RgL
         TK0pD6KiQqI2YXGPG7fKXMuJ+73qP6x7qQbalbAHUa03/eK+e0ueIbHLvN44+lvYba+D
         RwflEOY9Ne5/ga0NJZBIB64S1MbUFvSphT9D80Bd8EjxZroRIRbxUUtLPo6HDIo53RFn
         lMCg==
X-Forwarded-Encrypted: i=1; AJvYcCW8VdSeg2HvYy1XfwyBaXctol6JCscZmEXPtevHPefpP8oDLTNBZ+KFjk23Oi6wc/g/Chp3jppu@vger.kernel.org
X-Gm-Message-State: AOJu0YxtUycTFuHdOzl0qGIGDWaBoXlm6oRHRioouzgSOxkoeYh9JIP0
	EiuRIgmE0lYAkSF3t47dWQZ8mYZV2u7D7STt4tmWSaYHfVwjUM19tnACi0J9g7wREMTAgz7rGJE
	Qvg==
X-Google-Smtp-Source: AGHT+IHNIIcS02q9yEtK/CycKioNSm/xVnF7oU0CQTIF6GSZSwCqJv0pj1GYTNZPgPdmBaaClonc0irU2w==
X-Received: from pllo14.prod.google.com ([2002:a17:902:778e:b0:23f:8d14:d415])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c2:b0:240:6ae4:3695
 with SMTP id d9443c01a7336-2429f520b52mr65586545ad.4.1754553473692; Thu, 07
 Aug 2025 00:57:53 -0700 (PDT)
Date: Thu,  7 Aug 2025 17:57:45 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807075745.756415-1-tweek@google.com>
Subject: [RFC PATCH 2/2] memfd: call security_inode_init_security_anon
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Hugh Dickins <hughd@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
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

[1] https://crbug.com/1305267
[2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.com/

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 mm/memfd.c                          | 16 ++++++++++++++--
 security/selinux/hooks.c            | 15 +++++++++++----
 security/selinux/include/classmap.h |  2 ++
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index bbe679895ef6..13bff0e91816 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -433,6 +433,9 @@ static struct file *alloc_file(const char *name, unsign=
ed int flags)
 {
 	unsigned int *file_seals;
 	struct file *file;
+	struct inode *inode;
+	int err =3D 0;
+	const char *anon_name =3D "[memfd]";
=20
 	if (flags & MFD_HUGETLB) {
 		file =3D hugetlb_file_setup(name, 0, VM_NORESERVE,
@@ -444,12 +447,21 @@ static struct file *alloc_file(const char *name, unsi=
gned int flags)
 	}
 	if (IS_ERR(file))
 		return file;
+
+	inode =3D file_inode(file);
+	err =3D security_inode_init_security_anon(inode,
+			LSM_ANON_INODE_MEMFD,
+			&QSTR(anon_name), NULL);
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
index 8d36d5ebb6e5..49742930e706 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2367,8 +2367,8 @@ static int selinux_bprm_creds_for_exec(struct linux_b=
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
@@ -2378,8 +2378,8 @@ static int selinux_bprm_creds_for_exec(struct linux_b=
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
@@ -2997,6 +2997,13 @@ static int selinux_inode_init_security_anon(struct i=
node *inode,
=20
 		isec->sclass =3D context_isec->sclass;
 		isec->sid =3D context_isec->sid;
+	} else if (type =3D=3D LSM_ANON_INODE_MEMFD) {
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
--=20
2.50.1.703.g449372360f-goog

