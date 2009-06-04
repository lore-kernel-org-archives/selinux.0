Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n54KlnOi025384
	for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2009 16:47:50 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n54Km7jE013218
	for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2009 20:48:07 GMT
Date: Thu, 04 Jun 2009 16:47:48 -0400
Subject: Re: SELinux context patch
From: Chad Sellers <csellers@tresys.com>
To: Caleb Case <ccase@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <method@manicmethod.com>
Message-ID: <C64DAB34.A7B1B%csellers@tresys.com>
In-Reply-To: <150846cc0906041213n79e5e51ex3c72ab2cacb0ce64@mail.gmail.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 6/4/09 3:13 PM, "Caleb Case" <ccase@tresys.com> wrote:
> 
> I don't think it will adversely affect FCGlob integration.
> 
Very good.

<snip>
> 
> It doesn't support directories with spaces in them.

An excellent point, though it looks like file_contexts doesn't support
spaces right now either.

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
