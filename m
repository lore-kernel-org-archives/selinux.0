Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UJmTrT026305
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 15:48:29 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UJlMng007285
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 19:47:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>
Subject: Re: Access to xdm_t
Date: Fri, 1 Oct 2004 05:48:25 +1000
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de> <1096561927.4957.15.camel@nexus.verbum.private>
In-Reply-To: <1096561927.4957.15.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410010548.25592.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Oct 2004 02:32, Colin Walters <walters@verbum.org> wrote:
> On Wed, 2004-09-29 at 18:32 +0200, Thomas Bleher wrote:
> > If yes, should xdm_t get the attribute privfd?
>
> Actually even moving the log to /tmp you'll still get programs wanting
> access to the xdm_t fd.  Ideally we would have a little program run in
> its own domain (xdm_launcher_t say) that would simply close all of its
> file descriptors, open up the tmp file itself for logging and exec the
> user session.  Then you could make the xdm_launcher_t privfd, without

Why not just have the xdm program launch a script in the user context which 
opens the file and redirects output to it?  If the file handle is opened as 
user_t then it won't cause any problems for any program.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
