Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3Q8sFI4017791
	for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2003 04:54:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3Q8s8Vf026450
	for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2003 08:54:08 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3Q8s54D026446
	for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2003 08:54:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Howard Holm <hdholm@epoch.ncsc.mil>
Subject: file_contexts tiny patch
Date: Sat, 26 Apr 2003 18:53:55 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jkkq+cbDv3f1kaH"
Message-Id: <200304261853.55786.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_jkkq+cbDv3f1kaH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a tiny patch to add support for policy/file_contexts/misc .

This directory is to be used for .fc files that don't have a matching .te 
file.  One thing I have used this for is a .tar.gz archive of GCC for 
cross-compiling for ARM, so I have policy/file_contexts/misc/arm-gcc.fc which 
has the appropriate labelling for /opt/arm.

I think that this is generally useful.

I haven't moves types.fc yet because the misc directory is processed in 
alphabetical order and types.fc needs to be first.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_jkkq+cbDv3f1kaH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fc.diff"

diff -ruw /usr/share/selinux/policy/default/Makefile /usr/share/selinux/policy/current/Makefile
--- /usr/share/selinux/policy/default/Makefile	2003-04-25 16:46:07.000000000 +1000
+++ /usr/share/selinux/policy/current/Makefile	2003-04-26 18:47:43.000000000 +1000
@@ -35,7 +35,7 @@
 POLICYFILES += tmp/constraints-contexts.m4
 
 FC = file_contexts/file_contexts
-FCFILES=file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
+FCFILES=file_contexts/types.fc $(wildcard file_contexts/misc/*.fc) $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
 
 
 install: $(LOADPATH)
@@ -109,7 +109,7 @@
 reset:  $(FC) $(SETFILES)
 	$(SETFILES) -R $(FC) `mount | awk '/(ext[23]|reiserfs|jfs|jffs2)/{print $$3}'`
 
-$(FC): $(FCFILES) file_contexts/program 
+$(FC): $(FCFILES) file_contexts/program file_contexts/misc
 	cat $(FCFILES) > $@
 
 clean:

--Boundary-00=_jkkq+cbDv3f1kaH--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
