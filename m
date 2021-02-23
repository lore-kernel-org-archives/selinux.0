Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063A3C433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 15:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C095464E58
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 15:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhBWPFx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Feb 2021 10:05:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232938AbhBWPFK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Feb 2021 10:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614092624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o4kQfZ5oUK+B56y8kVdJzXiCNYtKrnaIPNTIIkJXHO8=;
        b=SoVDhas2Wt+8R8xm9CUhFldW4DgF2oCrD6Hzd9A8HPsfEQ1zfUarAMmJ54WFmIuiY09VTD
        UYCSjwJORIUOH7ud0RBv6NC31Sg97M8ZKAote5XrIoY3+plwIDj8gtpofJHj3dllM59ZaD
        Q7ybleDTK7zX/fYE16aLzVenBUlOpI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-5Np8AugwO-CbMnnfxyWcdw-1; Tue, 23 Feb 2021 10:03:38 -0500
X-MC-Unique: 5Np8AugwO-CbMnnfxyWcdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0332846209
        for <selinux@vger.kernel.org>; Tue, 23 Feb 2021 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 823795D6CF;
        Tue, 23 Feb 2021 15:03:35 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] sepolicy: Do not try to load policy on import
Date:   Tue, 23 Feb 2021 16:03:28 +0100
Message-Id: <20210223150328.56028-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When a policy is inaccessible, scripts fail right "import sepolicy". With
this change we let the "sepolicy" module to import and move the policy
initialization before it's used for the first time.

Fixes:
    >>> import seobject
    Traceback (most recent call last):
      File "/usr/lib/python3.9/site-packages/sepolicy/__init__.py", line 171, in policy
        _pol = setools.SELinuxPolicy(policy_file)
      File "setools/policyrep/selinuxpolicy.pxi", line 73, in setools.policyrep.SELinuxPolicy.__cinit__
      File "setools/policyrep/selinuxpolicy.pxi", line 695, in setools.policyrep.SELinuxPolicy._load_policy
    PermissionError: [Errno 13] Permission denied: '//etc/selinux/targeted/policy/policy.33'

    During handling of the above exception, another exception occurred:

    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
      File "/usr/lib/python3.9/site-packages/seobject.py", line 33, in <module>
        import sepolicy
      File "/usr/lib/python3.9/site-packages/sepolicy/__init__.py", line 186, in <module>
        raise e
      File "/usr/lib/python3.9/site-packages/sepolicy/__init__.py", line 183, in <module>
        policy(policy_file)
      File "/usr/lib/python3.9/site-packages/sepolicy/__init__.py", line 173, in policy
        raise ValueError(_("Failed to read %s policy file") % policy_file)
    ValueError: Failed to read //etc/selinux/targeted/policy/policy.33 policy file

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

It's based on review from https://lore.kernel.org/selinux/CAEjxPJ5gK_DdNxpjMq8tvvhkq1hxsoE5vTNZAa=hiP-6s=an8Q@mail.gmail.com/T/#m88ed2c2522a5b3907b607fdf08fde5dbf8d48571


 python/sepolicy/sepolicy/__init__.py | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index e4540977d042..7309875c7e27 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -178,15 +178,15 @@ def load_store_policy(store):
         return None
     policy(policy_file)
 
-try:
+def init_policy():
     policy_file = get_installed_policy()
     policy(policy_file)
-except ValueError as e:
-    if selinux.is_selinux_enabled() == 1:
-        raise e
-
 
 def info(setype, name=None):
+    global _pol
+    if not _pol:
+        init_policy()
+
     if setype == TYPE:
         q = setools.TypeQuery(_pol)
         q.name = name
@@ -337,6 +337,9 @@ def _setools_rule_to_dict(rule):
 
 
 def search(types, seinfo=None):
+    global _pol
+    if not _pol:
+        init_policy()
     if not seinfo:
         seinfo = {}
     valid_types = set([ALLOW, AUDITALLOW, NEVERALLOW, DONTAUDIT, TRANSITION, ROLE_ALLOW])
@@ -916,6 +919,10 @@ def get_all_roles():
     if roles:
         return roles
 
+    global _pol
+    if not _pol:
+        init_policy()
+
     q = setools.RoleQuery(_pol)
     roles = [str(x) for x in q.results() if str(x) != "object_r"]
     return roles
-- 
2.30.1

