Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C63C4332F
	for <selinux@archiver.kernel.org>; Thu,  8 Dec 2022 19:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLHTqJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Dec 2022 14:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHTqI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Dec 2022 14:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14851AA0A
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670528654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eqbnxCtPt0wDWA9dSEUJ/RCmYWoEgKeHaUcvHoNYDEI=;
        b=T8tnBSAZdaeAMbYlXWtaI6v3i4YTyOBg6+vgqKpydnK3txjQHXMfpTdCSj5sg/9V14qJ3Z
        WuK9HMxTXnnuWR0ZjCH3aVjSlW6soZdiScQ57NhNKISiHxGWBVC3UZ/YbKW5nZYGBwO1Ym
        vfugJpBXjcW/xHS/mKJgQ0i6SkE+kl8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-QKFxf8sUNAS8S4lLn4ZdRg-1; Thu, 08 Dec 2022 14:43:42 -0500
X-MC-Unique: QKFxf8sUNAS8S4lLn4ZdRg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 654F829AB413
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 19:43:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-192-196.brq.redhat.com [10.40.192.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0CD6492CA2;
        Thu,  8 Dec 2022 19:43:41 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 1/2] sepolicy: Switch main selection menu to GtkPopover
Date:   Thu,  8 Dec 2022 20:43:34 +0100
Message-Id: <20221208194335.479739-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes: https://github.com/SELinuxProject/selinux/issues/206

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/sepolicy/sepolicy/gui.py         | 20 ++++----------------
 python/sepolicy/sepolicy/sepolicy.glade |  9 +--------
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index c8f33f522a2d..53f3c6148b58 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -135,9 +135,8 @@ class SELinuxGui():
         builder.add_from_file(glade_file)
         self.outer_notebook = builder.get_object("outer_notebook")
         self.window = builder.get_object("SELinux_window")
-        self.main_selection_window = builder.get_object("Main_selection_menu")
+        self.main_selection_popover = builder.get_object("Main_selection_menu")
         self.main_advanced_label = builder.get_object("main_advanced_label")
-        self.popup = 0
         self.applications_selection_button = builder.get_object("applications_selection_button")
         self.revert_button = builder.get_object("Revert_button")
         self.busy_cursor = Gdk.Cursor(Gdk.CursorType.WATCH)
@@ -531,7 +530,6 @@ class SELinuxGui():
         dic = {
             "on_combo_button_clicked": self.open_combo_menu,
             "on_disable_ptrace_toggled": self.on_disable_ptrace,
-            "on_SELinux_window_configure_event": self.hide_combo_menu,
             "on_entrycompletion_obj_match_selected": self.set_application_label,
             "on_filter_changed": self.get_filter_data,
             "on_save_changes_file_equiv_clicked": self.update_to_file_equiv,
@@ -808,18 +806,8 @@ class SELinuxGui():
         return self.help_show_page()
 
     def open_combo_menu(self, *args):
-        if self.popup == 0:
-            self.popup = 1
-            location = self.window.get_position()
-            self.main_selection_window.move(location[0] + 2, location[1] + 65)
-            self.main_selection_window.show()
-        else:
-            self.main_selection_window.hide()
-            self.popup = 0
-
-    def hide_combo_menu(self, *args):
-        self.main_selection_window.hide()
-        self.popup = 0
+        self.main_selection_popover.set_relative_to(self.applications_selection_button)
+        self.main_selection_popover.popup()
 
     def set_application_label(self, *args):
         self.set_application_label = True
@@ -2335,7 +2323,7 @@ class SELinuxGui():
             self.active_button = self.network_radio_button
 
     def clearbuttons(self, clear=True):
-        self.main_selection_window.hide()
+        self.main_selection_popover.hide()
         self.boolean_radio_button.set_visible(False)
         self.files_radio_button.set_visible(False)
         self.network_radio_button.set_visible(False)
diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
index 0724d6c8caa4..30e7b03f21c2 100644
--- a/python/sepolicy/sepolicy/sepolicy.glade
+++ b/python/sepolicy/sepolicy/sepolicy.glade
@@ -10,11 +10,8 @@
       <column type="gchararray"/>
     </columns>
   </object>
-  <object class="GtkWindow" id="Main_selection_menu">
+  <object class="GtkPopover" id="Main_selection_menu">
     <property name="can_focus">False</property>
-    <property name="default_width">265</property>
-    <property name="default_height">100</property>
-    <property name="decorated">False</property>
     <child>
       <object class="GtkBox" id="vbox2">
         <property name="visible">True</property>
@@ -53,7 +50,6 @@
                 <property name="primary_icon_stock">gtk-find</property>
                 <property name="primary_icon_activatable">False</property>
                 <property name="secondary_icon_activatable">False</property>
-                <signal name="activate" handler="on_SELinux_window_configure_event" swapped="no"/>
                 <signal name="changed" handler="on_completion_entry_changed" swapped="no"/>
               </object>
               <packing>
@@ -306,7 +302,6 @@
     </columns>
   </object>
   <object class="GtkEntryCompletion" id="entrycompletion_obj">
-    <signal name="match-selected" handler="on_SELinux_window_configure_event" swapped="no"/>
     <signal name="match-selected" handler="on_completion_entry_changed" swapped="no"/>
     <signal name="match-selected" handler="on_entrycompletion_obj_match_selected" swapped="no"/>
   </object>
@@ -1707,9 +1702,7 @@
     <property name="window_position">center-always</property>
     <property name="default_width">650</property>
     <property name="default_height">420</property>
-    <signal name="configure-event" handler="on_SELinux_window_configure_event" swapped="no"/>
     <signal name="delete-event" handler="on_confirmation_close" swapped="no"/>
-    <signal name="focus-in-event" handler="on_SELinux_window_configure_event" swapped="no"/>
     <child>
       <object class="GtkBox" id="vbox1">
         <property name="visible">True</property>
-- 
2.38.1

