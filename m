Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5A8CZrT025763
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 04:12:35 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5A8CUaH029589
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 04:12:32 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: SELinux on Debian (Sid)
Date: Thu, 10 Jun 2004 18:13:12 +1000
Cc: Magnus Therning <magnus-work@therning.org>, selinux@tycho.nsa.gov
References: <20040609144404.GJ5477@philips.com> <20040609175001.GC5727@lkcl.net>
In-Reply-To: <20040609175001.GC5727@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406101813.12520.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jun 2004 03:50, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> 2) DO NOT add selinux.lemuria.org/newselinux to your /etc/apt/sources.list
>
> 3) DO add selinux.lemuria.org/walters to your /etc/apt/sources.list

Colin has not been working on his for quite some time.  Why would you want to 
use a repository with old versions that is not being maintained instead of a 
repository that is actively maintained with the latest versions?

> 4) DO install the (probably downgraded) cron, logrotate, coreutils etc.
>    from /walters

Why not install the latest versions of cron, logrotate, coreutils etc from my 
repository which requires no special effort as they are a minor sub-version 
greater than the versions in Debian/unstable?

> 5) use the 1.12 .debs for libselinux1 and selinux-policy-default
>    and selinux-utils policycoreutils etc. they are the latest and they
>    ARE in [ftp/http].*.debian.org

They are also only tested with the latest versions of the packages from my 
site, not from the /walters repository.

> 6) once you have installed the 1.12 selinux-policy-default and stuff,
>    YOU MUST go to http://sf.net/projects/selinux and download a
>    replacement genhomedircon from the
>    selinux-usr/policycoreutils//scripts/ directory.
>
>    the version presently released is brain-dead and does something
>    different and unexpected.

I've uploaded a new policycoreutils package that fixes this, along with a new 
policy source package to match.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
