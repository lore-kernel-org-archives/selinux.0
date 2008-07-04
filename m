Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m648B8cY020069
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2008 04:11:08 -0400
Received: from ikarus.tarent.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m648B6ml022442
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2008 08:11:06 GMT
Message-ID: <486DDAF3.8000300@tarent.de>
Date: Fri, 04 Jul 2008 10:10:27 +0200
From: Christian Kuester <c.kuester@tarent.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: c.kuester@tarent.de, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Adding local nodecon's through semanage
References: <486CD88E.2000406@tarent.de>	 <200807031032.57875.paul.moore@hp.com>	 <1215101787.22447.461.camel@moss-spartans.epoch.ncsc.mil>	 <200807031245.46905.paul.moore@hp.com> <1215104465.22447.480.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1215104465.22447.480.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------000803040806040901010704"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000803040806040901010704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Stephen Smalley schrieb:

Hi List,

> On Thu, 2008-07-03 at 12:45 -0400, Paul Moore wrote: 
>>> Christian - do you have a re-based copy of the patch against the svn
>>> trunk that you were testing with?
>> Christian, if you do have an updated/re-based patch, would you mind 
>> posting it?

I only tried the old patch against policycoreutils 1.32, but I did some
effort into making it apply against the SVN trunk. I did not had the
time to do the man page fix which was included in the original version
of the patch.

Re-based patch is attached.


Christian





-- 
tarent Gesellschaft für Softwareentwicklung und IT-Beratung mbH

Heilsbachstr. 24, 53123 Bonn  | Poststr. 4-5, 10178 Berlin
fon: +49(228) / 52675-0       | fon: +49(30) / 27594853
fax: +49(228) / 52675-25      | fax: +49(30) / 78709617

Geschäftsführer
Boris Esser, Elmar Geese
HRB AG Bonn 5168
Ust-ID: DE122264941

--------------000803040806040901010704
Content-Type: text/x-diff;
 name="semanage-svn.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage-svn.patch"

diff -r -u semanage.orig/semanage semanage/semanage
--- semanage.orig/semanage	2008-07-04 08:34:12.000000000 +0200
+++ semanage/semanage	2008-07-04 08:36:58.000000000 +0200
@@ -49,6 +49,7 @@
 semanage user -{a|d|m} [-LrRP] selinux_name
 semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
 semanage interface -{a|d|m} [-tr] interface_spec
+semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] addr\n\
 semanage fcontext -{a|d|m} [-frst] file_spec
 semanage translation -{a|d|m} [-T] level
 semanage boolean -{d|m} boolean
@@ -80,6 +81,7 @@
 		-p (named pipe) 
 
 	-p, --proto      Port protocol (tcp or udp)
+	-M, --mask       Netmask\n\
 	-P, --prefix     Prefix for home directory labeling
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)
 	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")
@@ -109,6 +111,8 @@
 		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--proto' ]
 		valid_option["interface"] = []
 		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range'] 
+		valid_option["node"] = []
+		valid_option["node"] += valid_everyone + [ '-M', '--mask', '-t', '--type', '-r', '--range', '-p', '--protocol' ]
 		valid_option["fcontext"] = []
 		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
 		valid_option["translation"] = []
@@ -128,6 +132,7 @@
 		serange = ""
 		port = ""
 		proto = ""
+		maske = ""
 		selevel = ""
 		setype = ""
 		ftype = ""
@@ -155,7 +160,7 @@
 		args = sys.argv[2:]
 
 		gopts, cmds = getopt.getopt(args,
-					    '01adf:lhmnp:s:CDR:L:r:t:T:P:S:',
+				'01adf:lhmnp:s:CDR:L:r:t:T:P:S:M:',
 					    ['add',
 					     'delete',
 					     'deleteall',
@@ -175,7 +180,8 @@
 					     'roles=',
 					     'type=',
 					     'trans=',
-					     'prefix='
+					     'prefix=',
+					     'mask='
 					     ])
 		for o, a in gopts:
 			if o not in option_dict[object]:
@@ -230,6 +236,9 @@
 			if o == "-p" or o == '--proto':
 				proto = a
 
+			if o == "-M" or o == '--mask':
+				mask = a
+
 			if o == "-P" or o == '--prefix':
 				prefix = a
 
@@ -261,6 +270,9 @@
 		
 		if object == "interface":
 			OBJECT = seobject.interfaceRecords(store)
+
+		if object == "node":
+			OBJECT = seobject.nodeRecords(store)
 		
 		if object == "fcontext":
 			OBJECT = seobject.fcontextRecords(store)
@@ -308,6 +320,9 @@
 			if object == "interface":
 				OBJECT.add(target, serange, setype)
 
+			if object == "node":
+				OBJECT.add(target, mask, proto, serange, setype)
+
 			if object == "fcontext":
 				OBJECT.add(target, setype, ftype, serange, seuser)
 			if object == "permissive":
@@ -335,6 +350,9 @@
 			if object == "interface":
 				OBJECT.modify(target, serange, setype)
 
+			if object == "node":
+				OBJECT.modify(target, mask, proto, serange, setype)
+
 			if object == "fcontext":
 				OBJECT.modify(target, setype, ftype, serange, seuser)
 
@@ -347,6 +365,9 @@
 			elif object == "fcontext":
 				OBJECT.delete(target, ftype)
 
+			elif object == "node":
+				OBJECT.delete(target, mask, proto)
+
 			else:
 				OBJECT.delete(target)
 
diff -r -u semanage.orig/seobject.py semanage/seobject.py
--- semanage.orig/seobject.py	2008-07-04 08:34:12.000000000 +0200
+++ semanage/seobject.py	2008-07-04 08:36:58.000000000 +0200
@@ -339,8 +339,8 @@
 			rc = semanage_module_remove(self.sh, "permissive_%s" % n)
 			if rc < 0:
 	                        raise ValueError(_("Could not remove permissive domain %s (remove failed)") % name)
-               rc = semanage_commit(self.sh)
-               if rc < 0:
+		rc = semanage_commit(self.sh)		
+		if rc < 0:
                        raise ValueError(_("Could not remove permissive domain %s (commit failed)") % name)
 			
 
@@ -1202,7 +1202,216 @@
 		else:
 			for k in keys:
 				print "%-30s %s:%s:%s " % (k,ddict[k][0], ddict[k][1],ddict[k][2])
-			
+
+
+class nodeRecords(semanageRecords):
+       def __init__(self, store = ""):
+               semanageRecords.__init__(self,store)
+              
+       def add(self, addr, mask, proto, serange, ctype):
+               if addr == "":
+                       raise ValueError(_("Node Address is required"))
+               
+               if mask == "":
+                       raise ValueError(_("Node Netmask is required"))
+                
+               if proto == "":
+                       proto = 0
+               else:
+                       proto = int(proto)
+                
+               if is_mls_enabled == 1:
+                       if serange == "":
+                               serange = "s0"
+                       else:
+                               serange = untranslate(serange)
+
+               if ctype == "":
+                       raise ValueError(_("SELinux Type is required"))
+
+               (rc,k) = semanage_node_key_create(self.sh, addr, mask, proto)
+               if rc < 0:
+                       raise ValueError(_("Could not create key for %s") % addr)
+               if rc < 0:
+                       raise ValueError(_("Could not check if addr %s is defined") % addr)
+
+               (rc,exists) = semanage_node_exists(self.sh, k)
+	       if exists:
+                       raise ValueError(_("Addr %s already defined") % addr)
+
+               (rc,node) = semanage_node_create(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not create addr for %s") % addr)
+               
+               rc = semanage_node_set_addr(self.sh, node, proto, addr)
+               (rc, con) = semanage_context_create(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not create context for %s") % addr)
+
+               rc = semanage_node_set_mask(self.sh, node, proto, mask)
+               if rc < 0:
+                       raise ValueError(_("Could not set mask for %s") % addr)
+    
+
+               rc = semanage_context_set_user(self.sh, con, "system_u")
+               if rc < 0:
+                       raise ValueError(_("Could not set user in addr context for %s") % addr)
+
+               rc = semanage_context_set_role(self.sh, con, "object_r")
+               if rc < 0:
+                       raise ValueError(_("Could not set role in addr context for %s") % addr)
+
+               rc = semanage_context_set_type(self.sh, con, ctype)
+               if rc < 0:
+                       raise ValueError(_("Could not set type in addr context for %s") % addr)
+
+               if serange != "":
+                       rc = semanage_context_set_mls(self.sh, con, serange)
+                       if rc < 0:
+                               raise ValueError(_("Could not set mls fields in addr context for %s") % addr)
+
+               rc = semanage_node_set_con(self.sh, node, con)
+               if rc < 0:
+                       raise ValueError(_("Could not set addr context for %s") % addr)
+
+               rc = semanage_begin_transaction(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not start semanage transaction"))
+
+               rc = semanage_node_modify_local(self.sh, k, node)
+               if rc < 0:
+                       raise ValueError(_("Could not add addr %s") % addr)
+
+               rc = semanage_commit(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not add addr %s") % addr)
+
+               semanage_context_free(con)
+               semanage_node_key_free(k)
+               semanage_node_free(node)
+
+       def modify(self, addr, mask, proto, serange, setype):
+               if addr == "":
+                       raise ValueError(_("Node Address is required"))
+               
+               if mask == "":
+                       raise ValueError(_("Node Netmask is required"))
+                
+               if proto == "":
+                       proto = 0
+               else:
+                       proto = int(proto)
+                      
+               if serange == "" and setype == "":
+                       raise ValueError(_("Requires setype or serange"))
+
+               (rc,k) = semanage_node_key_create(self.sh, addr, mask, proto)
+               if rc < 0:
+                       raise ValueError(_("Could not create key for %s") % addr)
+
+               (rc,exists) = semanage_node_exists(self.sh, k)
+               if rc < 0:
+                       raise ValueError(_("Could not check if addr %s is defined") % addr)
+               if not exists:
+                       raise ValueError(_("Addr %s is not defined") % addr)
+       
+               (rc,node) = semanage_node_query(self.sh, k)
+               if rc < 0:
+                       raise ValueError(_("Could not query addr %s") % addr)
+
+               con = semanage_node_get_con(node)
+                       
+               if serange != "":
+                       semanage_context_set_mls(self.sh, con, untranslate(serange))
+               if setype != "":
+                       semanage_context_set_type(self.sh, con, setype)
+
+               rc = semanage_begin_transaction(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not start semanage transaction"))
+
+               rc = semanage_node_modify_local(self.sh, k, node)
+               if rc < 0:
+                       raise ValueError(_("Could not modify addr %s") % addr)
+               
+               rc = semanage_commit(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not modify addr %s") % addr)
+
+               semanage_node_key_free(k)
+               semanage_node_free(node)
+
+       def delete(self, addr, mask, proto):
+               if addr == "":
+                       raise ValueError(_("Node Address is required"))
+               
+               if mask == "":
+                       raise ValueError(_("Node Netmask is required"))
+                
+               if proto == "":
+                       proto = 0
+               else:
+                       proto = int(proto)
+ 
+               (rc,k) = semanage_node_key_create(self.sh, addr, mask, proto)
+               if rc < 0:
+                       raise ValueError(_("Could not create key for %s") % addr)
+
+               (rc,exists) = semanage_node_exists(self.sh, k)
+               if rc < 0:
+                       raise ValueError(_("Could not check if addr %s is defined") % addr)
+               if not exists:
+                       raise ValueError(_("Addr %s is not defined") % addr)
+
+               (rc,exists) = semanage_node_exists_local(self.sh, k)
+               if rc < 0:
+                       raise ValueError(_("Could not check if addr %s is defined") % addr)
+               if not exists:
+                       raise ValueError(_("Addr %s is defined in policy, cannot be deleted") % addr)
+
+               rc = semanage_begin_transaction(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not start semanage transaction"))
+
+               rc = semanage_node_del_local(self.sh, k)
+               if rc < 0:
+                       raise ValueError(_("Could not delete addr %s") % addr)
+
+               rc = semanage_commit(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not delete addr %s") % addr)
+               
+               semanage_node_key_free(k)
+
+       def get_all(self):
+               ddict = {}
+               (rc, self.ilist) = semanage_node_list(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not list addrs"))
+
+               for node in self.ilist:
+                       con = semanage_node_get_con(node)
+                       addr = semanage_node_get_addr(self.sh, node)
+                       mask = semanage_node_get_mask(self.sh, node)
+                       proto = semanage_node_get_proto(node)
+                       ddict[(addr[1], mask[1], proto)] = (semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
+
+               return ddict
+                       
+       def list(self, heading = 1):
+               if heading:
+                       print "%-50s %s\n" % ("SELinux Addr", "Context")
+               ddict = self.get_all()
+               keys = ddict.keys()
+               keys.sort()
+               if is_mls_enabled:
+                       for k in keys:
+                               print "%-50s %s:%s:%s:%s " % (k,ddict[k][0], ddict[k][1],ddict[k][2], translate(ddict[k][3], False))
+               else:
+                       for k in keys:
+                               print "%-50s %s:%s:%s " % (k,ddict[k][0], ddict[k][1],ddict[k][2])
+
+
 class fcontextRecords(semanageRecords):
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)

--------------000803040806040901010704--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
