Return-Path: <SRS0=5iRL=QT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D359FC282C4
	for <selinux@archiver.kernel.org>; Tue, 12 Feb 2019 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2936207E0
	for <selinux@archiver.kernel.org>; Tue, 12 Feb 2019 15:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfBLPUv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:20:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfBLPUv (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 12 Feb 2019 10:20:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C70A8356F3
        for <selinux@vger.kernel.org>; Tue, 12 Feb 2019 15:20:50 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.205.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 120275D9D1;
        Tue, 12 Feb 2019 15:20:49 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2] libsemanage: genhomedircon - improve handling large groups
Date:   Tue, 12 Feb 2019 16:20:46 +0100
Message-Id: <20190212152046.13875-1-plautrba@redhat.com>
In-Reply-To: <pjdimxuxm7c.fsf@redhat.com>
References: <pjdimxuxm7c.fsf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 12 Feb 2019 15:20:50 +0000 (UTC)
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
 libsemanage/src/genhomedircon.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 591941fb..e5f8d371 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1077,10 +1077,24 @@ static int get_group_users(genhomedircon_settings_t * s,
 
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
+		if (grbuflen < 0)
+			/* the member list could exceed 2Gb on a system with a 32-bit CPU (where
+			 * sizeof(long) = 4) - if this ever happened, the loop would become infinite. */
+			goto cleanup;
+		new_grbuf = realloc(grbuf, grbuflen);
+		if (new_grbuf == NULL)
+			goto cleanup;
+		grbuf = new_grbuf;
 	}
+	if (retval != 0)
+		goto cleanup;
 
 	if (group == NULL) {
 		ERR(s->h_semanage, "Can't find group named %s\n", grname);
-- 
2.20.1

