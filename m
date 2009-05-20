Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4KG8eF1013470
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 12:08:40 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n4KG8lg5014043
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 16:08:48 GMT
Date: Wed, 20 May 2009 12:08:32 -0400
Subject: Re: SELinux context patch
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Caleb Case <ccase@tresys.com>, Joshua Brindle <method@manicmethod.com>
Message-ID: <C639A340.A73BA%csellers@tresys.com>
In-Reply-To: <4A11A5EC.9000904@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/18/09 2:16 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> This patch adds context files for virtual_domain and virtual_image,
> these are both being used to locat the default context to be executed by
> svirt.
> 
> I also included the subs patch which I submitted before.  This patch
> allows us to substitute prefixes to matchpathcon.
> 
> So we can say /export/home == /home
> 
> and
> 
> /web == /var/www

I'm surprised that the subs patch didn't get much discussion before. Any
thoughts on this? Any worries that it might not meld well with the work
currently being done to integrate FCGlob?

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
