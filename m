Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3MMLxM3012116
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 18:21:59 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n3MMLw1B002159
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 22:21:59 GMT
Date: Wed, 22 Apr 2009 18:21:57 -0400
Subject: Re: labeled network aware kernel
From: Chad Sellers <csellers@tresys.com>
To: Mark Webb <elihusmails@gmail.com>, <selinux@tycho.nsa.gov>
Message-ID: <C61510C5.A6A7F%csellers@tresys.com>
In-Reply-To: <9f066ee90904220426g563d2ebpa708ef8b6e1a4378@mail.gmail.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Josh's article talks about IPSec labeled networking (as well as using
SECMARK which provides firewall-level networking controls), as opposed to
Netlabel labeled networking. I played with the IPSec-based stuff in Fedora 9
and everything was there, so I'd imagine it's still there in F10. Just make
sure you install ipsec-tools.

Chad Sellers


On 4/22/09 7:26 AM, "Mark Webb" <elihusmails@gmail.com> wrote:

> I am interested in experimenting with the labeled networking that SE
> Linux offers.  I am reading through Josh Brindle's blog
> 
> http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/
> 
> My question is, how do I know if my kernel is capable of supporting
> this?  I am currently running Fedora 10 with all the latest updates
> but not sure how to check.
> 
> Also if I compile a kernel from source, is there anything that needs
> to be done in the configuring of the kernel build to enable the
> labeled networking?
> 
> Thanks,
> Mark
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
