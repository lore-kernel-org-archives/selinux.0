Return-Path: <SRS0=ShWd=O5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15568C43612
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 15:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F1521852
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 15:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeLTPOf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:14:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLTPOf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 20 Dec 2018 10:14:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCE14804F5
        for <selinux@vger.kernel.org>; Thu, 20 Dec 2018 15:14:34 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21950600C1;
        Thu, 20 Dec 2018 15:14:33 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 2/4] python/semanage: import sepolicy only when it's needed
Date:   Thu, 20 Dec 2018 16:14:18 +0100
Message-Id: <20181220151420.30878-3-plautrba@redhat.com>
In-Reply-To: <20181220151420.30878-1-plautrba@redhat.com>
References: <20181220151420.30878-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 20 Dec 2018 15:14:34 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Related:
https://github.com/SELinuxProject/selinux/issues/81

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index a192fac8..1cb13683 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -73,7 +73,7 @@ usage_interface_dict = {' --add': ('-t TYPE', '-r RANGE', 'interface'), ' --modi
 usage_boolean = "semanage boolean [-h] [-n] [-N] [-S STORE] ["
 usage_boolean_dict = {' --modify': ('(', '--on', '|', '--off', ')', 'boolean'), ' --list': ('-C',), '  --extract': ('',), ' --deleteall': ('',)}
 
-import sepolicy
+
 
 
 class CheckRole(argparse.Action):
@@ -82,7 +82,11 @@ class CheckRole(argparse.Action):
         newval = getattr(namespace, self.dest)
         if not newval:
             newval = []
-        roles = sepolicy.get_all_roles()
+        try:
+            import sepolicy
+            roles = sepolicy.get_all_roles()
+        except ValueError:
+            roles = []
         for v in value.split():
             if v not in roles:
                 raise ValueError("%s must be an SELinux role:\nValid roles: %s" % (v, ", ".join(roles)))
-- 
2.20.1

