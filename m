Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3648366568
	for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480831; cv=none; b=ntHCxM4t+J2pIYueA6ddU980gt8l813P2HpIBrPLuRD2cVrPTQPCPQn4AqbnRGGJN8GgsCpRIKPOqcFkBaPuOb7+AwP/iIdiuxd3wTQ5Xu1ywFtWPW0bPnYvXxZDTT3OONH2zjDRNS8nCbd+6fkTNZndHZwaHKSISjonifzl0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480831; c=relaxed/simple;
	bh=wvfQZaiOZ0J+nErWNOMfPfIWmJRhayt6aoPDFjq5Jwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLdDwOkPhfsxuwGFxVgOuBrSeJN/auNMDvT1Qmek5R+g3CgvoXXmvA2SkuI4dzb4wZWGVysaP5VbC0jLjmtIloDbeHWLm7GgCRpg4HTLkG4aG99qRtUxCO3KTPU671YncAfhzOfHTtc253r7jeWqSTsNUpcIsaaCpYLI5NtHKFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I78xQeje; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I78xQeje"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee1879e6d9so32446261cf.1
        for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 07:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763480829; x=1764085629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaBBiCSWsZ1bxuog+b7Q1HrhqzYOnLj/niVJLnzNuus=;
        b=I78xQejeBfA/JCeyGIjklMhvyrqL9zJuyL+jgHIJCuGHVZCl9VjSF8F0/0nMVWzJ6X
         g/7tf0nUy/wv7Id7ZgfO6zrOF6LvTlSOYCMz9PyYApwb3xjccKJHAEJnG82i2NlIOcxO
         XtObR64H2kcOFdfIsdBN2SH8cFmI5z69MBVEO9jJhCKmGv7X5+ErlQR8xZbr3AVR+LW1
         rGa3BLzk60rejKjLayBgXeyKjr7lCsMAoB1gtrkJ3JQ5nYbsxcUqSElc6Gu7LOcFuPeW
         HcdALYmOgT1wwervBb7zbbqiG5TBm3xY/cRCnQ+6x4QC2qjVDC6J8tXasGk36UEeAl4f
         0meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480829; x=1764085629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DaBBiCSWsZ1bxuog+b7Q1HrhqzYOnLj/niVJLnzNuus=;
        b=eLRA9LAxFmyGaSCtyh+osxhOJOY1HCYuFMgbgukbswBl3pkZeFag++Nc2GIoW6h7g8
         jFS9ZL+NucgkjQFlDCIyMmRYj0Ii/aqGhAasPIoNUMtg8nDtZNg5aSbJfpvwKsYtt+EX
         GhiYqUz+dtU/eOFdLs0GAgxU9pcZ55ytV1/7lBeG1ehF7p1RrbY9tMRS68XtOOtz9I3x
         1HeR5NPo6/xzYXDJu1bfLKW/LgJlNTlYK0IobvNHtIfEDYlDleVVxivpBnS++ARYAgvL
         dXvCU0FGqk+P/mr2DPWFspvD+XAMxl/IG+QqiIJ1LcIiPf+UrPHN/6OxWXuqvlG+wEGK
         HjAg==
X-Gm-Message-State: AOJu0YwieZQI83hWM3VwWmmS/7CJ9u/RWFT0Uj1yWEAHbsypJXKJCEbu
	N4I+5fl2qv70RvW0LPVgwieGN1fT9eeo1KvNIQTM/p8D6bAn4V348Kkt
X-Gm-Gg: ASbGncsAU+HRYgcZif2oMRkgJUKjB6R0FNoZkF0RJai5JHJjz/0FfThTyyT3mSNqPcI
	pWZ4JUthgGIba0+zRW76xES+2L2uvrKdRoiQfS7Dcveua56/mKG9J/g0nbneK/XJTIfQ6SuEtnA
	9Ia8l/WVj5HxaBTrFoJKKxpTmQq+ZPllQFfgIdIybOY17uvAWYAL/ggGsr84TownP1L87mFP64W
	PclbWwkwDhyG5N8YiLnaz9+rzTeUxvZclR8WktDvJ32H4kjEMCdNHy8eZRL0+5b713eWhjEJ/g9
	b9hqXaTXm7o6ZcxUeHIHZH+aSoo9dOT+66oUHcs3rfVPTxP5vhdKtXTqF4REPvkRPQ5KUE1dnaF
	LtQMQHebJnIvlyfZaskxbqcesFzwrtNJwwQPLyz98ZCU7Q1qL/MvvenERpzQO2p8/4TZcnFy8B1
	HR95foaZZQYMZDIZBOrVutzD5ft1KYlhmgyv1V+w1sgnfyef0hJYHNYX9GZpW2y2iTh/2y7PhwM
	jd55ZirWvqmtv+irItP+AdMIw==
X-Google-Smtp-Source: AGHT+IFaKzZXayvSqLb9lJH/t60teNEH2H9cuHSnXMJsPO3s/qd9H3m7JGIggt9fBtco4aKX8LZeqQ==
X-Received: by 2002:ac8:7f45:0:b0:4ee:1e63:a4cd with SMTP id d75a77b69052e-4ee1e63a6f7mr105758131cf.82.1763480828657;
        Tue, 18 Nov 2025 07:47:08 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286312406sm115911066d6.19.2025.11.18.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:47:08 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: mertsas@cisco.com
Cc: selinux@vger.kernel.org,
	paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH selinuxns 2/3] selinux: do not cache genfs xattr flag in superblock security blob
Date: Tue, 18 Nov 2025 10:46:46 -0500
Message-ID: <20251118154647.14566-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118154647.14566-1-stephen.smalley.work@gmail.com>
References: <20251118154647.14566-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should only try to fetch the xattr for cgroup or cgroup2 inodes if
the cgroup_seclabel policy capability is enabled in the policy.
Since this may differ in a child SELinux namespace, we need to check
it at inode labeling time rather than only on superblock initialization.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 12 ++++++++----
 security/selinux/include/security.h |  1 -
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 61171c45329f..5cfb7d8106fb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -749,7 +749,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	if (!strcmp(sb->s_type->name, "sysfs") ||
 	    !strcmp(sb->s_type->name, "cgroup") ||
 	    !strcmp(sb->s_type->name, "cgroup2"))
-		sbsec->flags |= SE_SBGENFS | SE_SBGENFS_XATTR;
+		sbsec->flags |= SE_SBGENFS;
 
 	if (!sbsec->behavior) {
 		/*
@@ -1428,6 +1428,7 @@ static int inode_doinit_use_xattr(struct selinux_state *state,
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
 	struct selinux_state *state = current_selinux_state;
+	struct super_block *sb = inode->i_sb;
 	struct superblock_security_struct *sbsec = NULL;
 	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 task_sid, sid = 0;
@@ -1451,7 +1452,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	while (state && !selinux_initialized(state))
 		state = state->parent;
 
-	sbsec = selinux_superblock(inode->i_sb);
+	sbsec = selinux_superblock(sb);
 	if (!state || !(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
@@ -1571,8 +1572,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 				goto out;
 			}
 
-			if ((sbsec->flags & SE_SBGENFS_XATTR) &&
-			    (inode->i_opflags & IOP_XATTR)) {
+			if ((inode->i_opflags & IOP_XATTR) &&
+			    (!strcmp(sb->s_type->name, "sysfs") ||
+			     (selinux_policycap_cgroupseclabel() &&
+			      (!strcmp(sb->s_type->name, "cgroup") ||
+			       !strcmp(sb->s_type->name, "cgroup2"))))) {
 				rc = inode_doinit_use_xattr(state, inode,
 							    dentry, sid,
 							    &sid);
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index c5df7a0b0069..8d39137c6ebc 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -67,7 +67,6 @@
 #define SE_SBINITIALIZED 0x0100
 #define SE_SBPROC	 0x0200
 #define SE_SBGENFS	 0x0400
-#define SE_SBGENFS_XATTR 0x0800
 #define SE_SBNATIVE	 0x1000
 
 #define CONTEXT_STR	"context"
-- 
2.51.1

