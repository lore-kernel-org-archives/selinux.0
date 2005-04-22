Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3MNPagA019981
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 19:25:52 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3MNHXrf003585
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 23:17:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: sshd transition points (user@ip or net_context with setcon)
Date: Sat, 23 Apr 2005 08:20:32 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20050221134124.GR14038@lkcl.net>
In-Reply-To: <20050221134124.GR14038@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504230820.35232.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 22 February 2005 00:41, Luke Kenneth Casson Leighton 
<lkcl@lkcl.net> wrote:
> after kindly receiving a message which advised how to achieve the
> same net effect as sought (using AllowUsers in sshd_config) i was
> wondering if anyone considered it _actually_ worthwhile to go
> ahead and provide a means to achieve the same effect (as AllowUsers)
> with SE-Linux policy and some modifications to sshd (to use setcon
> and thereby be able to do net_contexts on a per-user basis).

Have you considered using sshd_extern_t?

The current policy allows you to configure inetd to run sshd via:
runcon system_u:system_r:sshd_extern_t sshd -- -i

You could have sshd being run with the default context for connections 
corresponding to trusted IP addresses and use runcon to get sshd_extern_t for 
others.  The policy is flexible enough to allow multiple sshd contexts to be 
added easily which correspond to different combinations of user roles.

Some inetd programs allow running different programs based on IP address, 
while others require you to use a different port for each one (maybe have the 
firewall convert incoming connections to different destination ports based on 
the source IP Address).

The disadvantage of AllowUsers is that it's enforced by the sshd itself.  If 
you are concerned about the security of the sshd then restricting external 
users to security contexts that don't permit any damage is a good idea.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
