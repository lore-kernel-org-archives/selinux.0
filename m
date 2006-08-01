Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k71Ig9ZO000841
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 14:42:09 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k71IfxXQ011202
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 18:41:59 GMT
Subject: [PATCH 0/6] netfilter integration take 2
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 14:43:04 -0400
Message-Id: <1154457784.31522.146.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset adds support for netfilter secmark rules in all policy
packages.  Each line of the file has a priority at the beginning of the
line, and the remainder is treated as the rule.  Sorting is by priority,
and is stable within a module.  The current design is for the resultant
netfilter_contexts file be suitable for use with iptables-restore.

The priorities in order are:
pre - special lines that must be at the beginning
base - lines in the base module
module - lines in loadable modules
local - local overrides
post - special lines that must be at the end

This example would be the netfilter_contexts of the base module since it
has the extra portions required for iptables-restore use:

pre *mangle
pre :PREROUTING ACCEPT [0:0]
pre :INPUT ACCEPT [0:0]
pre :FORWARD ACCEPT [0:0]
pre :OUTPUT ACCEPT [0:0]
pre :POSTROUTING ACCEPT [0:0]
pre :selinux_input - [0:0]
pre :selinux_output - [0:0]
pre :selinux_new_input - [0:0]
pre :selinux_new_output - [0:0]
pre -A INPUT -j selinux_input
pre -A OUTPUT -j selinux_output
pre -A selinux_input -m state --state NEW -j selinux_new_input
pre -A selinux_input -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore
pre -A selinux_output -m state --state NEW -j selinux_new_output
pre -A selinux_output -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore
base -A selinux_new_input -j SECMARK --selctx system_u:object_r:server_packet_t
post -A selinux_new_input -j CONNSECMARK --save
post -A selinux_new_input -j RETURN
base -A selinux_new_output -j SECMARK --selctx system_u:object_r:client_packet_t
post -A selinux_new_output -j CONNSECMARK --save
post -A selinux_new_output -j RETURN
post COMMIT

While individual loadable modules' netfilter_contexts would look like:

module -A selinux_new_input -p tcp --dport 443 -j SECMARK --selctx system_u:object_r:http_server_packet_t
module -A selinux_new_output -p tcp --dport 443 -j SECMARK --selctx system_u:object_r:http_client_packet_t

The below patch to refpolicy will create a file appropriate for testing.
The resultant linked and sorted file will be written out
to /etc/selinux/NAME/contexts/netfilter_contexts.

Index: Rules.modular
===================================================================
--- Rules.modular	(revision 1933)
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
--- support/gennetfilter.py	(revision 1933)
+++ support/gennetfilter.py	(working copy)
@@ -43,7 +43,7 @@
 		self.ports = ports
 
 def print_input_rules(packets,mls,mcs):
-	line = "-A selinux_new_input -j SECMARK --selctx system_u:object_r:"+DEFAULT_INPUT_PACKET
+	line = "base -A selinux_new_input -j SECMARK --selctx system_u:object_r:"+DEFAULT_INPUT_PACKET
 	if mls:
 		line += ":"+DEFAULT_MLS
 	elif mcs:
@@ -53,18 +53,18 @@
 
 	for i in packets:
 		for j in i.ports:
-			line="-A selinux_new_input -p "+j.proto+" --dport "+j.num+" -j SECMARK --selctx system_u:object_r:"+i.prefix+PACKET_INPUT
+			line="base -A selinux_new_input -p "+j.proto+" --dport "+j.num+" -j SECMARK --selctx system_u:object_r:"+i.prefix+PACKET_INPUT
 			if mls:
 				line += ":"+j.mls_sens
 			elif mcs:
 				line += ":"+j.mcs_cats
 			print line
 
-	print "-A selinux_new_input -j CONNSECMARK --save"
-	print "-A selinux_new_input -j RETURN"
+	print "post -A selinux_new_input -j CONNSECMARK --save"
+	print "post -A selinux_new_input -j RETURN"
 
 def print_output_rules(packets,mls,mcs):
-	line = "-A selinux_new_output -j SECMARK --selctx system_u:object_r:"+DEFAULT_OUTPUT_PACKET
+	line = "base -A selinux_new_output -j SECMARK --selctx system_u:object_r:"+DEFAULT_OUTPUT_PACKET
 	if mls:
 		line += ":"+DEFAULT_MLS
 	elif mcs:
@@ -73,15 +73,15 @@
 
 	for i in packets:
 		for j in i.ports:
-			line = "-A selinux_new_output -p "+j.proto+" --dport "+j.num+" -j SECMARK --selctx system_u:object_r:"+i.prefix+PACKET_OUTPUT
+			line = "base -A selinux_new_output -p "+j.proto+" --dport "+j.num+" -j SECMARK --selctx system_u:object_r:"+i.prefix+PACKET_OUTPUT
 			if mls:
 				line += ":"+j.mls_sens
 			elif mcs:
 				line += ":"+j.mcs_cats
 			print line
 
-	print "-A selinux_new_output -j CONNSECMARK --save"
-	print "-A selinux_new_output -j RETURN"
+	print "post -A selinux_new_output -j CONNSECMARK --save"
+	print "post -A selinux_new_output -j RETURN"
 
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
+	print "pre *mangle"
+	print "pre :PREROUTING ACCEPT [0:0]"
+	print "pre :INPUT ACCEPT [0:0]"
+	print "pre :FORWARD ACCEPT [0:0]"
+	print "pre :OUTPUT ACCEPT [0:0]"
+	print "pre :POSTROUTING ACCEPT [0:0]"
+	print "pre :selinux_input - [0:0]"
+	print "pre :selinux_output - [0:0]"
+	print "pre :selinux_new_input - [0:0]"
+	print "pre :selinux_new_output - [0:0]"
+	print "pre -A INPUT -j selinux_input"
+	print "pre -A OUTPUT -j selinux_output"
+	print "pre -A selinux_input -m state --state NEW -j selinux_new_input"
+	print "pre -A selinux_input -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore"
+	print "pre -A selinux_output -m state --state NEW -j selinux_new_output"
+	print "pre -A selinux_output -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore"
 	print_input_rules(packets,mls,mcs)
 	print_output_rules(packets,mls,mcs)
-	print "COMMIT"
+	print "post COMMIT"
 
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
