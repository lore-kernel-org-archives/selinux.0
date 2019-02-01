Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D11C282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 16:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B709021726
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 16:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfBAQtp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:49:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQtp (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 1 Feb 2019 11:49:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12F66CA396
        for <selinux@vger.kernel.org>; Fri,  1 Feb 2019 16:49:45 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-100.brq.redhat.com [10.40.204.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 870AB6013D
        for <selinux@vger.kernel.org>; Fri,  1 Feb 2019 16:49:44 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/semanage/seobject: Fix listing boolean values
Date:   Fri,  1 Feb 2019 17:49:40 +0100
Message-Id: <20190201164940.31255-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 01 Feb 2019 16:49:45 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix gathering boolean values by fixing always False if condition
(determining whether the values are listed from local store).

Fix listing boolean values by printing the correct values and not
forcing the use of security_get_boolean_active (which causes
crash when listing booleans that are not present in active policy).

Fixes:
    # dnf install selinux-policy-mls
    # cat > mypolicy.cil
    (boolean xyz false)

    # semodule -i mypolicy.cil -s mls

    # semanage boolean -l -S mls
    ...
    irssi_use_full_network         (off  ,  off)  Allow the Irssi IRC Client to connect to any port, and to bind to any unreserved port.
    mozilla_plugin_use_bluejeans   (off  ,  off)  Allow mozilla plugin to use Bluejeans.
    OSError: No such file or directory

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 556d3ba5..b31a90c1 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2807,7 +2807,7 @@ class booleanRecords(semanageRecords):
             value = []
             name = semanage_bool_get_name(boolean)
             value.append(semanage_bool_get_value(boolean))
-            if self.modify_local and boolean in self.current_booleans:
+            if self.modify_local and name in self.current_booleans:
                 value.append(selinux.security_get_boolean_pending(name))
                 value.append(selinux.security_get_boolean_active(name))
             else:
@@ -2849,4 +2849,4 @@ class booleanRecords(semanageRecords):
             print("%-30s %s  %s %s\n" % (_("SELinux boolean"), _("State"), _("Default"), _("Description")))
         for k in sorted(ddict.keys()):
             if ddict[k]:
-                print("%-30s (%-5s,%5s)  %s" % (k, on_off[selinux.security_get_boolean_active(k)], on_off[ddict[k][2]], self.get_desc(k)))
+                print("%-30s (%-5s,%5s)  %s" % (k, on_off[ddict[k][2]], on_off[ddict[k][0]], self.get_desc(k)))
-- 
2.17.2

