Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9RBQQMA009609
	for <selinux@tycho.nsa.gov>; Thu, 27 Oct 2005 07:26:26 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9RBMJcv014166
	for <selinux@tycho.nsa.gov>; Thu, 27 Oct 2005 11:22:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: squid policy
Date: Thu, 27 Oct 2005 21:21:59 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1125686384.16388.66.camel@sgc.columbia.tresys.com>
In-Reply-To: <1125686384.16388.66.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510272122.06929.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 03 September 2005 04:39, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> While converting over the squid policy to a reference policy module, I
> noticed this:
>
> #squid requires the following when run in diskd mode, the recommended
> setting allow squid_t tmpfs_t:file { read write };
>
> I'm confused on how this can happen.  As far as I know, there shouldn't
> be no tmpfs_t files; everything should fall into a derived tmpfs domain,
> usually provided by tmpfs_domain().  Can someone clarify this?

It seems to work OK without it, remove it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
