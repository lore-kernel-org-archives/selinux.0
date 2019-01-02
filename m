Return-Path: <SRS0=NpCz=PK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663B4C43387
	for <selinux@archiver.kernel.org>; Wed,  2 Jan 2019 13:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD84218DE
	for <selinux@archiver.kernel.org>; Wed,  2 Jan 2019 13:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bigon.be header.i=@bigon.be header.b="kredz2Gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfABN4M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:56:12 -0500
Received: from ithil.bigon.be ([163.172.57.153]:36222 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbfABN4M (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 2 Jan 2019 08:56:12 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jan 2019 08:56:11 EST
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 7DB3820DD6
        for <selinux@vger.kernel.org>; Wed,  2 Jan 2019 14:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigon.be; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :date:subject:subject:from:from:received:received:received; s=
        key2; t=1546436929; x=1548251330; bh=YWv+SbuHMR2kdz/xgbisjiCjkw8
        2RduAGlFhZwMCOxY=; b=kredz2Gtap3jNXt4m4N927In4ApzTscFaa15L9s6o5L
        W2x0ufaVyahFpZkyJCCSbEsyQ1bqOUjJFDtUKi5GkJ29m/ktf5XnG98a/7TuNGi1
        3kOpI31NxoCDnDC1vMgaE5H+rNe4QCtr7NiXF/qNxcMQqZjfwKYLx2+1VlskX9xg
        =
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 4czIACipv1Ld for <selinux@vger.kernel.org>;
        Wed,  2 Jan 2019 14:48:49 +0100 (CET)
Received: from valinor.bigon.be (d54c71dba.static.telenet.be [84.199.29.186])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA
        for <selinux@vger.kernel.org>; Wed,  2 Jan 2019 14:48:49 +0100 (CET)
Received: from bigon (uid 1000)
        (envelope-from bigon@bigon.be)
        id 5fca5
        by valinor.bigon.be (DragonFly Mail Agent v0.11);
        Wed, 02 Jan 2019 14:46:39 +0100
From:   Laurent Bigonville <bigon@debian.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsemanage: Always set errno to 0 before calling getpwent()
Date:   Wed,  2 Jan 2019 14:46:39 +0100
Message-Id: <20190102134639.30515-1-bigon@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Laurent Bigonville <bigon@bigon.be>

The manpage explicitly states that:

  The  getpwent()  function  returns a pointer to a passwd structure, or
  NULL if there are no more entries or an error occurred.  If an error
  occurs, errno is set appropriately.  If one wants to check errno after
  the call, it should be set to zero before the call.

Without this, genhomedircon can wrongly return the following:
  libsemanage.get_home_dirs: Error while fetching users.  Returning list so far.

https://github.com/SELinuxProject/selinux/issues/121

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 libsemanage/src/genhomedircon.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 3e61b510..591941fb 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -361,7 +361,11 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 
 	errno = 0;
 	setpwent();
-	while ((pwbuf = getpwent()) != NULL) {
+	while (1) {
+		errno = 0;
+		pwbuf = getpwent();
+		if (pwbuf == NULL)
+			break;
 		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
@@ -403,7 +407,6 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		}
 		free(path);
 		path = NULL;
-		errno = 0;
 	}
 
 	if (errno) {
@@ -1101,7 +1104,11 @@ static int get_group_users(genhomedircon_settings_t * s,
 	}
 
 	setpwent();
-	while ((pw = getpwent()) != NULL) {
+	while (1) {
+		errno = 0;
+		pw = getpwent();
+		if (pw == NULL)
+			break;
 		// skip users who also have this group as their
 		// primary group
 		if (lfind(pw->pw_name, group->gr_mem, &nmembers,
-- 
2.20.1

