Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52938C7EE23
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 16:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjFAQgm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjFAQgl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 12:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC6013E
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685637362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QD+OxyQew44D49ZBnFgHAMKhTH8BPRvgCbGoZL26IOk=;
        b=jGHEI9ZGG0GQvpedwkmv9y5TzpeBhjxymOa1hx8wHaKBOK+Qhs51flnYENFvTOgkNMvdzh
        5C0dI/vg283n8c4ePq/l3mlu7cVX4fIXULuRx7k3i3SFULetbCUwdHSwPzNFzzBQtQBSsJ
        UyWsFkiwiw+9VZ5zsXFSLfwVTNFxXso=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-TluqBC5POgG16uZN-HZnHQ-1; Thu, 01 Jun 2023 12:34:35 -0400
X-MC-Unique: TluqBC5POgG16uZN-HZnHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2540E811E85
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 16:34:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC60D40C6EC4
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 16:34:34 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/sepolicy: Fix template for confined user policy modules
Date:   Thu,  1 Jun 2023 18:34:30 +0200
Message-Id: <20230601163430.2062951-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The following commit
https://github.com/SELinuxProject/refpolicy/commit/330b0fc3331d3b836691464734c96f3da3044490
changed the userdom_base_user_template, which now requires a role
corresponding to the user being created to be defined outside of the
template.
Similar change was also done to fedora-selinux/selinux-policy
https://github.com/fedora-selinux/selinux-policy/commit/e1e216b25df1bdb4eb7dbb8f73f32927ad6f3d1f

Although I believe the template should define the role (just as it
defines the new user), that will require extensive changes to refpolicy.
In the meantime the role needs to be defined separately.

Fixes:
\# sepolicy generate --term_user -n newuser
Created the following files:
/root/a/test/newuser.te # Type Enforcement file
/root/a/test/newuser.if # Interface file
/root/a/test/newuser.fc # File Contexts file
/root/a/test/newuser_selinux.spec # Spec file
/root/a/test/newuser.sh # Setup Script

\# ./newuser.sh
Building and Loading Policy
+ make -f /usr/share/selinux/devel/Makefile newuser.pp
Compiling targeted newuser module
Creating targeted newuser.pp policy package
rm tmp/newuser.mod tmp/newuser.mod.fc
+ /usr/sbin/semodule -i newuser.pp
Failed to resolve roleattributeset statement at /var/lib/selinux/targeted/tmp/modules/400/newuser/cil:8
Failed to resolve AST
/usr/sbin/semodule:  Failed!

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolicy/sepolicy/templates/user.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/python/sepolicy/sepolicy/templates/user.py b/python/sepolicy/sepolicy/templates/user.py
index 1ff9d2ce..7081fbae 100644
--- a/python/sepolicy/sepolicy/templates/user.py
+++ b/python/sepolicy/sepolicy/templates/user.py
@@ -28,6 +28,8 @@ policy_module(TEMPLATETYPE, 1.0.0)
 #
 # Declarations
 #
+role TEMPLATETYPE_r;
+
 userdom_unpriv_user_template(TEMPLATETYPE)
 """
 
@@ -38,6 +40,8 @@ policy_module(TEMPLATETYPE, 1.0.0)
 #
 # Declarations
 #
+role TEMPLATETYPE_r;
+
 userdom_admin_user_template(TEMPLATETYPE)
 """
 
@@ -48,6 +52,7 @@ policy_module(TEMPLATETYPE, 1.0.0)
 #
 # Declarations
 #
+role TEMPLATETYPE_r;
 
 userdom_restricted_user_template(TEMPLATETYPE)
 """
@@ -59,6 +64,7 @@ policy_module(TEMPLATETYPE, 1.0.0)
 #
 # Declarations
 #
+role TEMPLATETYPE_r;
 
 userdom_restricted_xwindows_user_template(TEMPLATETYPE)
 """
@@ -89,6 +95,7 @@ gen_tunable(TEMPLATETYPE_manage_user_files, false)
 #
 # Declarations
 #
+role TEMPLATETYPE_r;
 
 userdom_base_user_template(TEMPLATETYPE)
 """
-- 
2.40.0

