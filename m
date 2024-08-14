Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D513C673
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662206; cv=none; b=k8rSbPtRfvdt+XwbF+R491ouBdhvyMRyTH8tetLyF5r1QrV5XxRzV7n8p75k1swXR8fQrWjHxxFZmOPwLjOoRcjFeng8FDNjHgaepjkadvyhUhr5qqqJtsQGCt8uOVfGhWwoUgAz2ujaNsvv2MO+W5E5QOMZrZLmXU4FmaBJqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662206; c=relaxed/simple;
	bh=G002c3YHdUFOSN+pVr+iCZo28ewT/j662fYivFuQdho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AM2NvM9/vTpt2gq4gmUmunNKViV9RnaoW0q3X44vdGnA7JLMPYLsykcngeByOk7XPjuvNuKK2i7jDOUwpQzUN8ZkxTVDDiPW2sCu8ZKhpnbYlC6D0JKAU/hNJErkjyBNRToC4lBk0qUEgatAt+87eYiBOhN806tuGbqOc1wu5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8LLhUyS; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8LLhUyS"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1dcba8142so102547985a.0
        for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723662203; x=1724267003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RkArsO+T2c0wilyfT1wVl7081SkmPeixxTpk4TMtrrg=;
        b=Y8LLhUySQmm08u6h/61QbJRkTaYh3jyXG/AgH8a1D4wxx3iTpssmOiNaoL8/xpucQ+
         E9D91NzPwJ1NNanCBjkfxr8L4y0KYHfwFlUirtLVErHEmcdiOkjSuNuscsmh1FWiY9s5
         ujKpkycYN9rIDZcbtwkVdUo+jtJ3vzFmCebdtoSypZYUk78XV2WdgqXw/Dsh5IUx63NC
         5Kw231xRQIh1kAz7IJFY1cfrZ8MQyJZaPVm94Nt/o0iXlX2O3rccIZPeRFj2cxLcVR0+
         NyHcN83oNlhW6mp6rWr/4JoW4XUgQMrfOt6LH4fNzh0JH4ro7azwdb0S1W5gqyxc+69q
         Jq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723662203; x=1724267003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkArsO+T2c0wilyfT1wVl7081SkmPeixxTpk4TMtrrg=;
        b=igshmtUU3cydp1snW+xekiGjsP/PZHzjf8a65nf+c07WHJi+YSfIkmrv0Qhdb9NigM
         3hfxnj+PQNyyq4+p/H8eqq1KBUzvFivovloEJe3LWlWRX1JuP2JsKOFWymwiWeBHvxou
         S+10zCUein+hCyXCm8666+QMRydg64HRiwZ8IinT8J9SlVaynYrCFP11Pw8mZvg+cK5W
         tn6S6yuqGEr/7KLVUCx92u4qA1drE78qeNghwEMT01+keLrGD3g0zZHSHrtK3RuZcUmL
         eJZrCvVLgbuSnMS2LfPLIJIFDMfGjvZLNcks9DV+ufQqGjE9Rri2e65iaaG33LMmJ57q
         ncsQ==
X-Gm-Message-State: AOJu0Yy1geKNn44njPcgBUVN0np+ZIT1aw29lGmpjv6UoCrwzKPVCVOU
	04UEGnFOvaMj0F4rrI83napOGiZ0IYTBkscl9LNCTRZbbyuP1MmMCQzFmA==
X-Google-Smtp-Source: AGHT+IGB52Ba+VTy0ifd3c8xAacltRAlXuch05jkpzKy49ZCipUi3Rc2gHF7alNSGr/rWwTUR2papQ==
X-Received: by 2002:a05:620a:4001:b0:7a1:e341:d543 with SMTP id af79cd13be357-7a4fd23043cmr95972285a.28.1723662202492;
        Wed, 14 Aug 2024 12:03:22 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1c532asm44621391cf.30.2024.08.14.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:03:22 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] checkpolicy: Fix MLS users in optional blocks
Date: Wed, 14 Aug 2024 15:03:19 -0400
Message-ID: <20240814190319.321748-1-jwcart2@gmail.com>
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

 checkpolicy/policy_define.c | 71 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index bfeda86b..52045484 100644
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
 
@@ -4258,10 +4302,15 @@ int define_user(void)
 		return 0;
 	}
 
+	id = strdup(queue_head(id_queue));
+
 	if ((usrdatum = declare_user()) == NULL) {
 		return -1;
 	}
 
+	usr_global = hashtab_search(policydbp->p_users.table, (hashtab_key_t) id);
+	free(id);
+
 	while ((id = queue_remove(id_queue))) {
 		if (set_user_roles(&usrdatum->roles, id))
 			return -1;
@@ -4288,6 +4337,7 @@ int define_user(void)
 		usrdatum->dfltlevel.sens = levdatum->level->sens;
 
 		while ((id = queue_remove(id_queue))) {
+			/* This will add to any already existing categories */
 			if (parse_semantic_categories(id, levdatum,
 			                            &usrdatum->dfltlevel.cat)) {
 				free(id);
@@ -4313,6 +4363,7 @@ int define_user(void)
 			usrdatum->range.level[l].sens = levdatum->level->sens;
 
 			while ((id = queue_remove(id_queue))) {
+				/* This will add to any already existing categories */
 				if (parse_semantic_categories(id, levdatum,
 				               &usrdatum->range.level[l].cat)) {
 					free(id);
@@ -4333,6 +4384,24 @@ int define_user(void)
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

