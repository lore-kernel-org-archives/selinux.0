Return-Path: <SRS0=5wzx=N4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF61C43441
	for <selinux@archiver.kernel.org>; Sat, 17 Nov 2018 06:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636032084A
	for <selinux@archiver.kernel.org>; Sat, 17 Nov 2018 06:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636032084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbeKQQlp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 17 Nov 2018 11:41:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:52046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbeKQQlp (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 17 Nov 2018 11:41:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E00DAE18
        for <selinux@vger.kernel.org>; Sat, 17 Nov 2018 06:26:07 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     selinux@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 1/1] Documentation: Update SELinux reference policy URL
Date:   Sat, 17 Nov 2018 07:25:55 +0100
Message-Id: <20181117062555.11962-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Documentation/admin-guide/LSM/SELinux.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/LSM/SELinux.rst b/Documentation/admin-guide/LSM/SELinux.rst
index f722c9b4173a..520a1c2c6fd2 100644
--- a/Documentation/admin-guide/LSM/SELinux.rst
+++ b/Documentation/admin-guide/LSM/SELinux.rst
@@ -6,7 +6,7 @@ If you want to use SELinux, chances are you will want
 to use the distro-provided policies, or install the
 latest reference policy release from
 
-	http://oss.tresys.com/projects/refpolicy
+	https://github.com/SELinuxProject/refpolicy
 
 However, if you want to install a dummy policy for
 testing, you can do using ``mdp`` provided under
-- 
2.19.1

