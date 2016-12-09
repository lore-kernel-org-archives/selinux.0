Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB9FAB5f018935
 for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2016 10:10:12 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C057491D36
 for <selinux@tycho.nsa.gov>; Fri,  9 Dec 2016 15:10:07 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] python/sepolicy/sepolicy: Cleanup of gui code
Date: Fri,  9 Dec 2016 16:09:59 +0100
Message-Id: <1481296200-28904-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Based on 77589dd354218f1f56d1c83747799606fa1b4899 by Dan Walsh.
Speed up gui loading.
Some minor bug fixes.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolicy/sepolicy/gui.py         | 134 ++++++++++----------------------
 python/sepolicy/sepolicy/network.py     |   8 +-
 python/sepolicy/sepolicy/sepolicy.glade |  72 ++---------------
 3 files changed, 53 insertions(+), 161 deletions(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 62104e1..115e18b 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -112,6 +112,7 @@ class SELinuxGui():
 
     def __init__(self, app=None, test=False):
         self.finish_init = False
+        self.advanced_init = True
         self.opage = START_PAGE
         self.dbus = SELinuxDBus()
         try:
@@ -120,12 +121,6 @@ class SELinuxGui():
             print(e)
             self.quit()
 
-        sepolicy_domains = sepolicy.get_all_domains()
-        sepolicy_domains.sort(compare)
-        if app and app not in sepolicy_domains:
-            self.error(_("%s is not a valid domain" % app))
-            self.quit()
-
         self.init_cur()
         self.application = app
         self.filter_txt = ""
@@ -149,7 +144,7 @@ class SELinuxGui():
         self.files_add = False
         self.network_add = False
 
-        self.all_list = []
+        self.all_domains = []
         self.installed_list = []
         self.previously_modified = {}
 
@@ -161,10 +156,10 @@ class SELinuxGui():
         self.invalid_entry = False
         # Advanced search window ****************************
         self.advanced_search_window = builder.get_object("advanced_search_window")
-        self.advanced_search_liststore = builder.get_object("Advanced_search_liststore")
-        self.advanced_search_liststore.set_sort_column_id(0, Gtk.SortType.ASCENDING)
         self.advanced_search_filter = builder.get_object("advanced_filter")
         self.advanced_search_filter.set_visible_func(self.filter_the_data)
+        self.advanced_search_sort = builder.get_object("advanced_sort")
+
         self.advanced_filter_entry = builder.get_object("advanced_filter_entry")
         self.advanced_search_treeview = builder.get_object("advanced_search_treeview")
         self.advanced_search = False
@@ -433,12 +428,10 @@ class SELinuxGui():
 
         # Combobox and Entry items **************************
         self.combobox_menu = builder.get_object("combobox_org")                    # This is the combobox box object, aka the arrow next to the entry text bar
-        self.combobox_menu_model = builder.get_object("application_liststore")
+        self.application_liststore = builder.get_object("application_liststore")
         self.completion_entry = builder.get_object("completion_entry")  # self.combobox_menu.get_child()
-        self.completion_entry_model = builder.get_object("application_liststore")
         self.entrycompletion_obj = builder.get_object("entrycompletion_obj")
         #self.entrycompletion_obj = Gtk.EntryCompletion()
-        self.entrycompletion_obj.set_model(self.completion_entry_model)
         self.entrycompletion_obj.set_minimum_key_length(0)
         self.entrycompletion_obj.set_text_column(0)
         self.entrycompletion_obj.set_match_func(self.match_func, None)
@@ -493,20 +486,24 @@ class SELinuxGui():
         self.loading = 1
         path = None
         if test:
-            domains = ["httpd_t", "abrt_t"]
-            if app and app not in domains:
-                domains.append(app)
+            self.all_domains = ["httpd_t", "abrt_t"]
+            if app and app not in self.all_domains:
+                self.all_domains.append(app)
         else:
-            domains = sepolicy_domains
-            loading_gui.show()
-        length = len(domains)
-        for domain in domains:
+            self.all_domains = sepolicy.get_all_domains()
+        self.all_domains.sort(key=str.lower)
+
+        if app and app not in self.all_domains:
+            self.error(_("%s is not a valid domain" % app))
+            self.quit()
+
+        loading_gui.show()
+        length = len(self.all_domains)
+        for domain in self.all_domains:
             # After the user selects a path in the drop down menu call
             # get_init_entrypoint_target(entrypoint) to get the transtype
             # which will give you the application
-            self.combo_box_initialize(domain, None)
-            self.advanced_search_initialize(domain)
-            self.all_list.append(domain)
+            self.combo_box_add(domain, domain)
             self.percentage = float(float(self.loading) / float(length))
             self.progress_bar.set_fraction(self.percentage)
             self.progress_bar.set_pulse_step(self.percentage)
@@ -516,14 +513,13 @@ class SELinuxGui():
             for entrypoint in entrypoints:
                 path = sepolicy.find_entrypoint_path(entrypoint)
                 if path:
-                    self.combo_box_initialize(path, None)
-                    # Adds all files entrypoint paths that exists on disc
-                    # into the combobox
-                    self.advanced_search_initialize(path)
+                    self.combo_box_add(path, domain)
                     self.installed_list.append(path)
 
             self.loading += 1
         loading_gui.hide()
+        self.entrycompletion_obj.set_model(self.application_liststore)
+        self.advanced_search_treeview.set_model(self.advanced_search_sort)
 
         dic = {
             "on_combo_button_clicked": self.open_combo_menu,
@@ -555,7 +551,7 @@ class SELinuxGui():
             "on_file_equiv_button_clicked": self.show_file_equiv_page,
             "on_app/system_button_clicked": self.system_interface,
             "on_app/users_button_clicked": self.users_interface,
-            "on_main_advanced_label_button_press_event": self.advanced_label_main,
+            "on_show_advanced_search_window": self.on_show_advanced_search_window,
 
             "on_Show_mislabeled_files_toggled": self.show_mislabeled_files,
             "on_Browse_button_files_clicked": self.browse_for_files,
@@ -571,8 +567,6 @@ class SELinuxGui():
             "on_advanced_filter_entry_changed": self.get_advanced_filter_data,
             "on_advanced_search_treeview_row_activated": self.advanced_item_selected,
             "on_Select_advanced_search_clicked": self.advanced_item_button_push,
-            "on_All_advanced_button_toggled": self.advanced_radio_select,
-            "on_Installed_advanced_button_toggled": self.advanced_radio_select,
             "on_info_button_button_press_event": self.on_help_button,
             "on_back_button_clicked": self.on_help_back_clicked,
             "on_forward_button_clicked": self.on_help_forward_clicked,
@@ -713,7 +707,7 @@ class SELinuxGui():
 
     def match_func(self, completion, key_string, iter, func_data):
         try:
-            if self.combobox_menu_model.get_value(iter, 0).find(key_string) != -1:
+            if self.application_liststore.get_value(iter, 0).find(key_string) != -1:
                 return True
             return False
         except AttributeError:
@@ -924,11 +918,11 @@ class SELinuxGui():
         self.ready_mouse()
 
     def network_initialize(self, app):
-        netd = sepolicy.network.get_network_connect(app, "tcp", "name_connect")
+        netd = sepolicy.network.get_network_connect(app, "tcp", "name_connect", check_bools=True)
         self.net_update(app, netd, "tcp", OUTBOUND_PAGE, self.network_out_liststore)
-        netd = sepolicy.network.get_network_connect(app, "tcp", "name_bind")
+        netd = sepolicy.network.get_network_connect(app, "tcp", "name_bind", check_bools=True)
         self.net_update(app, netd, "tcp", INBOUND_PAGE, self.network_in_liststore)
-        netd = sepolicy.network.get_network_connect(app, "udp", "name_bind")
+        netd = sepolicy.network.get_network_connect(app, "udp", "name_bind", check_bools=True)
         self.net_update(app, netd, "udp", INBOUND_PAGE, self.network_in_liststore)
 
     def network_initial_data_insert(self, model, ports, portType, protocol):
@@ -964,12 +958,12 @@ class SELinuxGui():
         iter = liststore.get_iter(index)
         return liststore.get_value(iter, 0)
 
-    def combo_box_initialize(self, val, desc):
+    def combo_box_add(self, val, val1):
         if val is None:
             return
-        iter = self.combobox_menu_model.append()
-        for f in val:
-            self.combobox_menu_model.set_value(iter, 0, val)
+        iter = self.application_liststore.append()
+        self.application_liststore.set_value(iter, 0, val)
+        self.application_liststore.set_value(iter, 1, val1)
 
     def select_type_more(self, *args):
         app = self.moreTypes_treeview.get_selection()
@@ -985,19 +979,18 @@ class SELinuxGui():
         model, iter = row.get_selected()
         iter = model.convert_iter_to_child_iter(iter)
         iter = self.advanced_search_filter.convert_iter_to_child_iter(iter)
-        app = self.advanced_search_liststore.get_value(iter, 1)
+        app = self.application_liststore.get_value(iter, 1)
         if app is None:
             return
         self.advanced_filter_entry.set_text('')
         self.advanced_search_window.hide()
         self.reveal_advanced(self.main_advanced_label)
         self.completion_entry.set_text(app)
-        self.application_selected()
 
     def advanced_item_selected(self, treeview, path, *args):
         iter = self.advanced_search_filter.get_iter(path)
         iter = self.advanced_search_filter.convert_iter_to_child_iter(iter)
-        app = self.advanced_search_liststore.get_value(iter, 1)
+        app = self.application_liststore.get_value(iter, 1)
         self.advanced_filter_entry.set_text('')
         self.advanced_search_window.hide()
         self.reveal_advanced(self.main_advanced_label)
@@ -1006,7 +999,7 @@ class SELinuxGui():
 
     def find_application(self, app):
         if app and len(app) > 0:
-            for items in self.combobox_menu_model:
+            for items in self.application_liststore:
                 if app == items[0]:
                     return True
         return False
@@ -1637,7 +1630,7 @@ class SELinuxGui():
         self.files_type_combolist.clear()
         self.files_class_combolist.clear()
         compare = self.strip_domain(self.application)
-        for d in self.completion_entry_model:
+        for d in self.application_liststore:
             if d[0].startswith(compare) and d[0] != self.application and not d[0].startswith("httpd_sys"):
                 exclude_list.append(self.strip_domain(d[0]))
 
@@ -1716,10 +1709,10 @@ class SELinuxGui():
 
         try:
             if ipage == OUTBOUND_PAGE:
-                netd = sepolicy.network.get_network_connect(self.application, "tcp", "name_connect")
+                netd = sepolicy.network.get_network_connect(self.application, "tcp", "name_connect", check_bools=True)
             elif ipage == INBOUND_PAGE:
-                netd = sepolicy.network.get_network_connect(self.application, "tcp", "name_bind")
-                netd += sepolicy.network.get_network_connect(self.application, "udp", "name_bind")
+                netd = sepolicy.network.get_network_connect(self.application, "tcp", "name_bind", check_bools=True)
+                netd += sepolicy.network.get_network_connect(self.application, "udp", "name_bind", check_bools=True)
 
             port_types = []
             for k in netd.keys():
@@ -2552,34 +2545,7 @@ class SELinuxGui():
         self.network_mls_label.set_visible(advanced)
         self.network_mls_entry.set_visible(advanced)
 
-    def advanced_search_initialize(self, path):
-        try:
-            if path[0] == '/':
-                domain = sepolicy.get_init_transtype(path)
-            else:
-                domain = path
-        except IndexError:
-            return
-        except OSError:
-            return
-        iter = self.advanced_search_liststore.append()
-        self.advanced_search_liststore.set_value(iter, 0, path)
-        self.advanced_search_liststore.set_value(iter, 1, domain)
-        user_types = sepolicy.get_user_types()
-        if domain in user_types + ['initrc_t']:
-            return
-
-        entrypoints = sepolicy.get_entrypoints(domain)
-        # From entry_point = 0 to the number of keys in the dic
-        for exe in entrypoints:
-            if len(entrypoints[exe]):
-                file_class = entrypoints[exe][1]
-                for path in entrypoints[exe][0]:
-                    iter = self.advanced_search_liststore.append()
-                    self.advanced_search_liststore.set_value(iter, 1, domain)
-                    self.advanced_search_liststore.set_value(iter, 0, path)
-
-    def advanced_label_main(self, label, *args):
+    def on_show_advanced_search_window(self, label, *args):
         if label.get_text() == ADVANCED_SEARCH_LABEL[1]:
             label.set_text(ADVANCED_SEARCH_LABEL[0])
             self.close_popup()
@@ -2587,25 +2553,6 @@ class SELinuxGui():
             label.set_text(ADVANCED_SEARCH_LABEL[1])
             self.show_popup(self.advanced_search_window)
 
-    def advanced_radio_select(self, button):
-        label = ""
-        if button.get_active():
-            label = button.get_label()
-        if label == '':
-            return
-        self.advanced_search_liststore.clear()
-        if label == "All":
-            for items in self.all_list:
-                self.advanced_search_initialize(items)
-                self.idle_func()
-
-        elif label == "Installed":
-            if self.installed_list == []:
-                return
-            for items in self.installed_list:
-                self.advanced_search_initialize(items)
-                self.idle_func()
-
     def set_enforce_text(self, value):
         if value:
             self.status_bar.push(self.context_id, _("System Status: Enforcing"))
@@ -2615,6 +2562,9 @@ class SELinuxGui():
             self.current_status_permissive.set_active(True)
 
     def set_enforce(self, button):
+        if not self.finish_init:
+            return
+
         self.dbus.setenforce(button.get_active())
         self.set_enforce_text(button.get_active())
 
diff --git a/python/sepolicy/sepolicy/network.py b/python/sepolicy/sepolicy/network.py
index c4d95da..115f6b8 100755
--- a/python/sepolicy/sepolicy/network.py
+++ b/python/sepolicy/sepolicy/network.py
@@ -23,20 +23,20 @@
 import sepolicy
 
 
-def get_types(src, tclass, perm):
+def get_types(src, tclass, perm, check_bools=False):
     allows = sepolicy.search([sepolicy.ALLOW], {sepolicy.SOURCE: src, sepolicy.CLASS: tclass, sepolicy.PERMS: perm})
     nlist = []
     if allows:
-        for i in map(lambda y: y[sepolicy.TARGET], filter(lambda x: set(perm).issubset(x[sepolicy.PERMS]), allows)):
+        for i in map(lambda y: y[sepolicy.TARGET], filter(lambda x: set(perm).issubset(x[sepolicy.PERMS]) and (not check_bools or x["enabled"]), allows)):
             if i not in nlist:
                 nlist.append(i)
     return nlist
 
 
-def get_network_connect(src, protocol, perm):
+def get_network_connect(src, protocol, perm, check_bools=False):
     portrecs, portrecsbynum = sepolicy.gen_port_dict()
     d = {}
-    tlist = get_types(src, "%s_socket" % protocol, [perm])
+    tlist = get_types(src, "%s_socket" % protocol, [perm], check_bools)
     if len(tlist) > 0:
         d[(src, protocol, perm)] = []
         for i in tlist:
diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
index 00905e0..e7d96f9 100644
--- a/python/sepolicy/sepolicy/sepolicy.glade
+++ b/python/sepolicy/sepolicy/sepolicy.glade
@@ -2,7 +2,7 @@
 <!-- Generated with glade 3.16.0 on Fri Oct 11 08:24:19 2013 -->
 <interface>
   <!-- interface-requires gtk+ 3.8 -->
-  <object class="GtkListStore" id="Advanced_search_liststore">
+  <object class="GtkListStore" id="application_liststore">
     <columns>
       <!-- column-name Application -->
       <column type="gchararray"/>
@@ -82,7 +82,7 @@
             <attributes>
               <attribute name="foreground" value="#00004e4e9999"/>
             </attributes>
-            <signal name="button-press-event" handler="on_main_advanced_label_button_press_event" swapped="no"/>
+            <signal name="button-press-event" handler="on_show_advanced_search_window" swapped="no"/>
           </object>
           <packing>
             <property name="expand">True</property>
@@ -225,7 +225,7 @@
     </child>
   </object>
   <object class="GtkTreeModelFilter" id="advanced_filter">
-    <property name="child_model">Advanced_search_liststore</property>
+    <property name="child_model">application_liststore</property>
   </object>
   <object class="GtkTreeModelSort" id="advanced_sort">
     <property name="model">advanced_filter</property>
@@ -256,24 +256,6 @@
   <object class="GtkTreeModelSort" id="application_files_sort">
     <property name="model">application_files_filter</property>
   </object>
-  <object class="GtkListStore" id="application_liststore">
-    <columns>
-      <!-- column-name Application -->
-      <column type="gchararray"/>
-    </columns>
-  </object>
-  <object class="GtkTreeModelFilter" id="application_filter">
-    <property name="child_model">application_liststore</property>
-  </object>
-  <object class="GtkTreeModelSort" id="application_sort">
-    <property name="model">application_filter</property>
-  </object>
-  <object class="GtkListStore" id="application_tree_list">
-    <columns>
-      <!-- column-name Process -->
-      <column type="gchararray"/>
-    </columns>
-  </object>
   <object class="GtkListStore" id="boolean_liststore">
     <columns>
       <!-- column-name Active -->
@@ -473,7 +455,7 @@
             <property name="can_focus">False</property>
             <property name="xalign">0</property>
             <property name="xpad">10</property>
-            <property name="label" translatable="yes">Add file Equivilence Mapping.  Mapping will be created when Update is applied.</property>
+            <property name="label" translatable="yes">Add file Equivalence Mapping.  Mapping will be created when Update is applied.</property>
             <property name="justify">fill</property>
             <property name="wrap">True</property>
           </object>
@@ -823,7 +805,7 @@
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
-                        <property name="tooltip_text" translatable="yes">Select Make Path Recursive iff you want to apply this label to all children of the specified directory path. objects under the directory to have this label.</property>
+                        <property name="tooltip_text" translatable="yes">Select Make Path Recursive if you want to apply this label to all children of the specified directory path. objects under the directory to have this label.</property>
                         <property name="xalign">0.5</property>
                         <property name="draw_indicator">True</property>
                         <signal name="toggled" handler="on_make_path_recursive_toggled" swapped="no"/>
@@ -2948,7 +2930,7 @@ Enabled</property>
                                     <property name="tooltip_text" translatable="yes">Executables which will transition to a different domain, when the 'selected domain' executes them.</property>
                                     <property name="xpad">1</property>
                                     <property name="ypad">1</property>
-                                    <property name="label" translatable="yes">Applicaton Transitions From 'select domain'</property>
+                                    <property name="label" translatable="yes">Application Transitions From 'select domain'</property>
                                   </object>
                                   <packing>
                                     <property name="position">1</property>
@@ -4328,46 +4310,7 @@ allow alternative access control.</property>
                 <property name="position">0</property>
               </packing>
             </child>
-            <child>
-              <object class="GtkRadioButton" id="All_advanced_button">
-                <property name="label" translatable="yes">All</property>
-                <property name="visible">True</property>
-                <property name="can_focus">True</property>
-                <property name="receives_default">False</property>
-                <property name="xalign">0.5</property>
-                <property name="active">True</property>
-                <property name="draw_indicator">True</property>
-                <signal name="toggled" handler="on_All_advanced_button_toggled" swapped="no"/>
-              </object>
-              <packing>
-                <property name="expand">True</property>
-                <property name="fill">True</property>
-                <property name="position">1</property>
-              </packing>
-            </child>
-            <child>
-              <object class="GtkRadioButton" id="Installed_advanced_button">
-                <property name="label" translatable="yes">Installed</property>
-                <property name="visible">True</property>
-                <property name="can_focus">True</property>
-                <property name="receives_default">False</property>
-                <property name="xalign">0.5</property>
-                <property name="draw_indicator">True</property>
-                <property name="group">All_advanced_button</property>
-                <signal name="toggled" handler="on_Installed_advanced_button_toggled" swapped="no"/>
-              </object>
-              <packing>
-                <property name="expand">True</property>
-                <property name="fill">True</property>
-                <property name="position">2</property>
-              </packing>
-            </child>
           </object>
-          <packing>
-            <property name="expand">False</property>
-            <property name="fill">True</property>
-            <property name="position">0</property>
-          </packing>
         </child>
         <child>
           <object class="GtkScrolledWindow" id="scrolledwindow11">
@@ -4377,7 +4320,6 @@ allow alternative access control.</property>
               <object class="GtkTreeView" id="advanced_search_treeview">
                 <property name="visible">True</property>
                 <property name="can_focus">True</property>
-                <property name="model">advanced_sort</property>
                 <property name="enable_search">False</property>
                 <signal name="row-activated" handler="on_advanced_search_treeview_row_activated" swapped="no"/>
                 <child internal-child="selection">
@@ -4788,7 +4730,7 @@ allow alternative access control.</property>
             <property name="can_focus">False</property>
             <property name="xalign">0</property>
             <property name="xpad">10</property>
-            <property name="label" translatable="yes">Select file equivalence labeling to delete.File equivalence labeling will be deleted when update is applied.</property>
+            <property name="label" translatable="yes">Select file equivalence labeling to delete. File equivalence labeling will be deleted when update is applied.</property>
             <property name="justify">fill</property>
             <property name="wrap">True</property>
           </object>
-- 
2.7.4
