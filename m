Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8G7Qrmn026803
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 03:26:53 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8G7QppQ000061
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 07:26:52 GMT
Subject: Re: policycoreutils manpages needed
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@parisplace.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, russell@coker.com.au,
        SE-Linux
	 <selinux@tycho.nsa.gov>
Date: Fri, 16 Sep 2011 09:26:26 +0200
In-Reply-To: <1315862884.2223.33.camel@vortex>
References: <201109011509.05872.russell@coker.com.au>
	 <4E5F8BAA.6060208@redhat.com> <1314912106.2334.2.camel@vortex>
	 <CACLa4ptfSU3obZ8OyMVFfKDsqwLQn58-O9YRUbCyU8=mLzn=tA@mail.gmail.com>
	 <1315862884.2223.33.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316157987.2364.65.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-09-12 at 23:28 +0200, Guido Trentalancia wrote:
> I would like to take this opportunity to suggest that we create manual
> pages for configuration files where possible (none available at the
> moment ?!?).

I would like to stress the above once again.

Further manual pages that I found missing and that would be nice to have
in the future:

- global /etc/selinux/config (difficult to name, would that be very
generically config.5) ?
- /etc/sestatus.conf: why not ?
- setrans.conf

> For example, the very first one I would like to have is
> semanage.conf.5. 

By the way, an initial version of the above has been prepared.

> Then we could also create restorecond.conf.5 and restorecond_user.conf.5
> (both of them should be trivial).

I shall perhaps starting doing the above next...

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
