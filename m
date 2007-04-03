Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l33LgiGP014555
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 17:42:44 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l33LghPe022633
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 21:42:43 GMT
Message-ID: <4612CA4F.8090507@redhat.com>
Date: Tue, 03 Apr 2007 17:42:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dave Quigley <dquigley+selinux@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Applications without SELinux policies
References: <f888952b0704031313s4281e106tfcb9a47667a1319f@mail.gmail.com>
In-Reply-To: <f888952b0704031313s4281e106tfcb9a47667a1319f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dave Quigley wrote:
> Hello,
>    I am working on a high level language for SELinux for my master's
> thesis and I am at the point where I am trying to do code comparisons
> of my language vs other languages such as the reference policy and
> base SELinux policy.  I was wondering if anyone had any applications
> in mind for me to attempt this with that aren't overly complex. I can
> try to take some of the existing refpolicy applications and do this
> but I think it would be interesting to try writing something for an
> application from scratch since this would allow me to give a better
> account of experiences in developing the policy.
>
> Dave Quigley
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
How about exim.  We used to have policy for it, but it never made it 
from example to reference.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
