Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i683QgrT010515
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 23:26:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i683QLCu019321
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 03:26:22 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: SE Linux <selinux@tycho.nsa.gov>
Subject: comment change in attrib.te
Date: Thu, 8 Jul 2004 13:26:36 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_s7L7A3doMx1RFPp"
Message-Id: <200407081326.36713.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_s7L7A3doMx1RFPp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think that the attached comment change is worth having.  We want to 
discourage people from putting in rules that allow all domains to perform an 
action such as reading a file.  The current comment will tend to encourage 
such actions.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--Boundary-00=_s7L7A3doMx1RFPp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/attrib.te ./attrib.te
--- /usr/src/se/policy/attrib.te	2004-07-08 13:09:32.000000000 +1000
+++ ./attrib.te	2004-07-08 13:23:23.000000000 +1000
@@ -41,8 +41,7 @@
 # The domain attribute identifies every type that can be 
 # assigned to a process.  This attribute is used in TE rules 
 # that should be applied to all domains, e.g. permitting 
-# init to kill all processes or permitting all processes
-# to read a particular file.
+# init to kill all processes.
 attribute domain;
 
 # The privuser attribute identifies every domain that can 

--Boundary-00=_s7L7A3doMx1RFPp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
