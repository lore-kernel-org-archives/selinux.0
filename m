Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8UIXvux021633
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 14:33:57 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8UIX9j7023092
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 18:33:09 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8UIXto2016325
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 14:33:55 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8UIXtkc007661
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 14:33:55 -0400
Message-ID: <4AC3A494.5010500@redhat.com>
Date: Wed, 30 Sep 2009 14:33:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Add modules support to semanage
Content-Type: multipart/mixed;
 boundary="------------030309000106090809070007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030309000106090809070007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Includes enable and disable.


--------------030309000106090809070007
Content-Type: text/plain;
 name="modules.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="modules.patch"

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index 437eca3..128ab47 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -44,11 +44,12 @@ if __name__ == '__main__':
                text = _("""
 semanage [ -S store ] -i [ input_file | - ]
 
-semanage {boolean|login|user|port|interface|node|fcontext} -{l|D} [-n]
+semanage {boolean|login|user|port|interface|module|node|fcontext} -{l|D} [-n]
 semanage login -{a|d|m} [-sr] login_name | %groupname
 semanage user -{a|d|m} [-LrRP] selinux_name
 semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
 semanage interface -{a|d|m} [-tr] interface_spec
+semanage module -{a|d|m} [--enable|--disable] module
 semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] addr
 semanage fcontext -{a|d|m} [-frst] file_spec
 semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean | boolean_file
@@ -90,6 +91,8 @@ Object-specific Options (see above):
 	-s, --seuser     SELinux User Name
 	-t, --type       SELinux Type for the object
 	-r, --range      MLS/MCS Security Range (MLS/MCS Systems only)
+        --enable         Enable a module
+        --disable        Disable a module
 """)
                raise ValueError("%s\n%s" % (text, message))
 		
@@ -110,6 +113,8 @@ Object-specific Options (see above):
 		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--proto' ]
 		valid_option["interface"] = []
 		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range']
+		valid_option["module"] = []
+		valid_option["module"] += valid_everyone + [ '--enable', '--disable']
 		valid_option["node"] = []
 		valid_option["node"] += valid_everyone + [ '-M', '--mask', '-t', '--type', '-r', '--range', '-p', '--protocol']
 		valid_option["fcontext"] = []
@@ -188,6 +193,8 @@ Object-specific Options (see above):
 		locallist = False
 		use_file = False
                 store = ""
+                enable = False
+                disable = False
 			
 		object = argv[0]
 		option_dict=get_options()
@@ -240,6 +247,18 @@ Object-specific Options (see above):
 				if modify:
                                        raise ValueError(_("%s bad option") % o)
 				deleteall = True
+
+			if o == "--enable":
+                                if disable:
+                                       raise ValueError(_("You can't disable and enable at the same time"))
+
+				enable = True
+
+			if o == "--disable":
+                                if enable:
+                                       raise ValueError(_("You can't disable and enable at the same time"))
+				disable = True
+
 			if o == "-f"  or o == "--ftype":
 				ftype=a
 
@@ -307,6 +326,9 @@ Object-specific Options (see above):
 		if object == "interface":
 			OBJECT = seobject.interfaceRecords(store)
 
+		if object == "module":
+			OBJECT = seobject.moduleRecords(store)
+
 		if object == "node":
 			OBJECT = seobject.nodeRecords(store)
 
@@ -355,6 +377,9 @@ Object-specific Options (see above):
 			if object == "interface":
 				OBJECT.add(target, serange, setype)
 
+			if object == "module":
+				OBJECT.add(target)
+
 			if object == "node":
 				OBJECT.add(target, mask, proto, serange, setype)
 
@@ -382,6 +407,14 @@ Object-specific Options (see above):
 			if object == "interface":
 				OBJECT.modify(target, serange, setype)
 
+			if object == "module":
+                                if enable:
+                                       OBJECT.enable(target)
+                                elif disable:
+                                       OBJECT.disable(target)
+                                else:
+                                       OBJECT.modify(target)
+
 			if object == "node":
 				OBJECT.modify(target, mask, proto, serange, setype)
 
diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 7c94da0..4d36660 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -233,6 +233,77 @@ class semanageRecords:
                self.transaction = False
                self.commit()
 
+class moduleRecords(semanageRecords):
+	def __init__(self, store):
+               semanageRecords.__init__(self, store)
+
+	def get_all(self):
+               l = []
+               (rc, mlist, number) = semanage_module_list(self.sh)
+               if rc < 0:
+                      raise ValueError(_("Could not list SELinux modules"))
+
+               for i in range(number):
+                      mod = semanage_module_list_nth(mlist, i)
+                      l.append((semanage_module_get_name(mod), semanage_module_get_version(mod), semanage_module_get_enabled(mod)))
+               return l
+
+	def list(self, heading = 1, locallist = 0):
+		if heading:
+			print "\n%-25s%-10s\n" % (_("Modules Name"), _("Version"))
+                for t in self.get_all():
+                       if t[2] == 0:
+                              disabled = _("Disabled")
+                       else:
+                              disabled = ""
+                       print "%-25s%-10s%s" % (t[0], t[1], disabled)
+
+	def add(self, file):
+               rc = semanage_module_install_file(self.sh, file);
+               if rc >= 0:
+                      self.commit()
+
+	def disable(self, module):
+               need_commit = False                      
+               for m in module.split():
+                      rc = semanage_module_disable(self.sh, m)
+                      if rc < 0 and rc != -3:
+                             raise ValueError(_("Could not disable module %s (remove failed)") % m)
+                      if rc != -3:
+                             need_commit = True 
+               if need_commit:
+                      self.commit()
+			
+	def enable(self, module):
+               need_commit = False                      
+               for m in module.split():
+                      rc = semanage_module_enable(self.sh, m)
+                      if rc < 0 and rc != -3:
+                             raise ValueError(_("Could not enable module %s (remove failed)") % m)
+                      if rc != -3:
+                             need_commit = True 
+               if need_commit:
+                      self.commit()
+
+	def modify(self, file):
+               rc = semanage_module_update_file(self.sh, file);
+               if rc >= 0:
+                      self.commit()
+
+	def delete(self, module):
+               for m in module.split():
+                      rc = semanage_module_remove(self.sh, m)
+                      if rc < 0 and rc != -2:
+                             raise ValueError(_("Could not remove module %s (remove failed)") % m)
+                      
+               self.commit()
+			
+	def deleteall(self):
+               l = self.get_all()
+               if len(l) > 0:
+                      all = " ".join(l[0])
+                      self.delete(all)
+
 class dontauditClass(semanageRecords):
 	def __init__(self, store):
                semanageRecords.__init__(self, store)

--------------030309000106090809070007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
