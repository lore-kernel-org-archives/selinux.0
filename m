Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7K1x3rT000875
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 21:59:03 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7K1wMpw020729
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 01:58:22 GMT
Subject: Re: policy for scponly - need help
From: Colin Walters <walters@verbum.org>
To: Stefan SF <stefan@sf-net.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040819173620.GA8543@crux.localdomain>
References: <20040819173620.GA8543@crux.localdomain>
Content-Type: text/plain
Date: Thu, 19 Aug 2004 21:59:43 -0400
Message-Id: <1092967183.29540.30.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-19 at 19:36 +0200, Stefan SF wrote: 
> Hi,
> 
> I'm trying to build a policy for a program called "scponly".

scponly seems similar to rssh.  You may want to try my rssh policy:
http://verbum.org/files/rssh_macros.te
http://verbum.org/files/rssh.te
http://verbum.org/files/rssh.fc

It would likely be sufficient to just add a regexp for scponly to
rssh.fc.

> When I'm using the scponly program all things went fine, but when I'm trying to use the scponlyc program I get this message:
> 
> audit(1092936373.217:0): avc:  denied  { dac_override } for  pid=5220 exe=/usr/sbin/scponlyc capability=1 scontext=test:user_r:user_t tcontext=test:user_r:user_t tclass=capability
> audit(1092936373.217:0): avc:  denied  { dac_read_search } for  pid=5220 exe=/usr/sbin/scponlyc capability=2 scontext=test:user_r:user_t tcontext=test:user_r:user_t tclass=capability

Hmmm, odd.  Are you logging in as root?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
