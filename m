Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA20469
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 07:40:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA09405
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 11:38:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA09401 for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 11:38:47 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 0A22F92467
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 21:40:32 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 06A393546
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 13:40:24 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: patch to remove initrd support
Date: Thu, 26 Sep 2002 13:40:23 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_B3N1ERZHS2W4MCEVXATM"
Message-Id: <200209261340.23623.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_B3N1ERZHS2W4MCEVXATM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

The attached patch removes initrd support from policy/Makefile as it's just 
been obsoleted by Steve's recent kernel patches.


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_B3N1ERZHS2W4MCEVXATM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

--- Makefile	2002-09-21 05:01:24.000000000 +0200
+++ Makefile.new	2002-09-26 13:39:05.000000000 +0200
@@ -34,28 +34,18 @@
 POLICYFILES += rbac users constraints
 POLICYFILES += initial_sid_contexts fs_use genfs_contexts net_contexts
 
-INITRDPOLICYFILES = $(subst users, initrd-domains/users,$(subst all.te,initrd_all.te,$(POLICYFILES)))
-
 FC = file_contexts/file_contexts
 FCFILES=file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
 
 
 install: $(LOADPATH)
 
-install-initrd: $(LOADPATH).initrd
-
 $(LOADPATH):  $(POLICYCONF) $(CHECKPOLICY)
 	mkdir -p $(INSTALLDIR)
 	$(CHECKPOLICY) -o $@ $(POLICYCONF)
 # Note: Can't use install, so not sure how to deal with mode, user, and group
 #	other than by default.
 
-$(LOADPATH).initrd:  $(POLICYCONF).initrd $(CHECKPOLICY)
-	mkdir -p $(INSTALLDIR)
-	$(CHECKPOLICY) -o $@ $(POLICYCONF).initrd
-# Note: Can't use install, so not sure how to deal with mode, user, and group
-#	other than by default.
-
 policy: $(POLICYVER)
 
 $(POLICYVER):  policy.conf $(CHECKPOLICY)
@@ -65,10 +55,6 @@
 	mkdir -p $(SRCINSTALLDIR)
 	install -m 644 -o root -g root policy.conf $@
 
-$(POLICYCONF).initrd: policy.conf.initrd
-	mkdir -p $(SRCINSTALLDIR)
-	install -m 644 -o root -g root policy.conf.initrd $@
-
 reload tmp/load: $(LOADPATH)
 	$(BINDIR)/load_policy $(LOADPATH)
 	touch tmp/load
@@ -83,26 +69,15 @@
 	mkdir -p $(SRCINSTALLDIR)/policy
 	cp -R . $(SRCINSTALLDIR)/policy
 
-policy.conf.initrd: $(INITRDPOLICYFILES) 
-	m4 -Imacros -s $(INITRDPOLICYFILES) > $@
-
 ALLTEFILES := attrib.te tmp/program_used_flags.te tmp/all_macros.te tmp/all_types.te tmp/all_domains.te assert.te 
 
 tmp/all.te: $(ALLTEFILES)
 	cat $^ > $@
 
-INITRD_ALLTEFILES := attrib.te tmp/initrd_program_used_flags.te tmp/all_macros.te tmp/all_types.te tmp/all_initrd_domains.te assert.te 
-
-tmp/initrd_all.te: $(INITRD_ALLTEFILES)
-	cat $^ > $@
-
 tmp/program_used_flags.te: $(wildcard domains/program/*.te) domains/program
 	mkdir -p tmp
 	( cd domains/program/ ; for n in *.te ; do echo "define(\`$$n')"; done ) > $@
 
-tmp/initrd_program_used_flags.te: $(wildcard initrd-domains/*.te) initrd-domains
-	( cd initrd-domains ; for n in *.te ; do echo "define(\`$$n')"; done ) > $@
-
 tmp/all_macros.te:  macros $(wildcard macros/*.te) tmp/all_program_macros.te
 	cat $(wildcard macros/*.te) tmp/all_program_macros.te > $@
 
@@ -115,9 +90,6 @@
 tmp/all_domains.te: $(wildcard domains/*.te domains/misc/*.te domains/program/*.te) domains domains/misc domains/program
 	cat domains/*.te domains/misc/*.te domains/program/*.te > $@
 
-tmp/all_initrd_domains.te: $(wildcard initrd-domains/*.te) initrd-domains
-	cat initrd-domains/*.te > $@
-
 relabel:  $(FC) $(SETFILES)
 	$(SETFILES) $(FC) `mount | awk '/(ext[23]|reiserfs)/{print $$3}'`
 
@@ -128,7 +100,7 @@
 	cat $(FCFILES) > $@
 
 clean:
-	rm -f policy.conf policy.conf.initrd
+	rm -f policy.conf
 	rm -f tmp/*
 	rm -f $(FC)
  

--------------Boundary-00=_B3N1ERZHS2W4MCEVXATM--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
