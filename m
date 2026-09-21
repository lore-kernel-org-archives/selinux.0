Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com [74.125.230.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E33B8939
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020444; cv=none; b=aOG5gYS3eA6oWVWVp11VzMpnQfsR8XXisqXkIcu0joS3Ga2HKfy/S9AJ/fLbdLMOKM7XR5juZtdv7PDk21ULE1Zt9EZpaIU2nrwln3J6o9bTuPrCdDXiwtgS1k+Rcs16kPflr3ZLEDgYvnZ045fNEPwU3L2I5E4sNJKvVgms3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020444; c=relaxed/simple;
	bh=gCzAvo4ejsI+gHF4Oug6uBM7DVyGNIRSiQEZNzs6hAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGNBvnLJWRcZtk1BRCThiBdCio1n42Ap87sMh3rPe/AiYAJP+iNmkHR/maE9kH5uYVrTAiOfnSYy++lArdPEwxq29Gr6xB6a8Lnt0IqnRxpjAMLRCdIGDdnTdWy0hBV9x6wc9AiElY2XyOhgE6Mje/jysCiA5DtgV3bY24Pt0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLPu9q4f; arc=none smtp.client-ip=74.125.230.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLPu9q4f"
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso30241246d6.1
        for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790020441; x=1790625241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vfR8YPDtZ+wC0FpVP10Q66NTYR7jgyQBmP4VEyrXlq8=;
        b=JLPu9q4fRL5Ag1PJ/h0tgM9OY/KwkpFIQpo81Mlgz1W7/BHk4T5p8hNAiD8ZBn39pT
         /gQZqVm2cmaw9ZXvIVBoV672+XQrXtw2AgsoeBPxEgKeaY3JBYMoW9Fnffgji35BLMyK
         TzSpSNeOX+ssYreo627LDYLTqEqtz8cNTqWCAa2w66HnimQGvSkeZvNRC417sgyPUz20
         FOpmQOPg/FreAUrLyxljfPC6JzRyTCZTjAwU3QvBQYt/IrG+dZ1V1XzRhbrHZvbTs0j9
         0Vn5q6PuaEwgFb1MnRV1/WGlyp/9SsetOZ1+XJQHKl/tnrYCy9OW739qcpAR3cGeKd7t
         armw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020441; x=1790625241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vfR8YPDtZ+wC0FpVP10Q66NTYR7jgyQBmP4VEyrXlq8=;
        b=16VM89BnK4aBXLg1iFBopffPcBub+ImrZQq/zsexSM9qZtDBTPEp61ueMGplZFhNnw
         7s/14RlyDMpg2j9OOJ39BHZ7wk8iBtacOvXwbGVWlrQ5EoE/uMa4dajxfWRz6c60VSVK
         9BEEdeCndibh4zYzc8HiXM7fpxpT24A+R+ZO4uSkqp3hqz4bu3qPzDmrhs2LxD6F7tRz
         F9+uvKfsrPUsxb9+W1eA5qg8Y/AnuZwRnnh1+FBW3eE0WRug98QfgfjhcqnrqnZKN53h
         m1awjP9B5mAQDBYSLFK3UTnQnT6Cj7OXBsm4NTlPfWsJPOT1m7H1QwG8FededHrBDwI+
         4EGw==
X-Gm-Message-State: AFuF++mZSGeOA+VVHQlN/PdZD2gRYY6rSwHbgvKw9nACmPfTfxvv7GkS
	MfVrBNg87Op1DM+fzil10nIpLx+ogYf6Ji+kg9UW1hdw6B52Pdobx1hPJKf+8Q==
X-Gm-Gg: AYBFou1S8NZ8pVAWyQy/yRgrplmWqY7mds70BSeCWq+roR117Lr4tnZpi7En0O6lG8y
	AOZefB9l/mT4IVdY2F7v0xAJQVu+CiMVqW3oSopdg/XtkVSXmgtT7nVsxsbKkhLzlKNGXUfGdg3
	OODXi2t5D1cZj+aYkt3f1tQiy8MbuS9sav1A6PU3O1Wjp2gR/hWen8yNLJ6qMSmEDIhccWvfD33
	9JwirxASn0Sl1w8nTXYt4rN1gRmbw2K1GFpt93U+cr68xZT+5sZSyU1icSrC8BQ0UPwGCb+pqCm
	FSdcitgMw9ut7XyM8eTS5D1qJPYSzFcmxRC7BO+bQz0ZNIGG3511uuFAa6T1MQ5FEB2a42JPKdq
	KWagW22RV+Be3JSF7ZQbJVFTnJISBKKeyQiwTzg8JUmkCJmCJAICtUD8PmWp0k9nypE7wnKyJ0Y
	Ax5LAsuUz7wo0lLISmI+whDLgaDyiIpZFdszeQyipGmMu36zJtpJU8L5Wf3uR3uwxPJgJwzgJMa
	MnMToGeCqszZxYVpbuPB+nRsenyIfV0m4t4nYPb4QKDVBxfDEIybjVBdZ4CWkJJSCLpUX6YNoY=
X-Received: by 2002:a05:6214:268d:b0:912:61a9:5c33 with SMTP id 6a1803df08f44-913fc948b49mr21876946d6.34.1790020440899;
        Mon, 21 Sep 2026 12:54:00 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a8a0c0sm74709906d6.36.2026.09.21.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:54:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 5/5] libsepol: emit userbounds and fix rolebounds order when writing CIL
Date: Mon, 21 Sep 2026 15:53:41 -0400
Message-ID: <20260921195341.25227-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
References: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel_to_cil emits typebounds and rolebounds but has never emitted
userbounds, so a kernel policy that carries a userbounds loses it on
decompile. Add a loop over the sorted user list mirroring the role
bounds emitter.

module_to_cil has the same gap in user_to_cil(), and additionally
role_to_cil() has emitted (rolebounds child parent) since it was
written, whereas CIL takes (rolebounds parent child); the typebounds
site directly below already has the arguments the right way around.
Neither role nor user bounds can be expressed in module source, so
these paths are only reached when converting a binary module that
carries them, but fix both for correctness.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/kernel_to_cil.c | 19 +++++++++++++++++++
 libsepol/src/module_to_cil.c | 10 ++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 09ff5319..a9061e7c 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2648,6 +2648,25 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 		sepol_printf(out, "(user %s)\n", name);
 	}
 
+	for (i = 0; i < num; i++) {
+		name = strs_read_at_index(strs, i);
+		if (!name) {
+			continue;
+		}
+
+		user = hashtab_search(pdb->p_users.table, name);
+		if (!user) {
+			rc = -1;
+			goto exit;
+		}
+
+		if (user->bounds > 0) {
+			sepol_printf(out, "(userbounds %s %s)\n",
+				     pdb->p_user_val_to_name[user->bounds - 1],
+				     name);
+		}
+	}
+
 	for (i = 0; i < num; i++) {
 		name = strs_read_at_index(strs, i);
 		if (!name) {
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index c00c8d33..7516612d 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2493,8 +2493,9 @@ static int role_to_cil(int indent, struct policydb *pdb,
 		}
 
 		if (role->bounds > 0) {
-			cil_println(indent, "(rolebounds %s %s)", key,
-				    pdb->p_role_val_to_name[role->bounds - 1]);
+			cil_println(indent, "(rolebounds %s %s)",
+				    pdb->p_role_val_to_name[role->bounds - 1],
+				    key);
 		}
 		break;
 
@@ -2663,6 +2664,11 @@ static int user_to_cil(int indent, struct policydb *pdb,
 			    pdb->p_role_val_to_name[i]);
 	}
 
+	if (user->bounds > 0) {
+		cil_println(indent, "(userbounds %s %s)",
+			    pdb->p_user_val_to_name[user->bounds - 1], key);
+	}
+
 	cil_indent(indent);
 	cil_printf("(userlevel %s ", key);
 	if (pdb->mls) {
-- 
2.55.0

