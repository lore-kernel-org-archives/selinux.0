Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6JD2lrT012037
	for <selinux@tycho.nsa.gov>; Mon, 19 Jul 2004 09:02:47 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6JD2JNE010858
	for <selinux@tycho.nsa.gov>; Mon, 19 Jul 2004 13:02:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: genhomedircon
Date: Mon, 19 Jul 2004 23:02:42 +1000
Cc: fedora-selinux-list@redhat.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yZ8+AwKrLV4sSsO"
Message-Id: <200407192302.42130.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_yZ8+AwKrLV4sSsO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch fixes a bug in genhomedircon.

Without this if you create system users with "useradd -r" and give them home 
directories in unusual locations (such as /usr/DIR or /var/run/DIR) then a 
file_contexts file will be generated that will mess up your system.

This match makes it check /etc/login.defs for the value of UID_MIN.

Also perhaps we should make STARTING_UID default to 500.  500 is the default 
value for this in Fedora.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_yZ8+AwKrLV4sSsO
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- genhomedircon	2004-07-19 22:29:23.851864480 +1000
+++ /usr/sbin/genhomedircon	2004-07-19 22:47:01.984003944 +1000
@@ -25,7 +25,6 @@
 import commands, sys, os, pwd, string
 
 EXCLUDE_LOGINS=["/sbin/nologin", "/bin/false"]
-STARTING_UID=100
 
 def getPrefixes():
 	ulist = pwd.getpwall()
@@ -92,6 +91,12 @@
 		print len(sys.argv)
 		usage("Incorrect parameters")
 
+	rc=commands.getstatusoutput("grep -h '^UID_MIN' /etc/login.defs | sed -e 's/^UID_MIN[^0-9]*//'")
+	if rc[0] == 0:
+		STARTING_UID=rc[1]
+	else:
+		STARTING_UID=100
+
 	FILECONTEXTDIR=sys.argv[1]
 	prefixes = getPrefixes()
 

--Boundary-00=_yZ8+AwKrLV4sSsO--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
