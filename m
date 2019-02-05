Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4127C282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 08:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECCC2080F
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 08:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfBEI4P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:56:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40795 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbfBEI4P (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 5 Feb 2019 03:56:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61B965944F
        for <selinux@vger.kernel.org>; Tue,  5 Feb 2019 08:56:15 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBC8F61532
        for <selinux@vger.kernel.org>; Tue,  5 Feb 2019 08:56:14 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: Add -S option to manpage
Date:   Tue,  5 Feb 2019 09:56:10 +0100
Message-Id: <20190205085610.14029-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 05 Feb 2019 08:56:15 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 checkpolicy/checkpolicy.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 1c8805d5..a3e4acc0 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -39,6 +39,9 @@ Write a binary policy file to the specified filename.
 .B \-c policyvers
 Specify the policy version, defaults to the latest.
 .TP
+.B \-S,\-\-sort
+Sort ocontexts before writing out the binary policy. This option makes output of checkpolicy consistent with binary policies created by semanage and secilc.
+.TP
 .B \-t,\-\-target
 Specify the target platform (selinux or xen).
 .TP
-- 
2.17.2

