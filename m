Return-Path: <SRS0=ShWd=O5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE8DC43387
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 15:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5F21852
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 15:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeLTPOg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:14:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLTPOf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 20 Dec 2018 10:14:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC6462DD77C
        for <selinux@vger.kernel.org>; Thu, 20 Dec 2018 15:14:35 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DB93604CC;
        Thu, 20 Dec 2018 15:14:34 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 3/4] python/sepolicy: Add sepolicy.load_store_policy(store)
Date:   Thu, 20 Dec 2018 16:14:19 +0100
Message-Id: <20181220151420.30878-4-plautrba@redhat.com>
In-Reply-To: <20181220151420.30878-1-plautrba@redhat.com>
References: <20181220151420.30878-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 20 Dec 2018 15:14:35 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

load_store_policy() allows to (re)load SELinux policy based on a store name. It
is useful when SELinux is disabled and default policy is not installed; or when
a user wants to query or manipulate another policy.

Related: https://bugzilla.redhat.com/show_bug.cgi?id=1558861

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index fbeb731d..b69a6b94 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -129,6 +129,13 @@ def get_installed_policy(root="/"):
         pass
     raise ValueError(_("No SELinux Policy installed"))
 
+def get_store_policy(store, root="/"):
+    try:
+        policies = glob.glob("%s%s/policy/policy.*" % (selinux.selinux_path(), store))
+        policies.sort()
+        return policies[-1]
+    except:
+        return None
 
 def policy(policy_file):
     global all_domains
@@ -156,6 +163,11 @@ def policy(policy_file):
     except:
         raise ValueError(_("Failed to read %s policy file") % policy_file)
 
+def load_store_policy(store):
+    policy_file = get_store_policy(store)
+    if not policy_file:
+        return None
+    policy(policy_file)
 
 try:
     policy_file = get_installed_policy()
-- 
2.20.1

