Message-ID: <486BD1B6.5080908@manicmethod.com>
Date: Wed, 02 Jul 2008 15:06:30 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: This patch adds permissive to semanage
References: <4869037D.5040208@redhat.com>  <48691EB3.30706@manicmethod.com>	 <1215000045.22447.252.camel@moss-spartans.epoch.ncsc.mil>	 <486B7E03.1060304@manicmethod.com>	 <1215004621.22447.273.camel@moss-spartans.epoch.ncsc.mil>	 <486B848B.4020607@manicmethod.com> <1215008940.22447.275.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1215008940.22447.275.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2008-07-02 at 09:37 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Wed, 2008-07-02 at 09:09 -0400, Joshua Brindle wrote:
>>>> Stephen Smalley wrote:
>>>>> On Mon, 2008-06-30 at 13:58 -0400, Joshua Brindle wrote:
>>>>>> Daniel J Walsh wrote:
>>>>>>> Gives users the ability to set a domain as permissive
>>>>>>>
>>>>>>>
>>>>>>> semanage permissive -a http_t
>>>>>>>
>>>>>>> It created a policy module named permissive_httpd_t.pp with the
>>>>>>> permissive call.
>>>>>>>
>>>>>> So, a really quick glance brings up a couple issues. First you have '-n', '--noheading' which aren't documented in the man page or elsewhere. Second (and more importantly) why are you executing semodule like that? libsemanage is the library that manages modules, and also the library used by semanage for everything else. 
>>>>>>
>>>>>> I would prefer a more 'pure' approach where we keep a list of
>>>>>> permissive types and inject them into the kernel policy after linking
>>>>>> (like libsemanage does with users, ports, nodes, etc) but I understand
>>>>>> that adding a whole new set of databases and interfaces is both
>>>>>> annoying and time consuming so I'm fine with it working on modules,
>>>>>> I'd just like to see it using libsemanage interfaces instead of
>>>>>> calling semodule.
>>>>> Why do you see direct use of the libsemanage interfaces as preferable to
>>>>> invoking semodule (aside from performance, and this isn't really
>>>>> performance critical)?
>>>>>
>>>>> I'm unclear on the tradeoff being made there, as composing small
>>>>> programs together to perform more complex operation is the Unix (tm)
>>>>> way ;)
>>>>>
>>>>> The advantage of just invoking semodule is that semodule is already a
>>>>> well-tested program that performs that function well, does proper error
>>>>> checking and handling of the various libsemanage calls, etc.  And if we
>>>>> later fix a bug or introduce new functionality there, we only have to do
>>>>> it once vs. in multiple places.
>>>>>
>>>>> And the semanage permissive code already has to invoke a helper program
>>>>> to compile the policy module from source to binary, at least today, so
>>>>> it isn't much different to invoke semodule to install the binary module.
>>>>>
>>>>> Then there is the issue of being able to run the semodule stage of
>>>>> processing in a separate domain, although at present semanage and
>>>>> semodule operate in the same domain so it makes no difference at
>>>>> present.
>>>>>
>>>> Maybe its just personal preference but I see using library interfaces
>>>> as much more clean than invoking semodule and grepping. semanage
>>>> already uses the library interfaces for everything else so this would
>>>> be the one case where it doesn't. He already fixed it up to use the
>>>> interfaces so its moot at this point. 
>>> Well, it doesn't have to be moot - we can always take the first
>>> implementation if we think it best.  But I'm not fundamentally opposed
>>> to the latter approach, just wanted to explore the rationale.  One thing
>>> I would note however is that I see lack of complete error return
>>> checking in the new code that would have been properly checked by
>>> semodule...
>>>
>> I'll fix the error checking in the second patch if you are fine with it otherwise. I just think the library is there for a reason, if we didn't want client programs using it we should have just built it into the application code. Feel free to veto me here if my rationale is weak (as it likely is).
>>
>> Maybe deep down inside I'm just not a unix programmer ;)
> 
> Ok, that's fine with me.
> 
> Maybe my own bias is just against python code compared to good olde C
> programs!
> 

Updated patch, unrelated things removed and error checking paths fixed up.

-----

Index: policycoreutils/semanage/semanage
===================================================================
--- policycoreutils/semanage/semanage	(revision 2920)
+++ policycoreutils/semanage/semanage	(working copy)
@@ -52,6 +52,7 @@
 semanage fcontext -{a|d|m} [-frst] file_spec
 semanage translation -{a|d|m} [-T] level
 semanage boolean -{d|m} boolean
+semanage permissive -{d|a} type
 
 Primary Options:
 
@@ -114,6 +115,8 @@
 		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
 		valid_option["boolean"] = []
 		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0" ] 
+		valid_option["permissive"] = []
+		valid_option["permissive"] += [ '-a', '--add', '-d', '--delete', '-l', '--list', '-h', '--help', '-n', '--noheading', '-D', '--deleteall' ]
 		return valid_option
 
 	#
@@ -268,6 +271,9 @@
 		if object == "translation":
 			OBJECT = seobject.setransRecords()
 		
+		if object == "permissive":
+			OBJECT = seobject.permissiveRecords(store)
+		
 		if list:
 			OBJECT.list(heading, locallist)
 			sys.exit(0);
@@ -304,6 +310,9 @@
 
 			if object == "fcontext":
 				OBJECT.add(target, setype, ftype, serange, seuser)
+			if object == "permissive":
+				OBJECT.add(target)
+
 			sys.exit(0);
 			
 		if modify:
Index: policycoreutils/semanage/seobject.py
===================================================================
--- policycoreutils/semanage/seobject.py	(revision 2917)
+++ policycoreutils/semanage/seobject.py	(working copy)
@@ -1,5 +1,5 @@
 #! /usr/bin/python -E
-# Copyright (C) 2005, 2006, 2007 Red Hat 
+# Copyright (C) 2005, 2006, 2007, 2008 Red Hat 
 # see file 'COPYING' for use and warranty information
 #
 # semanage is a tool for managing SELinux configuration files
@@ -24,7 +24,9 @@
 import pwd, string, selinux, tempfile, os, re, sys
 from semanage import *;
 PROGNAME="policycoreutils"
+import sepolgen.module as module
 
+import commands
 import gettext
 gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
 gettext.textdomain(PROGNAME)
@@ -246,7 +248,108 @@
 		os.close(fd)
 		os.rename(newfilename, self.filename)
                 os.system("/sbin/service mcstrans reload > /dev/null")
-                
+
+class permissiveRecords:
+	def __init__(self, store):
+               self.store = store
+               self.sh = semanage_handle_create()
+               if not self.sh:
+                      raise ValueError(_("Could not create semanage handle"))
+               
+               if store != "":
+                      semanage_select_store(self.sh, store, SEMANAGE_CON_DIRECT);
+                      
+               self.semanaged = semanage_is_managed(self.sh)
+               
+               if not self.semanaged:
+                      semanage_handle_destroy(self.sh)
+                      raise ValueError(_("SELinux policy is not managed or store cannot be accessed."))
+
+               rc = semanage_access_check(self.sh)
+               if rc < SEMANAGE_CAN_READ:
+                      semanage_handle_destroy(self.sh)
+                      raise ValueError(_("Cannot read policy store."))
+
+               rc = semanage_connect(self.sh)
+               if rc < 0:
+                      semanage_handle_destroy(self.sh)
+                      raise ValueError(_("Could not establish semanage connection"))
+
+	def get_all(self):
+               l = []
+               (rc, mlist, number) = semanage_module_list(self.sh)
+               if rc < 0:
+                      raise ValueError(_("Could not list SELinux modules"))
+
+               for i in range(number):
+                      mod = semanage_module_list_nth(mlist, i)
+                      name = semanage_module_get_name(mod)
+                      if name and name.startswith("permissive_"):
+                             l.append(name.split("permissive_")[1])
+               return l
+
+	def list(self,heading = 1, locallist = 0):
+		if heading:
+			print "\n%-25s\n" % (_("Permissive Types"))
+                for t in self.get_all():
+                       print t
+
+
+	def add(self, type):
+               name = "permissive_%s" % type
+               dirname = "/var/lib/selinux"
+               os.chdir(dirname)
+               filename = "%s.te" % name
+               modtxt = """
+module %s 1.0;
+
+require {
+          type %s;
+}
+
+permissive %s;
+""" % (name, type, type)
+               fd = open(filename,'w')
+               fd.write(modtxt)
+               fd.close()
+               mc = module.ModuleCompiler()
+               mc.create_module_package(filename, 1)
+               fd = open("permissive_%s.pp" % type)
+               data = fd.read()
+               fd.close()
+
+               rc = semanage_module_install(self.sh, data, len(data));
+               if rc < 0:
+			raise ValueError(_("Could not set permissive domain %s (module installation failed)") % name)
+               rc = semanage_commit(self.sh)
+               if rc < 0:
+			raise ValueError(_("Could not set permissive domain %s (commit failed)") % name)
+               for root, dirs, files in os.walk("tmp", topdown=False):
+                      for name in files:
+                             os.remove(os.path.join(root, name))
+                      for name in dirs:
+                             os.rmdir(os.path.join(root, name))
+
+               if rc != 0:
+                      raise ValueError(out)			
+
+
+	def delete(self, name):
+		for n in name.split():
+			rc = semanage_module_remove(self.sh, "permissive_%s" % n)
+			if rc < 0:
+	                        raise ValueError(_("Could not remove permissive domain %s (remove failed)") % name)
+               rc = semanage_commit(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not remove permissive domain %s (commit failed)") % name)
+			
+
+	def deleteall(self):
+               l = self.get_all()
+               if len(l) > 0:
+                      all = " ".join(l)
+                      self.delete(all)
+
 class semanageRecords:
 	def __init__(self, store):
 		self.sh = semanage_handle_create()
Index: policycoreutils/semanage/semanage.8
===================================================================
--- policycoreutils/semanage/semanage.8	(revision 2917)
+++ policycoreutils/semanage/semanage.8	(working copy)
@@ -17,6 +17,8 @@
 .br
 .B semanage fcontext \-{a|d|m} [\-frst] file_spec
 .br
+.B semanage permissive \-{a|d} type
+.br
 .B semanage translation \-{a|d|m} [\-T] level
 .P
 
@@ -101,10 +103,11 @@
 $ semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
 # Allow Apache to listen on port 81
 $ semanage port -a -t http_port_t -p tcp 81
+# Change apache to a permissive domain
+$ semanage permissive -a http_t
 .fi
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com> and
 Russell Coker <rcoker@redhat.com>.
 Examples by Thomas Bleher <ThomasBleher@gmx.de>.
-


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
