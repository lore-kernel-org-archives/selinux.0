Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE01A0B05
	for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858163; cv=none; b=pjxcwcgwbkz/tbZQMZnC+uPreEp36ncG6T/7xzxtJpQI5kKJeKydTXrPYgAr7moPRQjotCGgTmL4Tk4dCi6T3VdvpLpkSGTFic7oIiRWPJCPFYLiEDXFgKz88gw3m/j6Zt2yY9s+ydIY2X0hbfoCjtZIcQF4qNtlTZMyev6kJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858163; c=relaxed/simple;
	bh=wNFn+B6hiTZlTEcI5PFswhi9Je1QIIdLrLgkcQrzWv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mShT4OUfANPG5dde1Bp4EZ9/0uyVC8myUJHpn8G4PtzzwrG16K4S5QoRSPPndUxNLyfXJmq6hEFO2tgPbJQldbexrmFkI9FqwF/p9+swxeQN95rcJStrHNzTGhVh+j3rQJAbu5Y4HI8rqvop0xsOTm88KdWfPZ6tqg3NE2uQQWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJIJHu/P; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJIJHu/P"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-456757d8871so3197611cf.0
        for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724858161; x=1725462961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awZdDvnzwJcg8LBY1gRC0RHF1ply1ZkE68HIpbEd6UU=;
        b=iJIJHu/PpEJTP5yufX9Vn42oDnisu7R4RXD7BG3xcZ6OawYdgr68yWcSL2wg2wbF/1
         vwSfvgkc0wt4BVc1gH4IE03y3iELf5NAhZ25uJ8g+xC4PmE4N/wmNLuoP73PX1Yd+O+a
         jdRPMcavjWmtvZJJGmkot4IIuEXMfwqv1ymTBykP5QTt1CLkZQtXc29C4vcyCypogojV
         BSHUF2ay4RoFq/BAOaHgULYdbkI5sa/roFp4u04vGV5UBo373UK1EoZtPM1ApvuMsA27
         0lZtLq27IIHFmDQnlR22qVv8Ms9pIB8n3iat/DOmqnd/pOQDxVdkHU/Eq2/xDoWhQf9z
         02kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858161; x=1725462961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awZdDvnzwJcg8LBY1gRC0RHF1ply1ZkE68HIpbEd6UU=;
        b=MsKz1CzWA1aaArn3JIrSKrsYQM0Cm3vWb1qt6zLMW9IHDghbG3p5XOCwh7Dn9fl+ON
         XDhzj1g36Tc+GVKi7xRZ5UPVEJ13GzMMz5pHvJu4dl9aorIIquSMoGaDYDCFAF4XkogO
         sZCwyJWtvvd/DzsIEbkR4826VDXJzgrO32EwK5z/rMEJjPepb5HgZhb843dJAZXrbUt1
         KfL7RneSauo99Fb8mQWyKjt/eqrVNTZmNYdupPSgnaX3QefOQZ27AANbwR18KQwGzMNX
         AqxR/ijI6hJRC2+CXyVF2qx4M9IHLIbUQ55KuO1U/RjRP4jfYHapj4a+Pow9//+A5lJp
         7BlQ==
X-Gm-Message-State: AOJu0YwN22TQ4HnWauN8ayAaA5qq4QXz6CUJ4woSmOaQ/UcyghofcPM8
	QAW3eCrSmlmG1aMCzFvxQCI6k7qd5zTlmvdSwCnrN1sVidBPxlXcccEx9g==
X-Google-Smtp-Source: AGHT+IEAo9pzv5HabD+pHZDjeEja81Z8wtyTMOwGjbgx+5/oyzwuJEypMV6yGrynfpRKYm2OyS8hmg==
X-Received: by 2002:a05:622a:1b12:b0:447:f79d:cf0b with SMTP id d75a77b69052e-4566e6a81damr27532731cf.41.1724858160462;
        Wed, 28 Aug 2024 08:16:00 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe1b8c3csm62273241cf.81.2024.08.28.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:16:00 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v3] checkpolicy: Fix MLS users in optional blocks
Date: Wed, 28 Aug 2024 11:15:57 -0400
Message-ID: <20240828151557.204343-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a user is created in an optional block, a user datum is added
to both the avrule_decl's symtab and the policydb's symtab, but
the semantic MLS information is only added to the avrule_decl's
user datum. This causes an error to occur during policy expansion
when user_copy_callback() is called. If this error did not occur
then the policydb's user datum would be written without any MLS
info and the policy would fail validation when read later.

When creating a user datum, search for a user datum with the same
key in the policydb's symtab. If that datum has no MLS information,
then copy the MLS information from the avrule_decl's datum. If it
does, then compare the default level, low level, and high level
sensitivities and give an error if they do not match. There is not
enough information to expand the categories for the high and low
levels, so merge the semantic categories. If the two category sets
are not equal an error will occur during the expansion phase.

A minimum policy to demonstrate the bug:
class CLASS1
sid kernel
class CLASS1 { PERM1 }
sensitivity SENS1;
dominance { SENS1 }
level SENS1;
mlsconstrain CLASS1 { PERM1 } ((h1 dom h2) and (l1 domby h1));
type TYPE1;
allow TYPE1 self : CLASS1 PERM1;
role ROLE1;
role ROLE1 types TYPE1;
optional {
  require {
    role ROLE1;
  }
  user USER2 roles ROLE1 level SENS1 range SENS1;
}
user USER1 roles ROLE1 level SENS1 range SENS1;
sid kernel USER1:ROLE1:TYPE1:SENS1

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2:
  - Fixed mls_semantic_cats_merge() so that it keeps existing cats in dst
  - Made src const in mls_add_or_check_level()
v3:
  - Free id in the error path

 checkpolicy/policy_define.c | 72 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index bfeda86b..af8d007c 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4175,6 +4175,50 @@ static int parse_categories(char *id, level_datum_t * levdatum, ebitmap_t * cats
 	return 0;
 }
 
+static int mls_semantic_cats_merge(mls_semantic_cat_t ** dst,
+								   const mls_semantic_cat_t * src)
+{
+	mls_semantic_cat_t *new;
+
+	while (src) {
+		new = (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
+		if (!new)
+			return -1;
+
+		mls_semantic_cat_init(new);
+		new->low = src->low;
+		new->high = src->high;
+		new->next = *dst;
+		*dst = new;
+
+		src = src->next;
+	}
+
+	return 0;
+}
+
+static int mls_add_or_check_level(mls_semantic_level_t *dst, const mls_semantic_level_t *src)
+{
+	if (!dst->sens) {
+		if (mls_semantic_level_cpy(dst, src) < 0) {
+			yyerror("out of memory");
+			return -1;
+		}
+	} else {
+		if (dst->sens != src->sens) {
+			return -1;
+		}
+		/* Duplicate cats won't cause problems, but different cats will
+		 * result in an error during expansion */
+		if (mls_semantic_cats_merge(&dst->cat, src->cat) < 0) {
+			yyerror("out of memory");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static int parse_semantic_categories(char *id, level_datum_t * levdatum __attribute__ ((unused)),
 				     mls_semantic_cat_t ** cats)
 {
@@ -4233,7 +4277,7 @@ static int parse_semantic_categories(char *id, level_datum_t * levdatum __attrib
 int define_user(void)
 {
 	char *id;
-	user_datum_t *usrdatum;
+	user_datum_t *usrdatum, *usr_global;
 	level_datum_t *levdatum;
 	int l;
 
@@ -4258,10 +4302,16 @@ int define_user(void)
 		return 0;
 	}
 
+	id = strdup(queue_head(id_queue));
+
 	if ((usrdatum = declare_user()) == NULL) {
+		free(id);
 		return -1;
 	}
 
+	usr_global = hashtab_search(policydbp->p_users.table, (hashtab_key_t) id);
+	free(id);
+
 	while ((id = queue_remove(id_queue))) {
 		if (set_user_roles(&usrdatum->roles, id))
 			return -1;
@@ -4288,6 +4338,7 @@ int define_user(void)
 		usrdatum->dfltlevel.sens = levdatum->level->sens;
 
 		while ((id = queue_remove(id_queue))) {
+			/* This will add to any already existing categories */
 			if (parse_semantic_categories(id, levdatum,
 			                            &usrdatum->dfltlevel.cat)) {
 				free(id);
@@ -4313,6 +4364,7 @@ int define_user(void)
 			usrdatum->range.level[l].sens = levdatum->level->sens;
 
 			while ((id = queue_remove(id_queue))) {
+				/* This will add to any already existing categories */
 				if (parse_semantic_categories(id, levdatum,
 				               &usrdatum->range.level[l].cat)) {
 					free(id);
@@ -4333,6 +4385,24 @@ int define_user(void)
 				return -1;
 			}
 		}
+
+		if (usr_global && usr_global != usrdatum) {
+			if (mls_add_or_check_level(&usr_global->dfltlevel,
+									   &usrdatum->dfltlevel)) {
+				yyerror("Problem with user default level");
+				return -1;
+			}
+			if (mls_add_or_check_level(&usr_global->range.level[0],
+									   &usrdatum->range.level[0])) {
+				yyerror("Problem with user low level");
+				return -1;
+			}
+			if (mls_add_or_check_level(&usr_global->range.level[1],
+									   &usrdatum->range.level[1])) {
+				yyerror("Problem with user high level");
+				return -1;
+			}
+		}
 	}
 	return 0;
 }
-- 
2.46.0

