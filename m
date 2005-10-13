Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9D6xjNs021265
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 02:59:45 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9D6vjgQ026662
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 06:57:46 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9ADCD61B05
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 16:58:03 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21685-01 for <selinux@tycho.nsa.gov>;
	Thu, 13 Oct 2005 16:58:03 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0497061B01
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 16:58:03 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 4B8DD4D
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 16:58:01 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: mls policy comments
Date: Thu, 13 Oct 2005 16:57:55 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4VgTDkoZC4FZs19"
Message-Id: <200510131658.00952.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_4VgTDkoZC4FZs19
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I believe that every attribute should have a comment explaining it's purpose.

I've attached a patch that adds comments for some of the MLS attributes.  I'm 
sure that someone on this list can do better, so please feel free to 
follow-up with a patch that you believe better explains it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_4VgTDkoZC4FZs19
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- mls.orig	2005-10-12 20:57:12.000000000 +1000
+++ mls	2005-10-13 16:56:03.000000000 +1000
@@ -733,16 +733,38 @@
 # these access vectors have no MLS restrictions
 # association { sendto recvfrom }
 
+# Read files and search directories that have a classification higher than
+# subject clearance
 attribute mlsfileread;
+# Read files and search directories with a classification higher than the
+# effective clearance but not higher than the clearance
 attribute mlsfilereadtoclr;
+# Write files and directories in situations where MLS normally denies writes
 attribute mlsfilewrite;
+# Write files and directories where clearance of the subject dominates the
+# classification of the file/dir and the classification of the file/dir
+# dominates the effective clearance of the subject.
 attribute mlsfilewritetoclr;
+# Increase the classification and/or effective classification of the object
+# regardless of the clearance of the subject.
 attribute mlsfileupgrade;
+# Decrease the classification and/or effective classification of the object
+# regardless of the clearance of the subject.  NB An new label with an
+# incomparable effective classification and an equal classification is
+# considered a downgrade as is an incomparable classification
 attribute mlsfiledowngrade;
-
+# Read network data with a lower effective classification than the effective
+# clearance of the process
 attribute mlsnetread;
+# Read network data with a lower effective classification than the effective
+# clearance of the process when the classification of the process is higher
 attribute mlsnetreadtoclr;
+# Write network data with a higher effective classification or with a
+# classification higher than the clearance of the subject
 attribute mlsnetwrite;
+# Write network data where the clearance of the process dominates the
+# effective classification of the data and the effective classification of
+# the data dominates the effective clearance of the subject.
 attribute mlsnetwritetoclr;
 attribute mlsnetupgrade;
 attribute mlsnetdowngrade;

--Boundary-00=_4VgTDkoZC4FZs19--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
