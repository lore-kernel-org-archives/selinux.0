Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B845EC169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 19:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884D72080D
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 19:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfBFTng (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:43:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfBFTng (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Feb 2019 14:43:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BBA530254D
        for <selinux@vger.kernel.org>; Wed,  6 Feb 2019 19:43:36 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-32.brq.redhat.com [10.40.204.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E3FD45D1;
        Wed,  6 Feb 2019 19:43:34 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 2/2] python/semanage: Use standard argparse.error() method in handlePermissive
Date:   Wed,  6 Feb 2019 20:43:25 +0100
Message-Id: <20190206194325.24875-2-plautrba@redhat.com>
In-Reply-To: <20190206194325.24875-1-plautrba@redhat.com>
References: <20190206194325.24875-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 06 Feb 2019 19:43:36 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This method prints a usage message including the message to the standard error
and terminates the program with a status code of 2.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 9b737fa8..a9fcb319 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -743,9 +743,7 @@ def handlePermissive(args):
         if args.action == "delete":
             OBJECT.delete(args.type)
     else:
-        args.parser.print_usage(sys.stderr)
-        sys.stderr.write(_('semanage permissive: error: the following argument is required: type\n'))
-        sys.exit(1)
+        args.parser.error(message=_('semanage permissive: error: the following argument is required: type\n'))
 
 
 def setupPermissiveParser(subparsers):
-- 
2.20.1

