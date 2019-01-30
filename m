Return-Path: <SRS0=UzQU=QG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAFEC282D7
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 13:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD9120989
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 13:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfA3NdD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:33:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3NdD (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 30 Jan 2019 08:33:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9905A58E40
        for <selinux@vger.kernel.org>; Wed, 30 Jan 2019 13:33:03 +0000 (UTC)
Received: from firefly.usersys.redhat.com (unknown [10.43.21.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EE025C21E
        for <selinux@vger.kernel.org>; Wed, 30 Jan 2019 13:33:02 +0000 (UTC)
From:   Viktor Ashirov <vashirov@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/restorecon: add force option
Date:   Wed, 30 Jan 2019 14:33:00 +0100
Message-Id: <20190130133300.3415-1-vashirov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 30 Jan 2019 13:33:03 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This adds 'force' keyword argument to selinux.restorecon() function
using SELINUX_RESTORECON_SET_SPECFILE_CTX flag.

Signed-off-by: Viktor Ashirov <vashirov@redhat.com>
---
 libselinux/src/selinuxswig_python.i | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 2af7c7e0..4c73bf92 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -20,7 +20,7 @@ DISABLED = -1
 PERMISSIVE = 0
 ENFORCING = 1
 
-def restorecon(path, recursive=False, verbose=False):
+def restorecon(path, recursive=False, verbose=False, force=False):
     """ Restore SELinux context on a given path
 
     Arguments:
@@ -29,6 +29,9 @@ def restorecon(path, recursive=False, verbose=False):
     Keyword arguments:
     recursive -- Change files and directories file labels recursively (default False)
     verbose -- Show changes in file labels (default False)
+    force -- Force reset of context to match file_context for customizable files,
+    and the default file context, changing the user, role, range portion  as well
+    as the type (default False)
     """
 
     restorecon_flags = SELINUX_RESTORECON_IGNORE_DIGEST | SELINUX_RESTORECON_REALPATH
@@ -36,6 +39,8 @@ def restorecon(path, recursive=False, verbose=False):
         restorecon_flags |= SELINUX_RESTORECON_RECURSE
     if verbose:
         restorecon_flags |= SELINUX_RESTORECON_VERBOSE
+    if force:
+        restorecon_flags |= SELINUX_RESTORECON_SET_SPECFILE_CTX
     selinux_restorecon(os.path.expanduser(path), restorecon_flags)
 
 def chcon(path, context, recursive=False):
-- 
2.20.1

