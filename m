Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NJB9rT011965
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 15:11:09 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NJB7Uk029871
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 19:11:08 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC] Upstream policy handling
Date: Fri, 24 Sep 2004 05:10:58 +1000
Cc: Colin Walters <walters@verbum.org>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Joshua Brindle <method@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <414DA0A7.1000708@gentoo.org> <1095695627.4431.157.camel@nexus.verbum.private> <4152FD20.4020302@redhat.com>
In-Reply-To: <4152FD20.4020302@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409240510.58045.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 Sep 2004 02:43, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >I'd need to see your patch, but if sysadmfile is really as close to
> >{ file_type -shadow_t } as you say, then that sounds fine too.
>
> With russells latest patches sysadmfile is the same as file_type
> -shadow_t , so we should be able to have a
> tunable to restrict sysadm_r access to sysadmfile.

Alternatively we could change sysadmfile to be more restrictive and use 
{ file_type -shadow_t } when the need the current sysadmfile behaviour.

The aim of my patch was not to have an attribute that gave the same result as 
{ file_type -shadow_t } but to make things more regular so we've got a 
consistent base for the next stage of development.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
