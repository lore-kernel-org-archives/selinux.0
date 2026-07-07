Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64973ED5D0
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437464; cv=none; b=TpIbdrwIxMK+JYXGOsuEaY2ziXjNmwJlvu6MOieLCLN+j5fp7cGQ5hYOgo7JqiINnx0pSP3gJ8tqst55+tYXDHpd//AsskG+WQ/iUxb1ij6imt/d3BM1lLkP2kNzH3Xh9HBgUx3o4HZw6ZaIzrIlESRJcSx429hcRkACNBoVPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437464; c=relaxed/simple;
	bh=uKVFXfXh7mUhHSZC4388FO2wQ3fQ3eEWn5OxTiwgURE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uX5yDNsCsz/jnZfkg1BABmfe1aNLmzmYqS3icZDpuvSkGqIHOU5gy2zVsDwEA59vmo9g4e6Nt/wgmS/+F/RlFvuR9B5xTWO/8eswXEYj2mD7t6QkcjieENOagZLYnKZGN6Q6J+/x/p5oXZyr2T16PN1qVr2xGB/7psVC2iNnzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia5VvsXE; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia5VvsXE"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c1805b8a7so49068651cf.3
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437462; x=1784042262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZznomXnkdeTyE/z/Czeh7zCCC31+Bqu+5AJXbY+brLk=;
        b=ia5VvsXEu4xtCjrW/e4q01uZNT7CIs+KktqvTGMHDWfjIEnNPxHjC4Y8MnsbMD4mDG
         PKiVXyFbMXc+Yq/Q3YgGSSzl7TOUl/OCpfudX1VwvX4+kMwIZkK3lvgVYxcI+pcaiENe
         +2SOelD3XOFA8qIxHON30xIdkBXGSsR6+qcgunfBaBiWSQ9flglZ3fBC6ry/iWHYODbS
         060k52ci9GyWb/Y2DwT9gkVEgRjI39eiULd4tIrV6d5g6Y2x831OwveyrqcQWoThOt84
         yjzd35oUsk724dY4KMqMsn+Y3xWlm6eLfEggdlsVamp4HlouDS1LhSkea/8n8Cx0MA52
         8Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437462; x=1784042262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZznomXnkdeTyE/z/Czeh7zCCC31+Bqu+5AJXbY+brLk=;
        b=gEcLmB4reK7PAh2Tf03L7mMLdSbQWfQdQtSn+8ynAqSUEjmiow/O2O/WhNGlN3EQpr
         7xQWRiXva6AnhyBzh9U7IhGX19LlEaLDUTtrb65OqFKUxHN69KUkcAkfkpnRcWY+2dxf
         NU1BeoaIhs+/wuCTlTf5KgmF+x/seKykYYUKhTqSC/brUqQul/upsLVmypMzGTJGfeyn
         LzkF+QmexaCcnWJKiJCEJyVrUyv4hTWDo2NCOXk6VazbUK76oLS0POAWEWnYZwuCXMrH
         5l9qFuzVz6AE7kjrxT5N7114BYWGLEYsY48s9CQ8FwoV++6Dv9N4Ts4AMJqnqQ9Xt+rF
         reHA==
X-Gm-Message-State: AOJu0YwQLvysuTm5DpqwbbpS6BQigznHwa9pVDViUEOmz86lFCM/3pbG
	uz8AAmpwLvK1Ozg5pSBU7MFto8YPGEFSAUM9ypWTt9d9efABQhkayxTV4kFzUQ==
X-Gm-Gg: AfdE7cl+ca2tRU08bwVMSD1lYt+icwTYL8qRb/f4RESteWtzt7eEFDrwmCSGFK7ocDj
	GheeXoVSBvJZyPtxuDW/Gzh3tgkV8STttC4nUZYd9Kuh1JdJSG9AHtGWNs69SZgSqvgttIqTP6q
	4q/5tBs6c4p0CdKrao0hKGITb2k6mwJkXhuaK0Yx+K9ZCmSLshh4FOi94Vq2NyRQzBHpLtNfcR4
	VMhq+dnTrhZXUdSTQfhr8cAPcxvR2DFx8leLSUyImBrk9vsaId/WkD3U9tII7xLK1PwXfp4v46A
	LioD0xQSkp16GZludgd9/zxSFBFHMkViYNWwGS77OLxDiRKWkOJbFaW5aufLfO/Q7Fzw8nd56TF
	6/Dn4rZE4r/ll2vMFBgAyjRiTgAg7idGOFu/4c9HRp6lbnAEfg3S7BfeWg6ieXMFHRFYt/Y/Af/
	doSWvronZJPwkvuKf8Hju05/ANxmPMCNbdID/cZE/9Muc5GeW/ozrOhF7TF5w37eSsPDpkLGkbF
	JHpoOeA4pguxIPz
X-Received: by 2002:a05:622a:8617:b0:51c:7b12:5fda with SMTP id d75a77b69052e-51c7b126540mr21285841cf.86.1783437461180;
        Tue, 07 Jul 2026 08:17:41 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41abe748sm116841491cf.1.2026.07.07.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:17:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: drop legacy probing of /selinux and /proc nodes for selinuxfs
Date: Tue,  7 Jul 2026 11:17:26 -0400
Message-ID: <20260707151726.14523-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally selinuxfs was mounted on /selinux before the kernel was
change starting in Linux v3.0 to create a mount point directory for it
at /sys/fs/selinux, and libselinux had logic to check
/proc/filesystems and /proc/mounts for selinuxfs to dynamically detect
whether SELinux was enabled and where selinuxfs was mounted if it
didn't find selinuxfs in the expected locations. This results in
wasted effort on any modern Linux kernel where selinuxfs is always
mounted on /sys/fs/selinux, particularly in the SELinux-disabled case.

NB This makes Linux v3.0 the minimum supported kernel version for the
SELinux userspace going forward.

Fixes: https://github.com/SELinuxProject/selinux/issues/468
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md                    |  4 ++++
 libselinux/src/init.c        | 43 ------------------------------------
 libselinux/src/load_policy.c |  6 -----
 libselinux/src/policy.h      |  3 +--
 4 files changed, 5 insertions(+), 51 deletions(-)

diff --git a/README.md b/README.md
index ea8c4e46..08e82d0c 100644
--- a/README.md
+++ b/README.md
@@ -22,6 +22,10 @@ Archives of the mailing list are available at https://lore.kernel.org/selinux.
 See the [SELinux Userspace wiki](https://github.com/SELinuxProject/selinux/wiki)
 for more information.
 
+Minimum Supported Kernel Version
+--------------------------------
+Linux v3.0 (for /sys/fs/selinux mount point directory)
+
 Installation
 ------------
 
diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index bd0803dd..1a377a0f 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -81,54 +81,11 @@ int selinuxfs_exists(void)
 
 static void init_selinuxmnt(void)
 {
-	char *buf = NULL, *p;
-	FILE *fp = NULL;
-	size_t len;
-	ssize_t num;
-
 	if (selinux_mnt)
 		return;
 
 	if (verify_selinuxmnt(SELINUXMNT) == 0)
 		return;
-
-	if (verify_selinuxmnt(OLDSELINUXMNT) == 0)
-		return;
-
-	/* Drop back to detecting it the long way. */
-	if (!selinuxfs_exists())
-		goto out;
-
-	/* At this point, the usual spot doesn't have an selinuxfs so
-	 * we look around for it */
-	fp = fopen("/proc/mounts", "re");
-	if (!fp)
-		goto out;
-
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-	while ((num = getline(&buf, &len, fp)) != -1) {
-		char *tmp;
-		p = strchr(buf, ' ');
-		if (!p)
-			goto out;
-		p++;
-		tmp = strchr(p, ' ');
-		if (!tmp)
-			goto out;
-		if (!strncmp(tmp + 1, SELINUXFS " ", strlen(SELINUXFS) + 1)) {
-			*tmp = '\0';
-			break;
-		}
-	}
-
-	/* If we found something, dup it */
-	if (num > 0)
-		verify_selinuxmnt(p);
-
-out:
-	free(buf);
-	if (fp)
-		fclose(fp);
 }
 
 void fini_selinuxmnt(void)
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 4337cedc..a6ec4a59 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -307,12 +307,6 @@ int selinux_init_load_policy(int *enforce)
 		  NULL) == 0 ||
 	    errno == EBUSY) {
 		mntpoint = SELINUXMNT;
-	} else {
-		/* check old mountpoint */
-		if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, NULL) == 0 ||
-		    errno == EBUSY) {
-			mntpoint = OLDSELINUXMNT;
-		}
 	}
 
 	if (!mntpoint) {
diff --git a/libselinux/src/policy.h b/libselinux/src/policy.h
index f6d72423..0ac599a4 100644
--- a/libselinux/src/policy.h
+++ b/libselinux/src/policy.h
@@ -20,9 +20,8 @@
 /* selinuxfs magic number */
 #define SELINUX_MAGIC 0xf97cff8c
 
-/* Preferred selinux mount location */
+/* selinux mount location */
 #define SELINUXMNT "/sys/fs/selinux"
-#define OLDSELINUXMNT "/selinux"
 
 /* selinuxfs mount point */
 extern char *selinux_mnt;
-- 
2.54.0

