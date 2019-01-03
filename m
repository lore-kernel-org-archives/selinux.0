Return-Path: <SRS0=aYz6=PL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F405C43444
	for <selinux@archiver.kernel.org>; Thu,  3 Jan 2019 12:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8452070D
	for <selinux@archiver.kernel.org>; Thu,  3 Jan 2019 12:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfACMDs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:03:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfACMDs (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 3 Jan 2019 07:03:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99D01806B3
        for <selinux@vger.kernel.org>; Thu,  3 Jan 2019 12:03:48 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5E796013C;
        Thu,  3 Jan 2019 12:03:47 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 3/5] python/sepolicy: Add sepolicy.load_store_policy(store)
Date:   Thu,  3 Jan 2019 13:03:38 +0100
Message-Id: <20190103120340.2695-3-plautrba@redhat.com>
In-Reply-To: <20190103120340.2695-1-plautrba@redhat.com>
References: <20181220151420.30878-1-plautrba@redhat.com>
 <20190103120340.2695-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 03 Jan 2019 12:03:48 +0000 (UTC)
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

