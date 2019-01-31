Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6133CC169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 19:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32537218AF
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 19:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfAaTlp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:41:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfAaTlp (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 31 Jan 2019 14:41:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7740FE3E08
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 19:41:45 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.205.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82AFB5D982;
        Thu, 31 Jan 2019 19:41:44 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dan Walsh <dwalsh@redhat.com>, Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] python/semanage: Examples are no longer in the main semanage man page
Date:   Thu, 31 Jan 2019 20:41:40 +0100
Message-Id: <20190131194140.3785-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 31 Jan 2019 19:41:45 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Dan Walsh <dwalsh@redhat.com>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage.8 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/python/semanage/semanage.8 b/python/semanage/semanage.8
index 0bdb90f4..0cdcfccd 100644
--- a/python/semanage/semanage.8
+++ b/python/semanage/semanage.8
@@ -57,9 +57,8 @@ to SELinux user identities (which controls the initial security context
 assigned to Linux users when they login and bounds their authorized role set)
 as well as security context mappings for various kinds of objects, such
 as network ports, interfaces, infiniband pkeys and endports, and nodes (hosts)
-as well as the file context mapping. See the EXAMPLES section below for some
-examples of common usage.  Note that the semanage login command deals with the
-mapping from Linux usernames (logins) to SELinux user identities,
+as well as the file context mapping. Note that the semanage login command deals
+with the mapping from Linux usernames (logins) to SELinux user identities,
 while the semanage user command deals with the mapping from SELinux
 user identities to authorized role sets.  In most cases, only the
 former mapping needs to be adjusted by the administrator; the latter
-- 
2.20.1

