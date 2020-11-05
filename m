Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510C4C388F9
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 01:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075D7206E3
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 01:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XXpsdZD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbgKEBNs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 20:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731555AbgKEBNs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 20:13:48 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B839FC0613CF
        for <selinux@vger.kernel.org>; Wed,  4 Nov 2020 17:13:47 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id r8so19822qtp.13
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2020 17:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fXlT4V71Q1ygW+YYHe4lDOyP4jMeUG7r9s39tPX40zA=;
        b=XXpsdZD4I81N1wwO9vWhzifc+mDoyXxTcjyueleBUSqHQlSv7QMsd3BXWodceGlcRY
         2kO9M/soRpH/h6cyKZQ3qIduzS03ISeihCsQWLrFBf03ha95L7Q41PvC2rHxsGb0AkJB
         S97liSh3a6GubMBzgzk050qHAOZEhYMWOT6YVF0zF4G4NfXssAG2UBHH2sYTEVEqvpK1
         gw+hPvw9Zgg8VNAZGpThws/1c5lsg/L3HYcq9McUZsXLOmH7l9zFS9uZEKJh+odu1Rb9
         M3CibMpxO5lxj1wljheMcN7f0Vs81af8QhL4isAzt7V+vGTWEayWguo5iFDvOqKA7tIM
         PKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=fXlT4V71Q1ygW+YYHe4lDOyP4jMeUG7r9s39tPX40zA=;
        b=goHw2215ajhIazRS1YptQ5vg2zFyWUr/C5smh/nc0tOb7DnZjfqurRS6F9T3nen6hS
         E3TboOWjwWSsjfT63/lvz2atN2OKn3qWhNK4Qz2JJ2FOuqIcB6S2J8JYd2ayB4Mv3hci
         rqkL8g43qDbq81mV+oAq7yv1BAnTN5mYk1wHvjpiqnSknAEunY2M0D2Qjzd5NjesvABE
         oOVWkiZSyksc1o1hGMuY3eKOg4x4Tw5z6Pg84X1s0hBL0uzmr4ZmhXNGX2OKPdP3+uxL
         sS0lb/N8X7GutG8QJIEEzmCdtg8wTY0b5jt3E15mAIWUSOzoy4qeGk1hoyH0O6ejwnmb
         vm9w==
X-Gm-Message-State: AOAM533mJRZxIDjN+/EkWaTmd8AqCb5W7S9eo/2aJeU5GkG3nq3qM4Ig
        96iUBINW2Gl1XZCQ4XB4BQxxw/nTfHAq
X-Google-Smtp-Source: ABdhPJy66JdAPLo2FUi293q0kgNhKimH2gqjYZ4uY4Nq9B3TG52QwEiXHZcevAt1NJ7AkvL3SQLWvw==
X-Received: by 2002:ac8:1e84:: with SMTP id c4mr819413qtm.340.1604538826358;
        Wed, 04 Nov 2020 17:13:46 -0800 (PST)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id c79sm5888qke.69.2020.11.04.17.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 17:13:45 -0800 (PST)
Subject: [PATCH] selinux: fix inode_doinit_with_dentry() LABEL_INVALID error
 handling
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     Sven Schnelle <svens@linux.ibm.com>
Date:   Wed, 04 Nov 2020 20:13:44 -0500
Message-ID: <160453882404.5064.13236738388118581389.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A previous fix, commit 83370b31a915 ("selinux: fix error initialization
in inode_doinit_with_dentry()"), changed how failures were handled
before a SELinux policy was loaded.  Unfortunately that patch was
potentially problematic for two reasons: it set the isec->initialized
state without holding a lock, and it didn't set the inode's SELinux
label to the "default" for the particular filesystem.  The later can
be a problem if/when a later attempt to revalidate the inode fails
and SELinux reverts to the existing inode label.

This patch should restore the default inode labeling that existed
before the original fix, without affecting the LABEL_INVALID marking
such that revalidation will still be attempted in the future.

Fixes: 83370b31a915 ("selinux: fix error initialization in inode_doinit_with_dentry()")
Reported-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 158fc47d8620..c46312710e73 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1451,13 +1451,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			 * inode_doinit with a dentry, before these inodes could
 			 * be used again by userspace.
 			 */
-			isec->initialized = LABEL_INVALID;
-			/*
-			 * There is nothing useful to jump to the "out"
-			 * label, except a needless spin lock/unlock
-			 * cycle.
-			 */
-			return 0;
+			goto out_invalid;
 		}
 
 		rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
@@ -1513,15 +1507,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			 * inode_doinit() with a dentry, before these inodes
 			 * could be used again by userspace.
 			 */
-			if (!dentry) {
-				isec->initialized = LABEL_INVALID;
-				/*
-				 * There is nothing useful to jump to the "out"
-				 * label, except a needless spin lock/unlock
-				 * cycle.
-				 */
-				return 0;
-			}
+			if (!dentry)
+				goto out_invalid;
 			rc = selinux_genfs_get_sid(dentry, sclass,
 						   sbsec->flags, &sid);
 			if (rc) {
@@ -1546,11 +1533,10 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 out:
 	spin_lock(&isec->lock);
 	if (isec->initialized == LABEL_PENDING) {
-		if (!sid || rc) {
+		if (rc) {
 			isec->initialized = LABEL_INVALID;
 			goto out_unlock;
 		}
-
 		isec->initialized = LABEL_INITIALIZED;
 		isec->sid = sid;
 	}
@@ -1558,6 +1544,15 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 out_unlock:
 	spin_unlock(&isec->lock);
 	return rc;
+
+out_invalid:
+	spin_lock(&isec->lock);
+	if (isec->initialized == LABEL_PENDING) {
+		isec->initialized = LABEL_INVALID;
+		isec->sid = sid;
+	}
+	spin_unlock(&isec->lock);
+	return 0;
 }
 
 /* Convert a Linux signal to an access vector. */

