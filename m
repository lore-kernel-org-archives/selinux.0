Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1E9rqYA011953
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 04:54:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7C544040856
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:48 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 14 Feb 2018 10:53:35 +0100
Message-Id: <20180214095337.1945-3-plautrba@redhat.com>
In-Reply-To: <20180214095337.1945-1-plautrba@redhat.com>
References: <20180214095337.1945-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 2/4] gui/polgengui.py: Convert polgen.glade to
 Builder format polgen.ui
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- $ gtk-builder-convert polgen.glade polgen.ui
- use get_object instead of get_widget
- use connect_signals instead of signal_connect

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 gui/Makefile                    |   2 +-
 gui/{polgen.glade => polgen.ui} | 967 +++++++++++++++++++---------------------
 gui/polgengui.py                | 201 +++++----
 3 files changed, 561 insertions(+), 609 deletions(-)
 rename gui/{polgen.glade => polgen.ui} (81%)

diff --git a/gui/Makefile b/gui/Makefile
index cfe47405..ff0fd001 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -12,7 +12,7 @@ fcontextPage.py \
 html_util.py \
 loginsPage.py \
 modulesPage.py \
-polgen.glade \
+polgen.ui \
 portsPage.py \
 semanagePage.py \
 statusPage.py \
diff --git a/gui/polgen.glade b/gui/polgen.ui
similarity index 81%
rename from gui/polgen.glade
rename to gui/polgen.ui
index 37c14723..aa4c70af 100644
--- a/gui/polgen.glade
+++ b/gui/polgen.ui
@@ -1,8 +1,8 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<glade-interface>
+<?xml version="1.0"?>
+<interface>
   <!-- interface-requires gtk+ 2.6 -->
   <!-- interface-naming-policy toplevel-contextual -->
-  <widget class="GtkAboutDialog" id="about_dialog">
+  <object class="GtkAboutDialog" id="about_dialog">
     <property name="can_focus">False</property>
     <property name="border_width">5</property>
     <property name="type_hint">normal</property>
@@ -10,14 +10,14 @@
     <property name="website">www.redhat.com</property>
     <property name="license" translatable="yes">GPL</property>
     <property name="authors">Daniel Walsh &lt;dwalsh@redhat.com&gt;</property>
-    <property name="translator_credits" translatable="yes" comments="TRANSLATORS: Replace this string with your names, one name per line.">translator-credits</property>
+    <property comments="TRANSLATORS: Replace this string with your names, one name per line." name="translator_credits" translatable="yes">translator-credits</property>
     <child internal-child="vbox">
-      <widget class="GtkVBox" id="dialog-vbox3">
+      <object class="GtkVBox" id="dialog-vbox3">
         <property name="can_focus">False</property>
         <child internal-child="action_area">
-          <widget class="GtkHButtonBox" id="dialog-action_area3">
+          <object class="GtkHButtonBox" id="dialog-action_area3">
             <property name="can_focus">False</property>
-          </widget>
+          </object>
           <packing>
             <property name="expand">False</property>
             <property name="fill">True</property>
@@ -25,10 +25,10 @@
             <property name="position">0</property>
           </packing>
         </child>
-      </widget>
+      </object>
     </child>
-  </widget>
-  <widget class="GtkDialog" id="boolean_dialog">
+  </object>
+  <object class="GtkDialog" id="boolean_dialog">
     <property name="can_focus">False</property>
     <property name="border_width">12</property>
     <property name="title" translatable="yes">Add Booleans Dialog</property>
@@ -36,25 +36,24 @@
     <property name="default_width">400</property>
     <property name="type_hint">dialog</property>
     <child internal-child="vbox">
-      <widget class="GtkVBox" id="dialog-vbox2">
+      <object class="GtkVBox" id="dialog-vbox2">
         <property name="visible">True</property>
         <property name="can_focus">False</property>
         <property name="spacing">6</property>
         <child internal-child="action_area">
-          <widget class="GtkHButtonBox" id="dialog-action_area2">
+          <object class="GtkHButtonBox" id="dialog-action_area2">
             <property name="visible">True</property>
             <property name="can_focus">False</property>
             <property name="layout_style">end</property>
             <child>
-              <widget class="GtkButton" id="cancelbutton1">
+              <object class="GtkButton" id="cancelbutton1">
                 <property name="label">gtk-cancel</property>
-                <property name="response_id">-6</property>
                 <property name="visible">True</property>
                 <property name="can_focus">True</property>
                 <property name="can_default">True</property>
                 <property name="receives_default">False</property>
                 <property name="use_stock">True</property>
-              </widget>
+              </object>
               <packing>
                 <property name="expand">False</property>
                 <property name="fill">False</property>
@@ -62,22 +61,21 @@
               </packing>
             </child>
             <child>
-              <widget class="GtkButton" id="okbutton1">
+              <object class="GtkButton" id="okbutton1">
                 <property name="label">gtk-add</property>
-                <property name="response_id">-5</property>
                 <property name="visible">True</property>
                 <property name="can_focus">True</property>
                 <property name="can_default">True</property>
                 <property name="receives_default">False</property>
                 <property name="use_stock">True</property>
-              </widget>
+              </object>
               <packing>
                 <property name="expand">False</property>
                 <property name="fill">False</property>
                 <property name="position">1</property>
               </packing>
             </child>
-          </widget>
+          </object>
           <packing>
             <property name="expand">False</property>
             <property name="fill">True</property>
@@ -86,7 +84,7 @@
           </packing>
         </child>
         <child>
-          <widget class="GtkTable" id="table6">
+          <object class="GtkTable" id="table6">
             <property name="visible">True</property>
             <property name="can_focus">False</property>
             <property name="n_rows">2</property>
@@ -94,24 +92,24 @@
             <property name="column_spacing">12</property>
             <property name="row_spacing">6</property>
             <child>
-              <widget class="GtkLabel" id="label48">
+              <object class="GtkLabel" id="label48">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="xalign">0</property>
                 <property name="label" translatable="yes">Boolean Name</property>
-              </widget>
+              </object>
               <packing>
                 <property name="x_options">GTK_FILL</property>
                 <property name="y_options"/>
               </packing>
             </child>
             <child>
-              <widget class="GtkLabel" id="label49">
+              <object class="GtkLabel" id="label49">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="xalign">0</property>
                 <property name="label" translatable="yes">Description</property>
-              </widget>
+              </object>
               <packing>
                 <property name="top_attach">1</property>
                 <property name="bottom_attach">2</property>
@@ -120,15 +118,15 @@
               </packing>
             </child>
             <child>
-              <widget class="GtkEntry" id="boolean_name_entry">
+              <object class="GtkEntry" id="boolean_name_entry">
                 <property name="visible">True</property>
                 <property name="can_focus">True</property>
-                <property name="invisible_char">•</property>
+                <property name="invisible_char">&#x2022;</property>
                 <property name="primary_icon_activatable">False</property>
                 <property name="secondary_icon_activatable">False</property>
                 <property name="primary_icon_sensitive">True</property>
                 <property name="secondary_icon_sensitive">True</property>
-              </widget>
+              </object>
               <packing>
                 <property name="left_attach">1</property>
                 <property name="right_attach">2</property>
@@ -136,15 +134,15 @@
               </packing>
             </child>
             <child>
-              <widget class="GtkEntry" id="boolean_description_entry">
+              <object class="GtkEntry" id="boolean_description_entry">
                 <property name="visible">True</property>
                 <property name="can_focus">True</property>
-                <property name="invisible_char">•</property>
+                <property name="invisible_char">&#x2022;</property>
                 <property name="primary_icon_activatable">False</property>
                 <property name="secondary_icon_activatable">False</property>
                 <property name="primary_icon_sensitive">True</property>
                 <property name="secondary_icon_sensitive">True</property>
-              </widget>
+              </object>
               <packing>
                 <property name="left_attach">1</property>
                 <property name="right_attach">2</property>
@@ -153,17 +151,21 @@
                 <property name="y_options"/>
               </packing>
             </child>
-          </widget>
+          </object>
           <packing>
             <property name="expand">True</property>
             <property name="fill">True</property>
             <property name="position">1</property>
           </packing>
         </child>
-      </widget>
+      </object>
     </child>
-  </widget>
-  <widget class="GtkFileChooserDialog" id="filechooserdialog">
+    <action-widgets>
+      <action-widget response="-6">cancelbutton1</action-widget>
+      <action-widget response="-5">okbutton1</action-widget>
+    </action-widgets>
+  </object>
+  <object class="GtkFileChooserDialog" id="filechooserdialog">
     <property name="can_focus">False</property>
     <property name="border_width">5</property>
     <property name="window_position">mouse</property>
@@ -171,25 +173,24 @@
     <property name="select_multiple">True</property>
     <property name="show_hidden">True</property>
     <child internal-child="vbox">
-      <widget class="GtkVBox" id="dialog-vbox1">
+      <object class="GtkVBox" id="dialog-vbox1">
         <property name="visible">True</property>
         <property name="can_focus">False</property>
         <property name="spacing">24</property>
         <child internal-child="action_area">
-          <widget class="GtkHButtonBox" id="dialog-action_area1">
+          <object class="GtkHButtonBox" id="dialog-action_area1">
             <property name="visible">True</property>
             <property name="can_focus">False</property>
             <property name="layout_style">end</property>
             <child>
-              <widget class="GtkButton" id="button5">
+              <object class="GtkButton" id="button5">
                 <property name="label">gtk-cancel</property>
-                <property name="response_id">-6</property>
                 <property name="visible">True</property>
                 <property name="can_focus">True</property>
                 <property name="can_default">True</property>
                 <property name="receives_default">False</property>
                 <property name="use_stock">True</property>
-              </widget>
+              </object>
               <packing>
                 <property name="expand">False</property>
                 <property name="fill">False</property>
@@ -197,23 +198,22 @@
               </packing>
             </child>
             <child>
-              <widget class="GtkButton" id="button6">
+              <object class="GtkButton" id="button6">
                 <property name="label">gtk-add</property>
-                <property name="response_id">-5</property>
                 <property name="visible">True</property>
                 <property name="can_focus">True</property>
                 <property name="can_default">True</property>
                 <property name="has_default">True</property>
                 <property name="receives_default">False</property>
                 <property name="use_stock">True</property>
-              </widget>
+              </object>
               <packing>
                 <property name="expand">False</property>
                 <property name="fill">False</property>
                 <property name="position">1</property>
               </packing>
             </child>
-          </widget>
+          </object>
           <packing>
             <property name="expand">False</property>
             <property name="fill">True</property>
@@ -221,36 +221,40 @@
             <property name="position">0</property>
           </packing>
         </child>
-      </widget>
+      </object>
     </child>
-  </widget>
-  <widget class="GtkWindow" id="main_window">
+    <action-widgets>
+      <action-widget response="-6">button5</action-widget>
+      <action-widget response="-5">button6</action-widget>
+    </action-widgets>
+  </object>
+  <object class="GtkWindow" id="main_window">
     <property name="visible">True</property>
     <property name="can_focus">False</property>
     <property name="title" translatable="yes">SELinux Policy Generation Tool</property>
     <child>
-      <widget class="GtkVBox" id="vbox11">
+      <object class="GtkVBox" id="vbox11">
         <property name="visible">True</property>
         <property name="can_focus">False</property>
         <property name="spacing">18</property>
         <child>
-          <widget class="GtkNotebook" id="notebook">
+          <object class="GtkNotebook" id="notebook">
             <property name="visible">True</property>
             <property name="can_focus">False</property>
             <property name="tab_pos">left</property>
             <property name="show_tabs">False</property>
             <child>
-              <widget class="GtkVBox" id="vbox59">
+              <object class="GtkVBox" id="vbox59">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_type_label">
+                  <object class="GtkLabel" id="select_type_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Select the policy type for the application or user role you want to confine:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -259,31 +263,31 @@
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkVBox" id="vbox58">
+                  <object class="GtkVBox" id="vbox58">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <child>
-                      <widget class="GtkVBox" id="vbox14">
+                      <object class="GtkVBox" id="vbox14">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <child>
-                          <widget class="GtkHBox" id="hbox16">
+                          <object class="GtkHBox" id="hbox16">
                             <property name="visible">True</property>
                             <property name="can_focus">False</property>
                             <property name="spacing">12</property>
                             <child>
-                              <widget class="GtkVBox" id="vbox18">
+                              <object class="GtkVBox" id="vbox18">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="spacing">6</property>
                                 <child>
-                                  <widget class="GtkLabel" id="label41">
+                                  <object class="GtkLabel" id="label41">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <property name="xalign">0</property>
                                     <property name="label" translatable="yes">&lt;b&gt;Applications&lt;/b&gt;</property>
                                     <property name="use_markup">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -291,15 +295,15 @@
                                   </packing>
                                 </child>
                                 <child>
-                                  <widget class="GtkHBox" id="hbox17">
+                                  <object class="GtkHBox" id="hbox17">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <child>
-                                      <widget class="GtkLabel" id="label52">
+                                      <object class="GtkLabel" id="label52">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="label">    </property>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
@@ -307,20 +311,20 @@
                                       </packing>
                                     </child>
                                     <child>
-                                      <widget class="GtkVBox" id="vbox6">
+                                      <object class="GtkVBox" id="vbox6">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="spacing">6</property>
                                         <child>
-                                          <widget class="GtkRadioButton" id="init_radiobutton">
+                                          <object class="GtkRadioButton" id="init_radiobutton">
                                             <property name="label" translatable="yes">Standard Init Daemon</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">Standard Init Daemon are daemons started on boot via init scripts.  Usually requires a script in /etc/rc.d/init.d</property>
+                                            <property name="tooltip-text" translatable="yes">Standard Init Daemon are daemons started on boot via init scripts.  Usually requires a script in /etc/rc.d/init.d</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
@@ -328,16 +332,16 @@
                                           </packing>
                                         </child>
                                         <child>
-                                          <widget class="GtkRadioButton" id="dbus_radiobutton">
+                                          <object class="GtkRadioButton" id="dbus_radiobutton">
                                             <property name="label" translatable="yes">DBUS System Daemon</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">Standard Init Daemon are daemons started on boot via init scripts.  Usually requires a script in /etc/rc.d/init.d</property>
+                                            <property name="tooltip-text" translatable="yes">Standard Init Daemon are daemons started on boot via init scripts.  Usually requires a script in /etc/rc.d/init.d</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
@@ -345,16 +349,16 @@
                                           </packing>
                                         </child>
                                         <child>
-                                          <widget class="GtkRadioButton" id="inetd_radiobutton">
+                                          <object class="GtkRadioButton" id="inetd_radiobutton">
                                             <property name="label" translatable="yes">Internet Services Daemon (inetd)</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">Internet Services Daemon are daemons started by xinetd</property>
+                                            <property name="tooltip-text" translatable="yes">Internet Services Daemon are daemons started by xinetd</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
@@ -362,16 +366,16 @@
                                           </packing>
                                         </child>
                                         <child>
-                                          <widget class="GtkRadioButton" id="cgi_radiobutton">
+                                          <object class="GtkRadioButton" id="cgi_radiobutton">
                                             <property name="label" translatable="yes">Web Application/Script (CGI)</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">Web Applications/Script (CGI) CGI scripts started by the web server (apache)</property>
+                                            <property name="tooltip-text" translatable="yes">Web Applications/Script (CGI) CGI scripts started by the web server (apache)</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
@@ -379,16 +383,16 @@
                                           </packing>
                                         </child>
                                         <child>
-                                          <widget class="GtkRadioButton" id="user_radiobutton">
+                                          <object class="GtkRadioButton" id="user_radiobutton">
                                             <property name="label" translatable="yes">User Application</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">User Application are any application that you would like to confine that is started by a user</property>
+                                            <property name="tooltip-text" translatable="yes">User Application are any application that you would like to confine that is started by a user</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
@@ -396,37 +400,37 @@
                                           </packing>
                                         </child>
                                         <child>
-                                          <widget class="GtkRadioButton" id="sandbox_radiobutton">
+                                          <object class="GtkRadioButton" id="sandbox_radiobutton">
                                             <property name="label" translatable="yes">Sandbox</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">User Application are any application that you would like to confine that is started by a user</property>
+                                            <property name="tooltip-text" translatable="yes">User Application are any application that you would like to confine that is started by a user</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
                                             <property name="position">5</property>
                                           </packing>
                                         </child>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
                                         <property name="position">1</property>
                                       </packing>
                                     </child>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">True</property>
                                     <property name="fill">True</property>
                                     <property name="position">1</property>
                                   </packing>
                                 </child>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">False</property>
                                 <property name="fill">True</property>
@@ -434,18 +438,18 @@
                               </packing>
                             </child>
                             <child>
-                              <widget class="GtkVBox" id="vbox19">
+                              <object class="GtkVBox" id="vbox19">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="spacing">6</property>
                                 <child>
-                                  <widget class="GtkLabel" id="label42">
+                                  <object class="GtkLabel" id="label42">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <property name="xalign">0</property>
                                     <property name="label" translatable="yes">&lt;b&gt;Login Users&lt;/b&gt;</property>
                                     <property name="use_markup">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -453,15 +457,15 @@
                                   </packing>
                                 </child>
                                 <child>
-                                  <widget class="GtkHBox" id="hbox18">
+                                  <object class="GtkHBox" id="hbox18">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <child>
-                                      <widget class="GtkLabel" id="label53">
+                                      <object class="GtkLabel" id="label53">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="label">    </property>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
@@ -469,21 +473,21 @@
                                       </packing>
                                     </child>
                                     <child>
-                                      <widget class="GtkVBox" id="vbox15">
+                                      <object class="GtkVBox" id="vbox15">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="spacing">6</property>
                                         <child>
-                                          <widget class="GtkRadioButton" id="existing_user_radiobutton">
+                                          <object class="GtkRadioButton" id="existing_user_radiobutton">
                                             <property name="label" translatable="yes">Existing User Roles</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">Modify an existing login user record.</property>
+                                            <property name="tooltip-text" translatable="yes">Modify an existing login user record.</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
@@ -491,16 +495,16 @@
                                           </packing>
                                         </child>
                                         <child>
-                                          <widget class="GtkRadioButton" id="terminal_user_radiobutton">
+                                          <object class="GtkRadioButton" id="terminal_user_radiobutton">
                                             <property name="label" translatable="yes">Minimal Terminal User Role</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">This user will login to a machine only via a terminal or remote login.  By default this user will have  no setuid, no networking, no su, no sudo.</property>
+                                            <property name="tooltip-text" translatable="yes">This user will login to a machine only via a terminal or remote login.  By default this user will have  no setuid, no networking, no su, no sudo.</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
@@ -508,16 +512,16 @@
                                           </packing>
                                         </child>
                                         <child>
-                                          <widget class="GtkRadioButton" id="xwindows_user_radiobutton">
+                                          <object class="GtkRadioButton" id="xwindows_user_radiobutton">
                                             <property name="label" translatable="yes">Minimal X Windows User Role</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">This user can login to a machine via X or terminal.  By default this user will have no setuid, no networking, no sudo, no su</property>
+                                            <property name="tooltip-text" translatable="yes">This user can login to a machine via X or terminal.  By default this user will have no setuid, no networking, no sudo, no su</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
@@ -525,16 +529,16 @@
                                           </packing>
                                         </child>
                                         <child>
-                                          <widget class="GtkRadioButton" id="login_user_radiobutton">
+                                          <object class="GtkRadioButton" id="login_user_radiobutton">
                                             <property name="label" translatable="yes">User Role</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">User with full networking, no setuid applications without transition, no sudo, no su.</property>
+                                            <property name="tooltip-text" translatable="yes">User with full networking, no setuid applications without transition, no sudo, no su.</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
@@ -542,37 +546,37 @@
                                           </packing>
                                         </child>
                                         <child>
-                                          <widget class="GtkRadioButton" id="admin_user_radiobutton">
+                                          <object class="GtkRadioButton" id="admin_user_radiobutton">
                                             <property name="label" translatable="yes">Admin User Role</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">User with full networking, no setuid applications without transition, no su, can sudo to Root Administration Roles</property>
+                                            <property name="tooltip-text" translatable="yes">User with full networking, no setuid applications without transition, no su, can sudo to Root Administration Roles</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
                                             <property name="position">4</property>
                                           </packing>
                                         </child>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">True</property>
                                         <property name="fill">False</property>
                                         <property name="position">1</property>
                                       </packing>
                                     </child>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">True</property>
                                     <property name="fill">True</property>
                                     <property name="position">1</property>
                                   </packing>
                                 </child>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">False</property>
                                 <property name="fill">True</property>
@@ -580,18 +584,18 @@
                               </packing>
                             </child>
                             <child>
-                              <widget class="GtkVBox" id="vbox20">
+                              <object class="GtkVBox" id="vbox20">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="spacing">6</property>
                                 <child>
-                                  <widget class="GtkLabel" id="label50">
+                                  <object class="GtkLabel" id="label50">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <property name="xalign">0</property>
                                     <property name="label" translatable="yes">&lt;b&gt;Root Users&lt;/b&gt;</property>
                                     <property name="use_markup">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -599,15 +603,15 @@
                                   </packing>
                                 </child>
                                 <child>
-                                  <widget class="GtkHBox" id="hbox19">
+                                  <object class="GtkHBox" id="hbox19">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <child>
-                                      <widget class="GtkLabel" id="label54">
+                                      <object class="GtkLabel" id="label54">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="label">    </property>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
@@ -615,96 +619,92 @@
                                       </packing>
                                     </child>
                                     <child>
-                                      <widget class="GtkVBox" id="vbox21">
+                                      <object class="GtkVBox" id="vbox21">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <child>
-                                          <widget class="GtkRadioButton" id="root_user_radiobutton">
+                                          <object class="GtkRadioButton" id="root_user_radiobutton">
                                             <property name="label" translatable="yes">Root Admin User Role</property>
                                             <property name="visible">True</property>
                                             <property name="can_focus">True</property>
                                             <property name="receives_default">False</property>
-                                            <property name="tooltip" translatable="yes">Select Root Administrator User Role, if this user will be used to administer the machine while running as root.  This user will not be able to login to the system directly.</property>
+                                            <property name="tooltip-text" translatable="yes">Select Root Administrator User Role, if this user will be used to administer the machine while running as root.  This user will not be able to login to the system directly.</property>
                                             <property name="use_underline">True</property>
                                             <property name="draw_indicator">True</property>
                                             <property name="group">init_radiobutton</property>
-                                          </widget>
+                                          </object>
                                           <packing>
                                             <property name="expand">False</property>
                                             <property name="fill">False</property>
                                             <property name="position">0</property>
                                           </packing>
                                         </child>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
                                         <property name="position">1</property>
                                       </packing>
                                     </child>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">True</property>
                                     <property name="fill">True</property>
                                     <property name="position">1</property>
                                   </packing>
                                 </child>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">True</property>
                                 <property name="fill">True</property>
                                 <property name="position">2</property>
                               </packing>
                             </child>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">True</property>
                             <property name="fill">True</property>
                             <property name="position">0</property>
                           </packing>
                         </child>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">True</property>
                         <property name="fill">True</property>
                         <property name="position">0</property>
                       </packing>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="tab_expand">True</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="label104">
+            <child type="tab">
+              <object class="GtkLabel" id="label104">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="no">Main Tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox60">
+              <object class="GtkVBox" id="vbox60">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_name_label">
+                  <object class="GtkLabel" id="select_name_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Enter name of application or user role:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -713,7 +713,7 @@
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkTable" id="table5">
+                  <object class="GtkTable" id="table5">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="n_rows">3</property>
@@ -721,28 +721,28 @@
                     <property name="column_spacing">12</property>
                     <property name="row_spacing">6</property>
                     <child>
-                      <widget class="GtkLabel" id="label1">
+                      <object class="GtkLabel" id="label1">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="xalign">0</property>
                         <property name="label" translatable="yes">Name</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="x_options">GTK_FILL</property>
                         <property name="y_options"/>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkEntry" id="exec_entry">
+                      <object class="GtkEntry" id="exec_entry">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
-                        <property name="tooltip" translatable="yes">Enter complete path for executable to be confined.</property>
-                        <property name="invisible_char">•</property>
+                        <property name="tooltip-text" translatable="yes">Enter complete path for executable to be confined.</property>
+                        <property name="invisible_char">&#x2022;</property>
                         <property name="primary_icon_activatable">False</property>
                         <property name="secondary_icon_activatable">False</property>
                         <property name="primary_icon_sensitive">True</property>
                         <property name="secondary_icon_sensitive">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="left_attach">1</property>
                         <property name="right_attach">2</property>
@@ -752,14 +752,14 @@
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkButton" id="exec_button">
+                      <object class="GtkButton" id="exec_button">
                         <property name="label" translatable="yes">...</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
-                        <signal name="clicked" handler="on_exec_select_clicked" swapped="no"/>
-                      </widget>
+                        <signal handler="on_exec_select_clicked" name="clicked" swapped="no"/>
+                      </object>
                       <packing>
                         <property name="left_attach">2</property>
                         <property name="right_attach">3</property>
@@ -770,16 +770,16 @@
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkEntry" id="name_entry">
+                      <object class="GtkEntry" id="name_entry">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
-                        <property name="tooltip" translatable="yes">Enter unique name for the confined application or user role.</property>
-                        <property name="invisible_char">•</property>
+                        <property name="tooltip-text" translatable="yes">Enter unique name for the confined application or user role.</property>
+                        <property name="invisible_char">&#x2022;</property>
                         <property name="primary_icon_activatable">False</property>
                         <property name="secondary_icon_activatable">False</property>
                         <property name="primary_icon_sensitive">True</property>
                         <property name="secondary_icon_sensitive">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="left_attach">1</property>
                         <property name="right_attach">3</property>
@@ -787,12 +787,12 @@
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkLabel" id="label2">
+                      <object class="GtkLabel" id="label2">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="xalign">0</property>
                         <property name="label" translatable="yes">Executable</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="top_attach">1</property>
                         <property name="bottom_attach">2</property>
@@ -801,12 +801,12 @@
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkLabel" id="label40">
+                      <object class="GtkLabel" id="label40">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="xalign">0</property>
                         <property name="label" translatable="yes">Init script</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="top_attach">2</property>
                         <property name="bottom_attach">3</property>
@@ -815,16 +815,16 @@
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkEntry" id="init_script_entry">
+                      <object class="GtkEntry" id="init_script_entry">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
-                        <property name="tooltip" translatable="yes">Enter complete path to init script used to start the confined application.</property>
-                        <property name="invisible_char">•</property>
+                        <property name="tooltip-text" translatable="yes">Enter complete path to init script used to start the confined application.</property>
+                        <property name="invisible_char">&#x2022;</property>
                         <property name="primary_icon_activatable">False</property>
                         <property name="secondary_icon_activatable">False</property>
                         <property name="primary_icon_sensitive">True</property>
                         <property name="secondary_icon_sensitive">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="left_attach">1</property>
                         <property name="right_attach">2</property>
@@ -834,14 +834,14 @@
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkButton" id="init_script_button">
+                      <object class="GtkButton" id="init_script_button">
                         <property name="label" translatable="yes">...</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
-                        <signal name="clicked" handler="on_init_script_select_clicked" swapped="no"/>
-                      </widget>
+                        <signal handler="on_init_script_select_clicked" name="clicked" swapped="no"/>
+                      </object>
                       <packing>
                         <property name="left_attach">2</property>
                         <property name="right_attach">3</property>
@@ -851,42 +851,38 @@
                         <property name="y_options"/>
                       </packing>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">1</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="select_name_label1">
+            <child type="tab">
+              <object class="GtkLabel" id="select_name_label1">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="no">Name Tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">1</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox61">
+              <object class="GtkVBox" id="vbox61">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_existing_role_label">
+                  <object class="GtkLabel" id="select_existing_role_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Select existing role to modify:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -895,56 +891,52 @@
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkScrolledWindow" id="scrolledwindow5">
+                  <object class="GtkScrolledWindow" id="scrolledwindow5">
                     <property name="visible">True</property>
                     <property name="can_focus">True</property>
                     <property name="hscrollbar_policy">automatic</property>
                     <property name="vscrollbar_policy">automatic</property>
                     <property name="shadow_type">in</property>
                     <child>
-                      <widget class="GtkTreeView" id="existing_user_treeview">
+                      <object class="GtkTreeView" id="existing_user_treeview">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
-                        <property name="tooltip" translatable="yes">Select the user roles that will transiton to the %s domain.</property>
+                        <property name="tooltip-text" translatable="yes">Select the user roles that will transiton to the %s domain.</property>
                         <property name="headers_visible">False</property>
-                      </widget>
+                      </object>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">2</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="label106">
+            <child type="tab">
+              <object class="GtkLabel" id="label106">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="yes">role tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">2</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox62">
+              <object class="GtkVBox" id="vbox62">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_label">
+                  <object class="GtkLabel" id="select_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Select roles that %s will transition to:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -953,54 +945,50 @@
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkScrolledWindow" id="scrolledwindow12">
+                  <object class="GtkScrolledWindow" id="scrolledwindow12">
                     <property name="visible">True</property>
                     <property name="can_focus">True</property>
                     <child>
-                      <widget class="GtkTreeView" id="transition_treeview">
+                      <object class="GtkTreeView" id="transition_treeview">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
-                        <property name="tooltip" translatable="yes">Select applications domains that %s will transition to.</property>
+                        <property name="tooltip-text" translatable="yes">Select applications domains that %s will transition to.</property>
                         <property name="headers_visible">False</property>
-                      </widget>
+                      </object>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">3</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="label107">
+            <child type="tab">
+              <object class="GtkLabel" id="label107">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="yes">transition 
 role tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">3</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox63">
+              <object class="GtkVBox" id="vbox63">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_user_roles_label">
+                  <object class="GtkLabel" id="select_user_roles_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Select the user_roles that will transition to %s:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -1009,53 +997,49 @@ role tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkScrolledWindow" id="scrolledwindow13">
+                  <object class="GtkScrolledWindow" id="scrolledwindow13">
                     <property name="visible">True</property>
                     <property name="can_focus">True</property>
                     <child>
-                      <widget class="GtkTreeView" id="user_transition_treeview">
+                      <object class="GtkTreeView" id="user_transition_treeview">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
-                        <property name="tooltip" translatable="yes">Select the user roles that will transiton to this applications domains.</property>
+                        <property name="tooltip-text" translatable="yes">Select the user roles that will transiton to this applications domains.</property>
                         <property name="headers_visible">False</property>
-                      </widget>
+                      </object>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">4</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="label108">
+            <child type="tab">
+              <object class="GtkLabel" id="label108">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="no">User Tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">4</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox64">
+              <object class="GtkVBox" id="vbox64">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_domain_admin_label">
+                  <object class="GtkLabel" id="select_domain_admin_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Select domains that %s will administer:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -1064,53 +1048,49 @@ role tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkScrolledWindow" id="scrolledwindow14">
+                  <object class="GtkScrolledWindow" id="scrolledwindow14">
                     <property name="visible">True</property>
                     <property name="can_focus">True</property>
                     <child>
-                      <widget class="GtkTreeView" id="admin_treeview">
+                      <object class="GtkTreeView" id="admin_treeview">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
-                        <property name="tooltip" translatable="yes">Select the domains that you would like this user administer.</property>
+                        <property name="tooltip-text" translatable="yes">Select the domains that you would like this user administer.</property>
                         <property name="headers_visible">False</property>
-                      </widget>
+                      </object>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">5</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="label109">
+            <child type="tab">
+              <object class="GtkLabel" id="label109">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="no">Admin Tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">5</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox65">
+              <object class="GtkVBox" id="vbox65">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_role_label">
+                  <object class="GtkLabel" id="select_role_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Select additional roles for %s:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -1119,53 +1099,49 @@ role tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkScrolledWindow" id="scrolledwindow15">
+                  <object class="GtkScrolledWindow" id="scrolledwindow15">
                     <property name="visible">True</property>
                     <property name="can_focus">True</property>
                     <child>
-                      <widget class="GtkTreeView" id="role_treeview">
+                      <object class="GtkTreeView" id="role_treeview">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
-                        <property name="tooltip" translatable="yes">Select the domains that you would like this user administer.</property>
+                        <property name="tooltip-text" translatable="yes">Select the domains that you would like this user administer.</property>
                         <property name="headers_visible">False</property>
-                      </widget>
+                      </object>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">6</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="in_net_page">
+            <child type="tab">
+              <object class="GtkLabel" id="in_net_page">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="no">Roles Tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">6</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="in_net_page1">
+              <object class="GtkVBox" id="in_net_page1">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_in_label">
+                  <object class="GtkLabel" id="select_in_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Enter network ports that %s binds on:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -1174,18 +1150,18 @@ role tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkVBox" id="vbox22">
+                  <object class="GtkVBox" id="vbox22">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="spacing">6</property>
                     <child>
-                      <widget class="GtkLabel" id="label55">
+                      <object class="GtkLabel" id="label55">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="xalign">0</property>
                         <property name="label" translatable="yes">&lt;b&gt;TCP Ports&lt;/b&gt;</property>
                         <property name="use_markup">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1193,15 +1169,15 @@ role tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkHBox" id="hbox20">
+                      <object class="GtkHBox" id="hbox20">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <child>
-                          <widget class="GtkLabel" id="label56">
+                          <object class="GtkLabel" id="label56">
                             <property name="visible">True</property>
                             <property name="can_focus">False</property>
                             <property name="label">    </property>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">False</property>
                             <property name="fill">False</property>
@@ -1209,25 +1185,25 @@ role tab</property>
                           </packing>
                         </child>
                         <child>
-                          <widget class="GtkVBox" id="vbox23">
+                          <object class="GtkVBox" id="vbox23">
                             <property name="visible">True</property>
                             <property name="can_focus">False</property>
                             <property name="spacing">6</property>
                             <child>
-                              <widget class="GtkHBox" id="hbox21">
+                              <object class="GtkHBox" id="hbox21">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="spacing">12</property>
                                 <child>
-                                  <widget class="GtkCheckButton" id="in_tcp_all_checkbutton">
+                                  <object class="GtkCheckButton" id="in_tcp_all_checkbutton">
                                     <property name="label" translatable="yes">All</property>
                                     <property name="visible">True</property>
                                     <property name="can_focus">True</property>
                                     <property name="receives_default">False</property>
-                                    <property name="tooltip" translatable="yes">Allows %s to bind to any udp port</property>
+                                    <property name="tooltip-text" translatable="yes">Allows %s to bind to any udp port</property>
                                     <property name="use_underline">True</property>
                                     <property name="draw_indicator">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -1236,15 +1212,15 @@ role tab</property>
                                   </packing>
                                 </child>
                                 <child>
-                                  <widget class="GtkCheckButton" id="in_tcp_reserved_checkbutton">
+                                  <object class="GtkCheckButton" id="in_tcp_reserved_checkbutton">
                                     <property name="label" translatable="yes">600-1024</property>
                                     <property name="visible">True</property>
                                     <property name="can_focus">True</property>
                                     <property name="receives_default">False</property>
-                                    <property name="tooltip" translatable="yes">Allow %s to call bindresvport with 0. Binding to port 600-1024</property>
+                                    <property name="tooltip-text" translatable="yes">Allow %s to call bindresvport with 0. Binding to port 600-1024</property>
                                     <property name="use_underline">True</property>
                                     <property name="draw_indicator">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -1253,15 +1229,15 @@ role tab</property>
                                   </packing>
                                 </child>
                                 <child>
-                                  <widget class="GtkCheckButton" id="in_tcp_unreserved_checkbutton">
+                                  <object class="GtkCheckButton" id="in_tcp_unreserved_checkbutton">
                                     <property name="label" translatable="yes">Unreserved Ports (&gt;1024)</property>
                                     <property name="visible">True</property>
                                     <property name="can_focus">True</property>
                                     <property name="receives_default">False</property>
-                                    <property name="tooltip" translatable="yes">Enter a comma separated list of udp ports or ranges of ports that %s binds to. Example: 612, 650-660</property>
+                                    <property name="tooltip-text" translatable="yes">Enter a comma separated list of udp ports or ranges of ports that %s binds to. Example: 612, 650-660</property>
                                     <property name="use_underline">True</property>
                                     <property name="draw_indicator">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -1269,7 +1245,7 @@ role tab</property>
                                     <property name="position">2</property>
                                   </packing>
                                 </child>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">True</property>
                                 <property name="fill">True</property>
@@ -1277,17 +1253,17 @@ role tab</property>
                               </packing>
                             </child>
                             <child>
-                              <widget class="GtkHBox" id="hbox22">
+                              <object class="GtkHBox" id="hbox22">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="spacing">12</property>
                                 <child>
-                                  <widget class="GtkLabel" id="label57">
+                                  <object class="GtkLabel" id="label57">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <property name="xalign">0</property>
                                     <property name="label" translatable="yes">Select Ports</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -1296,44 +1272,44 @@ role tab</property>
                                   </packing>
                                 </child>
                                 <child>
-                                  <widget class="GtkEntry" id="in_tcp_entry">
+                                  <object class="GtkEntry" id="in_tcp_entry">
                                     <property name="visible">True</property>
                                     <property name="can_focus">True</property>
-                                    <property name="tooltip" translatable="yes">Allows %s to bind to any udp ports &gt; 1024</property>
-                                    <property name="invisible_char">•</property>
+                                    <property name="tooltip-text" translatable="yes">Allows %s to bind to any udp ports &gt; 1024</property>
+                                    <property name="invisible_char">&#x2022;</property>
                                     <property name="primary_icon_activatable">False</property>
                                     <property name="secondary_icon_activatable">False</property>
                                     <property name="primary_icon_sensitive">True</property>
                                     <property name="secondary_icon_sensitive">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">True</property>
                                     <property name="fill">True</property>
                                     <property name="position">1</property>
                                   </packing>
                                 </child>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">True</property>
                                 <property name="fill">True</property>
                                 <property name="position">1</property>
                               </packing>
                             </child>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">True</property>
                             <property name="fill">True</property>
                             <property name="position">1</property>
                           </packing>
                         </child>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">True</property>
                         <property name="fill">True</property>
                         <property name="position">1</property>
                       </packing>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
@@ -1341,18 +1317,18 @@ role tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkVBox" id="vbox24">
+                  <object class="GtkVBox" id="vbox24">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="spacing">6</property>
                     <child>
-                      <widget class="GtkLabel" id="label58">
+                      <object class="GtkLabel" id="label58">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="xalign">0</property>
                         <property name="label" translatable="yes">&lt;b&gt;UDP Ports&lt;/b&gt;</property>
                         <property name="use_markup">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1360,15 +1336,15 @@ role tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkHBox" id="hbox23">
+                      <object class="GtkHBox" id="hbox23">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <child>
-                          <widget class="GtkLabel" id="label59">
+                          <object class="GtkLabel" id="label59">
                             <property name="visible">True</property>
                             <property name="can_focus">False</property>
                             <property name="label">    </property>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">False</property>
                             <property name="fill">False</property>
@@ -1376,25 +1352,25 @@ role tab</property>
                           </packing>
                         </child>
                         <child>
-                          <widget class="GtkVBox" id="vbox25">
+                          <object class="GtkVBox" id="vbox25">
                             <property name="visible">True</property>
                             <property name="can_focus">False</property>
                             <property name="spacing">6</property>
                             <child>
-                              <widget class="GtkHBox" id="hbox24">
+                              <object class="GtkHBox" id="hbox24">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="spacing">12</property>
                                 <child>
-                                  <widget class="GtkCheckButton" id="in_udp_all_checkbutton">
+                                  <object class="GtkCheckButton" id="in_udp_all_checkbutton">
                                     <property name="label" translatable="yes">All</property>
                                     <property name="visible">True</property>
                                     <property name="can_focus">True</property>
                                     <property name="receives_default">False</property>
-                                    <property name="tooltip" translatable="yes">Allows %s to bind to any udp port</property>
+                                    <property name="tooltip-text" translatable="yes">Allows %s to bind to any udp port</property>
                                     <property name="use_underline">True</property>
                                     <property name="draw_indicator">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -1403,15 +1379,15 @@ role tab</property>
                                   </packing>
                                 </child>
                                 <child>
-                                  <widget class="GtkCheckButton" id="in_udp_reserved_checkbutton">
+                                  <object class="GtkCheckButton" id="in_udp_reserved_checkbutton">
                                     <property name="label" translatable="yes">600-1024</property>
                                     <property name="visible">True</property>
                                     <property name="can_focus">True</property>
                                     <property name="receives_default">False</property>
-                                    <property name="tooltip" translatable="yes">Allow %s to call bindresvport with 0. Binding to port 600-1024</property>
+                                    <property name="tooltip-text" translatable="yes">Allow %s to call bindresvport with 0. Binding to port 600-1024</property>
                                     <property name="use_underline">True</property>
                                     <property name="draw_indicator">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -1420,15 +1396,15 @@ role tab</property>
                                   </packing>
                                 </child>
                                 <child>
-                                  <widget class="GtkCheckButton" id="in_udp_unreserved_checkbutton">
+                                  <object class="GtkCheckButton" id="in_udp_unreserved_checkbutton">
                                     <property name="label" translatable="yes">Unreserved Ports (&gt;1024)</property>
                                     <property name="visible">True</property>
                                     <property name="can_focus">True</property>
                                     <property name="receives_default">False</property>
-                                    <property name="tooltip" translatable="yes">Enter a comma separated list of udp ports or ranges of ports that %s binds to. Example: 612, 650-660</property>
+                                    <property name="tooltip-text" translatable="yes">Enter a comma separated list of udp ports or ranges of ports that %s binds to. Example: 612, 650-660</property>
                                     <property name="use_underline">True</property>
                                     <property name="draw_indicator">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -1436,7 +1412,7 @@ role tab</property>
                                     <property name="position">2</property>
                                   </packing>
                                 </child>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">True</property>
                                 <property name="fill">True</property>
@@ -1444,17 +1420,17 @@ role tab</property>
                               </packing>
                             </child>
                             <child>
-                              <widget class="GtkHBox" id="hbox25">
+                              <object class="GtkHBox" id="hbox25">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="spacing">12</property>
                                 <child>
-                                  <widget class="GtkLabel" id="label60">
+                                  <object class="GtkLabel" id="label60">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <property name="xalign">0</property>
                                     <property name="label" translatable="yes">Select Ports</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">False</property>
                                     <property name="fill">False</property>
@@ -1463,80 +1439,76 @@ role tab</property>
                                   </packing>
                                 </child>
                                 <child>
-                                  <widget class="GtkEntry" id="in_udp_entry">
+                                  <object class="GtkEntry" id="in_udp_entry">
                                     <property name="visible">True</property>
                                     <property name="can_focus">True</property>
-                                    <property name="tooltip" translatable="yes">Allows %s to bind to any udp ports &gt; 1024</property>
-                                    <property name="invisible_char">•</property>
+                                    <property name="tooltip-text" translatable="yes">Allows %s to bind to any udp ports &gt; 1024</property>
+                                    <property name="invisible_char">&#x2022;</property>
                                     <property name="primary_icon_activatable">False</property>
                                     <property name="secondary_icon_activatable">False</property>
                                     <property name="primary_icon_sensitive">True</property>
                                     <property name="secondary_icon_sensitive">True</property>
-                                  </widget>
+                                  </object>
                                   <packing>
                                     <property name="expand">True</property>
                                     <property name="fill">True</property>
                                     <property name="position">1</property>
                                   </packing>
                                 </child>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">True</property>
                                 <property name="fill">True</property>
                                 <property name="position">1</property>
                               </packing>
                             </child>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">True</property>
                             <property name="fill">True</property>
                             <property name="position">1</property>
                           </packing>
                         </child>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">True</property>
                         <property name="fill">True</property>
                         <property name="position">1</property>
                       </packing>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">2</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">7</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="label113">
+            <child type="tab">
+              <object class="GtkLabel" id="label113">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="yes">Network
 Bind tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">7</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox75">
+              <object class="GtkVBox" id="vbox75">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_out_label">
+                  <object class="GtkLabel" id="select_out_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Select network ports that %s connects to:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -1545,18 +1517,18 @@ Bind tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkVBox" id="vbox26">
+                  <object class="GtkVBox" id="vbox26">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="spacing">6</property>
                     <child>
-                      <widget class="GtkLabel" id="label37">
+                      <object class="GtkLabel" id="label37">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="xalign">0</property>
                         <property name="label" translatable="yes">&lt;b&gt;TCP Ports&lt;/b&gt;</property>
                         <property name="use_markup">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1564,15 +1536,15 @@ Bind tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkHBox" id="hbox26">
+                      <object class="GtkHBox" id="hbox26">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <child>
-                          <widget class="GtkLabel" id="label61">
+                          <object class="GtkLabel" id="label61">
                             <property name="visible">True</property>
                             <property name="can_focus">False</property>
                             <property name="label">    </property>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">False</property>
                             <property name="fill">False</property>
@@ -1580,20 +1552,20 @@ Bind tab</property>
                           </packing>
                         </child>
                         <child>
-                          <widget class="GtkHBox" id="hbox15">
+                          <object class="GtkHBox" id="hbox15">
                             <property name="visible">True</property>
                             <property name="can_focus">False</property>
                             <property name="spacing">12</property>
                             <child>
-                              <widget class="GtkCheckButton" id="out_tcp_all_checkbutton">
+                              <object class="GtkCheckButton" id="out_tcp_all_checkbutton">
                                 <property name="label" translatable="yes">All</property>
                                 <property name="visible">True</property>
                                 <property name="can_focus">True</property>
                                 <property name="receives_default">False</property>
-                                <property name="tooltip" translatable="yes">Allows %s to connect to any tcp port</property>
+                                <property name="tooltip-text" translatable="yes">Allows %s to connect to any tcp port</property>
                                 <property name="use_underline">True</property>
                                 <property name="draw_indicator">True</property>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">False</property>
                                 <property name="fill">False</property>
@@ -1602,12 +1574,12 @@ Bind tab</property>
                               </packing>
                             </child>
                             <child>
-                              <widget class="GtkLabel" id="label38">
+                              <object class="GtkLabel" id="label38">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="xalign">0</property>
                                 <property name="label" translatable="yes">Select Ports</property>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">False</property>
                                 <property name="fill">False</property>
@@ -1616,37 +1588,37 @@ Bind tab</property>
                               </packing>
                             </child>
                             <child>
-                              <widget class="GtkEntry" id="out_tcp_entry">
+                              <object class="GtkEntry" id="out_tcp_entry">
                                 <property name="visible">True</property>
                                 <property name="can_focus">True</property>
-                                <property name="tooltip" translatable="yes">Enter a comma separated list of tcp ports or ranges of ports that %s connects to. Example: 612, 650-660</property>
-                                <property name="invisible_char">•</property>
+                                <property name="tooltip-text" translatable="yes">Enter a comma separated list of tcp ports or ranges of ports that %s connects to. Example: 612, 650-660</property>
+                                <property name="invisible_char">&#x2022;</property>
                                 <property name="primary_icon_activatable">False</property>
                                 <property name="secondary_icon_activatable">False</property>
                                 <property name="primary_icon_sensitive">True</property>
                                 <property name="secondary_icon_sensitive">True</property>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">True</property>
                                 <property name="fill">True</property>
                                 <property name="position">2</property>
                               </packing>
                             </child>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">True</property>
                             <property name="fill">True</property>
                             <property name="position">1</property>
                           </packing>
                         </child>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">True</property>
                         <property name="fill">True</property>
                         <property name="position">1</property>
                       </packing>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
@@ -1654,18 +1626,18 @@ Bind tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkVBox" id="vbox27">
+                  <object class="GtkVBox" id="vbox27">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="spacing">6</property>
                     <child>
-                      <widget class="GtkLabel" id="label23">
+                      <object class="GtkLabel" id="label23">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="xalign">0</property>
                         <property name="label" translatable="yes">&lt;b&gt;UDP Ports&lt;/b&gt;</property>
                         <property name="use_markup">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1673,15 +1645,15 @@ Bind tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkHBox" id="hbox27">
+                      <object class="GtkHBox" id="hbox27">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <child>
-                          <widget class="GtkLabel" id="label62">
+                          <object class="GtkLabel" id="label62">
                             <property name="visible">True</property>
                             <property name="can_focus">False</property>
                             <property name="label">    </property>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">False</property>
                             <property name="fill">False</property>
@@ -1689,20 +1661,20 @@ Bind tab</property>
                           </packing>
                         </child>
                         <child>
-                          <widget class="GtkHBox" id="hbox12">
+                          <object class="GtkHBox" id="hbox12">
                             <property name="visible">True</property>
                             <property name="can_focus">False</property>
                             <property name="spacing">12</property>
                             <child>
-                              <widget class="GtkCheckButton" id="out_udp_all_checkbutton">
+                              <object class="GtkCheckButton" id="out_udp_all_checkbutton">
                                 <property name="label" translatable="yes">All</property>
                                 <property name="visible">True</property>
                                 <property name="can_focus">True</property>
                                 <property name="receives_default">False</property>
-                                <property name="tooltip" translatable="yes">Allows %s to connect to any udp port</property>
+                                <property name="tooltip-text" translatable="yes">Allows %s to connect to any udp port</property>
                                 <property name="use_underline">True</property>
                                 <property name="draw_indicator">True</property>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">False</property>
                                 <property name="fill">False</property>
@@ -1711,12 +1683,12 @@ Bind tab</property>
                               </packing>
                             </child>
                             <child>
-                              <widget class="GtkLabel" id="label22">
+                              <object class="GtkLabel" id="label22">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="xalign">0</property>
                                 <property name="label" translatable="yes">Select Ports</property>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">False</property>
                                 <property name="fill">False</property>
@@ -1725,73 +1697,69 @@ Bind tab</property>
                               </packing>
                             </child>
                             <child>
-                              <widget class="GtkEntry" id="out_udp_entry">
+                              <object class="GtkEntry" id="out_udp_entry">
                                 <property name="visible">True</property>
                                 <property name="can_focus">True</property>
-                                <property name="tooltip" translatable="yes">Enter a comma separated list of udp ports or ranges of ports that %s connects to. Example: 612, 650-660</property>
-                                <property name="invisible_char">•</property>
+                                <property name="tooltip-text" translatable="yes">Enter a comma separated list of udp ports or ranges of ports that %s connects to. Example: 612, 650-660</property>
+                                <property name="invisible_char">&#x2022;</property>
                                 <property name="primary_icon_activatable">False</property>
                                 <property name="secondary_icon_activatable">False</property>
                                 <property name="primary_icon_sensitive">True</property>
                                 <property name="secondary_icon_sensitive">True</property>
-                              </widget>
+                              </object>
                               <packing>
                                 <property name="expand">True</property>
                                 <property name="fill">True</property>
                                 <property name="position">2</property>
                               </packing>
                             </child>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">True</property>
                             <property name="fill">True</property>
                             <property name="position">1</property>
                           </packing>
                         </child>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">True</property>
                         <property name="fill">True</property>
                         <property name="position">1</property>
                       </packing>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">2</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">8</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="label114">
+            <child type="tab">
+              <object class="GtkLabel" id="label114">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="no">Network
 Connect Tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">8</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox68">
+              <object class="GtkVBox" id="vbox68">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_common_label">
+                  <object class="GtkLabel" id="select_common_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Select common application traits for %s:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -1800,19 +1768,19 @@ Connect Tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkVBox" id="vbox4">
+                  <object class="GtkVBox" id="vbox4">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="spacing">6</property>
                     <child>
-                      <widget class="GtkCheckButton" id="syslog_checkbutton">
+                      <object class="GtkCheckButton" id="syslog_checkbutton">
                         <property name="label" translatable="yes">Writes syslog messages	</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
                         <property name="draw_indicator">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1820,14 +1788,14 @@ Connect Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkCheckButton" id="tmp_checkbutton">
+                      <object class="GtkCheckButton" id="tmp_checkbutton">
                         <property name="label" translatable="yes">Create/Manipulate temporary files in /tmp</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
                         <property name="draw_indicator">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1835,14 +1803,14 @@ Connect Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkCheckButton" id="pam_checkbutton">
+                      <object class="GtkCheckButton" id="pam_checkbutton">
                         <property name="label" translatable="yes">Uses Pam for authentication</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
                         <property name="draw_indicator">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1850,14 +1818,14 @@ Connect Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkCheckButton" id="uid_checkbutton">
+                      <object class="GtkCheckButton" id="uid_checkbutton">
                         <property name="label" translatable="yes">Uses nsswitch or getpw* calls</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
                         <property name="draw_indicator">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1865,14 +1833,14 @@ Connect Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkCheckButton" id="dbus_checkbutton">
+                      <object class="GtkCheckButton" id="dbus_checkbutton">
                         <property name="label" translatable="yes">Uses dbus</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
                         <property name="draw_indicator">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1880,14 +1848,14 @@ Connect Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkCheckButton" id="audit_checkbutton">
+                      <object class="GtkCheckButton" id="audit_checkbutton">
                         <property name="label" translatable="yes">Sends audit messages</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
                         <property name="draw_indicator">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1895,14 +1863,14 @@ Connect Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkCheckButton" id="terminal_checkbutton">
+                      <object class="GtkCheckButton" id="terminal_checkbutton">
                         <property name="label" translatable="yes">Interacts with the terminal</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
                         <property name="draw_indicator">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -1910,57 +1878,53 @@ Connect Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkCheckButton" id="mail_checkbutton">
+                      <object class="GtkCheckButton" id="mail_checkbutton">
                         <property name="label" translatable="yes">Sends email</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
                         <property name="draw_indicator">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
                         <property name="position">7</property>
                       </packing>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">9</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="label115">
+            <child type="tab">
+              <object class="GtkLabel" id="label115">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="no">Common
 Tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">9</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox69">
+              <object class="GtkVBox" id="vbox69">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_manages_label">
+                  <object class="GtkLabel" id="select_manages_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Add files/directories that %s manages&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -1969,38 +1933,38 @@ Tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkHBox" id="hbox1">
+                  <object class="GtkHBox" id="hbox1">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="spacing">12</property>
                     <child>
-                      <widget class="GtkVBox" id="vbox3">
+                      <object class="GtkVBox" id="vbox3">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="spacing">6</property>
                         <child>
-                          <widget class="GtkButton" id="button2">
+                          <object class="GtkButton" id="button2">
                             <property name="visible">True</property>
                             <property name="can_focus">True</property>
                             <property name="receives_default">False</property>
-                            <signal name="clicked" handler="on_add_clicked" swapped="no"/>
+                            <signal handler="on_add_clicked" name="clicked" swapped="no"/>
                             <child>
-                              <widget class="GtkAlignment" id="alignment6">
+                              <object class="GtkAlignment" id="alignment6">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="xscale">0</property>
                                 <property name="yscale">0</property>
                                 <child>
-                                  <widget class="GtkHBox" id="hbox4">
+                                  <object class="GtkHBox" id="hbox4">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <property name="spacing">2</property>
                                     <child>
-                                      <widget class="GtkImage" id="image3">
+                                      <object class="GtkImage" id="image3">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="stock">gtk-add</property>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
@@ -2008,23 +1972,23 @@ Tab</property>
                                       </packing>
                                     </child>
                                     <child>
-                                      <widget class="GtkLabel" id="label17">
+                                      <object class="GtkLabel" id="label17">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="label">Add File</property>
                                         <property name="use_underline">True</property>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
                                         <property name="position">1</property>
                                       </packing>
                                     </child>
-                                  </widget>
+                                  </object>
                                 </child>
-                              </widget>
+                              </object>
                             </child>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">False</property>
                             <property name="fill">False</property>
@@ -2032,28 +1996,28 @@ Tab</property>
                           </packing>
                         </child>
                         <child>
-                          <widget class="GtkButton" id="button9">
+                          <object class="GtkButton" id="button9">
                             <property name="visible">True</property>
                             <property name="can_focus">True</property>
                             <property name="receives_default">False</property>
-                            <signal name="clicked" handler="on_add_dir_clicked" swapped="no"/>
+                            <signal handler="on_add_dir_clicked" name="clicked" swapped="no"/>
                             <child>
-                              <widget class="GtkAlignment" id="alignment5">
+                              <object class="GtkAlignment" id="alignment5">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="xscale">0</property>
                                 <property name="yscale">0</property>
                                 <child>
-                                  <widget class="GtkHBox" id="hbox3">
+                                  <object class="GtkHBox" id="hbox3">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <property name="spacing">2</property>
                                     <child>
-                                      <widget class="GtkImage" id="image2">
+                                      <object class="GtkImage" id="image2">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="stock">gtk-add</property>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
@@ -2061,23 +2025,23 @@ Tab</property>
                                       </packing>
                                     </child>
                                     <child>
-                                      <widget class="GtkLabel" id="label16">
+                                      <object class="GtkLabel" id="label16">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="label">Add Directory</property>
                                         <property name="use_underline">True</property>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
                                         <property name="position">1</property>
                                       </packing>
                                     </child>
-                                  </widget>
+                                  </object>
                                 </child>
-                              </widget>
+                              </object>
                             </child>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">False</property>
                             <property name="fill">False</property>
@@ -2085,22 +2049,22 @@ Tab</property>
                           </packing>
                         </child>
                         <child>
-                          <widget class="GtkButton" id="button4">
+                          <object class="GtkButton" id="button4">
                             <property name="label">gtk-delete</property>
                             <property name="visible">True</property>
                             <property name="can_focus">True</property>
                             <property name="receives_default">False</property>
                             <property name="use_stock">True</property>
-                            <signal name="clicked" handler="on_delete_clicked" swapped="no"/>
+                            <signal handler="on_delete_clicked" name="clicked" swapped="no"/>
                             <accelerator key="Delete" signal="clicked"/>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">False</property>
                             <property name="fill">False</property>
                             <property name="position">2</property>
                           </packing>
                         </child>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -2109,63 +2073,59 @@ Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkScrolledWindow" id="scrolledwindow2">
+                      <object class="GtkScrolledWindow" id="scrolledwindow2">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="hscrollbar_policy">automatic</property>
                         <property name="vscrollbar_policy">automatic</property>
                         <property name="shadow_type">in</property>
                         <child>
-                          <widget class="GtkTreeView" id="write_treeview">
+                          <object class="GtkTreeView" id="write_treeview">
                             <property name="visible">True</property>
                             <property name="can_focus">True</property>
-                            <property name="tooltip" translatable="yes">Files/Directories which the %s "manages". Pid Files, Log Files, /var/lib Files ...</property>
+                            <property name="tooltip-text" translatable="yes">Files/Directories which the %s "manages". Pid Files, Log Files, /var/lib Files ...</property>
                             <property name="headers_visible">False</property>
-                          </widget>
+                          </object>
                         </child>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">True</property>
                         <property name="fill">True</property>
                         <property name="position">1</property>
                       </packing>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">10</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="label116">
+            <child type="tab">
+              <object class="GtkLabel" id="label116">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <property name="label" translatable="no">Add Tab</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">10</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox70">
+              <object class="GtkVBox" id="vbox70">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_booleans_label">
+                  <object class="GtkLabel" id="select_booleans_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Add booleans from the %s policy:&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -2174,38 +2134,38 @@ Tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkHBox" id="hbox2">
+                  <object class="GtkHBox" id="hbox2">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="spacing">12</property>
                     <child>
-                      <widget class="GtkVBox" id="vbox1">
+                      <object class="GtkVBox" id="vbox1">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="spacing">6</property>
                         <child>
-                          <widget class="GtkButton" id="button1">
+                          <object class="GtkButton" id="button1">
                             <property name="visible">True</property>
                             <property name="can_focus">True</property>
                             <property name="receives_default">False</property>
-                            <signal name="clicked" handler="on_add_boolean_clicked" swapped="no"/>
+                            <signal handler="on_add_boolean_clicked" name="clicked" swapped="no"/>
                             <child>
-                              <widget class="GtkAlignment" id="alignment1">
+                              <object class="GtkAlignment" id="alignment1">
                                 <property name="visible">True</property>
                                 <property name="can_focus">False</property>
                                 <property name="xscale">0</property>
                                 <property name="yscale">0</property>
                                 <child>
-                                  <widget class="GtkHBox" id="hbox5">
+                                  <object class="GtkHBox" id="hbox5">
                                     <property name="visible">True</property>
                                     <property name="can_focus">False</property>
                                     <property name="spacing">2</property>
                                     <child>
-                                      <widget class="GtkImage" id="image1">
+                                      <object class="GtkImage" id="image1">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="stock">gtk-add</property>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
@@ -2213,23 +2173,23 @@ Tab</property>
                                       </packing>
                                     </child>
                                     <child>
-                                      <widget class="GtkLabel" id="label3">
+                                      <object class="GtkLabel" id="label3">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
                                         <property name="label">Add Boolean</property>
                                         <property name="use_underline">True</property>
-                                      </widget>
+                                      </object>
                                       <packing>
                                         <property name="expand">False</property>
                                         <property name="fill">False</property>
                                         <property name="position">1</property>
                                       </packing>
                                     </child>
-                                  </widget>
+                                  </object>
                                 </child>
-                              </widget>
+                              </object>
                             </child>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">False</property>
                             <property name="fill">False</property>
@@ -2237,22 +2197,22 @@ Tab</property>
                           </packing>
                         </child>
                         <child>
-                          <widget class="GtkButton" id="button3">
+                          <object class="GtkButton" id="button3">
                             <property name="label">gtk-delete</property>
                             <property name="visible">True</property>
                             <property name="can_focus">True</property>
                             <property name="receives_default">False</property>
                             <property name="use_stock">True</property>
-                            <signal name="clicked" handler="on_delete_boolean_clicked" swapped="no"/>
+                            <signal handler="on_delete_boolean_clicked" name="clicked" swapped="no"/>
                             <accelerator key="Delete" signal="clicked"/>
-                          </widget>
+                          </object>
                           <packing>
                             <property name="expand">False</property>
                             <property name="fill">False</property>
                             <property name="position">1</property>
                           </packing>
                         </child>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">True</property>
@@ -2261,61 +2221,57 @@ Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkScrolledWindow" id="scrolledwindow1">
+                      <object class="GtkScrolledWindow" id="scrolledwindow1">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="hscrollbar_policy">automatic</property>
                         <property name="vscrollbar_policy">automatic</property>
                         <property name="shadow_type">in</property>
                         <child>
-                          <widget class="GtkTreeView" id="boolean_treeview">
+                          <object class="GtkTreeView" id="boolean_treeview">
                             <property name="visible">True</property>
                             <property name="can_focus">True</property>
-                            <property name="tooltip" translatable="yes">Add/Remove booleans used by the %s domain</property>
-                          </widget>
+                            <property name="tooltip-text" translatable="yes">Add/Remove booleans used by the %s domain</property>
+                          </object>
                         </child>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">True</property>
                         <property name="fill">True</property>
                         <property name="position">1</property>
                       </packing>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">True</property>
                     <property name="fill">True</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">11</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="GtkLabel">
+            <child type="tab">
+              <object class="GtkLabel" id="GtkLabel">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">11</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkVBox" id="vbox71">
+              <object class="GtkVBox" id="vbox71">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
                 <child>
-                  <widget class="GtkLabel" id="select_dir_label">
+                  <object class="GtkLabel" id="select_dir_label">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="xalign">0</property>
                     <property name="label" translatable="yes">&lt;b&gt;Which directory you will generate the %s policy?&lt;/b&gt;</property>
                     <property name="use_markup">True</property>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -2323,16 +2279,16 @@ Tab</property>
                   </packing>
                 </child>
                 <child>
-                  <widget class="GtkHBox" id="hbox6">
+                  <object class="GtkHBox" id="hbox6">
                     <property name="visible">True</property>
                     <property name="can_focus">False</property>
                     <property name="spacing">12</property>
                     <child>
-                      <widget class="GtkLabel" id="label18">
+                      <object class="GtkLabel" id="label18">
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="label" translatable="yes">Policy Directory</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
@@ -2341,15 +2297,15 @@ Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkEntry" id="output_entry">
+                      <object class="GtkEntry" id="output_entry">
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
-                        <property name="invisible_char">•</property>
+                        <property name="invisible_char">&#x2022;</property>
                         <property name="primary_icon_activatable">False</property>
                         <property name="secondary_icon_activatable">False</property>
                         <property name="primary_icon_sensitive">True</property>
                         <property name="secondary_icon_sensitive">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">True</property>
                         <property name="fill">True</property>
@@ -2357,20 +2313,20 @@ Tab</property>
                       </packing>
                     </child>
                     <child>
-                      <widget class="GtkButton" id="output_button">
+                      <object class="GtkButton" id="output_button">
                         <property name="label" translatable="yes">...</property>
                         <property name="visible">True</property>
                         <property name="can_focus">True</property>
                         <property name="receives_default">False</property>
                         <property name="use_underline">True</property>
-                      </widget>
+                      </object>
                       <packing>
                         <property name="expand">False</property>
                         <property name="fill">False</property>
                         <property name="position">2</property>
                       </packing>
                     </child>
-                  </widget>
+                  </object>
                   <packing>
                     <property name="expand">False</property>
                     <property name="fill">False</property>
@@ -2378,23 +2334,19 @@ Tab</property>
                     <property name="position">1</property>
                   </packing>
                 </child>
-              </widget>
-              <packing>
-                <property name="position">12</property>
-              </packing>
+              </object>
             </child>
-            <child>
-              <widget class="GtkLabel" id="GtkLabel1">
+            <child type="tab">
+              <object class="GtkLabel" id="GtkLabel1">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
-              </widget>
+              </object>
               <packing>
                 <property name="position">12</property>
                 <property name="tab_fill">False</property>
-                <property name="type">tab</property>
               </packing>
             </child>
-          </widget>
+          </object>
           <packing>
             <property name="expand">True</property>
             <property name="fill">True</property>
@@ -2402,20 +2354,19 @@ Tab</property>
           </packing>
         </child>
         <child>
-          <widget class="GtkHButtonBox" id="hbuttonbox2">
+          <object class="GtkHButtonBox" id="hbuttonbox2">
             <property name="visible">True</property>
             <property name="can_focus">False</property>
             <property name="layout_style">end</property>
             <child>
-              <widget class="GtkButton" id="cancel_button">
+              <object class="GtkButton" id="cancel_button">
                 <property name="label">gtk-cancel</property>
                 <property name="visible">True</property>
                 <property name="can_focus">True</property>
                 <property name="can_default">True</property>
                 <property name="receives_default">False</property>
                 <property name="use_stock">True</property>
-                <signal name="activate" handler="on_cancel_activate" swapped="no"/>
-              </widget>
+              </object>
               <packing>
                 <property name="expand">False</property>
                 <property name="fill">False</property>
@@ -2423,15 +2374,14 @@ Tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkButton" id="back_button">
+              <object class="GtkButton" id="back_button">
                 <property name="label">gtk-go-back</property>
                 <property name="visible">True</property>
                 <property name="can_focus">True</property>
                 <property name="can_default">True</property>
                 <property name="receives_default">False</property>
                 <property name="use_stock">True</property>
-                <signal name="activate" handler="on_back_activate" swapped="no"/>
-              </widget>
+              </object>
               <packing>
                 <property name="expand">False</property>
                 <property name="fill">False</property>
@@ -2439,22 +2389,21 @@ Tab</property>
               </packing>
             </child>
             <child>
-              <widget class="GtkButton" id="forward_button">
+              <object class="GtkButton" id="forward_button">
                 <property name="label">gtk-go-forward</property>
                 <property name="visible">True</property>
                 <property name="can_focus">True</property>
                 <property name="can_default">True</property>
                 <property name="receives_default">False</property>
                 <property name="use_stock">True</property>
-                <signal name="activate" handler="on_forward_activate" swapped="no"/>
-              </widget>
+              </object>
               <packing>
                 <property name="expand">False</property>
                 <property name="fill">False</property>
                 <property name="position">2</property>
               </packing>
             </child>
-          </widget>
+          </object>
           <packing>
             <property name="expand">False</property>
             <property name="fill">False</property>
@@ -2462,7 +2411,7 @@ Tab</property>
             <property name="position">1</property>
           </packing>
         </child>
-      </widget>
+      </object>
     </child>
-  </widget>
-</glade-interface>
+  </object>
+</interface>
diff --git a/gui/polgengui.py b/gui/polgengui.py
index 09723278..cd73ea6d 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -97,10 +97,10 @@ def foreach(model, path, iter, selected):
 ##
 xml = Gtk.Builder()
 xml.set_translation_domain(PROGNAME)
-if os.access("polgen.glade", os.F_OK):
-    xml.add_from_file("polgen.glade")
+if os.access("polgen.ui", os.F_OK):
+    xml.add_from_file("polgen.ui")
 else:
-    xml.add_from_file("/usr/share/system-config-selinux/polgen.glade")
+    xml.add_from_file("/usr/share/system-config-selinux/polgen.ui")
 
 FILE = 1
 DIR = 2
@@ -125,82 +125,82 @@ class childWindow:
 
     def __init__(self):
         self.xml = xml
-        self.notebook = xml.get_widget("notebook")
+        self.notebook = xml.get_object("notebook")
         self.label_dict = {}
         self.tooltip_dict = {}
-        label = xml.get_widget("select_label")
+        label = xml.get_object("select_label")
         self.label_dict[label] = label.get_text()
 
-        label = xml.get_widget("select_user_roles_label")
+        label = xml.get_object("select_user_roles_label")
         self.label_dict[label] = label.get_text()
 
-        label = xml.get_widget("select_dir_label")
+        label = xml.get_object("select_dir_label")
         self.label_dict[label] = label.get_text()
 
-        label = xml.get_widget("select_domain_admin_label")
+        label = xml.get_object("select_domain_admin_label")
         self.label_dict[label] = label.get_text()
 
-        label = xml.get_widget("select_in_label")
+        label = xml.get_object("select_in_label")
         self.label_dict[label] = label.get_text()
 
-        label = xml.get_widget("select_out_label")
+        label = xml.get_object("select_out_label")
         self.label_dict[label] = label.get_text()
 
-        label = xml.get_widget("select_common_label")
+        label = xml.get_object("select_common_label")
         self.label_dict[label] = label.get_text()
 
-        label = xml.get_widget("select_manages_label")
+        label = xml.get_object("select_manages_label")
         self.label_dict[label] = label.get_text()
 
-        label = xml.get_widget("select_booleans_label")
+        label = xml.get_object("select_booleans_label")
         self.label_dict[label] = label.get_text()
 
-        label = xml.get_widget("existing_user_treeview")
+        label = xml.get_object("existing_user_treeview")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("transition_treeview")
+        label = xml.get_object("transition_treeview")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("in_tcp_all_checkbutton")
+        label = xml.get_object("in_tcp_all_checkbutton")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("in_tcp_reserved_checkbutton")
+        label = xml.get_object("in_tcp_reserved_checkbutton")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("in_tcp_unreserved_checkbutton")
+        label = xml.get_object("in_tcp_unreserved_checkbutton")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("in_tcp_entry")
+        label = xml.get_object("in_tcp_entry")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("in_udp_all_checkbutton")
+        label = xml.get_object("in_udp_all_checkbutton")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("in_udp_reserved_checkbutton")
+        label = xml.get_object("in_udp_reserved_checkbutton")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("in_udp_unreserved_checkbutton")
+        label = xml.get_object("in_udp_unreserved_checkbutton")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("in_udp_entry")
+        label = xml.get_object("in_udp_entry")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("out_tcp_entry")
+        label = xml.get_object("out_tcp_entry")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("out_udp_entry")
+        label = xml.get_object("out_udp_entry")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("out_tcp_all_checkbutton")
+        label = xml.get_object("out_tcp_all_checkbutton")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("out_udp_all_checkbutton")
+        label = xml.get_object("out_udp_all_checkbutton")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("boolean_treeview")
+        label = xml.get_object("boolean_treeview")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
-        label = xml.get_widget("write_treeview")
+        label = xml.get_object("write_treeview")
         self.tooltip_dict[label] = label.get_tooltip_text()
 
         try:
@@ -216,23 +216,26 @@ class childWindow:
             self.error(str(e))
 
         self.name = ""
-        xml.signal_connect("on_delete_clicked", self.delete)
-        xml.signal_connect("on_delete_boolean_clicked", self.delete_boolean)
-        xml.signal_connect("on_exec_select_clicked", self.exec_select)
-        xml.signal_connect("on_init_script_select_clicked", self.init_script_select)
-        xml.signal_connect("on_add_clicked", self.add)
-        xml.signal_connect("on_add_boolean_clicked", self.add_boolean)
-        xml.signal_connect("on_add_dir_clicked", self.add_dir)
-        xml.signal_connect("on_about_clicked", self.on_about_clicked)
-        xml.get_widget("cancel_button").connect("clicked", self.quit)
-        self.forward_button = xml.get_widget("forward_button")
+        handlers = {
+            "on_delete_clicked": self.delete,
+            "on_delete_boolean_clicked": self.delete_boolean,
+            "on_exec_select_clicked": self.exec_select,
+            "on_init_script_select_clicked": self.init_script_select,
+            "on_add_clicked": self.add,
+            "on_add_boolean_clicked": self.add_boolean,
+            "on_add_dir_clicked": self.add_dir,
+            "on_about_clicked": self.on_about_clicked
+        }
+        xml.connect_signals(handlers)
+        xml.get_object("cancel_button").connect("clicked", self.quit)
+        self.forward_button = xml.get_object("forward_button")
         self.forward_button.connect("clicked", self.forward)
-        self.back_button = xml.get_widget("back_button")
+        self.back_button = xml.get_object("back_button")
         self.back_button.connect("clicked", self.back)
 
-        self.boolean_dialog = xml.get_widget("boolean_dialog")
-        self.boolean_name_entry = xml.get_widget("boolean_name_entry")
-        self.boolean_description_entry = xml.get_widget("boolean_description_entry")
+        self.boolean_dialog = xml.get_object("boolean_dialog")
+        self.boolean_name_entry = xml.get_object("boolean_name_entry")
+        self.boolean_description_entry = xml.get_object("boolean_description_entry")
 
         self.pages = {}
         for i in sepolicy.generate.USERS:
@@ -251,34 +254,34 @@ class childWindow:
 
         self.network_buttons = {}
 
-        self.in_tcp_all_checkbutton = xml.get_widget("in_tcp_all_checkbutton")
-        self.in_tcp_reserved_checkbutton = xml.get_widget("in_tcp_reserved_checkbutton")
-        self.in_tcp_unreserved_checkbutton = xml.get_widget("in_tcp_unreserved_checkbutton")
-        self.in_tcp_entry = self.xml.get_widget("in_tcp_entry")
+        self.in_tcp_all_checkbutton = xml.get_object("in_tcp_all_checkbutton")
+        self.in_tcp_reserved_checkbutton = xml.get_object("in_tcp_reserved_checkbutton")
+        self.in_tcp_unreserved_checkbutton = xml.get_object("in_tcp_unreserved_checkbutton")
+        self.in_tcp_entry = self.xml.get_object("in_tcp_entry")
         self.network_buttons[self.in_tcp_all_checkbutton] = [self.in_tcp_reserved_checkbutton, self.in_tcp_unreserved_checkbutton, self.in_tcp_entry]
 
-        self.out_tcp_all_checkbutton = xml.get_widget("out_tcp_all_checkbutton")
-        self.out_tcp_reserved_checkbutton = xml.get_widget("out_tcp_reserved_checkbutton")
-        self.out_tcp_unreserved_checkbutton = xml.get_widget("out_tcp_unreserved_checkbutton")
-        self.out_tcp_entry = self.xml.get_widget("out_tcp_entry")
+        self.out_tcp_all_checkbutton = xml.get_object("out_tcp_all_checkbutton")
+        self.out_tcp_reserved_checkbutton = xml.get_object("out_tcp_reserved_checkbutton")
+        self.out_tcp_unreserved_checkbutton = xml.get_object("out_tcp_unreserved_checkbutton")
+        self.out_tcp_entry = self.xml.get_object("out_tcp_entry")
 
         self.network_buttons[self.out_tcp_all_checkbutton] = [self.out_tcp_entry]
 
-        self.in_udp_all_checkbutton = xml.get_widget("in_udp_all_checkbutton")
-        self.in_udp_reserved_checkbutton = xml.get_widget("in_udp_reserved_checkbutton")
-        self.in_udp_unreserved_checkbutton = xml.get_widget("in_udp_unreserved_checkbutton")
-        self.in_udp_entry = self.xml.get_widget("in_udp_entry")
+        self.in_udp_all_checkbutton = xml.get_object("in_udp_all_checkbutton")
+        self.in_udp_reserved_checkbutton = xml.get_object("in_udp_reserved_checkbutton")
+        self.in_udp_unreserved_checkbutton = xml.get_object("in_udp_unreserved_checkbutton")
+        self.in_udp_entry = self.xml.get_object("in_udp_entry")
 
         self.network_buttons[self.in_udp_all_checkbutton] = [self.in_udp_reserved_checkbutton, self.in_udp_unreserved_checkbutton, self.in_udp_entry]
 
-        self.out_udp_all_checkbutton = xml.get_widget("out_udp_all_checkbutton")
-        self.out_udp_entry = self.xml.get_widget("out_udp_entry")
+        self.out_udp_all_checkbutton = xml.get_object("out_udp_all_checkbutton")
+        self.out_udp_entry = self.xml.get_object("out_udp_entry")
         self.network_buttons[self.out_udp_all_checkbutton] = [self.out_udp_entry]
 
         for b in self.network_buttons.keys():
             b.connect("clicked", self.network_all_clicked)
 
-        self.boolean_treeview = self.xml.get_widget("boolean_treeview")
+        self.boolean_treeview = self.xml.get_object("boolean_treeview")
         self.boolean_store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_STRING)
         self.boolean_treeview.set_model(self.boolean_store)
         self.boolean_store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
@@ -287,7 +290,7 @@ class childWindow:
         col = Gtk.TreeViewColumn(_("Description"), Gtk.CellRendererText(), text=1)
         self.boolean_treeview.append_column(col)
 
-        self.role_treeview = self.xml.get_widget("role_treeview")
+        self.role_treeview = self.xml.get_object("role_treeview")
         self.role_store = Gtk.ListStore(GObject.TYPE_STRING)
         self.role_treeview.set_model(self.role_store)
         self.role_treeview.get_selection().set_mode(Gtk.SelectionMode.MULTIPLE)
@@ -295,7 +298,7 @@ class childWindow:
         col = Gtk.TreeViewColumn(_("Role"), Gtk.CellRendererText(), text=0)
         self.role_treeview.append_column(col)
 
-        self.existing_user_treeview = self.xml.get_widget("existing_user_treeview")
+        self.existing_user_treeview = self.xml.get_object("existing_user_treeview")
         self.existing_user_store = Gtk.ListStore(GObject.TYPE_STRING)
         self.existing_user_treeview.set_model(self.existing_user_store)
         self.existing_user_store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
@@ -306,9 +309,9 @@ class childWindow:
             iter = self.role_store.append()
             self.role_store.set_value(iter, 0, i[:-2])
 
-        self.in_tcp_reserved_checkbutton = xml.get_widget("in_tcp_reserved_checkbutton")
+        self.in_tcp_reserved_checkbutton = xml.get_object("in_tcp_reserved_checkbutton")
 
-        self.transition_treeview = self.xml.get_widget("transition_treeview")
+        self.transition_treeview = self.xml.get_object("transition_treeview")
         self.transition_store = Gtk.ListStore(GObject.TYPE_STRING)
         self.transition_treeview.set_model(self.transition_store)
         self.transition_treeview.get_selection().set_mode(Gtk.SelectionMode.MULTIPLE)
@@ -316,7 +319,7 @@ class childWindow:
         col = Gtk.TreeViewColumn(_("Application"), Gtk.CellRendererText(), text=0)
         self.transition_treeview.append_column(col)
 
-        self.user_transition_treeview = self.xml.get_widget("user_transition_treeview")
+        self.user_transition_treeview = self.xml.get_object("user_transition_treeview")
         self.user_transition_store = Gtk.ListStore(GObject.TYPE_STRING)
         self.user_transition_treeview.set_model(self.user_transition_store)
         self.user_transition_treeview.get_selection().set_mode(Gtk.SelectionMode.MULTIPLE)
@@ -330,7 +333,7 @@ class childWindow:
             iter = self.existing_user_store.append()
             self.existing_user_store.set_value(iter, 0, i[:-2])
 
-        self.admin_treeview = self.xml.get_widget("admin_treeview")
+        self.admin_treeview = self.xml.get_object("admin_treeview")
         self.admin_store = Gtk.ListStore(GObject.TYPE_STRING)
         self.admin_treeview.set_model(self.admin_store)
         self.admin_treeview.get_selection().set_mode(Gtk.SelectionMode.MULTIPLE)
@@ -385,7 +388,7 @@ class childWindow:
 
         if self.pages[type][self.current_page] == self.FINISH_PAGE:
             self.generate_policy()
-            self.xml.get_widget("cancel_button").set_label(Gtk.STOCK_CLOSE)
+            self.xml.get_object("cancel_button").set_label(Gtk.STOCK_CLOSE)
         else:
             self.current_page = self.current_page + 1
             self.notebook.set_current_page(self.pages[type][self.current_page])
@@ -605,7 +608,7 @@ class childWindow:
         self.__add(DIR)
 
     def on_about_clicked(self, args):
-        dlg = xml.get_widget("about_dialog")
+        dlg = xml.get_object("about_dialog")
         dlg.run()
         dlg.hide()
 
@@ -614,43 +617,43 @@ class childWindow:
 
     def setupScreen(self):
         # Bring in widgets from glade file.
-        self.mainWindow = self.xml.get_widget("main_window")
-        self.druid = self.xml.get_widget("druid")
+        self.mainWindow = self.xml.get_object("main_window")
+        self.druid = self.xml.get_object("druid")
         self.type = 0
-        self.name_entry = self.xml.get_widget("name_entry")
+        self.name_entry = self.xml.get_object("name_entry")
         self.name_entry.connect("insert_text", self.on_name_entry_changed)
         self.name_entry.connect("focus_out_event", self.on_focus_out_event)
-        self.exec_entry = self.xml.get_widget("exec_entry")
-        self.exec_button = self.xml.get_widget("exec_button")
-        self.init_script_entry = self.xml.get_widget("init_script_entry")
-        self.init_script_button = self.xml.get_widget("init_script_button")
-        self.output_entry = self.xml.get_widget("output_entry")
+        self.exec_entry = self.xml.get_object("exec_entry")
+        self.exec_button = self.xml.get_object("exec_button")
+        self.init_script_entry = self.xml.get_object("init_script_entry")
+        self.init_script_button = self.xml.get_object("init_script_button")
+        self.output_entry = self.xml.get_object("output_entry")
         self.output_entry.set_text(os.getcwd())
-        self.xml.get_widget("output_button").connect("clicked", self.output_button_clicked)
-
-        self.xwindows_user_radiobutton = self.xml.get_widget("xwindows_user_radiobutton")
-        self.terminal_user_radiobutton = self.xml.get_widget("terminal_user_radiobutton")
-        self.root_user_radiobutton = self.xml.get_widget("root_user_radiobutton")
-        self.login_user_radiobutton = self.xml.get_widget("login_user_radiobutton")
-        self.admin_user_radiobutton = self.xml.get_widget("admin_user_radiobutton")
-        self.existing_user_radiobutton = self.xml.get_widget("existing_user_radiobutton")
-
-        self.user_radiobutton = self.xml.get_widget("user_radiobutton")
-        self.init_radiobutton = self.xml.get_widget("init_radiobutton")
-        self.inetd_radiobutton = self.xml.get_widget("inetd_radiobutton")
-        self.dbus_radiobutton = self.xml.get_widget("dbus_radiobutton")
-        self.cgi_radiobutton = self.xml.get_widget("cgi_radiobutton")
-        self.sandbox_radiobutton = self.xml.get_widget("sandbox_radiobutton")
-        self.tmp_checkbutton = self.xml.get_widget("tmp_checkbutton")
-        self.uid_checkbutton = self.xml.get_widget("uid_checkbutton")
-        self.pam_checkbutton = self.xml.get_widget("pam_checkbutton")
-        self.dbus_checkbutton = self.xml.get_widget("dbus_checkbutton")
-        self.audit_checkbutton = self.xml.get_widget("audit_checkbutton")
-        self.terminal_checkbutton = self.xml.get_widget("terminal_checkbutton")
-        self.mail_checkbutton = self.xml.get_widget("mail_checkbutton")
-        self.syslog_checkbutton = self.xml.get_widget("syslog_checkbutton")
-        self.view = self.xml.get_widget("write_treeview")
-        self.file_dialog = self.xml.get_widget("filechooserdialog")
+        self.xml.get_object("output_button").connect("clicked", self.output_button_clicked)
+
+        self.xwindows_user_radiobutton = self.xml.get_object("xwindows_user_radiobutton")
+        self.terminal_user_radiobutton = self.xml.get_object("terminal_user_radiobutton")
+        self.root_user_radiobutton = self.xml.get_object("root_user_radiobutton")
+        self.login_user_radiobutton = self.xml.get_object("login_user_radiobutton")
+        self.admin_user_radiobutton = self.xml.get_object("admin_user_radiobutton")
+        self.existing_user_radiobutton = self.xml.get_object("existing_user_radiobutton")
+
+        self.user_radiobutton = self.xml.get_object("user_radiobutton")
+        self.init_radiobutton = self.xml.get_object("init_radiobutton")
+        self.inetd_radiobutton = self.xml.get_object("inetd_radiobutton")
+        self.dbus_radiobutton = self.xml.get_object("dbus_radiobutton")
+        self.cgi_radiobutton = self.xml.get_object("cgi_radiobutton")
+        self.sandbox_radiobutton = self.xml.get_object("sandbox_radiobutton")
+        self.tmp_checkbutton = self.xml.get_object("tmp_checkbutton")
+        self.uid_checkbutton = self.xml.get_object("uid_checkbutton")
+        self.pam_checkbutton = self.xml.get_object("pam_checkbutton")
+        self.dbus_checkbutton = self.xml.get_object("dbus_checkbutton")
+        self.audit_checkbutton = self.xml.get_object("audit_checkbutton")
+        self.terminal_checkbutton = self.xml.get_object("terminal_checkbutton")
+        self.mail_checkbutton = self.xml.get_object("mail_checkbutton")
+        self.syslog_checkbutton = self.xml.get_object("syslog_checkbutton")
+        self.view = self.xml.get_object("write_treeview")
+        self.file_dialog = self.xml.get_object("filechooserdialog")
 
         self.store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_INT)
         self.view.set_model(self.store)
-- 
2.16.1
