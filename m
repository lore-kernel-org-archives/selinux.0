Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4B9C433FE
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 11:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiKULCl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKULCg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 06:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766A1A13F2
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 03:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669028496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ba+nQyNEyY4SLryqfU2kPymuxlHjbxmtr3c0dX4+rvA=;
        b=RlhtQU7OKZe+ThbDrKS7R5rTIf+C3+HKHcLdXAUdEN6mDbW4q8o+JAaM4Gmj1apllHTBWf
        2nNBH7wk9PnGwjj+oElQ1HlgLmgZSqmW0TPjZn/K6d3ZMlYr9iL7zEnIzEYeLWg3Xp8wsS
        CtEl+IsRO8tdhHY2+RwSPq6jWGu/mWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-4ylnK0MZPN2DGfu1aQz8IA-1; Mon, 21 Nov 2022 06:01:35 -0500
X-MC-Unique: 4ylnK0MZPN2DGfu1aQz8IA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1A42185A7A8
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-194-120.brq.redhat.com [10.40.194.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 140312027062;
        Mon, 21 Nov 2022 11:01:32 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] Fix E275 missing whitespace after keyword
Date:   Mon, 21 Nov 2022 12:01:25 +0100
Message-Id: <20221121110125.525391-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
  ./gui/polgengui.py:484:18: E275 missing whitespace after keyword
  ./gui/polgengui.py:530:18: E275 missing whitespace after keyword
  ./python/sepolgen/src/sepolgen/policygen.py:327:19: E275 missing whitespace after keyword
  ./python/sepolgen/src/sepolgen/policygen.py:329:11: E275 missing whitespace after keyword
  ./python/sepolicy/sepolicy/__init__.py:453:15: E275 missing whitespace after keyword
  ./python/sepolicy/sepolicy/generate.py:1351:28: E275 missing whitespace after keyword
  ./python/sepolicy/sepolicy/generate.py:1353:28: E275 missing whitespace after keyword
  ./python/sepolicy/sepolicy/gui.py:638:24: E275 missing whitespace after keyword
  ./python/sepolicy/sepolicy/gui.py:863:23: E275 missing whitespace after keyword
  ./python/sepolicy/sepolicy/gui.py:2177:16: E275 missing whitespace after keyword
  ./sandbox/sandbox:114:7: E275 missing whitespace after keyword
  ./sandbox/sandbox:134:11: E275 missing whitespace after keyword
  ./sandbox/sandbox:136:7: E275 missing whitespace after keyword

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 gui/polgengui.py                          | 4 ++--
 python/sepolgen/src/sepolgen/policygen.py | 4 ++--
 python/sepolicy/sepolicy/__init__.py      | 4 ++--
 python/sepolicy/sepolicy/generate.py      | 4 ++--
 python/sepolicy/sepolicy/gui.py           | 6 +++---
 sandbox/sandbox                           | 6 +++---
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/gui/polgengui.py b/gui/polgengui.py
index 7a3ecd50c91c..16116ba68b61 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -481,7 +481,7 @@ class childWindow:
             my_policy = sepolicy.generate.policy(self.get_name(), self.get_type())
 
             iter = self.boolean_store.get_iter_first()
-            while(iter):
+            while iter:
                 my_policy.add_boolean(self.boolean_store.get_value(iter, 0), self.boolean_store.get_value(iter, 1))
                 iter = self.boolean_store.iter_next(iter)
 
@@ -527,7 +527,7 @@ class childWindow:
             my_policy.set_out_udp(self.out_udp_all_checkbutton.get_active(), self.out_udp_entry.get_text())
 
             iter = self.store.get_iter_first()
-            while(iter):
+            while iter:
                 if self.store.get_value(iter, 1) == FILE:
                     my_policy.add_file(self.store.get_value(iter, 0))
                 else:
diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/src/sepolgen/policygen.py
index 8f0ce26e4dc7..183b41a93d50 100644
--- a/python/sepolgen/src/sepolgen/policygen.py
+++ b/python/sepolgen/src/sepolgen/policygen.py
@@ -324,9 +324,9 @@ def call_interface(interface, av):
             ifcall.args.append(av.obj_class)
         else:
             print(params[i].type)
-            assert(0)
+            assert 0
 
-    assert(len(ifcall.args) > 0)
+    assert len(ifcall.args) > 0
 
     return ifcall
 
diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 9c3caa05b80b..05888e5cb94a 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -450,9 +450,9 @@ def get_conditionals(src, dest, tclass, perm):
                 tlist.append(tdict)
                 tdict = {}
     except KeyError:
-        return(tlist)
+        return tlist
 
-    return (tlist)
+    return tlist
 
 
 def get_conditionals_format_text(cond):
diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 3717d5d4ed78..b6df3e91160b 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -1346,9 +1346,9 @@ allow %s_t %s_t:%s_socket name_%s;
             if len(temp_dirs) != 0:
                 for i in temp_dirs:
                     if i in self.dirs.keys():
-                        del(self.dirs[i])
+                        del self.dirs[i]
                     elif i in self.files.keys():
-                        del(self.files[i])
+                        del self.files[i]
                     else:
                         continue
 
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 335be582b668..c8f33f522a2d 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -635,7 +635,7 @@ class SELinuxGui():
         for k in self.cur_dict:
             for j in self.cur_dict[k]:
                 if i == ctr:
-                    del(self.cur_dict[k][j])
+                    del self.cur_dict[k][j]
                     return
                 i += 1
 
@@ -860,7 +860,7 @@ class SELinuxGui():
                     if val is True or val is False or val is None:
                         continue
                     # Returns true if filter_txt exists within the val
-                    if(val.find(self.filter_txt) != -1 or val.lower().find(self.filter_txt) != -1):
+                    if val.find(self.filter_txt) != -1 or val.lower().find(self.filter_txt) != -1:
                         return True
                 except (AttributeError, TypeError):
                     pass
@@ -2174,7 +2174,7 @@ class SELinuxGui():
         model.set_value(iter, 0, not model.get_value(iter, 0))
         active = model.get_value(iter, 0)
         if name in self.cur_dict["boolean"]:
-            del(self.cur_dict["boolean"][name])
+            del self.cur_dict["boolean"][name]
         else:
             self.cur_dict["boolean"][name] = {"active": active}
         self.new_updates()
diff --git a/sandbox/sandbox b/sandbox/sandbox
index 770807345858..a2762a7d215a 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -111,7 +111,7 @@ def copyfile(file, srcdir, dest):
 
 def savefile(new, orig, X_ind):
     copy = False
-    if(X_ind):
+    if X_ind:
         import gi
         gi.require_version('Gtk', '3.0')
         from gi.repository import Gtk
@@ -131,9 +131,9 @@ def savefile(new, orig, X_ind):
         except NameError:
             pass
         ans = input(_("Do you want to save changes to '%s' (y/N): ") % orig)
-        if(re.match(_("[yY]"), ans)):
+        if re.match(_("[yY]"), ans):
             copy = True
-    if(copy):
+    if copy:
         shutil.copy2(new, orig)
 
 
-- 
2.38.1

