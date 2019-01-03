Return-Path: <SRS0=aYz6=PL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856BC43612
	for <selinux@archiver.kernel.org>; Thu,  3 Jan 2019 12:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FDA2070D
	for <selinux@archiver.kernel.org>; Thu,  3 Jan 2019 12:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfACMDx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:03:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfACMDx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 3 Jan 2019 07:03:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CF2E368DD
        for <selinux@vger.kernel.org>; Thu,  3 Jan 2019 12:03:53 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BB136013C;
        Thu,  3 Jan 2019 12:03:52 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 5/5] python/sepolicy: Make policy files sorting more robust
Date:   Thu,  3 Jan 2019 13:03:40 +0100
Message-Id: <20190103120340.2695-5-plautrba@redhat.com>
In-Reply-To: <20190103120340.2695-1-plautrba@redhat.com>
References: <20181220151420.30878-1-plautrba@redhat.com>
 <20190103120340.2695-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 03 Jan 2019 12:03:53 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The sorting order seems to be fragile because '100' < '99', so the policy
filename needs to be parsed in order to extract the version as an integer and
sort according to it.

Based on idea from Nicolas Iooss <nicolas.iooss@m4x.org>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index b69a6b94..6f729472 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -119,23 +119,34 @@ all_allow_rules = None
 all_transitions = None
 
 
+def policy_sortkey(policy_path):
+    # Parse the extension of a policy path which looks like .../policy/policy.31
+    extension = policy_path.rsplit('/policy.', 1)[1]
+    try:
+        return int(extension), policy_path
+    except ValueError:
+        # Fallback with sorting on the full path
+        return 0, policy_path
+
 def get_installed_policy(root="/"):
     try:
         path = root + selinux.selinux_binary_policy_path()
         policies = glob.glob("%s.*" % path)
-        policies.sort()
+        policies.sort(key=policy_sortkey)
         return policies[-1]
     except:
         pass
     raise ValueError(_("No SELinux Policy installed"))
 
-def get_store_policy(store, root="/"):
-    try:
-        policies = glob.glob("%s%s/policy/policy.*" % (selinux.selinux_path(), store))
-        policies.sort()
-        return policies[-1]
-    except:
+def get_store_policy(store):
+    """Get the path to the policy file located in the given store name"""
+    policies = glob.glob("%s%s/policy/policy.*" %
+                         (selinux.selinux_path(), store))
+    if not policies:
         return None
+    # Return the policy with the higher version number
+    policies.sort(key=policy_sortkey)
+    return policies[-1]
 
 def policy(policy_file):
     global all_domains
-- 
2.20.1

