Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6I2wprT006202
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 22:58:51 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6I2wkRh011962
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2004 02:58:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: file_contexts patch
Date: Sun, 18 Jul 2004 12:58:37 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <200407171159.00489.russell@coker.com.au> <20040717195326.GA16762@bern.cip.ifi.lmu.de>
In-Reply-To: <20040717195326.GA16762@bern.cip.ifi.lmu.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407181258.37018.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 18 Jul 2004 05:53, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> > kcheckpass should use PAM and therefore use unix_chkpwd.
>
> Doh. Of course you are right. I checked again and kcheckpass does the
> right thing and calls PAM but the SuSE PAM implementation doesn't use
> unix_chkpwd yet.
> So you can dismiss that part of my patch.

http://cvs.sourceforge.net/viewcvs.py/pam/Linux-PAM/modules/pam_unix/unix_chkpwd.c

unix_chkpwd has been around for years, I can't believe that it's something 
that they haven't got to it yet.

Are you running kcheckpass as root (maybe SETUID)?  If so then SUSE would be 
using PAM without my patch to pam_unix.so which allows unix_chkpwd to be 
called if /etc/shadow can't be opened as root (without that patch it just 
aborts).  Also does SUSE have unix_verify (again part of my patch) installed?  
If not then the default policy will not work in all situations...

> > Maybe we should have a suse.te and suse.fc for such things?  One thing we
> > want to avoid if possible is having entries in types.fc for distribution
> > specific names which bloat types.fc and make setfiles run more slowly.
>
> I think this is a good idea. I have a few other policy snippets which
> are needed on SuSE but won't be suitable for general policy.
> As a start, I have attached a small suse.te and suse.fc.
> Can this be included in CVS?

I'll put it in my tree, Steve will have to decide about CVS when he next does 
an update.

# Depends: rpm.te

suse.te needs the above line.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
