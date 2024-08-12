Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019617A5B5
	for <selinux@vger.kernel.org>; Mon, 12 Aug 2024 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491657; cv=none; b=XvrqT+tDXuh7r9O0nRSghFYa8UlJoZoyvKh0VnD5KW7BJIF4nqFT1HfP1MEyPiSbwBx8gkaRO2Cvl1UC7emtGO2alkUpz/i3KOwpPQpoOj0EeweQnV+dxsnemF/7tm+OrO2nonoTE045ENqczE8iKYKuElSoAc9ZKAIJ6gDctYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491657; c=relaxed/simple;
	bh=3RT3tSNJ8RTra45XOSaGVN6bLlCdVTr88Sehqse7fM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qT4b8sgZ58CzfwVZRDZdugmxWX6ibOf6EEEOMimbpAofvAA4dG1yt5CZf/yhASrau12Bg+ePnFSyqePprZibsNyfEnuPd8+2cuPyfNHoKT+sTP12Q/KqWfPYtvvAWgZE0idYj+XMA7JGm0+z/+rogW02gkmyqffTPGGh5cf2C64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T02XdC9w; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T02XdC9w"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d7bc07b7so320984085a.0
        for <selinux@vger.kernel.org>; Mon, 12 Aug 2024 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723491654; x=1724096454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LrGhmMumGE3InSdwb2tlclYBkijg0jUNGDk7LEbEuYA=;
        b=T02XdC9wWb0X5OS3V7bQQ/DXz7YPylGX0ZZwMWSpOsfbqenM2FIDZs6K40CLHsklF3
         GFNtcJeeSqCeTtr3tp2CKJa0ELl2FR7KDNdHlINkyNduHAWlvX+pM6IFxbOnxQzJWZ/G
         5t1eOS+phkGUJBzgvfaZPtR2pwJlxT4P5Z14jRWz9ugGAXQncOnex0RwucHeN871RVQp
         1VHU3clXi30MnNDVNNf5L5gif8Rfclou0b29M+kK4/EHTou3RUFADwxo4yO59DvMGZSN
         iLw0dBHo3Y0C4J9fZpvsC1/Six3/G8YYQp1VXnz0PKICIeEuZZ8jAJz3/1Op//xqhNFM
         FY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723491654; x=1724096454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrGhmMumGE3InSdwb2tlclYBkijg0jUNGDk7LEbEuYA=;
        b=Vkx0KEw1bXIoqfP6onmRWyHwp9oyvHbNAi4EhYJcmNE8423EIaFgQG10COnOdTjmZF
         xGcDl115Ln8rer8xO6by9tirC+1SPAizFb07Pw5fKi3iUhyvzzn2I20H9OFUSpLxQYps
         OqEwGGHwyJFXU4Sh+L5MNQy4Q1aFv9bUXFCbgLFhP3T5AzFBI18bkRNNDx5q+AcrH9e+
         uI1gJtIxqJmsT07i1jbcBGo8tPKEtXYPMBI8/IAn4Xaa9SYmjUMYKszXzppGi+EWiQNI
         GkuGEolfGmABM04wSg8eHhv9vJK6y0WkPWYGhe0G9KhJdXydEYspnXhBUhPKSbrf2hmO
         CZ+A==
X-Gm-Message-State: AOJu0YxkuPaDW9hq2Qkoa/KMVxU8tSqX/jRfk4cWpfL/GlMjySHyh/F9
	2DKQlYScC0Qo0QJmCkAvnVVd/p2DmSqUyuab/nwfIgkMZtc4hjH7kyxYeQ==
X-Google-Smtp-Source: AGHT+IHfOTzOD0jqHNeF4rNTUHNkkXP9eE7SvOgFZ/sKYs7EIhC1MjCaMLcf6FMfogp9mstiELtL9Q==
X-Received: by 2002:a05:620a:4441:b0:79d:6349:32de with SMTP id af79cd13be357-7a4e15040f4mr161829085a.7.1723491654145;
        Mon, 12 Aug 2024 12:40:54 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e04175sm272314385a.112.2024.08.12.12.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 12:40:53 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] checkpolicy: Fix MLS users in optional blocks
Date: Mon, 12 Aug 2024 15:40:51 -0400
Message-ID: <20240812194051.66157-1-jwcart2@gmail.com>
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
 checkpolicy/policy_define.c | 76 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index bfeda86b..93a1397e 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4175,6 +4175,55 @@ static int parse_categories(char *id, level_datum_t * levdatum, ebitmap_t * cats
 	return 0;
 }
 
+static int mls_semantic_cats_merge(mls_semantic_cat_t ** dst,
+								   const mls_semantic_cat_t * src)
+{
+	mls_semantic_cat_t *new, *dcat;
+
+	dcat = *dst;
+	while (src) {
+		new = (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
+		if (!new)
+			return -1;
+
+		mls_semantic_cat_init(new);
+		new->low = src->low;
+		new->high = src->high;
+
+		if (dcat)
+			dcat->next = new;
+		else
+			*dst = new;
+		dcat = new;
+
+		src = src->next;
+	}
+
+	return 0;
+}
+
+static int mls_add_or_check_level(mls_semantic_level_t *dst, mls_semantic_level_t *src)
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
@@ -4233,7 +4282,7 @@ static int parse_semantic_categories(char *id, level_datum_t * levdatum __attrib
 int define_user(void)
 {
 	char *id;
-	user_datum_t *usrdatum;
+	user_datum_t *usrdatum, *usr_global;
 	level_datum_t *levdatum;
 	int l;
 
@@ -4258,10 +4307,15 @@ int define_user(void)
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
@@ -4288,6 +4342,7 @@ int define_user(void)
 		usrdatum->dfltlevel.sens = levdatum->level->sens;
 
 		while ((id = queue_remove(id_queue))) {
+			/* This will add to any already existing categories */
 			if (parse_semantic_categories(id, levdatum,
 			                            &usrdatum->dfltlevel.cat)) {
 				free(id);
@@ -4313,6 +4368,7 @@ int define_user(void)
 			usrdatum->range.level[l].sens = levdatum->level->sens;
 
 			while ((id = queue_remove(id_queue))) {
+				/* This will add to any already existing categories */
 				if (parse_semantic_categories(id, levdatum,
 				               &usrdatum->range.level[l].cat)) {
 					free(id);
@@ -4333,6 +4389,24 @@ int define_user(void)
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

