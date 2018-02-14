Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1ELJGel022764
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 16:19:16 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 3zhXMk2L4jz3GDw7
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 21:18:58 +0000 (UTC)
Received: from UPDC3CPA11_EEMSG_MP27.eemsg.mil (unknown [192.168.18.22])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 3zhXMk0bmqz3GDw4
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 21:18:58 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5989B561259
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 22:16:50 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Wed, 14 Feb 2018 22:16:25 +0100
Message-Id: <20180214211625.531-3-nicolas.iooss@m4x.org>
In-Reply-To: <20180214211625.531-1-nicolas.iooss@m4x.org>
References: <20180214211625.531-1-nicolas.iooss@m4x.org>
Subject: [PATCH 3/3] python/sepolicy: Fix translated strings with parameters
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a translated string takes parameters with %, the % and the
parameters need to be after the call to the underline function in order
to work properly.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/generate.py  |  2 +-
 python/sepolicy/sepolicy/gui.py       | 28 ++++++++++++++--------------
 python/sepolicy/sepolicy/interface.py |  4 ++--
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index f885425806f1..325a3888be2b 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -191,7 +191,7 @@ def verify_ports(ports):
                 temp.append(p)
         return temp
     except ValueError:
-        raise ValueError(_("Ports must be numbers or ranges of numbers from 1 to %d " % max_port))
+        raise ValueError(_("Ports must be numbers or ranges of numbers from 1 to %d ") % max_port)
 
 
 class policy:
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 6562aa850c98..537d5168a536 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -500,7 +500,7 @@ class SELinuxGui():
         self.all_domains.sort(key=str.lower)
 
         if app and app not in self.all_domains:
-            self.error(_("%s is not a valid domain" % app))
+            self.error(_("%s is not a valid domain") % app)
             self.quit()
 
         loading_gui.show()
@@ -1056,21 +1056,21 @@ class SELinuxGui():
         self.application_files_initialize(app)
         self.transitions_files_initialize(app)
 
-        self.executable_files_tab.set_tooltip_text(_("File path used to enter the '%s' domain." % app))
-        self.writable_files_tab.set_tooltip_text(_("Files to which the '%s' domain can write." % app))
-        self.network_out_tab.set_tooltip_text(_("Network Ports to which the '%s' is allowed to connect." % app))
-        self.network_in_tab.set_tooltip_text(_("Network Ports to which the '%s' is allowed to listen." % app))
-        self.application_files_tab.set_tooltip_text(_("File Types defined for the '%s'." % app))
-        self.boolean_radio_button.set_tooltip_text(_("Display boolean information that can be used to modify the policy for the '%s'." % app))
-        self.files_radio_button.set_tooltip_text(_("Display file type information that can be used by the '%s'." % app))
-        self.network_radio_button.set_tooltip_text(_("Display network ports to which the '%s' can connect or listen to." % app))
-        self.transitions_into_tab.set_label(_("Application Transitions Into '%s'" % app))
-        self.transitions_from_tab.set_label(_("Application Transitions From '%s'" % app))
-        self.transitions_file_tab.set_label(_("File Transitions From '%s'" % app))
+        self.executable_files_tab.set_tooltip_text(_("File path used to enter the '%s' domain.") % app)
+        self.writable_files_tab.set_tooltip_text(_("Files to which the '%s' domain can write.") % app)
+        self.network_out_tab.set_tooltip_text(_("Network Ports to which the '%s' is allowed to connect.") % app)
+        self.network_in_tab.set_tooltip_text(_("Network Ports to which the '%s' is allowed to listen.") % app)
+        self.application_files_tab.set_tooltip_text(_("File Types defined for the '%s'.") % app)
+        self.boolean_radio_button.set_tooltip_text(_("Display boolean information that can be used to modify the policy for the '%s'.") % app)
+        self.files_radio_button.set_tooltip_text(_("Display file type information that can be used by the '%s'.") % app)
+        self.network_radio_button.set_tooltip_text(_("Display network ports to which the '%s' can connect or listen to.") % app)
+        self.transitions_into_tab.set_label(_("Application Transitions Into '%s'") % app)
+        self.transitions_from_tab.set_label(_("Application Transitions From '%s'") % app)
+        self.transitions_file_tab.set_label(_("File Transitions From '%s'") % app)
         self.transitions_into_tab.set_tooltip_text(_("Executables which will transition to '%s', when executing selected domains entrypoint.") % app)
         self.transitions_from_tab.set_tooltip_text(_("Executables which will transition to a different domain, when '%s' executes them.") % app)
-        self.transitions_file_tab.set_tooltip_text(_("Files by '%s' with transitions to a different label." % app))
-        self.transitions_radio_button.set_tooltip_text(_("Display applications that can transition into or out of the '%s'." % app))
+        self.transitions_file_tab.set_tooltip_text(_("Files by '%s' with transitions to a different label.") % app)
+        self.transitions_radio_button.set_tooltip_text(_("Display applications that can transition into or out of the '%s'.") % app)
 
         self.application = app
         self.applications_selection_button.set_label(self.application)
diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
index c64122e5e565..18374dcfed96 100644
--- a/python/sepolicy/sepolicy/interface.py
+++ b/python/sepolicy/sepolicy/interface.py
@@ -220,7 +220,7 @@ def interface_compile_test(interface, path="/usr/share/selinux/devel/policy.xml"
     idict = get_interface_dict(path)
 
     if not (interface.split("_")[0] in exclude_interfaces or idict[interface][2] in exclude_interface_type):
-        print(_("Compiling %s interface" % interface))
+        print(_("Compiling %s interface") % interface)
         try:
             fd = open(policy_files['te'], "w")
             fd.write(generate_compile_te(interface, idict))
@@ -237,4 +237,4 @@ def interface_compile_test(interface, path="/usr/share/selinux/devel/policy.xml"
                 os.remove(v)
 
     else:
-        sys.stderr.write(_("\nCompiling of %s interface is not supported." % interface))
+        sys.stderr.write(_("\nCompiling of %s interface is not supported.") % interface)
-- 
2.16.0
