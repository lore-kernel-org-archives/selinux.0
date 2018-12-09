Return-Path: <SRS0=r/KF=OS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9BC67838
	for <selinux@archiver.kernel.org>; Sun,  9 Dec 2018 14:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28EB20672
	for <selinux@archiver.kernel.org>; Sun,  9 Dec 2018 14:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28EB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLIOXs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:23:48 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:48140 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLIOXs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Dec 2018 09:23:48 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 98A77564670
        for <selinux@vger.kernel.org>; Sun,  9 Dec 2018 15:23:45 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] python/chcat: fix removing categories on users with Fedora default setup
Date:   Sun,  9 Dec 2018 15:23:23 +0100
Message-Id: <20181209142323.21149-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209142323.21149-1-nicolas.iooss@m4x.org>
References: <20181209142323.21149-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Dec  9 15:23:45 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Using Vagrant with fedora/28-cloud-base image, SELinux logins are
configured this way:

    # semanage login -l
    Login Name           SELinux User         MLS/MCS Range        Service

    __default__          unconfined_u         s0-s0:c0.c1023       *
    root                 unconfined_u         s0-s0:c0.c1023       *
    vagrant              unconfined_u         s0-s0:c0.c1023       *

Using "chcat -l +c42 vagrant" successfully adds the category to user
vagrant, but "chcat -l -- -c42 vagrant" fails to remove it.
semanage login -l returns:

    vagrant              unconfined_u         s0-s0:c0.c1023,c42   *

This issue is caused by expandCats(), which refuses to return a list of
more than 25 categories. This causes chcat_user_remove() to work with
cats=['c0.c1023,c42'] instead of cats=['c0.c102','c42'], which leads to
it not been able to remove 'c42' from the list.

Fix this issue by splitting the list of categories before calling
expandCats().

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/chcat/chcat | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/python/chcat/chcat b/python/chcat/chcat
index 73f757258807..5bef0073b7a4 100755
--- a/python/chcat/chcat
+++ b/python/chcat/chcat
@@ -82,8 +82,7 @@ def chcat_user_add(newcat, users):
         if len(serange) > 1:
             top = serange[1].split(":")
             if len(top) > 1:
-                cats.append(top[1])
-                cats = expandCats(cats)
+                cats = expandCats(top[1].split(','))
 
         for i in newcat[1:]:
             if i not in cats:
@@ -163,8 +162,7 @@ def chcat_user_remove(newcat, users):
         if len(serange) > 1:
             top = serange[1].split(":")
             if len(top) > 1:
-                cats.append(top[1])
-                cats = expandCats(cats)
+                cats = expandCats(top[1].split(','))
 
         for i in newcat[1:]:
             if i in cats:
-- 
2.19.1

