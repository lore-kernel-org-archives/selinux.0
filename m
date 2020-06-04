Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54311C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECCF20659
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgnVzwsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgFDUIo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgFDUIo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 16:08:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64121C08C5C0
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 13:08:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z1so6452191qtn.2
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AS6JZ91HEJKToeZjWGQIOirN8Xp8QNxYL3mmnA0mI2U=;
        b=FgnVzwszgIzJnqwXD98XV6aBo14vxS1grDaoUrTtdVTP9pFpXvpgaLbcw84fPFKrdL
         rMXnj2QjI/gqiD78li+1c0K5Ols9Epgbrrym0cV/SGS9W9Y76MtFUJ8Ie+UEcbpwq+f6
         c7nmObLst7MY8JKmraTgpEw6yjTLMl8X2YMfUakafz72Fpozfk35J4zr/QnnYno797MR
         t2jFCywnLBsuhCNtCzfrgHz7j2SYoSGGk7wiUFUOG+sWZDa+yKTgqN+QJqcO9j+fjPEs
         Iba7qXtqNojIsZO6GD8rziae1dYC/RvwCyNwk/5rQ56VxR2RckrfOricAy2u7grkvny1
         dhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AS6JZ91HEJKToeZjWGQIOirN8Xp8QNxYL3mmnA0mI2U=;
        b=Soa5otDT+Vjmlr7C4kZpmUzWFxX5k1kzMLE8lo7e4dhjL6S3kYfqAN/e6Ua3G9WanV
         waANe9ZR9og/bN3iYvdGuUS5R9cqPBGq6/O+sXfpwnDUzOzyyXHaSHRtrceXLfrlQj0W
         wpVh5JCBmTXOVQc39kp7Ni/WweNo6p+OF8vMnJwk7tr2UkrBjA+b89lInpSXpgfzSU7v
         rkUM6iHeiFO8aAzDlAjgFsgKDwLNODqQ6/7Q1NDrk0GSqaOxWd1hD9lXsPb1q8U/2Ky2
         E1gC4DO+vlzUhkjnAxhbDI1BINM40u0EXeF7OW2CbvRKP8jaNIKgj5XDZbu/P4LclnmD
         P2nA==
X-Gm-Message-State: AOAM5326VDAz4QOPXroGl2TYpWMrZPytPAxLajrDNxR6zlU8LcwaBiNN
        5d3lkPPUkFbFZddjdxP0WHotiAQb
X-Google-Smtp-Source: ABdhPJwitPItKnRVMIJWGTWNKvNzFg7KFMsKfELy35EnvlZvIx7TEKQ0xo+Wk8cgepDBnqX5mpCv1w==
X-Received: by 2002:ac8:2db1:: with SMTP id p46mr6236215qta.337.1591301322460;
        Thu, 04 Jun 2020 13:08:42 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id u7sm5414249qkb.7.2020.06.04.13.08.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2020 13:08:42 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: fix selinux_restorecon() statfs bug
Date:   Thu,  4 Jun 2020 16:08:31 -0400
Message-Id: <20200604200831.28866-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As reported in https://github.com/SELinuxProject/selinux/issues/248,
setfiles -r (rootpath) fails when the alternate root contains a symlink
that is correct relative to the alternate root but not in the current root.
This is a regression introduced by commit e016502c0a26 ("libselinux: Save
digest of all partial matches for directory").  Do not call statfs(2) here
if acting on a symbolic link.  Unfortunately there is no lstatfs() call.
Ensure that we initialize the statfs buffer always.  If the supplied
file is a symlink, then we don't need to worry about the later tests of
filesystem type because we wouldn't be setting the digest anyway and
we are not performing a full sysfs relabel.  While here, fix the earlier
test for a directory to use the correct test.

Reproducer:
$ mkdir /root/my-chroot && echo foo > /root/my-chroot/link-target && ln -s /link-target /root/my-chroot/symlink
$ echo "/root/my-chroot/symlink" | setfiles -vFi -r /root/my-chroot -f - /etc/selinux/targeted/contexts/files/file_contexts

Before:
setfiles: statfs(/root/my-chroot/symlink) failed: No such file or directory

After:
Relabeled /root/my-chroot/symlink from unconfined_u:object_r:admin_home_t:s0 to system_u:object_r:default_t:s0

Fixes: https://github.com/SELinuxProject/selinux/issues/248
Fixes: e016502c0a26 ("libselinux: Save digest of all partial matches for directory")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 91dfeb66..d1ce830c 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -938,7 +938,7 @@ int selinux_restorecon(const char *pathname_orig,
 	}
 
 	/* Skip digest if not a directory */
-	if ((sb.st_mode & S_IFDIR) != S_IFDIR)
+	if (!S_ISDIR(sb.st_mode))
 		setrestorecondigest = false;
 
 	if (!flags.recurse) {
@@ -952,7 +952,8 @@ int selinux_restorecon(const char *pathname_orig,
 	}
 
 	/* Obtain fs type */
-	if (statfs(pathname, &sfsb) < 0) {
+	memset(&sfsb, 0, sizeof sfsb);
+	if (!S_ISLNK(sb.st_mode) && statfs(pathname, &sfsb) < 0) {
 		selinux_log(SELINUX_ERROR,
 			    "statfs(%s) failed: %s\n",
 			    pathname, strerror(errno));
-- 
2.23.3

