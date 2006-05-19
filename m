Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JASRUs032359
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 06:28:27 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JASOk7014334
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 10:28:25 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id ECF5061B09
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 20:28:23 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03071-03 for <selinux@tycho.nsa.gov>;
	Fri, 19 May 2006 20:28:23 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8F9A461B06
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 20:28:23 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id C5B23A7ED4
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 20:28:32 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: genhomedircon
Date: Fri, 19 May 2006 20:28:29 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Q3ZbEesOrdeweN1"
Message-Id: <200605192028.32354.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Q3ZbEesOrdeweN1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

        def checkExists(self, home):
                fd = open(self.getFileContextFile())
                for i in  fd.read().split('\n'):
                    if len(i) == 0:
                            continue
                    regex = i.split()[0]


The above code at line 282 in genhomedircon in FC5 has a bug in that it can't 
handle a line in the file contexts file containing " ".

The attached patch fixes a bug in the FC5 policy which generates such a line 
with only a space.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Q3ZbEesOrdeweN1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru serefpolicy-2.2.38.orig/policy/support/misc_macros.spt serefpolicy-2.2.38/policy/support/misc_macros.spt
--- serefpolicy-2.2.38.orig/policy/support/misc_macros.spt	2006-05-08 23:54:02.000000000 +1000
+++ serefpolicy-2.2.38/policy/support/misc_macros.spt	2006-05-19 20:15:07.000000000 +1000
@@ -37,7 +37,7 @@
 #
 # gen_context(context,mls_sensitivity,[mcs_categories])
 #
-define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')') dnl
+define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')')dnl
 
 ########################################
 #

--Boundary-00=_Q3ZbEesOrdeweN1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
