Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5B0pmrT003232
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 20:51:48 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5B0pfP2005675
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 20:51:42 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [debian] - installation of mysqld requires chfn
Date: Fri, 11 Jun 2004 10:52:37 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040609222209.GH5727@lkcl.net> <200406101220.53966.russell@coker.com.au> <20040610204147.GE2861@lkcl.net>
In-Reply-To: <20040610204147.GE2861@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406111052.37270.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 11 Jun 2004 06:41, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> if you look at dpkg.te, and presumably rpm.te too, are you at all
> concerned about the ever-increasing permission set that's added to
> these two packages' policies?

No.

> it doesn't seem right to me that dpkg's policy file has to grant
> permission to run passwd.te in order to install oh, say, foomatic-db.
>
> it just goes against the grain of granting least privilege.

We can't grant least privilege to dpkg and rpm.  By design these programs need 
write access to every significant file on the system and can totally break 
the system with the smallest bug.

Trying to reduce the access of such programs to the system makes no sense.

> i'm just concerned that dpkg.te and rpm.te turn into these
> pretty-much-everything "monsters".

That's what they do!

> so, let's see... is it possible to add something into dpkg
> (se_dpkg?) to make it call run_init or do a domain_auto_trans
> just before calling the postinstall / prerm etc. scripts,
> to move it from dpkg.te into dpkg_<PACKAGENAME>.te?

What good would that do?  dpkg/rpm still has full control.  They can replace 
libc, they can replace anything in /sbin, /bin, etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
