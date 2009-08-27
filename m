Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7RLdZYP016019
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 17:39:35 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7RLd063025564
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 21:39:01 GMT
Message-ID: <4A96FD0F.6070000@redhat.com>
Date: Thu, 27 Aug 2009 17:39:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to semanage
References: <C6BC696A.AA1D4%csellers@tresys.com>
In-Reply-To: <C6BC696A.AA1D4%csellers@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------060300070501010501010607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060300070501010501010607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Redone to match man page and remove reload_policy.

--------------060300070501010501010607
Content-Type: text/plain;
 name="policycoreutils-dontaudit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-dontaudit.patch"

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index c4c957c..2285489 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -54,6 +54,7 @@ semanage fcontext -{a|d|m} [-frst] file_spec
 semanage translation -{a|d|m} [-T] level
 semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean | boolean_file
 semanage permissive -{d|a} type
+semanage dontaudit [ on | off ]
 
 Primary Options:
 
@@ -116,6 +117,7 @@ Object-specific Options (see above):
 		valid_option["node"] += valid_everyone + [ '-M', '--mask', '-t', '--type', '-r', '--range', '-p', '--protocol']
 		valid_option["fcontext"] = []
 		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
+		valid_option["dontaudit"] = [ '-S', '--store' ]
 		valid_option["translation"] = []
 		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
 		valid_option["boolean"] = []
@@ -346,6 +348,12 @@ Object-specific Options (see above):
                         
                 target = cmds[0]
 
+
+		if object == "dontaudit":
+			OBJECT = seobject.dontauditClass(store)
+                        OBJECT.toggle(target)
+                        return
+                              
 		if add:
 			if object == "login":
 				OBJECT.add(target, seuser, serange)
diff --git a/policycoreutils/semanage/semanage.8 b/policycoreutils/semanage/semanage.8
index d0726cf..d83e94e 100644
--- a/policycoreutils/semanage/semanage.8
+++ b/policycoreutils/semanage/semanage.8
@@ -21,6 +21,8 @@ semanage \- SELinux Policy Management tool
 .br
 .B semanage permissive \-{a|d} type
 .br
+.B semanage dontaudit [ on | off ]
+.br
 .B semanage translation \-{a|d|m} [\-T] level
 .P
 
@@ -117,6 +119,8 @@ $ semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
 $ semanage port -a -t http_port_t -p tcp 81
 # Change apache to a permissive domain
 $ semanage permissive -a httpd_t
+# Turn off dontaudit rules
+$ semanage dontaudit off
 .fi
 
 .SH "AUTHOR"
diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 20bd205..bc329e1 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -314,6 +314,17 @@ class semanageRecords:
                self.transaction = False
                self.commit()
 
+class dontauditClass(semanageRecords):
+	def __init__(self, store):
+               semanageRecords.__init__(self, store)
+
+	def toggle(self, dontaudit):
+               if dontaudit not in [ "on", "off" ]:
+                      raise ValueError(_("dontaudit requires either 'on' or 'off'"))
+               self.begin()
+               rc = semanage_set_disable_dontaudit(self.sh, dontaudit == "off")
+               self.commit()
+               
 class permissiveRecords(semanageRecords):
 	def __init__(self, store):
                semanageRecords.__init__(self, store)

--------------060300070501010501010607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
