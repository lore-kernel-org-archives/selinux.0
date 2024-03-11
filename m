Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ABD36AE4
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161317; cv=none; b=rO75K+G00Z1zLWu+Q6HuyZZ9G9o5OegxqtPmxYt95qmU181xvsvZccwQAcAHA7bW4X75eJttfS8ff8ZNFXbn7U0Ww/ZIJzDo3hyJszZFjSEK/OWyuQICF5IH0ESwTVJoyCHofn+vfTQhuKWPzpI2qTOE5UFH20BAnmjYXOSotMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161317; c=relaxed/simple;
	bh=C4qyoLT1+SXgMEtOqviCxeuqZDKQ/UygvAw4KdX67dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sL5ncAmqtemadSe7fNPwxQ2fKuxZq2pb4QozYjkChgaIiU9qQ3P6JAjYLBJEmdfNz7nKYIyErfPVcn8+8MwJqOLRmokBVBB4XARjn/DDWfKWu+iQIHCqEs/9eUoSsZS72wNI2svtB6+TINZXFLH9GxXX6o2XJkdUhKvw0xD4dJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yt+0s0n+; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt+0s0n+"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso4132348276.0
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710161315; x=1710766115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ/NOb5/LbGKq0ewQufJCaqO1Qpcu5Y9Qc4RaTqYDAA=;
        b=Yt+0s0n+63YYA2Lnm0nAaJFvon+1EuyKcyr4bg8UcueSbCA8SUefNsswSt9Qoqkekj
         uIfgUwegKtQBlOUm+JXOVlWigEV2iJQG0Cw0x7K8gTdX/vUVGY6FMWIU1ecAEm51hSjK
         4/e9ZKhKcjs1s3304bwX9cYTovXGCm6+0aZnNW3/zbcnvDxxtRShsMJ/c4J5h4HruM+O
         RwCmdHFtZqA+vkCoMFK0amMkrVzbioa32Y0YfDEzf5BRxQWhO37VADMDrVhy3w8SgLpv
         hcHYQdWSyeKpKh+MoDZ8FX2K/D77HS+Fk2WKQ6HUIdhcLTqUUzapPSJ3sLNmRbIIiqkk
         YsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710161315; x=1710766115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJ/NOb5/LbGKq0ewQufJCaqO1Qpcu5Y9Qc4RaTqYDAA=;
        b=e1GpHqXRevzRLdoFHB92Cuvj0u8tHp/o4uN8uXioXSz8RAYo/6cAl823zba6njw0qm
         PCw9yf8kVvSsliz34Mf4dt6+Oiz9V/Cgcs2I/R4hJ/gq6U+cxlnuMJP1koueVi0mCz0+
         TBSwUIJGUqrsxZwSet5oLHuY9scqrLehPrUVe1SXTgIOhuEsyPwj8JdBR+QQdP3RL2k6
         HNsZ29bqzfBumWUJbMTxSi+Va3qbPjLGGlxklusLvOZsurQLrElLF5a/oma9MyKo2gaF
         dZXGYtt6EJHNl4dKppfqY49sa9K89GkLfGEIXBGVX+phbpqpVUBOBsT6qyIEIywR1yQJ
         krBA==
X-Gm-Message-State: AOJu0Yyae/P3KPzNoFu420IIJnJ860XoLnYyaxFp4FGAyFYXiseOAnjl
	wVieMuxC2mg+II5rkrVdA8GYBKyh4pV4Jl22s1WLZy9oV1z3gJpKxaVd6pPF
X-Google-Smtp-Source: AGHT+IFaJWW8vJKF4dx8edwvMwbfUM6I+XMXZU220F0SdnIVjfVxihX9wStSnTpqPSafGCRiJ2o89A==
X-Received: by 2002:a25:2182:0:b0:dc2:2d75:5fde with SMTP id h124-20020a252182000000b00dc22d755fdemr4642114ybh.29.1710161314668;
        Mon, 11 Mar 2024 05:48:34 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id ki4-20020a05622a770400b0042e6be98dbasm2677866qtb.31.2024.03.11.05.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 05:48:34 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Fix buffer overflow when using sepol_av_to_string()
Date: Mon, 11 Mar 2024 08:48:31 -0400
Message-ID: <20240311124832.2659731-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function sepol_av_to_string() returns a list of permissions
with a space at the beginning. This fits the normal formating of
permisisons for a policy.conf policy which uses a format of
"{ p1 p2 ... pn }", but not the formating for a CIL policy which uses
a format of "(p1 p2 ... pn)". Both kernel_to_cil and module_to_cil
skip the space by using "perms+1", but this is a problem if there
are no permissions because sepol_av_to_string() returns '\0'.

In kernel_to_cil and module_to_cil, check for the permission string
being '\0' and return an error if it is.

Reported-by: oss-fuzz (issue 67276)
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_cil.c | 11 +++++++++++
 libsepol/src/module_to_cil.c | 12 ++++++++++++
 2 files changed, 23 insertions(+)

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

