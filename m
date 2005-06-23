Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5N6LvgA024115
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 02:21:57 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5N6CANa028299
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 06:12:11 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id CEC8061B02
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:12:10 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03456-01 for <selinux@tycho.nsa.gov>;
	Thu, 23 Jun 2005 16:12:10 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 633B561B01
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:12:10 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 6755137
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:12:09 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: /usr/local policy patch
Date: Thu, 23 Jun 2005 16:12:06 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5KluCDkYz6ei7Qc"
Message-Id: <200506231612.09187.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_5KluCDkYz6ei7Qc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached trivial patch changes "/usr(/local)?/" to "/usr/(local/)?".  The 
reason for this is that the string "/something/" works with the stem 
compression code in matchpathcon and in this example will only involve regex 
library calls for files that are under the /usr directory.  A string that has 
any regex meta-characters before the second '/' will not work with the stem 
compression code and therefore such regular expressions will be applied 
against all files on disk.  This has a performance impact on setfiles and 
restorecon, the impact for two regexes is small, but it all adds up.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_5KluCDkYz6ei7Qc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- types.fc.orig	2005-06-23 11:41:55.000000000 +1000
+++ types.fc	2005-06-23 11:43:16.000000000 +1000
@@ -389,8 +389,8 @@
 /usr/local/src(/.*)?		system_u:object_r:src_t
 /usr/local/man(/.*)?		system_u:object_r:man_t
 /usr/local/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
-/usr(/local)?/lib/wine/.*\.so   --	system_u:object_r:texrel_shlib_t
-/usr(/local)?/lib/libfame-.*\.so.*    --	system_u:object_r:texrel_shlib_t
+/usr/(local/)?lib/wine/.*\.so   --	system_u:object_r:texrel_shlib_t
+/usr/(local/)?lib/libfame-.*\.so.*    --	system_u:object_r:texrel_shlib_t
 
 
 #

--Boundary-00=_5KluCDkYz6ei7Qc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
