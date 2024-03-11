Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460956772
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191991; cv=none; b=I3nzEmZX2zC48cHOKf4o9Jt1rcA9j7hruRhRmzblhXtylW/3QX9CKyUUvPKWS1VmRM68+8+KI1ssOvsw/wL2/c7tj/C0KDsB45U0KYGOK/O+Cnmyz29t6YEqJRypLnihLCAA99ZZB+DRzu+7QsgXW4WM08YlA8pcw7Vgjp7nI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191991; c=relaxed/simple;
	bh=10mhg0PhVvawNV/ssQLxLQJ9elB+Wl87tnuRvG7RrPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tgi0KjRMLRjuey7OIWq9vrgB7aMpTm3Z6z83gn+JU2DR/ZY+YeSFPFhzPvMZ+AGEoTk5DrTK8aZZ5VSAPHZ5tk9xP29wxOkUiOlItm2BS9ZV9BiqYuY/L1eEE/6eyk5FJUjxJKaimrSyPKFmQ1Rbzg4yj49HzjPlZi3QB8FR5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3hx2H9z; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3hx2H9z"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2210865d962so1908672fac.3
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710191989; x=1710796789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHRH0MRsQv4qEZrXvuF1WeCnYQYOs7EEEN7SzgZePYc=;
        b=N3hx2H9zwV6zvGilVfutUaU5UCtQeLSOc7NWIeud9ny4+ORPBqfszCY75wrzgtyw3x
         hSNWM3SlTXdHRqUZTkBNlfxR11pmckSPl0hKBdpRi0jTcqAlAS5/wOa7V0hcAfAWafl4
         9/t2ZGXOd3H6FovFuCZpZ6S11yVhHlBqQnTKP/KIqmWftFuX/tN9Zf1WD0o5xqkhFUt7
         r/LH32uHgkzkisL51HTK5g8LeSpH5yXlAY9Fp8C3vpIEPIV8l7jU0vBIlc4Tv0QNUGCb
         yhDDchUdvpzRmTsIoLxtRSOIuQvh2S5yGKL3fmmL62A18Fb3tcXnReYu/MWMzsGKP6Yi
         Nflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710191989; x=1710796789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHRH0MRsQv4qEZrXvuF1WeCnYQYOs7EEEN7SzgZePYc=;
        b=R16Vkr/jMJHeJNQD0asNyYorDal5NB8NYz/jubCJRoErHQoxTLb3IKxuL+OzSTvfqm
         tGCA37b0yfUn5qMy4PxO9a0JNKuQh03nkPCp8/Dv7r8kG4w8eTivkkpB9Q0D2AjGKl4y
         CtbzXNk7bAezgTThoA7+kWdVuJAqeTEHCiHMbHKV3VqRLAVqa4ZqTY25FO0IdjCGmSLP
         Zk18t4hZoG53uFheFZMAF8WxZNlh4cI9k6SG09LKmyuDh4BJorye8gHNzvyr79F6NwA6
         KCHb3TphIBeodfcYdO+G/S0JS+Gf1JG+x05AHa49H2YQN6UKyBJArlGDzI7OXTRW3oCG
         fD/Q==
X-Gm-Message-State: AOJu0YwmKXrhrJuT848E7Yyrcz2AgeQgHa31th74ml1Osou++wANEmSU
	9nEI2N8OYVDMzmOYHdM/xIl8X5YVHhOj5yRH5nOFrTfd4dwat/AcCedMEqiA
X-Google-Smtp-Source: AGHT+IHsOX/hO5q1gyNwZACZWEfcj7Vbl1bYT7/NTQwkrS7IX8jVgiy9XCifWnTlL1Tg+MhEBCiWFg==
X-Received: by 2002:a05:6870:32ce:b0:21e:df09:fbb6 with SMTP id r14-20020a05687032ce00b0021edf09fbb6mr8451614oac.41.1710191989027;
        Mon, 11 Mar 2024 14:19:49 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id v13-20020a05620a090d00b007884103dfcesm3021725qkv.87.2024.03.11.14.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 14:19:48 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol: Fix buffer overflow when using sepol_av_to_string()
Date: Mon, 11 Mar 2024 17:19:46 -0400
Message-ID: <20240311211946.2691879-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function sepol_av_to_string() normally returns a list of
permissions with a space at the beginning, but it will return '\0'
if there are no permissions. Unfortunately, functions in
kernel_to_cil, kernel_to_conf, and module_to_cil assume there is a
space at the beginning and skip the space by using "perms+1".

In kernel_to_cil, kernel_to_conf, and module_to_cil, check for the
permission string being '\0' and return an error if it is.

Reported-by: oss-fuzz (issue 67276)
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_cil.c  | 11 +++++++++++
 libsepol/src/kernel_to_conf.c | 11 +++++++++++
 libsepol/src/module_to_cil.c  | 12 ++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index a081915e..e20ba4af 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -302,6 +302,12 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 			rc = -1;
 			goto exit;
 		}
+		if (*perms == '\0') {
+			ERR(NULL, "No permisisons in permission string");
+			free(perms);
+			rc = -1;
+			goto exit;
+		}
 
 		if (is_mls) {
 			key_word = "mlsconstrain";
@@ -1775,6 +1781,11 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 			ERR(NULL, "Failed to generate permission string");
 			goto exit;
 		}
+		if (*perms == '\0') {
+			ERR(NULL, "No permisisons in permission string");
+			free(perms);
+			goto exit;
+		}
 		rule = create_str("(%s %s %s (%s (%s)))",
 				  flavor, src, tgt, class, perms+1);
 		free(perms);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 956fb6e8..5860a513 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -297,6 +297,12 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 			rc = -1;
 			goto exit;
 		}
+		if (*perms == '\0') {
+			ERR(NULL, "No permisisons in permission string");
+			free(perms);
+			rc = -1;
+			goto exit;
+		}
 		if (strchr(perms, ' ')) {
 			perm_prefix = "{ ";
 			perm_suffix = " }";
@@ -1741,6 +1747,11 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 			ERR(NULL, "Failed to generate permission string");
 			goto exit;
 		}
+		if (*permstring == '\0') {
+			ERR(NULL, "No permisisons in permission string");
+			free(permstring);
+			goto exit;
+		}
 		rule = create_str("%s %s %s:%s { %s };",
 				  flavor, src, tgt, class, permstring+1);
 		free(permstring);
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 6699a46b..3b3480bf 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -593,6 +593,12 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 				rc = -1;
 				goto exit;
 			}
+			if (*perms == '\0') {
+				ERR(NULL, "No permissions in permission string");
+				free(perms);
+				rc = -1;
+				goto exit;
+			}
 			cil_println(indent, "(%s %s %s (%s (%s)))",
 					rule, src, tgt,
 					pdb->p_class_val_to_name[classperm->tclass - 1],
@@ -1973,6 +1979,12 @@ static int constraints_to_cil(int indent, struct policydb *pdb, char *classkey,
 				rc = -1;
 				goto exit;
 			}
+			if (*perms == '\0') {
+				ERR(NULL, "No permissions in permission string");
+				free(perms);
+				rc = -1;
+				goto exit;
+			}
 			cil_println(indent, "(%sconstrain (%s (%s)) %s)", mls, classkey, perms + 1, expr);
 			free(perms);
 		} else {
-- 
2.44.0

