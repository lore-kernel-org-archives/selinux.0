Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518EC14036E
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646387; cv=none; b=qBKmrnB60mqsJ5Rnjxz1/Ke7zs9y05ZVsf/u6g6zn/iyCF+MsEsQalhR5s+hhrVLWIxURuyQap8V/78OMwoTq1XRcXrinVtDwL7Gwks07ZUeLHzhA9b8rL1gzvgG74x/dt4PWy0pFb6hs22Jn5Gs5sSjR8DFcA1h8T4JvDBjhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646387; c=relaxed/simple;
	bh=aM4vSla3FklEqzpSwFgI1CX/2aoG7RSbRnBFkFDJKcw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7zBOLI7FWKqxwPI+wTyy4cI0S+1OLOgcEJS9Mkt5gc/Awp44vh/o2rHigXnoIKyf/gaPgPCQRjg9h++dZNkwkMzPp+/hENo4Hi16e0T8eJrRg+l5QGTrwmNIlehryxPkHZUMGrXWVzZxCleZ3zxFgPtcR6CTYjvcLuePOo9XLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CLdO16AP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CLdO16AP"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-787a405e724so20671085a.0
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646385; x=1709251185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v+qkWGnNrZij6xJdUWz2TmdhdmHC1pGGdlSTc8y4WI=;
        b=CLdO16APTOsByrJPdnwEOYfjWol3rzxjyHqw0Ro3OQ0vG65vM57r2b8S6pHx7lL8Cb
         4RRi5nTdCgBByCjY2p+4SyTo6SFdHV/dz9guvlpVipgoTa44sxpofs19aS/tzsNfWqA/
         5ZmMyv2ViDzHIZQTXgJY3nh7ECDSMFZY4lbJdzT/BHXE/bKVNClyQlteprSZm/po/CWE
         c8j36olPaRAkrOBSnYIYFAq8fzYeaaIc8jzYgbSo7QxvHjVHjFOXpc/nBDQaouEa2gs2
         /xbMysZck3+dpHFAp3SqiZSzDT5XNGu2KBvhzk1aRKWwT7nQ1jGS2S9pxPmL3wOzepNu
         0FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646385; x=1709251185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v+qkWGnNrZij6xJdUWz2TmdhdmHC1pGGdlSTc8y4WI=;
        b=XYSRPdooIoo1/ZEJrJBCJnGcmH0ZThbKhJxlIqaa8pP8L9NEPMB1hhidBTVozAyZuX
         BK5D7opUsGG7D/+P9fffnSiQvEQL5TOuGvxnD9pTZ37S2taE/4dcTjOH5rujL2lcTyo9
         tuEDPQL98jbkGttBU3WRvcqUlBPY1wpV0BdN9KHeKlIDDxD+9vmYnBNM/c8s07FM2DCF
         82NPKg31uqQON4qn5tiqZzM6Fd4XKzH1zAX0PXsjIISr3R1GO8kQM9MZ7Y0sZsXbupi1
         aTQiwJ3m/JSobW+mLt66xvVHqFwHTL0MDZftA5TTtxecDnH2yQzFkmVDPjC9a2dk7xYV
         n/0A==
X-Gm-Message-State: AOJu0Yy0AaYbr/c+TIYqmkQjuZ746VFvruqzJFGO+54fgNubZBUsYje2
	mpNo0EtKR33Nn6/nTzaarcvPrHT84sSXz/R5Gnj9PXbpF5l3DSHj0tZW7OG+imDWDeF2RzBO488
	=
X-Google-Smtp-Source: AGHT+IHKrb11vv0OybUHBRD8awqyZuvEU8oL9dYGzbZ/B0Zv4wZWBp1U5bVHGnklzmFO3ctOwvrxUg==
X-Received: by 2002:a05:620a:385c:b0:787:9e79:6f5c with SMTP id po28-20020a05620a385c00b007879e796f5cmr520701qkn.49.1708646384912;
        Thu, 22 Feb 2024 15:59:44 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c20-20020a05620a135400b007877f9d9e11sm2564920qkl.119.2024.02.22.15.59.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:44 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 12/21] selinux: fix style issues in security/selinux/ss/mls.h
Date: Thu, 22 Feb 2024 18:52:30 -0500
Message-ID: <20240222235708.386652-35-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4330; i=paul@paul-moore.com; h=from:subject; bh=aM4vSla3FklEqzpSwFgI1CX/2aoG7RSbRnBFkFDJKcw=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19+c+4FgS1XjrF1uyPW0pnx6jq4Ao4RFfudKq YbEsHno82yJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffnAAKCRDqIPLalzeJ c1IZEACf6xRqTn2W4BThlr1uuprn1rBbVMIK/JuwgkrWwUXqYOtox4DyHyJOsUlyoxm2kOjC3vS 4F2jjn0ykS0w9rI9aZ4gewFvqXM7lY069BY4tF8XAZ9rie28mCBJk1JCCHpDru63XhsSgGD2j1y 7BpsFHboQt5xX9wPMlT2Kf6mx61zZmRKnbkiluDtfRHIRca4/HnUGfX9nBmQrOzJnXFLoeWFl6P OnQl3uxr07uQo9sDGpx1k8D5GUrbsjGoofbndffDUv4W6nBe2zpLzleCoA4os+DgszZS7mO0Mex mRmwbeYolT0fO5XSfeZRk/reaY186a4pGq2mXwg/g2CmyUrRluwvvronl2VgqLBDaZD0fVfuD2V jw6fViCuQGTcOcbqg4e94chAlKkACmLkQewO0HTFkpMpg1Vx7h3cifJgda61RRaxE3TiQ3afi0f 1SEY9gXh38ECZM1QAS+6BhrTzTsJb89xNPtk9nu8Oc262/bnJ5OhGMHAFR/PSE29YmHH3KxBZDl GXvDaCjX06ct6hIzEvHeEBwfJWvJ+dFLDBocw5c8VfPF13Gzp92t+cWsU6KtcAV6xoBlCkd27K5 10m0ptKV6f5Hpff78Ur0Ma25RRvZh0Vjh3UQ88QdPvwtN+4tURSVcyIUPGkMKd7jkaY+VgblpYr fQKd+V6eKIdwGOQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/mls.h | 58 +++++++++++++--------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index 107681dd1824..07980636751f 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -4,19 +4,15 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ *          Support for enhanced MLS infrastructure.
+ *          Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
  *
- *	Support for enhanced MLS infrastructure.
- *
- * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
- */
-/*
  * Updated: Hewlett-Packard <paul@paul-moore.com>
- *
- *	Added support to import/export the MLS label from NetLabel
- *
- * (c) Copyright Hewlett-Packard Development Company, L.P., 2006
+ *          Added support to import/export the MLS label from NetLabel
+ *          Copyright (X) Hewlett-Packard Development Company, L.P., 2006
  */
 
 #ifndef _SS_MLS_H_
@@ -35,47 +31,32 @@ int mls_context_isvalid(struct policydb *p, struct context *c);
 int mls_range_isvalid(struct policydb *p, struct mls_range *r);
 int mls_level_isvalid(struct policydb *p, struct mls_level *l);
 
-int mls_context_to_sid(struct policydb *p,
-		       char oldc,
-		       char *scontext,
-		       struct context *context,
-		       struct sidtab *s,
-		       u32 def_sid);
+int mls_context_to_sid(struct policydb *p, char oldc, char *scontext,
+		       struct context *context, struct sidtab *s, u32 def_sid);
 
 int mls_from_string(struct policydb *p, char *str, struct context *context,
 		    gfp_t gfp_mask);
 
 int mls_range_set(struct context *context, struct mls_range *range);
 
-int mls_convert_context(struct policydb *oldp,
-			struct policydb *newp,
-			struct context *oldc,
-			struct context *newc);
+int mls_convert_context(struct policydb *oldp, struct policydb *newp,
+			struct context *oldc, struct context *newc);
 
-int mls_compute_sid(struct policydb *p,
-		    struct context *scontext,
-		    struct context *tcontext,
-		    u16 tclass,
-		    u32 specified,
-		    struct context *newcontext,
-		    bool sock);
+int mls_compute_sid(struct policydb *p, struct context *scontext,
+		    struct context *tcontext, u16 tclass, u32 specified,
+		    struct context *newcontext, bool sock);
 
-int mls_setup_user_range(struct policydb *p,
-			 struct context *fromcon, struct user_datum *user,
-			 struct context *usercon);
+int mls_setup_user_range(struct policydb *p, struct context *fromcon,
+			 struct user_datum *user, struct context *usercon);
 
 #ifdef CONFIG_NETLABEL
-void mls_export_netlbl_lvl(struct policydb *p,
-			   struct context *context,
+void mls_export_netlbl_lvl(struct policydb *p, struct context *context,
 			   struct netlbl_lsm_secattr *secattr);
-void mls_import_netlbl_lvl(struct policydb *p,
-			   struct context *context,
+void mls_import_netlbl_lvl(struct policydb *p, struct context *context,
 			   struct netlbl_lsm_secattr *secattr);
-int mls_export_netlbl_cat(struct policydb *p,
-			  struct context *context,
+int mls_export_netlbl_cat(struct policydb *p, struct context *context,
 			  struct netlbl_lsm_secattr *secattr);
-int mls_import_netlbl_cat(struct policydb *p,
-			  struct context *context,
+int mls_import_netlbl_cat(struct policydb *p, struct context *context,
 			  struct netlbl_lsm_secattr *secattr);
 #else
 static inline void mls_export_netlbl_lvl(struct policydb *p,
@@ -112,5 +93,4 @@ static inline u32 mls_range_hash(const struct mls_range *r, u32 hash)
 	return hash;
 }
 
-#endif	/* _SS_MLS_H */
-
+#endif /* _SS_MLS_H */
-- 
2.43.2

