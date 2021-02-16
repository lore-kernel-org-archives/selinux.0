Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC195C433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 20:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD1E64E08
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 20:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBPUKS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Feb 2021 15:10:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhBPUKR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Feb 2021 15:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613506131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sUsFs0hFgTOAAYwB3CMC+Dy0+qhTzce9A5e1uqQxn/Q=;
        b=dowGzLN7lwHOrfYOUF8wnBMl2/vshjGi8mw4ulo2/f5xIeWDJawM0zbox3O7Qmx6QTKpJP
        U0irVmJAuKihaZwz1rs9LHAuMltRt3kuewT/j6iFw11ixmybE7tUh7BuBXoM72osV2HSkv
        KOeTeG16sTCn0P/u1cVcaGefCF6moAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-Zq2c-trTMMefgklvYzz-1w-1; Tue, 16 Feb 2021 15:08:45 -0500
X-MC-Unique: Zq2c-trTMMefgklvYzz-1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1710D195D560
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 20:08:45 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.193.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84115722C6
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 20:08:44 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] gui: fix "file type" selection in fcontextPage
Date:   Tue, 16 Feb 2021 21:08:39 +0100
Message-Id: <20210216200839.1784987-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A change in seobject.py file_type_str_to_option made the "file type"
list not compatible with items in this ComboBox.
See: 317743bbe2a235a5c68f1066b4153e0726a3118f

Avoid this in the future by populating the ComboBox using keys from
file_type_str_to_option.

This change disables translations on the file types, but those cause
other issues (adding file context fails the same way as with 'socket
file' since the translated strings differ form
file_type_str_to_option.keys, 'properties' of a file context entry
shows no file type for the same reason).

Fixes:
 Traceback (most recent call last):
  File "/usr/share/system-config-selinux/system-config-selinux.py", line 136, in add
    self.tabs[self.notebook.get_current_page()].addDialog()
  File "/usr/share/system-config-selinux/semanagePage.py", line 143, in addDialog
    if self.add() is False:
  File "/usr/share/system-config-selinux/fcontextPage.py", line 195, in add
    (rc, out) = getstatusoutput("semanage fcontext -a -t %s -r %s -f '%s' '%s'" % (type, mls, seobject.file_type_str_to_option[ftype], fspec))
 KeyError: 'socket file'
---
 gui/fcontextPage.py          |  7 +++++++
 gui/system-config-selinux.ui | 26 --------------------------
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
index 370bbee4..d26aa1b4 100644
--- a/gui/fcontextPage.py
+++ b/gui/fcontextPage.py
@@ -102,6 +102,13 @@ class fcontextPage(semanagePage):
         self.load()
         self.fcontextEntry = xml.get_object("fcontextEntry")
         self.fcontextFileTypeCombo = xml.get_object("fcontextFileTypeCombo")
+        # Populate file type combo_box
+        liststore = self.fcontextFileTypeCombo.get_model()
+        for ftype in seobject.file_type_str_to_option.keys():
+            iter = liststore.append()
+            liststore.set_value(iter, 0, ftype)
+        iter = liststore.get_iter_first()
+        self.fcontextFileTypeCombo.set_active_iter(iter)
         self.fcontextTypeEntry = xml.get_object("fcontextTypeEntry")
         self.fcontextMLSEntry = xml.get_object("fcontextMLSEntry")
 
diff --git a/gui/system-config-selinux.ui b/gui/system-config-selinux.ui
index 7cc1cc53..e7b84a64 100644
--- a/gui/system-config-selinux.ui
+++ b/gui/system-config-selinux.ui
@@ -401,32 +401,6 @@ Level</property>
       <!-- column-name gchararray -->
       <column type="gchararray"/>
     </columns>
-    <data>
-      <row>
-        <col id="0" translatable="yes">all files</col>
-      </row>
-      <row>
-        <col id="0" translatable="yes">regular file</col>
-      </row>
-      <row>
-        <col id="0" translatable="yes">directory</col>
-      </row>
-      <row>
-        <col id="0" translatable="yes">character device</col>
-      </row>
-      <row>
-        <col id="0" translatable="yes">block device</col>
-      </row>
-      <row>
-        <col id="0" translatable="yes">socket file</col>
-      </row>
-      <row>
-        <col id="0" translatable="yes">symbolic link</col>
-      </row>
-      <row>
-        <col id="0" translatable="yes">named pipe</col>
-      </row>
-    </data>
   </object>
   <object class="GtkDialog" id="fcontextDialog">
     <property name="can_focus">False</property>
-- 
2.29.2

