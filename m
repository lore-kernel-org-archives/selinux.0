Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5B0k7rT003194
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 20:46:07 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5B0juP2005541
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 20:45:57 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Date: Fri, 11 Jun 2004 10:46:51 +1000
Cc: Ed Street <edstreet@street-tek.com>, "'SE-Linux'" <selinux@tycho.nsa.gov>
References: <20040610022221.7796D3A4063@abyss.simplyaquatics.com> <200406101510.31547.russell@coker.com.au> <20040610202134.GB2861@lkcl.net>
In-Reply-To: <20040610202134.GB2861@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406111046.51540.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 11 Jun 2004 06:21, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > issue in version 1.1.7-5 by making the files not be copied to the chroot
> > if master.cf does not specify any services to be chrooted.
>
>  ah - ah... do you know if he addressed the issue of the context of
>  those files being copied over from /etc/ to /var/spool/postfix/etc

Of course not.  He just made the scripts not copy them if they are not needed.

>  as well, such that of course initrd_t then needs to have permission
>  to rm etc_t and such?

There is no initrd_t, I presume you mean initrc_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
