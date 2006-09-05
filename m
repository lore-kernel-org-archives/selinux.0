Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k85ISuol013728
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 14:28:56 -0400
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k85IS5N8023526
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 18:28:12 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k85ISlW4002393
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 14:28:47 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k85ISlid277038
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 14:28:47 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k85ISk1k001719
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 14:28:47 -0400
Received: from [9.12.242.64] ([9.12.242.64])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k85ISjuE001575
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 14:28:46 -0400
From: Rodrigo Vivi <vivijim@br.ibm.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: [PATCH] policycoreutils semanage for nodes
Date: Tue, 5 Sep 2006 15:27:40 -0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dGc/EqaLUXJJMKT"
Message-Id: <200609051527.41081.vivijim@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_dGc/EqaLUXJJMKT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

Since libsemanage support node context management and semanage command for 
policycoreutils does not, I thought that was a good idea to implement this.

This patch provide all that semanage command needs to manage nodes context.
(including a man page updated)

However I know that SECMARK mechanism largely obsoletes the use of
netif and node contexts going forward, but I did this patch because I was 
missing the node management at semanage command.

Thanks,
Rodrigo Vivi.
(vivijim at #selinux)

--Boundary-00=_dGc/EqaLUXJJMKT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="node.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="node.patch"

diff -ruN policycoreutils-1.30.26/semanage/semanage policycoreutils-dev/semanage/semanage
--- policycoreutils-1.30.26/semanage/semanage	2006-08-12 09:21:39.000000000 -0300
+++ policycoreutils-dev/semanage/semanage	2006-09-03 05:05:41.000000000 -0300
@@ -41,6 +41,7 @@
 semanage user -{a|d|m} [-LrRP] selinux_name\n\
 semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range\n\
 semanage interface -{a|d|m} [-tr] interface_spec\n\
+semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] addr\n\
 semanage fcontext -{a|d|m} [-frst] file_spec\n\
 semanage translation -{a|d|m} [-T] level\n\n\
 \
@@ -65,7 +66,8 @@
 		-l (symbolic link) \n\
 		-p (named pipe) \n\n\
 \
-	-p, --proto      Port protocol (tcp or udp)\n\
+	-p, --protocol   Port protocol (tcp or udp)\n\
+        -M, --mask       Netmask\n\
 	-P, --prefix     Prefix for home directory labeling\n\
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)\n\
 	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")\n\
@@ -94,7 +96,9 @@
 		valid_option["port"] = []
 		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--protocol' ] 
 		valid_option["interface"] = []
-		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range'] 
+		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range']
+                valid_option["node"] = []
+		valid_option["node"] += valid_everyone + [ '-M', '--mask', '-t', '--type', '-r', '--range', '-p', '--protocol' ]
 		valid_option["fcontext"] = []
 		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
 		valid_option["translation"] = []
@@ -110,6 +114,7 @@
 		serange = ""
 		port = ""
 		proto = ""
+                mask = ""
 		selevel = ""
 		setype = ""
 		ftype = ""
@@ -134,7 +139,7 @@
 		args = sys.argv[2:]
 
 		gopts, cmds = getopt.getopt(args,
-					    'adf:lhmnp:s:R:L:r:t:T:P:',
+					    'adf:lhmnp:s:R:L:r:t:T:P:M:',
 					    ['add',
 					     'delete',
 					     'ftype=',
@@ -149,7 +154,8 @@
 					     'roles=',
 					     'type=',
 					     'trans=',
-					     'prefix='
+					     'prefix=',
+                                             'mask='
 					     ])
 		for o, a in gopts:
 			if o not in option_dict[object]:
@@ -194,6 +200,9 @@
 			if o == "-p" or o == '--proto':
 				proto = a
 
+			if o == "-M" or o == '--mask':
+				mask = a
+
 			if o == "-P" or o == '--prefix':
 				prefix = a
 
@@ -220,6 +229,9 @@
 		
 		if object == "interface":
 			OBJECT = seobject.interfaceRecords()
+
+                if object == "node":
+			OBJECT = seobject.nodeRecords()
 		
 		if object == "fcontext":
 			OBJECT = seobject.fcontextRecords()
@@ -257,6 +269,9 @@
 			if object == "interface":
 				OBJECT.add(target, serange, setype)
 
+			if object == "node":
+				OBJECT.add(target, mask, proto, serange, setype)
+                                
 			if object == "fcontext":
 				OBJECT.add(target, setype, ftype, serange, seuser)
 			sys.exit(0);
@@ -278,6 +293,9 @@
 			if object == "interface":
 				OBJECT.modify(target, serange, setype)
 
+			if object == "node":
+				OBJECT.modify(target, mask, proto, serange, setype)
+
 			if object == "fcontext":
 				OBJECT.modify(target, setype, ftype, serange, seuser)
 
@@ -290,6 +308,9 @@
 			elif object == "fcontext":
 				OBJECT.delete(target, ftype)
 
+			elif object == "node":
+				OBJECT.delete(target, mask, proto)
+
 			else:
 				OBJECT.delete(target)
 
diff -ruN policycoreutils-1.30.26/semanage/semanage.8 policycoreutils-dev/semanage/semanage.8
--- policycoreutils-1.30.26/semanage/semanage.8	2006-08-12 09:21:39.000000000 -0300
+++ policycoreutils-dev/semanage/semanage.8	2006-09-05 15:12:44.000000000 -0300
@@ -3,7 +3,7 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage {login|user|port|interface|fcontext|translation} \-l [\-n]
+.B semanage {login|user|port|interface|node|fcontext|translation} \-l [\-n]
 .br
 .B semanage login \-{a|d|m} [\-sr] login_name
 .br
@@ -13,6 +13,8 @@
 .br
 .B semanage interface \-{a|d|m} [\-tr] interface_spec
 .br
+.B semanage node \-{a|d|m} [\-tr] [-M netmask] [-p protocol] address
+.br
 .B semanage fcontext \-{a|d|m} [\-frst] file_spec
 .br
 .B semanage translation \-{a|d|m} [\-T] level
@@ -93,6 +95,8 @@
 $ semanage fcontext -a -t httpd_sys_content_t '/web(/.*)?'
 # Allow Apache to listen on port 81
 $ semanage port -a -t http_port_t -p tcp 81
+# Add node context to 192.168.0.1 / 255.255.255.0
+$ semanage node -a -M 255.255.255.0 -t compat_ipv4_node_t 192.168.0.1
 .fi
 
 .SH "AUTHOR"
diff -ruN policycoreutils-1.30.26/semanage/seobject.py policycoreutils-dev/semanage/seobject.py
--- policycoreutils-1.30.26/semanage/seobject.py	2006-08-12 09:21:39.000000000 -0300
+++ policycoreutils-dev/semanage/seobject.py	2006-09-05 11:41:06.000000000 -0300
@@ -1002,6 +1002,213 @@
 		else:
 			for k in keys:
 				print "%-30s %s:%s:%s " % (k,ddict[k][0], ddict[k][1],ddict[k][2])
+
+class nodeRecords(semanageRecords):
+	def __init__(self):
+		semanageRecords.__init__(self)
+              
+	def add(self, addr, mask, proto, serange, ctype):
+		if addr == "":
+			raise ValueError(_("Node Address is required"))
+               
+		if mask == "":
+			raise ValueError(_("Node Netmask is required"))
+                
+		if proto == "":
+			proto = 0
+		else:
+			proto = int(proto)
+                
+		if is_mls_enabled == 1:
+			if serange == "":
+				serange = "s0"
+			else:
+				serange = untranslate(serange)
+
+		if ctype == "":
+			raise ValueError(_("SELinux Type is required"))
+
+		(rc,k) = semanage_node_key_create(self.sh, addr, mask, proto)
+		if rc < 0:
+			raise ValueError(_("Could not create key for %s") % addr)
+                (rc,exists) = semanage_node_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError(_("Could not check if addr %s is defined") % addr)
+		if exists:
+			raise ValueError(_("Addr %s already defined") % addr)
+
+		(rc,node) = semanage_node_create(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not create addr for %s") % addr)
+		
+		rc = semanage_node_set_addr(self.sh, node, proto, addr)
+		(rc, con) = semanage_context_create(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not create context for %s") % addr)
+
+                rc = semanage_node_set_mask(self.sh, node, proto, mask)
+		if rc < 0:
+			raise ValueError(_("Could not set mask for %s") % addr)
+    
+
+		rc = semanage_context_set_user(self.sh, con, "system_u")
+		if rc < 0:
+			raise ValueError(_("Could not set user in addr context for %s") % addr)
+
+		rc = semanage_context_set_role(self.sh, con, "object_r")
+		if rc < 0:
+			raise ValueError(_("Could not set role in addr context for %s") % addr)
+
+		rc = semanage_context_set_type(self.sh, con, ctype)
+		if rc < 0:
+			raise ValueError(_("Could not set type in addr context for %s") % addr)
+
+		if serange != "":
+			rc = semanage_context_set_mls(self.sh, con, serange)
+			if rc < 0:
+				raise ValueError(_("Could not set mls fields in addr context for %s") % addr)
+
+		rc = semanage_node_set_con(self.sh, node, con)
+		if rc < 0:
+			raise ValueError(_("Could not set addr context for %s") % addr)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not start semanage transaction"))
+
+                rc = semanage_node_modify_local(self.sh, k, node)
+		if rc < 0:
+			raise ValueError(_("Could not add addr %s") % addr)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not add addr %s") % addr)
+
+		semanage_context_free(con)
+		semanage_node_key_free(k)
+		semanage_node_free(node)
+
+	def modify(self, addr, mask, proto, serange, setype):
+		if addr == "":
+			raise ValueError(_("Node Address is required"))
+               
+		if mask == "":
+			raise ValueError(_("Node Netmask is required"))
+                
+		if proto == "":
+			proto = 0
+		else:
+			proto = int(proto)
+                      
+		if serange == "" and setype == "":
+			raise ValueError(_("Requires setype or serange"))
+
+		(rc,k) = semanage_node_key_create(self.sh, addr, mask, proto)
+		if rc < 0:
+			raise ValueError(_("Could not create key for %s") % addr)
+
+                (rc,exists) = semanage_node_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError(_("Could not check if addr %s is defined") % addr)
+		if not exists:
+			raise ValueError(_("Addr %s is not defined") % addr)
+	
+		(rc,node) = semanage_node_query(self.sh, k)
+		if rc < 0:
+			raise ValueError(_("Could not query addr %s") % addr)
+
+		con = semanage_node_get_con(node)
+			
+		if serange != "":
+			semanage_context_set_mls(self.sh, con, untranslate(serange))
+		if setype != "":
+			semanage_context_set_type(self.sh, con, setype)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not start semanage transaction"))
+
+		rc = semanage_node_modify_local(self.sh, k, node)
+		if rc < 0:
+			raise ValueError(_("Could not modify addr %s") % addr)
+		
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not modify addr %s") % addr)
+
+		semanage_node_key_free(k)
+		semanage_node_free(node)
+
+	def delete(self, addr, mask, proto):
+		if addr == "":
+			raise ValueError(_("Node Address is required"))
+               
+		if mask == "":
+			raise ValueError(_("Node Netmask is required"))
+                
+		if proto == "":
+			proto = 0
+		else:
+			proto = int(proto)
+ 
+		(rc,k) = semanage_node_key_create(self.sh, addr, mask, proto)
+		if rc < 0:
+			raise ValueError(_("Could not create key for %s") % addr)
+
+		(rc,exists) = semanage_node_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError(_("Could not check if addr %s is defined") % addr)
+		if not exists:
+			raise ValueError(_("Addr %s is not defined") % addr)
+
+		(rc,exists) = semanage_node_exists_local(self.sh, k)
+		if rc < 0:
+			raise ValueError(_("Could not check if addr %s is defined") % addr)
+		if not exists:
+			raise ValueError(_("Addr %s is defined in policy, cannot be deleted") % addr)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not start semanage transaction"))
+
+		rc = semanage_node_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError(_("Could not delete addr %s") % addr)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not delete addr %s") % addr)
+		
+		semanage_node_key_free(k)
+
+	def get_all(self):
+		ddict = {}
+		(rc, self.ilist) = semanage_node_list(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not list addrs"))
+
+		for node in self.ilist:
+			con = semanage_node_get_con(node)
+                        addr = semanage_node_get_addr(self.sh, node)
+                        mask = semanage_node_get_mask(self.sh, node)
+                        proto = semanage_node_get_proto(node)
+			ddict[(addr[1], mask[1], proto)] = (semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
+
+		return ddict
+			
+	def list(self, heading = 1):
+		if heading:
+			print "%-50s %s\n" % ("SELinux Addr", "Context")
+		ddict = self.get_all()
+		keys = ddict.keys()
+		keys.sort()
+		if is_mls_enabled:
+			for k in keys:
+				print "%-50s %s:%s:%s:%s " % (k,ddict[k][0], ddict[k][1],ddict[k][2], translate(ddict[k][3], False))
+		else:
+			for k in keys:
+				print "%-50s %s:%s:%s " % (k,ddict[k][0], ddict[k][1],ddict[k][2])
+
 			
 class fcontextRecords(semanageRecords):
 	def __init__(self):
@@ -1280,3 +1487,5 @@
 		for k in keys:
 			if ddict[k]:
 				print "%-50s %-18s " % (k[0], ddict[k][0])
+
+

--Boundary-00=_dGc/EqaLUXJJMKT--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
