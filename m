Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF64436B
	for <selinux@vger.kernel.org>; Thu, 28 Mar 2024 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653430; cv=none; b=jjPhUyJ+rp91cZvH4M2WY0c4WO7QyKdOEfIZuCclSxDHkQpgvPKi0SUOIacd2pEdUIAUTDaUKisGS/BWivwIT1skl8aNTRZbheEdv/CJYqi2BDtBqrN8TDUdU4MD7lJOPQpFDD2SK2eK/DEfSagnSZlvkfNUw4x135YgIwYyPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653430; c=relaxed/simple;
	bh=dWsJQgDMgfbNUd4nyIamCcw94Ki64JYg4cfifddBRfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bb13Rh48qktu6iKOZVxeL5efDrcNfbbEhFytFLVg3Lvt8LgcBkz9XrXFhRk2NjWKAMBOjdo/mjDn0UVqPaOWFEYuMb4aMzGvgvlwlHSCvXSe8PMSDE4AS/TOBUDN1a2HCNlgkUYW22aW30PC8UgIh7GKk3eReGH3N3x/tOgkReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=JypofpVG; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="JypofpVG"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1711653423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oF5FH43XiVtyt6ausLAKcsWPQkMHRvI2dOhZQLS3ivw=;
	b=JypofpVG7kZNnlAu65omFmb7+ZliDaQ0boJD4kb1JIMkGqsUO9zgh2LLkaeTSbLNmOt/xW
	FfOOutFMC0e1yM46vt+HzRlrDNINME0EGf8cLd58cvCruGY9Re8cOU9zRDPXzwzoHEQgcO
	tDLouN6DD2py9qraSHNO2N7i50M9yiwLDBqwNJ/nFVxCPbBwqEyawR7HXFpBJ6v2x9K9Lw
	XPnj11qxKPTPaxL+czS1ojAgoDcztr9b+Jf4YBNbJqB7iP0kPQV1AKyQEyRz49htiax4qi
	wpE1ctOmgEOqud32Wa9iu3i6vW7N0LDyWB7h9HjsB6W21bIvW8CDbZKX+R6Vtw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] selinux: avoid dereference of garbage after mount failure
Date: Thu, 28 Mar 2024 20:16:58 +0100
Message-ID: <20240328191658.210221-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

In case kern_mount() fails and returns an error pointer return in the
error branch instead of continuing and dereferencing the error pointer.

While on it drop the never read static variable selinuxfs_mount.

Fixes: 0619f0f5e36f ("selinux: wrap selinuxfs state")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index d18581d741e8..7e9aa5d151b4 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2125,7 +2125,6 @@ static struct file_system_type sel_fs_type = {
 	.kill_sb	= sel_kill_sb,
 };
 
-static struct vfsmount *selinuxfs_mount __ro_after_init;
 struct path selinux_null __ro_after_init;
 
 static int __init init_sel_fs(void)
@@ -2147,18 +2146,21 @@ static int __init init_sel_fs(void)
 		return err;
 	}
 
-	selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
-	if (IS_ERR(selinuxfs_mount)) {
+	selinux_null.mnt = kern_mount(&sel_fs_type);
+	if (IS_ERR(selinux_null.mnt)) {
 		pr_err("selinuxfs:  could not mount!\n");
-		err = PTR_ERR(selinuxfs_mount);
-		selinuxfs_mount = NULL;
+		err = PTR_ERR(selinux_null.mnt);
+		selinux_null.mnt = NULL;
+		return err;
 	}
+
 	selinux_null.dentry = d_hash_and_lookup(selinux_null.mnt->mnt_root,
 						&null_name);
 	if (IS_ERR(selinux_null.dentry)) {
 		pr_err("selinuxfs:  could not lookup null!\n");
 		err = PTR_ERR(selinux_null.dentry);
 		selinux_null.dentry = NULL;
+		return err;
 	}
 
 	return err;
-- 
2.43.0

