Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6IF3xrT007642
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2004 11:04:00 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6IF3XNF012548
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2004 15:03:34 GMT
Received: from rom.cip.ifi.lmu.de (rom.cip.informatik.uni-muenchen.de [141.84.214.183])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id B5A5643601
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2004 17:03:57 +0200 (CEST)
Date: Sun, 18 Jul 2004 17:03:57 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: file_contexts patch
Message-ID: <20040718150357.GA322@rom.cip.ifi.lmu.de>
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <200407171159.00489.russell@coker.com.au> <20040717195326.GA16762@bern.cip.ifi.lmu.de> <200407181258.37018.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200407181258.37018.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Russell Coker <russell@coker.com.au> [2004-07-18 06:33]:
> On Sun, 18 Jul 2004 05:53, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
> wrote:
> > > kcheckpass should use PAM and therefore use unix_chkpwd.
> >
> > Doh. Of course you are right. I checked again and kcheckpass does the
> > right thing and calls PAM but the SuSE PAM implementation doesn't use
> > unix_chkpwd yet.
> > So you can dismiss that part of my patch.
> 
> http://cvs.sourceforge.net/viewcvs.py/pam/Linux-PAM/modules/pam_unix/unix_chkpwd.c
> 
> unix_chkpwd has been around for years, I can't believe that it's something 
> that they haven't got to it yet.

unix_chkpwd is included in the PAM package, it's just that suse has
developed their own pam module (pam_unix2.so) which doesn't use
unix_chkpwd AFAIK.
 
> Are you running kcheckpass as root (maybe SETUID)?  
It's sgid shadow.

> If so then SUSE would be 
> using PAM without my patch to pam_unix.so which allows unix_chkpwd to be 
> called if /etc/shadow can't be opened as root (without that patch it just 
> aborts).  Also does SUSE have unix_verify (again part of my patch) installed?  
> If not then the default policy will not work in all situations...

Yeah, I had to give login, ssh, kdm, ... the auth attribute.
I do not know which part of the patch is missing, it's been a while
since I looked at the PAM code.
At the time I made the packages I simply gave up on PAM after a while
because it was too complicated and I didn't want to find out how suse's
module differed from the rest of the world...
I guess it's time I dig again into this mess, sigh.
I really wish there was someone actively maintaining this code.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
