Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9TFSCWt007372
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 10:28:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9TFRnUf012353
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 15:27:54 GMT
Received: from lyta.coker.com.au (nat-pool-bos.redhat.com [66.187.230.200])
	by jazzswing.ncsc.mil  with ESMTP id h9TFRhtU012340
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 15:27:49 GMT
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 031867F01D
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 02:26:43 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] policy-1
Date: Thu, 30 Oct 2003 02:26:43 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zw9n/41bQaVY4Nh"
Message-Id: <200310300226.43569.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_zw9n/41bQaVY4Nh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 24 Oct 2003 06:24, Bastian Blank wrote:
> hi folks
>
> this patch fixes the following problems:
> - fix type for shlibs in /usr/local/lib
> files: file_contexts/types.fc

How about the attached patch?

I've been changing all the file contexts files to include the type of the file 
as much as possible.

I have changed the ldconfig.te file to have sym-links generated with type 
lib_t.  So the attached patch will make /usr/local/lib act the way that
/usr/lib and /lib will.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_zw9n/41bQaVY4Nh
Content-Type: text/x-diff;
  charset="us-ascii";
  name="policy-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="policy-1"

Index: file_contexts/types.fc
===================================================================
--- file_contexts/types.fc	(.../upstream/current/policy)	(revision 46)
+++ file_contexts/types.fc	(.../trunk/policy)	(revision 46)
@@ -322,7 +322,7 @@
 # /usr/local/lib
 #
 /usr/local/lib(/.*)?		system_u:object_r:lib_t
-/usr/local/lib/.*\.so		system_u:object_r:shlib_t
+/usr/local/lib/.*\.so.* --	system_u:object_r:shlib_t
 
 #
 # /usr/sbin

--Boundary-00=_zw9n/41bQaVY4Nh--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
