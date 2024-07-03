Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35D191F84
	for <selinux@vger.kernel.org>; Wed,  3 Jul 2024 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041108; cv=none; b=u0m+3n3Od33DK8ziej9V6TVS/NdBGOzoXEJtZzEH+KPDzoVBA+jCvawAD7dKvrh33fmIeK/IeTCROeliBObcxD/V9XAHv6JFK5AWufh5ZPLoJfN2ooT6c2yqOKa3GN1akvLxMmnuUuZvAbKmD/FnFUdmDa5UnGMKaJhpPATSioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041108; c=relaxed/simple;
	bh=wZFvPplBA5czywCUBflHPzgRNL0Sq05dZrkZr5gs9eY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=or9eWjBojqyAVzd1ay+xVzbL/fV9zelpNP5OZQvEHEhjcpBR2UZ7nlKGEDb8H7eLlOACQB+vPIBt3rYqx8H4aH2SUXOH7za5LFsnKXlysdSlYRD/dzfjZ7vRrz1fWc2C+RbCK98KySANqio4Aqfqz8jUOGXW+JdE04d6RVIQWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dqUlOhFk; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dqUlOhFk"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b5dc36b895so45676d6.1
        for <selinux@vger.kernel.org>; Wed, 03 Jul 2024 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720041105; x=1720645905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnyKkJVgC/cQ7dQRIq7KgfEKF2f1km9Urn3V2lCE9SQ=;
        b=dqUlOhFk839RBf1GXb1IaazAdFMVmap444bu7809AYy7N2kzeAhbCmkuHmi6EgpwLN
         Ics05Z0zGA7n+DvJEW/gjjEsPU0Iq35w5ibN4K0xeC+tYTSmQdJlcJB63DvZyiazRTKn
         IOA7ZwKWyQlETeN8GfoiUbiFBtGV1ttTLCFHib3MUF/WBCY15v3UmQY3+GxmhritG0zi
         BDtpiRaxI0CQ8VT2pWM59A3c+8RbTGDmgpYy2pYSeOviTiIj0mlT9V9fBqEnDuRXpx1p
         rtYS+BAIVOMK0s5iGBrUaQVo8IkqdDcIBY+3dWsrh7EqV6kbdSCACRQc1jpErY6KgfHS
         F2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720041105; x=1720645905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnyKkJVgC/cQ7dQRIq7KgfEKF2f1km9Urn3V2lCE9SQ=;
        b=l3BjFVG7LVVDeY3ta2/5vD+1ncYzj0Ea6rASFNGExPowteW89ifzbJR7VJmvrW3Niq
         RZ6b82AGYSXWby6CR09Wgbxzcxa20mqPn7DWEq9JPQYuWNu7wlILxfIVdLKBzJ4DYuL9
         ELrT+iAHsjfoJeDlr9XHEFYPs5tG5YyaKC+Za0CkM52T9L0NKb+BxAUvL+erQnHD6k55
         KJtnJBhAQK9dVuOxpNfyt0M/dAl9plc6p/fb3bD8hWVRUSgIhxObLN9+hwKkA7IbLvFu
         FZhZeTvO4DwY2ZOJkKrmzsXyj4TfkNWzoafVkFeizgJuJDuvEtXiYWKAofYize0Cf7hr
         af6A==
X-Forwarded-Encrypted: i=1; AJvYcCVoqZgFyD30wR3II4Mj82IhiPKAVyef6IAIfZZOCRVnT7SuuhvKeY9KQJ4u0Qx/xhiihB+n3tjAYWyTIbe33vDq7+O4/Er84Q==
X-Gm-Message-State: AOJu0YwvDF1aw/AgcIhVIHg9rjnzN1IC85jAHx3Xp/aBZy4eGj9hC+L7
	VQjUP/PV+UxFXVJS7WK0VLDzVqAmRaNFDIl9RmdIO2H+KXu14GHP9mufZe0b2/IkwwucsqTxrtY
	=
X-Google-Smtp-Source: AGHT+IHLe73UD4amcWFSbKp1vSKLhzE6MAdHDNTLaNkVgOXw3n2FHCKQoQPnOSjPVk/Us4GV+TzmOg==
X-Received: by 2002:ad4:5eca:0:b0:6b5:e7c8:5493 with SMTP id 6a1803df08f44-6b5e7c859ecmr10333986d6.50.1720041104940;
        Wed, 03 Jul 2024 14:11:44 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e368456sm56959546d6.7.2024.07.03.14.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:11:44 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] selinux,smack: remove the capability checks in the removexattr hooks
Date: Wed,  3 Jul 2024 17:11:35 -0400
Message-ID: <20240703211134.349950-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150; i=paul@paul-moore.com; h=from:subject; bh=wZFvPplBA5czywCUBflHPzgRNL0Sq05dZrkZr5gs9eY=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBmhb6GiiLz0e89gj4sxPP7pB5ETACOtTVb5Die5 xojeZkIffCJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZoW+hgAKCRDqIPLalzeJ cxeuEACN4tI4iJBkq6zWO9wFqEVysWS+OPXDiThkObO4c+2TiNz+1WQLyCRio8UOC5WTaOApuZS V6S9gquK/aYjwMNdSldFcIk00xG3BNsvuhldA0Xt4dw1WNCPnfY8QFM8AFWhO26/hSyJLfmXwk6 aWwv+lGzdE3pEFpMuwzU/U4UJul6OG+o8qtla2IFf3PmcgO2fRklCIpeWVpm6n4SYfvYAzKrvYH 4gHURWJrROlnf2J38gDN4lSOFaV6lM/VCuop2YuoYSTMHhe1wnhM159r2G3El0duEi09+CdVfv7 K4uMVU8oNQu/Y5K384L+C3Kfn/ZIQ1fBRaDGzkXvy0/gyJXhWMSmGfbQVaET1y14xo7h+pWpz3S FL3BrG0KId+11JAmZnpx5Hk0BaSaVeCMSTEJ/AuoobcJhUswiO3pg+s7dbO9+DmMeCHBp+ll+HY nKHEsAEIJ4HuZohLyxCFjr5N9tni08tgFavXy2v+Zi9UCnwmfGLMMP/U3rwmn91lTnWtdG4nDYj CTo0S+jAPWGxm0DwkJe6ruS5ObtcutY46uIbdBuMhcniQ4834l8z0Mj0i1VLB1KA1/SsgLQJoqf tVjuvzs8scBu4JplqKJq5dcBkErfvG4kNrIl1v0mbNEXDHzTLQaExvr0SM7oaWDeGqNZ5B2Y7DW jMLpdM+aqDy1C3g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Commit 61df7b828204 ("lsm: fixup the inode xattr capability handling")
moved the responsibility of doing the inode xattr capability checking
out of the individual LSMs and into the LSM framework itself.
Unfortunately, while the original commit added the capability checks
to both the setxattr and removexattr code in the LSM framework, it
only removed the setxattr capability checks from the individual LSMs,
leaving duplicated removexattr capability checks in both the SELinux
and Smack code.

This patch removes the duplicated code from SELinux and Smack.

Fixes: 61df7b828204 ("lsm: fixup the inode xattr capability handling")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c   | 10 ++--------
 security/smack/smack_lsm.c |  3 +--
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2daa0961b7f1..c41bf07d4b06 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3356,15 +3356,9 @@ static int selinux_inode_listxattr(struct dentry *dentry)
 static int selinux_inode_removexattr(struct mnt_idmap *idmap,
 				     struct dentry *dentry, const char *name)
 {
-	if (strcmp(name, XATTR_NAME_SELINUX)) {
-		int rc = cap_inode_removexattr(idmap, dentry, name);
-		if (rc)
-			return rc;
-
-		/* Not an attribute we recognize, so just check the
-		   ordinary setattr permission. */
+	/* if not a selinux xattr, only check the ordinary setattr perm */
+	if (strcmp(name, XATTR_NAME_SELINUX))
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
-	}
 
 	if (!selinux_initialized())
 		return 0;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a19a94f27766..9f8a8ffb5dde 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1461,8 +1461,7 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
 	    strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
 		if (!smack_privileged(CAP_MAC_ADMIN))
 			rc = -EPERM;
-	} else
-		rc = cap_inode_removexattr(idmap, dentry, name);
+	}
 
 	if (rc != 0)
 		return rc;
-- 
2.45.2

