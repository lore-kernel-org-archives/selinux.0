Return-Path: <SRS0=OyWE=Q3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730B8C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EE42146E
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 16:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfBTQE7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:04:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51665 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfBTQE7 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 20 Feb 2019 11:04:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DE11CFEDF
        for <selinux@vger.kernel.org>; Wed, 20 Feb 2019 16:04:59 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C7B5611B6;
        Wed, 20 Feb 2019 16:04:58 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 3/3] README: Update Fedora python 3 dependencies
Date:   Wed, 20 Feb 2019 17:04:46 +0100
Message-Id: <20190220160446.23150-4-plautrba@redhat.com>
In-Reply-To: <20190220160446.23150-1-plautrba@redhat.com>
References: <20190220160446.23150-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 20 Feb 2019 16:04:59 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 1c009b01..e4423ca2 100644
--- a/README
+++ b/README
@@ -3,7 +3,7 @@ Subscribe by sending "subscribe selinux" in the body of an email
 to majordomo@vger.kernel.org.
 
 Build dependencies on Fedora:
-yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig xmlto redhat-rpm-config
+yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python3-devel python3-setools swig xmlto redhat-rpm-config
 
 To build and install everything under a private directory, run:
 make DESTDIR=~/obj install install-pywrap
-- 
2.20.1

