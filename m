Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3EB9iNb025178
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 07:09:46 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3EB9MZb002814
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 11:09:28 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A8A0461B08
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 21:09:01 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 22332-09 for <selinux@tycho.nsa.gov>;
	Fri, 14 Apr 2006 21:09:01 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A17A661B06
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 21:08:58 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: semanage patch
Date: Fri, 14 Apr 2006 21:08:25 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sK4PEZul86A1LPG"
Message-Id: <200604142108.28814.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_sK4PEZul86A1LPG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch against the semanage utility in rawhide allows it to create 
and modify prefixes.

Also when testing semanage I noticed that it let me remove a SE Linux user 
when a login still referred to it.  After doing so it then wouldn't let me 
recreate the user (with a confusing error message).  But as that bug didn't 
stop me from doing my work I haven't taken the time to fix it.

As the complexity of the semanage utility continues to increase I think that 
we need to split it into separate programs selogin, seuser, seport, 
seinterface, sefcontext, and setranslation.  This will make the man page 
easier to understand and generally increase ease of use.  It will also allow 
shell command-completion to do more of the work for the sysadmin.  What do 
you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_sK4PEZul86A1LPG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- seobject.py	2006-04-14 20:36:08.000000000 +1000
+++ /usr/lib/python2.4/site-packages/seobject.py	2006-04-14 20:56:04.000000000 +1000
@@ -381,7 +381,7 @@
 	def __init__(self):
 		semanageRecords.__init__(self)
 
-	def add(self, name, roles, selevel, serange):
+	def add(self, name, roles, selevel, serange, prefix):
 		if is_mls_enabled == 1:
 			if serange == "":
 				serange = "s0"
@@ -427,6 +427,9 @@
 				if rc < 0:
 					raise ValueError("Could not set MLS level for %s" % name)
 
+			rc = semanage_user_set_prefix(self.sh, u, prefix)
+			if rc < 0:
+				raise ValueError("Could not add prefix %s for %s" % (r, prefix))
 			(rc,key) = semanage_user_key_extract(self.sh,u)
 			if rc < 0:
 				raise ValueError("Could not extract key for %s" % name)
@@ -451,13 +454,13 @@
 		semanage_user_key_free(k)
 		semanage_user_free(u)
 
-	def modify(self, name, roles = [], selevel = "", serange = ""):
+	def modify(self, name, roles = [], selevel = "", serange = "", prefix = ""):
 		try:
-			if len(roles) == 0  and serange == "" and selevel == "":
+			if prefix == "" and len(roles) == 0  and serange == "" and selevel == "":
 				if is_mls_enabled == 1:
-					raise ValueError("Requires roles, level or range")
+					raise ValueError("Requires prefix, roles, level or range")
 				else:
-					raise ValueError("Requires roles")
+					raise ValueError("Requires prefix or roles")
 
 			(rc,k) = semanage_user_key_create(self.sh, name)
 			if rc < 0:
@@ -478,6 +481,9 @@
 			if selevel != "":
 				semanage_user_set_mlslevel(self.sh, u, untranslate(selevel))
 
+			if prefix != "":
+				semanage_user_set_prefix(self.sh, u, prefix)
+
 			if len(roles) != 0:
 				for r in roles:
 					semanage_user_add_role(self.sh, u, r)
--- semanage	2006-04-14 20:46:23.000000000 +1000
+++ /usr/sbin/semanage	2006-04-14 20:56:56.000000000 +1000
@@ -32,7 +32,7 @@
 		print '\
 semanage {login|user|port|interface|fcontext|translation} -l [-n] \n\
 semanage login -{a|d|m} [-sr] login_name\n\
-semanage user -{a|d|m} [-LrR] selinux_name\n\
+semanage user -{a|d|m} [-LrRP] selinux_name\n\
 semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range\n\
 semanage interface -{a|d|m} [-tr] interface_spec\n\
 semanage fcontext -{a|d|m} [-frst] file_spec\n\
@@ -60,6 +60,7 @@
 		-p (named pipe) \n\n\
 \
 	-p, --proto      Port protocol (tcp or udp)\n\
+	-P, --prefix     Prefix for home directory labeling\n\
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)\n\
 	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")\n\
 	-T, --trans      SELinux Level Translation (MLS/MCS Systems only)\n\n\
@@ -83,7 +84,7 @@
 		valid_option["login"] = []
 		valid_option["login"] += valid_everyone + [ '-s', '--seuser', '-r', '--range']
 		valid_option["user"] = []
-		valid_option["user"] += valid_everyone + [ '-L', '--level', '-r', '--range', '-R', '--roles' ] 
+		valid_option["user"] += valid_everyone + [ '-L', '--level', '-r', '--range', '-R', '--roles', '-P', '--prefix' ] 
 		valid_option["port"] = []
 		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--protocol' ] 
 		valid_option["interface"] = []
@@ -109,6 +110,7 @@
 		setrans = ""
 		roles = ""
 		seuser = ""
+		prefix = ""
 		heading=1
 
 		add = 0
@@ -126,7 +128,7 @@
 		args = sys.argv[2:]
 
 		gopts, cmds = getopt.getopt(args,
-					    'adf:lhmnp:s:R:L:r:t:T:',
+					    'adf:lhmnp:s:R:L:r:t:T:P:',
 					    ['add',
 					     'delete',
 					     'ftype=',
@@ -140,7 +142,8 @@
 					     'level=',
 					     'roles=',
 					     'type=',
-					     'trans='
+					     'trans=',
+					     'prefix='
 					     ])
 		for o, a in gopts:
 			if o not in option_dict[object]:
@@ -185,6 +188,9 @@
 			if o == "-p" or o == '--proto':
 				proto = a
 
+			if o == "-P" or o == '--prefix':
+				prefix = a
+
 			if o == "-R" or o == '--roles':
 				roles = roles + " " + a
 
@@ -235,7 +241,7 @@
 				rlist = roles.split()
 				if len(rlist) == 0:
 					raise ValueError("You must specify a role")
-				OBJECT.add(target, rlist, selevel, serange)
+				OBJECT.add(target, rlist, selevel, serange, prefix)
 
 			if object == "port":
 				OBJECT.add(target, proto, serange, setype)

--Boundary-00=_sK4PEZul86A1LPG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
