Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2OCbKRb006680
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 07:37:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2OCZUdQ006441
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 12:35:30 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i2OCZSBL006394
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 12:35:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: patch for libselinux1
Date: Wed, 24 Mar 2004 23:35:51 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200403232125.21252.russell@coker.com.au> <1080050046.30176.75.camel@moss-spartans.epoch.ncsc.mil> <200403241810.45211.russell@coker.com.au>
In-Reply-To: <200403241810.45211.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nCYYA+dR8ioLgEb"
Message-Id: <200403242335.51568.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_nCYYA+dR8ioLgEb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 24 Mar 2004 18:10, Russell Coker <russell@coker.com.au> wrote:
> On Wed, 24 Mar 2004 00:54, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > > It's not a significant issue for Fedora at the moment as no-one will be
> > > mounting /selinux by hand (I hope).  But it's already become an issue
> > > for Debian (I've uploaded a fixed package to Debian already).
> >
> > Your patch has a few bugs in it.  How about this one instead?
>
> Yes, your patch is much better.  I've done a new upload to Debian with your
> patch.

Also the attached policy patch is needed as fopen() will stat the file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_nCYYA+dR8ioLgEb
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /etc/selinux/macros/global_macros.te	2004-03-22 15:26:39.000000000 +1100
+++ macros/global_macros.te	2004-03-24 23:30:01.000000000 +1100
@@ -23,7 +23,7 @@
 allow $1 proc_t:dir search;
 allow $1 proc_t:{ file lnk_file } read;
 allow $1 self:dir search;
-allow $1 self:file { read write };
+allow $1 self:file { getattr read write };
 ')
 
 ##################################
@@ -37,7 +37,7 @@
 allow $1 proc_t:dir search;
 allow $1 proc_t:lnk_file read;
 allow $1 self:dir search;
-allow $1 self:file read;
+allow $1 self:file { getattr read };
 ')
 
 ##################################
@@ -71,7 +71,7 @@
 allow $1 proc_t:dir search;
 allow $1 proc_t:{ file lnk_file } read;
 allow $1 self:dir search;
-allow $1 self:file { read write };
+allow $1 self:file { getattr read write };
 ')
 
 #################################

--Boundary-00=_nCYYA+dR8ioLgEb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
