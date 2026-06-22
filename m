Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070653BB672;
	Mon, 22 Jun 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139198; cv=none; b=heleugVCpzc7twDlBeNiIr5Lx8OhrSDX/PNvs6bIBcLl706l64PMXJwHXiE2X4PZ54p0EDN1E0D3Lf8Va8SeWiKirQCWl5TLhJfvXVVzS2VGEkrdSlfopwfWalrA45nNFpQYL/mBWvPa2NGsMU7Kr0yjt/L0hNQnuIpqBEZe2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139198; c=relaxed/simple;
	bh=VAjdVkrihz9u3LYc2gdiJ9Q98PZxFbBcVU4GN1dEz+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1zCDJxBIobDjgdpS4jKJofdf0cTK/N29LeWGFdMIHdlyc7tkaaa1XcP8ZAbK9fzQvDmOK64mn82J11gPClvHPIYJBymSjzGZehurAgCiCy6MrCAELuBPWdHhTCNLgtUaUSuej5+B9WMKMY1aQd+7N94ZEGId3xPBOpjR34hRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LXA6U8BY; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LXA6U8BY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qY
	6ZiF9Jzx1RpxwnFeBWONijdHovnCXGbMawNMEYkes=; b=LXA6U8BY1giC18rJPv
	4DqjFlTIJ9/xPJ3jeX8RexBUxSeEqZhI8qbWMi8SF2cmPpMvizPjvsiUSeLHkKpK
	+mznM0HmRw0q3IMtVTxURfc8p4qeKXyzO3PaWPa1Yy2yDxJOpz+vTXWJ3kNEerWx
	TlOJUpTc/x0bss1Z9VaYlY5nM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAn+gGjSDlqc3E2Dw--.59698S2;
	Mon, 22 Jun 2026 22:37:24 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] selinux: clean up selinuxfs resources on init failure
Date: Mon, 22 Jun 2026 22:37:22 +0800
Message-Id: <20260622143722.1167703-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAn+gGjSDlqc3E2Dw--.59698S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1xXr18XrW7XF1rur47CFg_yoW8CFWrpa
	43Kay5Wr18KFWxJrsxJ3WSya45Zr9YkFy7Wry7Wr4SqryDZr10qwn7KF1ftrn8Ar48Gayj
	vw48Ja1qgrWUAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piOeOPUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gQkkmo5SKSozQAA3G

init_sel_fs() creates the selinuxfs mount point and registers the
filesystem before mounting selinuxfs internally. If kern_mount()
or the subsequent lookup of the null file fails, the function
returns without undoing the resources that were already registered.

Add the missing error unwinding so the internal mount, filesystem
registration, and sysfs mount point are released as appropriate.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 security/selinux/selinuxfs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 5aaaf69410bb..c7d91476971c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1984,17 +1984,15 @@ int __init init_sel_fs(void)
 		return err;
 
 	err = register_filesystem(&sel_fs_type);
-	if (err) {
-		sysfs_remove_mount_point(fs_kobj, "selinux");
-		return err;
-	}
+	if (err)
+		goto err_remove_mount_point;
 
 	selinux_null.mnt = kern_mount(&sel_fs_type);
 	if (IS_ERR(selinux_null.mnt)) {
 		pr_err("selinuxfs:  could not mount!\n");
 		err = PTR_ERR(selinux_null.mnt);
 		selinux_null.mnt = NULL;
-		return err;
+		goto err_unregister_fs;
 	}
 
 	selinux_null.dentry = try_lookup_noperm(&null_name,
@@ -2003,7 +2001,7 @@ int __init init_sel_fs(void)
 		pr_err("selinuxfs:  could not lookup null!\n");
 		err = PTR_ERR(selinux_null.dentry);
 		selinux_null.dentry = NULL;
-		return err;
+		goto err_unmount;
 	}
 
 	/*
@@ -2012,5 +2010,14 @@ int __init init_sel_fs(void)
 	 */
 	(void) selinux_kernel_status_page();
 
+	return 0;
+
+err_unmount:
+	kern_unmount(selinux_null.mnt);
+	selinux_null.mnt = NULL;
+err_unregister_fs:
+	unregister_filesystem(&sel_fs_type);
+err_remove_mount_point:
+	sysfs_remove_mount_point(fs_kobj, "selinux");
 	return err;
 }
-- 
2.25.1

