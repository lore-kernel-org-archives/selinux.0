Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i683MsrT010477
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 23:22:55 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i683MUCu019156
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 03:22:31 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Makefile and /etc/passwd
Date: Thu, 8 Jul 2004 13:22:45 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F4L7A5E5KbygMNH"
Message-Id: <200407081322.45107.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_F4L7A5E5KbygMNH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch will cause the file_contexts file to be outdated by every 
change to /etc/passwd.  This allows adding new users who were in the policy 
but not /etc/passwd previously, and also dealing with a change of location 
for the home directory.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--Boundary-00=_F4L7A5E5KbygMNH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/Makefile ./Makefile
--- /usr/src/se/policy/Makefile	2004-06-30 13:03:10.000000000 +1000
+++ ./Makefile	2004-07-06 13:35:59.000000000 +1000
@@ -139,7 +139,7 @@
 	@mkdir -p $(CONTEXTPATH)/files
 	install -m 644 $(FC) $(FCPATH)
 
-$(FC): $(FCFILES) domains/program domains/misc file_contexts/program file_contexts/misc users
+$(FC): $(FCFILES) domains/program domains/misc file_contexts/program file_contexts/misc users /etc/passwd
 	@echo "Building file_contexts ..."
 	@m4 $(FCFILES) > $@.tmp
 	@grep -v "^/root" $@.tmp > $@.root

--Boundary-00=_F4L7A5E5KbygMNH--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
