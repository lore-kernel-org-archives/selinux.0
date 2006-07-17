Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6HKUx4r029281
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 16:30:59 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6HKUuXA013800
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 20:30:58 GMT
Subject: [PATCH 0/6] netfilter integration
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 16:32:29 -0400
Message-Id: <1153168349.10090.45.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset adds support for netfilter secmark rules in all policy
packages.  Each line of the file has a priority (1-9) at the beginning
of the line, and the remainder is treated as the rule.  Sorting is by
priority (1-9), and is stable within a module.  The current design is
for the resultant netfilter_contexts file be suitable for use with
iptables-restore.

This example would be the netfilter_contexts of the base module since it
has the extra portions required for iptables-restore use:

1 *mangle
1 :PREROUTING ACCEPT [0:0]
1 :INPUT ACCEPT [0:0]
1 :FORWARD ACCEPT [0:0]
1 :OUTPUT ACCEPT [0:0]
1 :POSTROUTING ACCEPT [0:0]
1 :selinux_input - [0:0]
1 :selinux_output - [0:0]
1 :selinux_new_input - [0:0]
1 :selinux_new_output - [0:0]
1 -A INPUT -j selinux_input
1 -A OUTPUT -j selinux_output
1 -A selinux_input -m state --state NEW -j selinux_new_input
1 -A selinux_input -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore
1 -A selinux_output -m state --state NEW -j selinux_new_output
1 -A selinux_output -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore
1 -A selinux_new_input -j SECMARK --selctx system_u:object_r:server_packet_t
5 -A selinux_new_input -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:http_server_packet_t
9 -A selinux_new_input -j CONNSECMARK --save
9 -A selinux_new_input -j RETURN
1 -A selinux_new_output -j SECMARK --selctx system_u:object_r:client_packet_t
5 -A selinux_new_output -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:http_client_packet_t
9 -A selinux_new_output -j CONNSECMARK --save
9 -A selinux_new_output -j RETURN
9 COMMIT

While individual loadable modules's netfilter_contexts would look like:

5 -A selinux_new_input -p tcp --dport 443 -j SECMARK --selctx system_u:object_r:http_server_packet_t
5 -A selinux_new_output -p tcp --dport 443 -j SECMARK --selctx system_u:object_r:http_client_packet_t

The below patch to refpolicy will create a file appropriate for testing.
The resultant linked and sorted file will be written out
to /etc/selinux/NAME/contexts/netfilter_contexts.

Index: Rules.modular
===================================================================
--- Rules.modular	(revision 1919)
+++ Rules.modular	(working copy)
@@ -89,10 +89,10 @@
 #
 # Create a base module package
 #
-$(BASE_PKG): $(BASE_MOD) $(BASE_FC) $(USERS_EXTRA) $(SEUSERS)
+$(BASE_PKG): $(BASE_MOD) $(BASE_FC) $(USERS_EXTRA) $(SEUSERS) $(net_contexts)
 	@echo "Creating $(NAME) base module package"
 	@test -d $(BUILDDIR) || mkdir -p $(BUILDDIR)
-	$(verbose) $(SEMOD_PKG) -o $@ -m $(BASE_MOD) -f $(BASE_FC) -u $(USERS_EXTRA) -s $(SEUSERS)
+	$(verbose) $(SEMOD_PKG) -o $@ -m $(BASE_MOD) -f $(BASE_FC) -u $(USERS_EXTRA) -s $(SEUSERS) -n $(net_contexts)
 
 $(BASE_MOD): $(BASE_CONF)
 	@echo "Compiling $(NAME) base module"
Index: support/gennetfilter.py
===================================================================
--- support/gennetfilter.py	(revision 1919)
+++ support/gennetfilter.py	(working copy)
@@ -43,7 +43,7 @@
 		self.ports = ports
 
 def print_input_rules(packets,mls,mcs):
-	line = "-A selinux_new_input -j SECMARK --selctx system_u:object_r:"+DEFAULT_INPUT_PACKET
+	line = "1 -A selinux_new_input -j SECMARK --selctx system_u:object_r:"+DEFAULT_INPUT_PACKET
 	if mls:
 		line += ":"+DEFAULT_MLS
 	elif mcs:
@@ -53,18 +53,18 @@
 
 	for i in packets:
 		for j in i.ports:
-			line="-A selinux_new_input -p "+j.proto+" --dport "+j.num+" -j SECMARK --selctx system_u:object_r:"+i.prefix+PACKET_INPUT
+			line="5 -A selinux_new_input -p "+j.proto+" --dport "+j.num+" -j SECMARK --selctx system_u:object_r:"+i.prefix+PACKET_INPUT
 			if mls:
 				line += ":"+j.mls_sens
 			elif mcs:
 				line += ":"+j.mcs_cats
 			print line
 
-	print "-A selinux_new_input -j CONNSECMARK --save"
-	print "-A selinux_new_input -j RETURN"
+	print "9 -A selinux_new_input -j CONNSECMARK --save"
+	print "9 -A selinux_new_input -j RETURN"
 
 def print_output_rules(packets,mls,mcs):
-	line = "-A selinux_new_output -j SECMARK --selctx system_u:object_r:"+DEFAULT_OUTPUT_PACKET
+	line = "1 -A selinux_new_output -j SECMARK --selctx system_u:object_r:"+DEFAULT_OUTPUT_PACKET
 	if mls:
 		line += ":"+DEFAULT_MLS
 	elif mcs:
@@ -73,15 +73,15 @@
 
 	for i in packets:
 		for j in i.ports:
-			line = "-A selinux_new_output -p "+j.proto+" --dport "+j.num+" -j SECMARK --selctx system_u:object_r:"+i.prefix+PACKET_OUTPUT
+			line = "5 -A selinux_new_output -p "+j.proto+" --dport "+j.num+" -j SECMARK --selctx system_u:object_r:"+i.prefix+PACKET_OUTPUT
 			if mls:
 				line += ":"+j.mls_sens
 			elif mcs:
 				line += ":"+j.mcs_cats
 			print line
 
-	print "-A selinux_new_output -j CONNSECMARK --save"
-	print "-A selinux_new_output -j RETURN"
+	print "9 -A selinux_new_output -j CONNSECMARK --save"
+	print "9 -A selinux_new_output -j RETURN"
 
 def parse_corenet(file_name):
 	packets = []
@@ -118,25 +118,25 @@
 	return packets
 
 def print_netfilter_config(packets,mls,mcs):
-	print "*mangle"
-	print ":PREROUTING ACCEPT [0:0]"
-	print ":INPUT ACCEPT [0:0]"
-	print ":FORWARD ACCEPT [0:0]"
-	print ":OUTPUT ACCEPT [0:0]"
-	print ":POSTROUTING ACCEPT [0:0]"
-	print ":selinux_input - [0:0]"
-	print ":selinux_output - [0:0]"
-	print ":selinux_new_input - [0:0]"
-	print ":selinux_new_output - [0:0]"
-	print "-A INPUT -j selinux_input"
-	print "-A OUTPUT -j selinux_output"
-	print "-A selinux_input -m state --state NEW -j selinux_new_input"
-	print "-A selinux_input -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore"
-	print "-A selinux_output -m state --state NEW -j selinux_new_output"
-	print "-A selinux_output -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore"
+	print "1 *mangle"
+	print "1 :PREROUTING ACCEPT [0:0]"
+	print "1 :INPUT ACCEPT [0:0]"
+	print "1 :FORWARD ACCEPT [0:0]"
+	print "1 :OUTPUT ACCEPT [0:0]"
+	print "1 :POSTROUTING ACCEPT [0:0]"
+	print "1 :selinux_input - [0:0]"
+	print "1 :selinux_output - [0:0]"
+	print "1 :selinux_new_input - [0:0]"
+	print "1 :selinux_new_output - [0:0]"
+	print "1 -A INPUT -j selinux_input"
+	print "1 -A OUTPUT -j selinux_output"
+	print "1 -A selinux_input -m state --state NEW -j selinux_new_input"
+	print "1 -A selinux_input -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore"
+	print "1 -A selinux_output -m state --state NEW -j selinux_new_output"
+	print "1 -A selinux_output -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore"
 	print_input_rules(packets,mls,mcs)
 	print_output_rules(packets,mls,mcs)
-	print "COMMIT"
+	print "9 COMMIT"
 
 mls = False
 mcs = False


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
