Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6INxtrT008934
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2004 19:59:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6INxRNF021954
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2004 23:59:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: file_contexts patch
Date: Mon, 19 Jul 2004 09:59:48 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>, krahmer@suse.de
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <200407181258.37018.russell@coker.com.au> <20040718150357.GA322@rom.cip.ifi.lmu.de>
In-Reply-To: <20040718150357.GA322@rom.cip.ifi.lmu.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200407190959.48713.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Jul 2004 01:03, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> > unix_chkpwd has been around for years, I can't believe that it's
> > something that they haven't got to it yet.
>
> unix_chkpwd is included in the PAM package, it's just that suse has
> developed their own pam module (pam_unix2.so) which doesn't use
> unix_chkpwd AFAIK.

Why can't you just use pam_unix.so instead?

Also it shouldn't be that difficult to fix the SUSE code.

> > Are you running kcheckpass as root (maybe SETUID)?
>
> It's sgid shadow.

That's entirely the wrong approach.  Any bug in kcheckpass on a SUSE system 
will give full access to /etc/shadow.

> > If so then SUSE would be
> > using PAM without my patch to pam_unix.so which allows unix_chkpwd to be
> > called if /etc/shadow can't be opened as root (without that patch it just
> > aborts).  Also does SUSE have unix_verify (again part of my patch)
> > installed? If not then the default policy will not work in all
> > situations...
>
> Yeah, I had to give login, ssh, kdm, ... the auth attribute.
> I do not know which part of the patch is missing, it's been a while
> since I looked at the PAM code.
> At the time I made the packages I simply gave up on PAM after a while
> because it was too complicated and I didn't want to find out how suse's
> module differed from the rest of the world...
> I guess it's time I dig again into this mess, sigh.
> I really wish there was someone actively maintaining this code.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
