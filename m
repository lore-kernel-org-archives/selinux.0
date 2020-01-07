Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDD2C32771
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 01:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402552072E
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 01:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go/i/cMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgAGBjY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:39:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34474 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgAGBjY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 20:39:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so20923809pfc.1;
        Mon, 06 Jan 2020 17:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BcDQpu3fVXCp65bnUVYlKVk92q4FOMqEZL5EQW3/yP0=;
        b=go/i/cMbOARRQVokioLhN/htb67IaDYlIXboEVmR1TbTKiQ2STY3u7h+OAlUGluGD9
         nisE4oGOyJq2DU9BJziGyu5rlwdKzFeJ8Q99xx5LSTmq7kug3g4njnY6/IeKySSE6Rpw
         J6XkW9JpUQXDpViYg4XB8n/79IPwt7hKekALIFpDbrOhptBoDWHnFaSk2B+YnAYdWu0y
         qdFnXhGxKJgvsVSUR2YL+tGpYZNiXXKJ3JiYosEq6NEAqSX0pJDImRkoaRZPygFcq1BT
         15fYgMMSzAoiREZHI9aSh1KDDnudMKMr0YNg7NLALjqLaxOkj4BPjHd54Cd94JuK2hTK
         aODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BcDQpu3fVXCp65bnUVYlKVk92q4FOMqEZL5EQW3/yP0=;
        b=W2pOOyFJZNcJniknCcnNjUvdGYI3kVYh1f1S5Nk03dK2Moy3Ng/+vCZc4EXyiZSoSj
         Azr1n1gDeiR9cF1cQyUzyKULD0hZGNUiRM3lFQmYIMrMfUGqq9IPSIj/r5+Bxv+Fvuea
         ii02gF1IWBYCv/TMWDA10AYAuCwtqF9I8jv5tagcNKh+y0wv3D/2xIRThOdAKhzwACva
         0Gg6gk4TMSP0rACSqcP6Qs0hJ0ROiuf61G9kAuxmwo5EabUE1AjTYwVQnccEN6zxLI+f
         adinjThPPIlQBcKdVErI8XdMGpY+mgUQ+uxuDZvEcY1KDBEtvxabdPzOiqwLD0TsIP0Q
         A22g==
X-Gm-Message-State: APjAAAWxWPHINIdgHFiEsOT2XUvpk9GU8njHleD+sOZMBOSiYd0JX2Nw
        e6Dv4nOOtSiw6IPvrDctRKTKwcc0
X-Google-Smtp-Source: APXvYqyrC/hBUWYQWUfTch01WDIl59Zo5xgxUL1U3eB1k4mRKVaNtP7SHeVR+/2OMDkTHoKxKDx68w==
X-Received: by 2002:aa7:96b7:: with SMTP id g23mr109012696pfk.108.1578361164098;
        Mon, 06 Jan 2020 17:39:24 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p23sm74779248pgh.83.2020.01.06.17.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 17:39:23 -0800 (PST)
From:   liuyang34 <yangliuxm34@gmail.com>
X-Google-Original-From: liuyang34 <liuyang34@xiaomi.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liuyang34 <liuyang34@xiaomi.com>
Subject: [PATCH v2] selinuxfs: use scnprinft to get real length for inode
Date:   Tue,  7 Jan 2020 09:39:18 +0800
Message-Id: <1578361158-27940-1-git-send-email-liuyang34@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

as the return value of snprintf maybe over the size of TMPBUFLEN, use scnprintf
to instead of it in sel_read_class and sel_read_perm

Signed-off-by: liuyang34 <liuyang34@xiaomi.com>
---
 security/selinux/selinuxfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ee94fa4..376d2c0e 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1672,7 +1672,7 @@ static ssize_t sel_read_class(struct file *file, char __user *buf,
 {
 	unsigned long ino = file_inode(file)->i_ino;
 	char res[TMPBUFLEN];
-	ssize_t len = snprintf(res, sizeof(res), "%d", sel_ino_to_class(ino));
+	ssize_t len = scnprintf(res, sizeof(res), "%d", sel_ino_to_class(ino));
 	return simple_read_from_buffer(buf, count, ppos, res, len);
 }
 
@@ -1686,7 +1686,7 @@ static ssize_t sel_read_perm(struct file *file, char __user *buf,
 {
 	unsigned long ino = file_inode(file)->i_ino;
 	char res[TMPBUFLEN];
-	ssize_t len = snprintf(res, sizeof(res), "%d", sel_ino_to_perm(ino));
+	ssize_t len = scnprintf(res, sizeof(res), "%d", sel_ino_to_perm(ino));
 	return simple_read_from_buffer(buf, count, ppos, res, len);
 }
 
-- 
2.7.4

