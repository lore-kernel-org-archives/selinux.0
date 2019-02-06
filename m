Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0473BC169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC6C2080D
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 19:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfBFTpd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:45:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfBFTpd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Feb 2019 14:45:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 428D77E9D8
        for <selinux@vger.kernel.org>; Wed,  6 Feb 2019 19:45:33 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-32.brq.redhat.com [10.40.204.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 622D445CD;
        Wed,  6 Feb 2019 19:45:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libsemanage: genhomedircon - improve handling large groups
Date:   Wed,  6 Feb 2019 20:45:29 +0100
Message-Id: <20190206194529.24952-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 06 Feb 2019 19:45:33 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

getgrnam_r() uses a preallocated buffer to store a structure containing
the broken-out fields of the record in the group database. The size of
this buffer is usually sysconf(_SC_GETGR_R_SIZE_MAX) == 1024 and it is
not enough for groups with a large number of users.  In these cases,
getgrnam_r() returns -1 and sets errno to ERANGE and the caller can
retry with a larger buffer.

Fixes:
$ semanage login -a -s user_u -r s0-s0:c1.c2 '%largegroup'
libsemanage.semanage_direct_commit: semanage_genhomedircon returned error code -1. (Numerical result out of range).
OSError: Numerical result out of range

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/genhomedircon.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 591941fb..ac376671 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1077,10 +1077,20 @@ static int get_group_users(genhomedircon_settings_t * s,
 
 	const char *grname = selogin + 1;
 
-	if (getgrnam_r(grname, &grstorage, grbuf,
-			(size_t) grbuflen, &group) != 0) {
-		goto cleanup;
+	errno = 0;
+	while (
+		(retval = getgrnam_r(grname, &grstorage, grbuf, (size_t) grbuflen, &group)) != 0 &&
+		errno == ERANGE
+	) {
+		char *new_grbuf;
+		grbuflen *= 2;
+		new_grbuf = realloc(grbuf, grbuflen);
+		if (new_grbuf == NULL)
+			goto cleanup;
+		grbuf = new_grbuf;
 	}
+	if (retval == -1)
+		goto cleanup;
 
 	if (group == NULL) {
 		ERR(s->h_semanage, "Can't find group named %s\n", grname);
-- 
2.20.1

