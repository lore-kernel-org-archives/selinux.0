Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UKftrT026883
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 16:41:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UKemng010961
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 20:40:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: Access to xdm_t
Date: Fri, 1 Oct 2004 06:41:51 +1000
Cc: Colin Walters <walters@verbum.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de> <1096561927.4957.15.camel@nexus.verbum.private> <20040930192935.GA6063@lkcl.net>
In-Reply-To: <20040930192935.GA6063@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410010641.51462.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Oct 2004 05:29, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Thu, Sep 30, 2004 at 12:32:07PM -0400, Colin Walters wrote:
> > On Wed, 2004-09-29 at 18:32 +0200, Thomas Bleher wrote:
> > > If yes, should xdm_t get the attribute privfd?
> >
> > Actually even moving the log to /tmp you'll still get programs wanting
> > access to the xdm_t fd.  Ideally we would have a little program run in
> > its own domain (xdm_launcher_t say) that would simply close all of its
> > file descriptors, open up the tmp file itself for logging and exec the
> > user session.
>
>  /usr/bin/startkde for example?

Yes, that sounds good for it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
