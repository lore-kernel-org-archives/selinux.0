Return-Path: <SRS0=LxTM=M4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BC7C070C3
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 10:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF802089E
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 10:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF802089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJPRzd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:55:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPRzd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 16 Oct 2018 13:55:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24C67C04B95A
        for <selinux@vger.kernel.org>; Tue, 16 Oct 2018 10:05:53 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-163.brq.redhat.com [10.40.204.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EC137A7A3
        for <selinux@vger.kernel.org>; Tue, 16 Oct 2018 10:05:52 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] python/semanage: Stop rejecting aliases in semanage commands
Date:   Tue, 16 Oct 2018 12:05:33 +0200
Message-Id: <20181016100533.12249-4-vmojzis@redhat.com>
In-Reply-To: <20181016100533.12249-1-vmojzis@redhat.com>
References: <20181016100533.12249-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 16 Oct 2018 10:05:53 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Resolves:

\# semanage fcontext -a -t svirt_sandbox_file_t /pokus
ValueError: Type svirt_sandbox_file_t is invalid, must be a file or device type
\# semanage fcontext -d -t svirt_sandbox_file_t /pokus
ValueError: File context for /pokus is not defined

\# seinfo -tsvirt_sandbox_file_t -x
   TypeName container_file_t
   Aliases
      svirt_sandbox_file_t
      svirt_lxc_file_t

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index c1467185..5d34cdbe 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1081,7 +1081,7 @@ class portRecords(semanageRecords):
         if type == "":
             raise ValueError(_("Type is required"))
 
-        if type not in self.valid_types:
+        if sepolicy.get_real_type_name(type) not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a port type") % type)
 
         (k, proto_d, low, high) = self.__genkey(port, proto)
@@ -1145,7 +1145,7 @@ class portRecords(semanageRecords):
             else:
                 raise ValueError(_("Requires setype"))
 
-        if setype and setype not in self.valid_types:
+        if setype and sepolicy.get_real_type_name(setype) not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a port type") % setype)
 
         (k, proto_d, low, high) = self.__genkey(port, proto)
@@ -1349,7 +1349,7 @@ class ibpkeyRecords(semanageRecords):
         if type == "":
             raise ValueError(_("Type is required"))
 
-        if type not in self.valid_types:
+        if sepolicy.get_real_type_name(type) not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a ibpkey type") % type)
 
         (k, subnet_prefix, low, high) = self.__genkey(pkey, subnet_prefix)
@@ -1411,7 +1411,7 @@ class ibpkeyRecords(semanageRecords):
             else:
                 raise ValueError(_("Requires setype"))
 
-        if setype and setype not in self.valid_types:
+        if setype and sepolicy.get_real_type_name(setype) not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a ibpkey type") % setype)
 
         (k, subnet_prefix, low, high) = self.__genkey(pkey, subnet_prefix)
@@ -1597,7 +1597,7 @@ class ibendportRecords(semanageRecords):
         if type == "":
             raise ValueError(_("Type is required"))
 
-        if type not in self.valid_types:
+        if sepolicy.get_real_type_name(type) not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be an ibendport type") % type)
         (k, ibendport, port) = self.__genkey(ibendport, ibdev_name)
 
@@ -1658,7 +1658,7 @@ class ibendportRecords(semanageRecords):
             else:
                 raise ValueError(_("Requires setype"))
 
-        if setype and setype not in self.valid_types:
+        if setype and sepolicy.get_real_type_name(setype) not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be an ibendport type") % setype)
 
         (k, ibdev_name, port) = self.__genkey(ibendport, ibdev_name)
@@ -1847,7 +1847,7 @@ class nodeRecords(semanageRecords):
         if ctype == "":
             raise ValueError(_("SELinux node type is required"))
 
-        if ctype not in self.valid_types:
+        if sepolicy.get_real_type_name(ctype) not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a node type") % ctype)
 
         (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
@@ -1916,7 +1916,7 @@ class nodeRecords(semanageRecords):
         if serange == "" and setype == "":
             raise ValueError(_("Requires setype or serange"))
 
-        if setype and setype not in self.valid_types:
+        if setype and sepolicy.get_real_type_name(setype) not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a node type") % setype)
 
         (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
@@ -2235,7 +2235,6 @@ class fcontextRecords(semanageRecords):
     try:
         valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "file_type"))[0]["types"])
         valid_types += list(list(sepolicy.info(sepolicy.ATTRIBUTE, "device_node"))[0]["types"])
-        valid_types.append("<<none>>")
     except RuntimeError:
         valid_types = []
 
@@ -2363,7 +2362,7 @@ class fcontextRecords(semanageRecords):
         if type == "":
             raise ValueError(_("SELinux Type is required"))
 
-        if type not in self.valid_types:
+        if type != "<<none>>" and sepolicy.get_real_type_name(type) not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a file or device type") % type)
 
         (rc, k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
@@ -2426,7 +2425,7 @@ class fcontextRecords(semanageRecords):
     def __modify(self, target, setype, ftype, serange, seuser):
         if serange == "" and setype == "" and seuser == "":
             raise ValueError(_("Requires setype, serange or seuser"))
-        if setype and setype not in self.valid_types:
+        if setype not in ["",  "<<none>>"] and sepolicy.get_real_type_name(setype) not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a file or device type") % setype)
 
         self.validate(target)
-- 
2.17.1

