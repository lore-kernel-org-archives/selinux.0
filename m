Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KCFvrT003220
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 08:15:57 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KCFsQ4023678
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 12:15:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: distro.tun
Date: Fri, 20 Aug 2004 22:15:52 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200408192333.25072.russell@coker.com.au> <200408201459.47366.russell@coker.com.au> <1093002687.16585.34.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1093002687.16585.34.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408202215.52503.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Aug 2004 21:51, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > By using "redhat", "debian", "gentoo", and "suse" as flag macros we are
> > essentially making them reserved words.  I think that the most practical
> > solution to this problem is to use "USING_REDHAT" etc as the flag macros.
> > The chance of someone wanting a user role named USING_REDHAT_r is quite
> > low, while the incidence of people wanting a redhat_r role is much
> > higher.
>
> distro_redhat, distro_debian, distro_gentoo, distro_suse.  No need to
> shout.

I think that there is a need to shout.  As there is currently no upper-case 
used in the policy the chance of someone using the string "USING_REDHAT" or 
"DISTRO_REDHAT" is lower than that of "using_redhat" or "distro_redhat".

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
