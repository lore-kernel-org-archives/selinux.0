Message-ID: <48A3DF80.4060905@tarent.de>
Date: Thu, 14 Aug 2008 09:32:16 +0200
From: Christian Kuester <c.kuester@tarent.de>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Paul Moore <paul.moore@hp.com>
Subject: [PATCH] Revised Patch for local nodecon support in semanage (was:
 Adding local nodecon's through semanage)
References: <486CD88E.2000406@tarent.de>	 <1215450682.27975.108.camel@moss-spartans.epoch.ncsc.mil>	 <48733DCF.3000808@tarent.de>	 <1215520245.27975.231.camel@moss-spartans.epoch.ncsc.mil> <1217333603.20373.158.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217333603.20373.158.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------020402050201030408090608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020402050201030408090608
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Stephen Smalley schrieb:

Hi List,

> On Tue, 2008-07-08 at 08:30 -0400, Stephen Smalley wrote:
>> On Tue, 2008-07-08 at 12:13 +0200, Christian Kuester wrote:
>>>> Other tidbits on the semanage patch that I noticed:
>>>> - semanage node -l was broken, requires additional argument that has
>>>> been added to the list methods subsequently.  Also would be nice to
>>>> support locallist/-C option.
>>>> - semanage node -p option should take a string rather than an integer
>>>> and map it to the proper symbolic constant for ipv4/ipv6.
>> Please be sure to test each of the nodeRecords methods.
> Are you still pursuing getting this cleaned up and merged?

Sorry, it took some time. The revised patch for nodecon support in
the semanage tool is attached.

It now takes strings as arguments for the ip protocol. list/locallist
work as expected and output is more readable. I also made changes for
the semanage.8 man page.


Kind Regards,
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

--------------020402050201030408090608
Content-Type: text/x-diff;
 name="semanage-patch-revised.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage-patch-revised.patch"

diff -u -r semanage/semanage semanage-new/semanage
--- semanage/semanage	2008-08-13 17:50:41.000000000 +0200
+++ semanage-new/semanage	2008-08-14 09:14:57.000000000 +0200
@@ -44,11 +44,12 @@
 
 	def usage(message = ""):
 		print _("""
-semanage {boolean|login|user|port|interface|fcontext|translation} -{l|D} [-n] 
+semanage {boolean|login|user|port|interface|node|fcontext|translation} -{l|D} [-n] 
 semanage login -{a|d|m} [-sr] login_name | %groupname
 semanage user -{a|d|m} [-LrRP] selinux_name
 semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
 semanage interface -{a|d|m} [-tr] interface_spec
+semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] addr
 semanage fcontext -{a|d|m} [-frst] file_spec
 semanage translation -{a|d|m} [-T] level
 semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean | boolean_file
@@ -80,7 +81,8 @@
 		-p (named pipe) 
 
         -F, --file       Treat target as an input file for command, change multiple settings
-	-p, --proto      Port protocol (tcp or udp)
+	-p, --proto      Port protocol (tcp or udp) or internet protocol version of node (ipv4 or ipv6)
+	-M, --mask       Netmask
 	-P, --prefix     Prefix for home directory labeling
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)
 	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")
@@ -109,7 +111,9 @@
 		valid_option["port"] = []
 		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--proto' ]
 		valid_option["interface"] = []
-		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range'] 
+		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range']
+		valid_option["node"] = []
+		valid_option["node"] += valid_everyone + [ '-M', '--mask', '-t', '--type', '-r', '--range', '-p', '--protocol']
 		valid_option["fcontext"] = []
 		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
 		valid_option["translation"] = []
@@ -129,6 +133,7 @@
 		serange = ""
 		port = ""
 		proto = ""
+		mask = ""
 		selevel = ""
 		setype = ""
 		ftype = ""
@@ -157,7 +162,7 @@
 		args = sys.argv[2:]
 
 		gopts, cmds = getopt.getopt(args,
-					    '01adf:lhmnp:s:FCDR:L:r:t:T:P:S:',
+					    '01adf:lhmnp:s:FCDR:L:r:t:T:P:S:M:',
 					    ['add',
 					     'delete',
 					     'deleteall',
@@ -178,7 +183,8 @@
 					     'roles=',
 					     'type=',
 					     'trans=',
-					     'prefix='
+					     'prefix=',
+                         'mask='
 					     ])
 		for o, a in gopts:
 			if o not in option_dict[object]:
@@ -245,6 +251,9 @@
 
 			if o == "-s" or o == "--seuser":
 				seuser = a
+                
+			if o == "-M" or o == '--mask':
+				mask = a
 
 			if o == "-t" or o == "--type":
 				setype = a
@@ -268,6 +277,9 @@
 		
 		if object == "interface":
 			OBJECT = seobject.interfaceRecords(store)
+            
+		if object == "node":
+			OBJECT = seobject.nodeRecords(store)
 		
 		if object == "fcontext":
 			OBJECT = seobject.fcontextRecords(store)
@@ -316,6 +328,9 @@
 			if object == "interface":
 				OBJECT.add(target, serange, setype)
 
+			if object == "node":
+				OBJECT.add(target, mask, proto, serange, setype)
+
 			if object == "fcontext":
 				OBJECT.add(target, setype, ftype, serange, seuser)
 			if object == "permissive":
@@ -342,6 +357,9 @@
 
 			if object == "interface":
 				OBJECT.modify(target, serange, setype)
+                
+			if object == "node":
+				OBJECT.modify(target, mask, proto, serange, setype)
 
 			if object == "fcontext":
 				OBJECT.modify(target, setype, ftype, serange, seuser)
@@ -354,6 +372,9 @@
 
 			elif object == "fcontext":
 				OBJECT.delete(target, ftype)
+                
+			elif object == "node":
+				OBJECT.delete(target, mask, proto)
 
 			else:
 				OBJECT.delete(target)
diff -u -r semanage/semanage.8 semanage-new/semanage.8
--- semanage/semanage.8	2008-08-13 17:50:41.000000000 +0200
+++ semanage-new/semanage.8	2008-08-14 09:00:19.000000000 +0200
@@ -3,7 +3,7 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|D} [\-n] [\-S store] 
+.B semanage {boolean|login|user|port|interface|node|fcontext|translation} \-{l|D} [\-n] [\-S store] 
 .br
 .B semanage boolean \-{d|m} [\-\-on|\-\-off|\-1|\-0] -F boolean | boolean_file
 .br
@@ -15,6 +15,8 @@
 .br
 .B semanage interface \-{a|d|m} [\-tr] interface_spec
 .br
+.B semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] address
+.br
 .B semanage fcontext \-{a|d|m} [\-frst] file_spec
 .br
 .B semanage permissive \-{a|d} type
@@ -78,7 +80,7 @@
 Do not print heading when listing OBJECTS.
 .TP
 .I                \-p, \-\-proto
-Protocol for the specified port (tcp|udp).
+Protocol for the specified port (tcp|udp) or internet protocol version for the specified node (ipv4|ipv6).
 .TP
 .I                \-r, \-\-range      
 MLS/MCS Security Range (MLS/MCS Systems only)
diff -u -r semanage/seobject.py semanage-new/seobject.py
--- semanage/seobject.py	2008-08-13 17:50:41.000000000 +0200
+++ semanage-new/seobject.py	2008-08-13 18:20:25.000000000 +0200
@@ -1030,6 +1030,231 @@
 			for p in ddict[i][1:]:
 				rec += ", %s" % p
 			print rec
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
+	       if proto == "ipv4":
+                       proto = 0
+               elif proto == "ipv6":
+                       proto = 1
+               else:
+                      raise ValueError(_("Unknown or missing protocol"))
+
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
+               if exists:
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
+               if proto == "ipv4":
+                       proto = 0
+               elif proto == "ipv6":
+                       proto = 1
+	       else:
+		      raise ValueError(_("Unknown or missing protocol"))
+			
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
+	       if proto == "ipv4":
+                       proto = 0
+               elif proto == "ipv6":
+                       proto = 1
+               else:
+                      raise ValueError(_("Unknown or missing protocol"))
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
+       def get_all(self, locallist = 0):
+               ddict = {}
+	       if locallist :
+			(rc, self.ilist) = semanage_node_list_local(self.sh)
+	       else:
+	                (rc, self.ilist) = semanage_node_list(self.sh)
+               if rc < 0:
+                       raise ValueError(_("Could not list addrs"))
+
+               for node in self.ilist:
+                       con = semanage_node_get_con(node)
+                       addr = semanage_node_get_addr(self.sh, node)
+                       mask = semanage_node_get_mask(self.sh, node)
+                       proto = semanage_node_get_proto(node)
+		       if proto == 0:
+				proto = "ipv4"
+		       elif proto == 1:
+				proto = "ipv6"
+                       ddict[(addr[1], mask[1], proto)] = (semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
+
+               return ddict
+                       
+       def list(self, heading = 1, locallist = 0):
+               if heading:
+                       print "%-18s %-18s %-5s %-5s\n" % ("IP Address", "Netmask", "Protocol", "Context")
+               ddict = self.get_all()
+               keys = ddict.keys()
+               keys.sort()
+               if is_mls_enabled:
+			for k in keys:
+				val = ''
+				for fields in k:
+					val = val + '\t' + str(fields)
+                                print "%-18s %-18s %-5s %s:%s:%s:%s " % (k[0],k[1],k[2],ddict[k][0], ddict[k][1],ddict[k][2], translate(ddict[k][3], False))
+               else:
+                       for k in keys:
+                               print "%-18s %-18s %-5s %s:%s:%s " % (k[0],k[1],k[2],ddict[k][0], ddict[k][1],ddict[k][2])
+
 
 class interfaceRecords(semanageRecords):
 	def __init__(self, store = ""):

--------------020402050201030408090608--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
