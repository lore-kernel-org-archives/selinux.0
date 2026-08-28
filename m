Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096B346A14
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948656; cv=none; b=FL2n1A1UTKyRBciuvyYgDzplQxd3htOZH7BdLW/GJyr0mg8ipEwhbMWizZEJSusZhNEK5BX61avTuG00f1gIhhWia8B4CW9DtPA1QVSsh69iervsf/k6zTVq0C3LeGuZT3no5SGk5100fYYT8klgmH0YI2UyughR/eFZFnmiWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948656; c=relaxed/simple;
	bh=bJ2qI8n8MRLuELujalm02jSraj/mYN/ggN4Ti8CdFC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KsbYUD1FuaZYzBEB6xrO7DY1G6IkvhKU1WByuB2DM5ucJ/S5F3XwFyUxtGYuDMUldMkDsNVfYKXtQL8+mKpGFNaWg8wVHzJ5j2aKojUioDm81zkj2aUDc8Ej5jry014O8XrfnwwiNrRLLtFvTXz12tFqy7bvXPUxvZiGSyVnb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzoI1I28; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzoI1I28"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52fbb20c30eso9301901cf.1
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787948653; x=1788553453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qxwxB18lFGJQirPk4Gku/+LnY+cv8UnIU/Bbso2V9Vw=;
        b=DzoI1I28iCyJWrjj6WmOATt797hcvZHVmiGhGAtfsFnSyS8rXCj4e8B4JsJkvlu3+h
         IflksGH+LjXbLZVtyZq1FSiun9jEXhxqqqT95LKNptMXiVZcdeTBKBFFIIRKERNg6gyQ
         3egMvs/59bne88slIZ/u0rR5w4wy5IwUQ57ot35z59Qx9B2448JOEwUKW/roD+1Pwh2z
         FqPG8FjSodAsEDI0FncxkY4Gm4U7bevs7ku9OdX1Cs6klI/IFHIJ3+Qkhqe+ZkivYyHF
         mFFxz0lG0eZmXEtmPAkG2cCfyaOemEK+ERMLmYdnzlfjr7yI985g76i+OEzQHtc1dY73
         HnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787948653; x=1788553453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qxwxB18lFGJQirPk4Gku/+LnY+cv8UnIU/Bbso2V9Vw=;
        b=CynNxI0F8tlivBmrsPla11BOu4INlbmKe10SncG9mEqRUOpt+IrXqmz79SnLAz1+cK
         r8OdkTZhfEByoFHSdv52eVdow9Cg3qBIRVKUe8T+SRBRadOCYyZ5P7ls2KA1PzqpWBGb
         XPSAz9o6eEnMxv6GAQ5rVAadb7VekXm7NmxmxIQw3n5JnpKTnwLMYWIV5c4KpR+0NvND
         a3VTD+SVniqK7cp8SdPN1B93DYTx3e31qOH1j+usuIIPx0czr8Z9+4oFXH6iXIrnqQe4
         tvq0PDKqs0fTjyKQcXZ9usZRUV8lxMlT+b9VoY7lQ3afpJtCgvKKLaCJLVmY0wWOVV6O
         JjRQ==
X-Gm-Message-State: AFuF++khUr/RBaTVze2fL3n2ENbPdxnCfLI2AczrbAAw4JTQiJvc4mOr
	bGhIIicWhZCZ0nak+I+3l6yn64GnRoTkXnjvkZleAN/A3tQAZjDa1ZFw3BHZ3A==
X-Gm-Gg: AR+sD10d80vuCLC7T5BGpHfbsFvwP6GU+hPi115xn65KBpuJ9wPLMZSfm6xNQOy5NJ6
	qskgMBCIQfQyTAxKm71o8FZylY4Y3rmJhHhfS6z7dihrrK+SctVDdtZZbxgHocK+Kf8uG0/rekW
	OniDwRSWpUtxYT3Qm6nMOLJMYcB+lRuQuR1FwoUWJkfyACv6cBtRb70ja9PuxSEwFALnns/3LZk
	u+D79NSb7QSdWGr40MJCXZAFHJqsaRL0lTYDDR9DkszG6BsSPg0lYcEsmv2dctpolql/fLJ86jq
	mfEoTJSSaCrfGvKjDCjdvIsNEs7TYEjbDKIOryS9F1dSgfOwkdYxocAkZJ299HQOfPlrAKaE2nT
	UH6nraHQCKIruFBBUHSRWcKxeU+yej55WKUPlzILkvf7vZJIgC9RMXu1Q7A5cyvsENmre0romU9
	eVf2TxrXFV7lH/rxCWk+4ioAwb3Arxxwy5hNA2Sllu4cRT2wl3sesHGzm0fSKcno4QX1Vw8B/N8
	4mFrHBcNpHN711FCedutigiEFy0RUgH+jJkBfrsKWJLBymACh2NR6gxkrHl0Cab
X-Received: by 2002:a05:620a:a299:10b0:937:80a9:94b4 with SMTP id af79cd13be357-9391379488fmr878570885a.2.1787948652910;
        Fri, 28 Aug 2026 13:24:12 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173a737dsm216538085a.23.2026.08.28.13.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 13:24:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: remove unused mls_setup_user_range()
Date: Fri, 28 Aug 2026 16:23:50 -0400
Message-ID: <20260828202350.110547-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mls_setup_user_range() was a helper for security_get_user_sids(),
which was removed by commit ad1ac3d740cc6b8 ("selinux: prune
/sys/fs/selinux/user"). Since mls_setup_user_range() has no remaining
users, remove it too and any other helpers that only it was using.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/mls.c       | 38 ---------------------------------
 security/selinux/ss/mls.h       |  3 ---
 security/selinux/ss/mls_types.h |  3 ---
 3 files changed, 44 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 40c62600650e..b48f8256dd4c 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -400,44 +400,6 @@ int mls_range_set(struct context *context, struct mls_range *range)
 	return rc;
 }
 
-int mls_setup_user_range(struct policydb *p, struct context *fromcon,
-			 struct user_datum *user, struct context *usercon)
-{
-	if (p->mls_enabled) {
-		struct mls_level *fromcon_sen = &(fromcon->range.level[0]);
-		struct mls_level *fromcon_clr = &(fromcon->range.level[1]);
-		struct mls_level *user_low = &(user->range.level[0]);
-		struct mls_level *user_clr = &(user->range.level[1]);
-		struct mls_level *user_def = &(user->dfltlevel);
-		struct mls_level *usercon_sen = &(usercon->range.level[0]);
-		struct mls_level *usercon_clr = &(usercon->range.level[1]);
-
-		/* Honor the user's default level if we can */
-		if (mls_level_between(user_def, fromcon_sen, fromcon_clr))
-			*usercon_sen = *user_def;
-		else if (mls_level_between(fromcon_sen, user_def, user_clr))
-			*usercon_sen = *fromcon_sen;
-		else if (mls_level_between(fromcon_clr, user_low, user_def))
-			*usercon_sen = *user_low;
-		else
-			return -EINVAL;
-
-		/* Lower the clearance of available contexts
-		   if the clearance of "fromcon" is lower than
-		   that of the user's default clearance (but
-		   only if the "fromcon" clearance dominates
-		   the user's computed sensitivity level) */
-		if (mls_level_dom(user_clr, fromcon_clr))
-			*usercon_clr = *fromcon_clr;
-		else if (mls_level_dom(fromcon_clr, user_clr))
-			*usercon_clr = *user_clr;
-		else
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
 /*
  * Convert the MLS fields in the security context
  * structure `oldc' from the values specified in the
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index 93cde1b22992..c107b5182fb7 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -46,9 +46,6 @@ int mls_compute_sid(struct policydb *p, struct context *scontext,
 		    struct context *tcontext, u16 tclass, u32 specified,
 		    struct context *newcontext, bool sock);
 
-int mls_setup_user_range(struct policydb *p, struct context *fromcon,
-			 struct user_datum *user, struct context *usercon);
-
 #ifdef CONFIG_NETLABEL
 void mls_export_netlbl_lvl(struct policydb *p, struct context *context,
 			   struct netlbl_lsm_secattr *secattr);
diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
index 51df2ebd1211..d36a03f104c2 100644
--- a/security/selinux/ss/mls_types.h
+++ b/security/selinux/ss/mls_types.h
@@ -42,9 +42,6 @@ static inline int mls_level_dom(const struct mls_level *l1,
 #define mls_level_incomp(l1, l2) \
 	(!mls_level_dom((l1), (l2)) && !mls_level_dom((l2), (l1)))
 
-#define mls_level_between(l1, l2, l3) \
-	(mls_level_dom((l1), (l2)) && mls_level_dom((l3), (l1)))
-
 #define mls_range_contains(r1, r2)                        \
 	(mls_level_dom(&(r2).level[0], &(r1).level[0]) && \
 	 mls_level_dom(&(r1).level[1], &(r2).level[1]))
-- 
2.55.0

