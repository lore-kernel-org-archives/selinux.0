Return-Path: <SRS0=ETpO=NK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DF5C2BC61
	for <selinux@archiver.kernel.org>; Tue, 30 Oct 2018 15:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AA320657
	for <selinux@archiver.kernel.org>; Tue, 30 Oct 2018 15:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AA320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJaAU6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:20:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40015 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeJaAU6 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 30 Oct 2018 20:20:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 269643082B56
        for <selinux@vger.kernel.org>; Tue, 30 Oct 2018 15:27:03 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-167.brq.redhat.com [10.40.204.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63E5B8B3E4
        for <selinux@vger.kernel.org>; Tue, 30 Oct 2018 15:27:02 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python: replace aliases with corresponding type names
Date:   Tue, 30 Oct 2018 16:26:29 +0100
Message-Id: <20181030152629.7438-2-vmojzis@redhat.com>
In-Reply-To: <20181030152629.7438-1-vmojzis@redhat.com>
References: <CAJfZ7==UCR-a=mfLY1TRad++g+nbpZ6QMxFz5N6JV5_W6QomDQ@mail.gmail.com>
 <20181030152629.7438-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 30 Oct 2018 15:27:03 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Aliases are not used in the selinux database. When user enters a type
alias as a parameter it should be converted to the corresponding type
in order to be processed correctly further in the userspace logic.

Fixes e.g.:

\#sepolicy transition -s phpfpm_t
/* where phpfpm_t is a type alias of httpd_t */

Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 691, in <module>
    args.func(args)
  File "/usr/bin/sepolicy", line 458, in transition
    mytrans = setrans(args.source, args.target)
  File "/usr/lib/python3.6/site-packages/sepolicy/transition.py", line 48, in __init__
    self._process(self.source)
  File "/usr/lib/python3.6/site-packages/sepolicy/transition.py", line 54, in _process
    trans = _get_trans(source)
  File "/usr/lib/python3.6/site-packages/sepolicy/transition.py", line 36, in _get_trans
    src_list = [src] + list(filter(lambda x: x['name'] == src, sepolicy.get_all_types_info()))[0]['attributes']
IndexError: list index out of range
---
 python/semanage/seobject.py          | 43 ++++++++++++++++++++--------
 python/sepolicy/sepolicy.py          | 11 ++++---
 python/sepolicy/sepolicy/__init__.py | 14 ++++-----
 3 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 5d34cdbe..c4c65621 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1081,7 +1081,9 @@ class portRecords(semanageRecords):
         if type == "":
             raise ValueError(_("Type is required"))
 
-        if sepolicy.get_real_type_name(type) not in self.valid_types:
+        type = sepolicy.get_real_type_name(type)
+
+        if type not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a port type") % type)
 
         (k, proto_d, low, high) = self.__genkey(port, proto)
@@ -1145,7 +1147,8 @@ class portRecords(semanageRecords):
             else:
                 raise ValueError(_("Requires setype"))
 
-        if setype and sepolicy.get_real_type_name(setype) not in self.valid_types:
+        setype = sepolicy.get_real_type_name(setype)
+        if setype and setype not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a port type") % setype)
 
         (k, proto_d, low, high) = self.__genkey(port, proto)
@@ -1349,7 +1352,9 @@ class ibpkeyRecords(semanageRecords):
         if type == "":
             raise ValueError(_("Type is required"))
 
-        if sepolicy.get_real_type_name(type) not in self.valid_types:
+        type = sepolicy.get_real_type_name(type)
+
+        if type not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a ibpkey type") % type)
 
         (k, subnet_prefix, low, high) = self.__genkey(pkey, subnet_prefix)
@@ -1411,7 +1416,9 @@ class ibpkeyRecords(semanageRecords):
             else:
                 raise ValueError(_("Requires setype"))
 
-        if setype and sepolicy.get_real_type_name(setype) not in self.valid_types:
+        setype = sepolicy.get_real_type_name(setype)
+
+        if setype and setype not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a ibpkey type") % setype)
 
         (k, subnet_prefix, low, high) = self.__genkey(pkey, subnet_prefix)
@@ -1597,7 +1604,9 @@ class ibendportRecords(semanageRecords):
         if type == "":
             raise ValueError(_("Type is required"))
 
-        if sepolicy.get_real_type_name(type) not in self.valid_types:
+        type = sepolicy.get_real_type_name(type)
+
+        if type not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be an ibendport type") % type)
         (k, ibendport, port) = self.__genkey(ibendport, ibdev_name)
 
@@ -1658,7 +1667,9 @@ class ibendportRecords(semanageRecords):
             else:
                 raise ValueError(_("Requires setype"))
 
-        if setype and sepolicy.get_real_type_name(setype) not in self.valid_types:
+        setype = sepolicy.get_real_type_name(setype)
+
+        if setype and setype not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be an ibendport type") % setype)
 
         (k, ibdev_name, port) = self.__genkey(ibendport, ibdev_name)
@@ -1847,7 +1858,9 @@ class nodeRecords(semanageRecords):
         if ctype == "":
             raise ValueError(_("SELinux node type is required"))
 
-        if sepolicy.get_real_type_name(ctype) not in self.valid_types:
+        ctype = sepolicy.get_real_type_name(ctype)
+
+        if ctype not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a node type") % ctype)
 
         (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
@@ -1916,7 +1929,9 @@ class nodeRecords(semanageRecords):
         if serange == "" and setype == "":
             raise ValueError(_("Requires setype or serange"))
 
-        if setype and sepolicy.get_real_type_name(setype) not in self.valid_types:
+        setype = sepolicy.get_real_type_name(setype)
+
+        if setype and setype not in self.valid_types:
             raise ValueError(_("Type %s is invalid, must be a node type") % setype)
 
         (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
@@ -2362,8 +2377,10 @@ class fcontextRecords(semanageRecords):
         if type == "":
             raise ValueError(_("SELinux Type is required"))
 
-        if type != "<<none>>" and sepolicy.get_real_type_name(type) not in self.valid_types:
-            raise ValueError(_("Type %s is invalid, must be a file or device type") % type)
+        if type != "<<none>>":
+            type = sepolicy.get_real_type_name(type)
+            if type not in self.valid_types:
+                raise ValueError(_("Type %s is invalid, must be a file or device type") % type)
 
         (rc, k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
         if rc < 0:
@@ -2425,8 +2442,10 @@ class fcontextRecords(semanageRecords):
     def __modify(self, target, setype, ftype, serange, seuser):
         if serange == "" and setype == "" and seuser == "":
             raise ValueError(_("Requires setype, serange or seuser"))
-        if setype not in ["",  "<<none>>"] and sepolicy.get_real_type_name(setype) not in self.valid_types:
-            raise ValueError(_("Type %s is invalid, must be a file or device type") % setype)
+        if setype not in ["",  "<<none>>"]:
+            setype = sepolicy.get_real_type_name(setype)
+            if setype not in self.valid_types:
+                raise ValueError(_("Type %s is invalid, must be a file or device type") % setype)
 
         self.validate(target)
 
diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 01380fbe..8cc7e8cc 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -101,7 +101,8 @@ class CheckDomain(argparse.Action):
         domains = sepolicy.get_all_domains()
 
         if isinstance(values, str):
-            if sepolicy.get_real_type_name(values) not in domains:
+            values = sepolicy.get_real_type_name(values)
+            if values not in domains:
                 raise ValueError("%s must be an SELinux process domain:\nValid domains: %s" % (values, ", ".join(domains)))
             setattr(namespace, self.dest, values)
         else:
@@ -110,7 +111,8 @@ class CheckDomain(argparse.Action):
                 newval = []
 
             for v in values:
-                if sepolicy.get_real_type_name(v) not in domains:
+                v = sepolicy.get_real_type_name(v)
+                if v not in domains:
                     raise ValueError("%s must be an SELinux process domain:\nValid domains: %s" % (v, ", ".join(domains)))
                 newval.append(v)
             setattr(namespace, self.dest, newval)
@@ -165,10 +167,11 @@ class CheckPortType(argparse.Action):
         if not newval:
             newval = []
         for v in values:
-            if sepolicy.get_real_type_name(v) not in port_types:
+            v = sepolicy.get_real_type_name(v)
+            if v not in port_types:
                 raise ValueError("%s must be an SELinux port type:\nValid port types: %s" % (v, ", ".join(port_types)))
             newval.append(v)
-        setattr(namespace, self.dest, values)
+        setattr(namespace, self.dest, newval)
 
 
 class LoadPolicy(argparse.Action):
diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index b18683e4..7db43957 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -172,7 +172,7 @@ def info(setype, name=None):
         results = list(q.results())
 
         if name and len(results) < 1:
-            # type not found, try alias
+            #type not found, try alias
             q.name = None
             q.alias = name
             results = list(q.results())
@@ -450,18 +450,16 @@ def get_file_types(setype):
 def get_real_type_name(name):
     """Return the real name of a type
 
-    * If 'name' refers to a type, return the same name.
     * If 'name' refers to a type alias, return the corresponding type name.
-    * Otherwise return None.
+    * Otherwise return the original name (even if the type does not exist).
     """
     if not name:
-        return None
+        return name
 
     try:
         return next(info(TYPE, name))["name"]
     except (RuntimeError, StopIteration):
-        return None
-
+        return name
 
 def get_writable_files(setype):
     file_types = get_all_file_types()
@@ -1074,10 +1072,12 @@ def _dict_has_perms(dict, perms):
 def gen_short_name(setype):
     all_domains = get_all_domains()
     if setype.endswith("_t"):
+        #replace aliases with corresponding types
+        setype = get_real_type_name(setype)
         domainname = setype[:-2]
     else:
         domainname = setype
-    if get_real_type_name(domainname + "_t") not in all_domains:
+    if domainname + "_t" not in all_domains:
         raise ValueError("domain %s_t does not exist" % domainname)
     if domainname[-1] == 'd':
         short_name = domainname[:-1] + "_"
-- 
2.17.2

