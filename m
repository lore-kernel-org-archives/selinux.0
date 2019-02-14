Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B12FC4360F
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6A0222A4
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbfBNJu3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:50:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39187 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406071AbfBNJu3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 04:50:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so4631117wrw.6
        for <selinux@vger.kernel.org>; Thu, 14 Feb 2019 01:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bGOaJVcpELXxYzFdDhvL1YHcgIqKm1Gn5nD/mHbV1Kk=;
        b=EtmQVaAMf1Dlgio6j/FSSWgHtCil8XF+kLfHopvHGKbjAjqEHHReYzW8H0nzOJZ7fk
         ANmWSWh5jPh0CeqRbT+StMwYXUaCyX0CSdhRsBswMhgtupxVm6EN0C+AGWD+aO+zPX4B
         C/KWnB4qu4sTfWatVFdcKo0yZRJn0JXpnzPTMno3KoY7+WtQYLRm0YIM+8ayQeyg6JFe
         gKTot+XKXzhhFwOyL4SlH1EFOL520UzyhePHb5ZVSjPt4GTjSFa1KsEEd94py2L73hze
         Wqkad/P3ZJVhGrsoGu+aGtFMc8F0g9g4IsUHpumPdMadEjag6TOtP5qBRnaBYvqhH1o/
         Qz0A==
X-Gm-Message-State: AHQUAuaRcAoYcGFdQKkLpDSX+3dbffatuKRvWJGzWafASQo3/CLoGDGo
        3qt45ppANusB2RJIvuzcFj6AuSb+iLs=
X-Google-Smtp-Source: AHgI3Ia+TF1ZD1s6a32oz6WcAFXsTC5p7cgpqogH32Xq/gqPkeLy9SvugQFeeGZASEX0/Z/hZEbUxQ==
X-Received: by 2002:adf:b60e:: with SMTP id f14mr2059756wre.134.1550137826481;
        Thu, 14 Feb 2019 01:50:26 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g11sm969439wmk.26.2019.02.14.01.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:50:25 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v6 1/5] selinux: try security xattr after genfs for kernfs filesystems
Date:   Thu, 14 Feb 2019 10:50:11 +0100
Message-Id: <20190214095015.16032-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214095015.16032-1-omosnace@redhat.com>
References: <20190214095015.16032-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since kernfs supports the security xattr handlers, we can simply use
these to determine the inode's context, dropping the need to update it
from kernfs explicitly using a security_inode_notifysecctx() call.

We achieve this by setting a new sbsec flag SE_SBGENFS_XATTR to all
mounts that are known to use kernfs under the hood and then fetching the
xattrs after determining the fallback genfs sid in
inode_doinit_with_dentry() when this flag is set.

This will allow implementing full security xattr support in kernfs and
removing the ...notifysecctx() call in a subsequent patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c            | 160 +++++++++++++++-------------
 security/selinux/include/security.h |   1 +
 2 files changed, 88 insertions(+), 73 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 81e012c66d95..7dea5b1a89a3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -793,11 +793,13 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 
 	if (!strcmp(sb->s_type->name, "debugfs") ||
 	    !strcmp(sb->s_type->name, "tracefs") ||
-	    !strcmp(sb->s_type->name, "sysfs") ||
-	    !strcmp(sb->s_type->name, "pstore") ||
+	    !strcmp(sb->s_type->name, "pstore"))
+		sbsec->flags |= SE_SBGENFS;
+
+	if (!strcmp(sb->s_type->name, "sysfs") ||
 	    !strcmp(sb->s_type->name, "cgroup") ||
 	    !strcmp(sb->s_type->name, "cgroup2"))
-		sbsec->flags |= SE_SBGENFS;
+		sbsec->flags |= SE_SBGENFS | SE_SBGENFS_XATTR;
 
 	if (!sbsec->behavior) {
 		/*
@@ -1392,6 +1394,71 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 	return rc;
 }
 
+static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
+				  u32 def_sid, u32 *sid)
+{
+#define INITCONTEXTLEN 255
+	char *context = NULL;
+	unsigned int len = 0;
+	int rc;
+
+	*sid = def_sid;
+
+	if (!(inode->i_opflags & IOP_XATTR))
+		return 0;
+
+	len = INITCONTEXTLEN;
+	context = kmalloc(len + 1, GFP_NOFS);
+	if (!context)
+		return -ENOMEM;
+
+	context[len] = '\0';
+	rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
+	if (rc == -ERANGE) {
+		kfree(context);
+
+		/* Need a larger buffer.  Query for the right size. */
+		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
+		if (rc < 0)
+			return rc;
+
+		len = rc;
+		context = kmalloc(len + 1, GFP_NOFS);
+		if (!context)
+			return -ENOMEM;
+
+		context[len] = '\0';
+		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX,
+				    context, len);
+	}
+	if (rc < 0) {
+		kfree(context);
+		if (rc != -ENODATA) {
+			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%ld\n",
+				__func__, -rc, inode->i_sb->s_id, inode->i_ino);
+			return rc;
+		}
+		return 0;
+	}
+
+	rc = security_context_to_sid_default(&selinux_state, context, rc, sid,
+					     def_sid, GFP_NOFS);
+	if (rc) {
+		char *dev = inode->i_sb->s_id;
+		unsigned long ino = inode->i_ino;
+
+		if (rc == -EINVAL) {
+			pr_notice_ratelimited("SELinux: inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
+					      ino, dev, context);
+		} else {
+			pr_warn("SELinux: %s:  context_to_sid(%s) returned %d for dev=%s ino=%ld\n",
+				__func__, context, -rc, dev, ino);
+		}
+	}
+	kfree(context);
+	return 0;
+}
+
 /* The inode's security attributes must be initialized before first use. */
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
@@ -1400,9 +1467,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	u32 task_sid, sid = 0;
 	u16 sclass;
 	struct dentry *dentry;
-#define INITCONTEXTLEN 255
-	char *context = NULL;
-	unsigned len = 0;
 	int rc = 0;
 
 	if (isec->initialized == LABEL_INITIALIZED)
@@ -1470,72 +1534,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			goto out;
 		}
 
-		len = INITCONTEXTLEN;
-		context = kmalloc(len+1, GFP_NOFS);
-		if (!context) {
-			rc = -ENOMEM;
-			dput(dentry);
-			goto out;
-		}
-		context[len] = '\0';
-		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
-		if (rc == -ERANGE) {
-			kfree(context);
-
-			/* Need a larger buffer.  Query for the right size. */
-			rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
-			if (rc < 0) {
-				dput(dentry);
-				goto out;
-			}
-			len = rc;
-			context = kmalloc(len+1, GFP_NOFS);
-			if (!context) {
-				rc = -ENOMEM;
-				dput(dentry);
-				goto out;
-			}
-			context[len] = '\0';
-			rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
-		}
+		rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
+					    &sid);
 		dput(dentry);
-		if (rc < 0) {
-			if (rc != -ENODATA) {
-				pr_warn("SELinux: %s:  getxattr returned "
-				       "%d for dev=%s ino=%ld\n", __func__,
-				       -rc, inode->i_sb->s_id, inode->i_ino);
-				kfree(context);
-				goto out;
-			}
-			/* Map ENODATA to the default file SID */
-			sid = sbsec->def_sid;
-			rc = 0;
-		} else {
-			rc = security_context_to_sid_default(&selinux_state,
-							     context, rc, &sid,
-							     sbsec->def_sid,
-							     GFP_NOFS);
-			if (rc) {
-				char *dev = inode->i_sb->s_id;
-				unsigned long ino = inode->i_ino;
-
-				if (rc == -EINVAL) {
-					if (printk_ratelimit())
-						pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
-							"context=%s.  This indicates you may need to relabel the inode or the "
-							"filesystem in question.\n", ino, dev, context);
-				} else {
-					pr_warn("SELinux: %s:  context_to_sid(%s) "
-					       "returned %d for dev=%s ino=%ld\n",
-					       __func__, context, -rc, dev, ino);
-				}
-				kfree(context);
-				/* Leave with the unlabeled SID */
-				rc = 0;
-				break;
-			}
-		}
-		kfree(context);
+		if (rc)
+			goto out;
 		break;
 	case SECURITY_FS_USE_TASK:
 		sid = task_sid;
@@ -1586,9 +1589,20 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 				goto out;
 			rc = selinux_genfs_get_sid(dentry, sclass,
 						   sbsec->flags, &sid);
-			dput(dentry);
-			if (rc)
+			if (rc) {
+				dput(dentry);
 				goto out;
+			}
+
+			if (sbsec->flags & SE_SBGENFS_XATTR) {
+				rc = inode_doinit_use_xattr(inode, dentry,
+							    sid, &sid);
+				if (rc) {
+					dput(dentry);
+					goto out;
+				}
+			}
+			dput(dentry);
 		}
 		break;
 	}
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f68fb25b5702..6e5928f951da 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -58,6 +58,7 @@
 #define SE_SBINITIALIZED	0x0100
 #define SE_SBPROC		0x0200
 #define SE_SBGENFS		0x0400
+#define SE_SBGENFS_XATTR	0x0800
 
 #define CONTEXT_STR	"context="
 #define FSCONTEXT_STR	"fscontext="
-- 
2.20.1

