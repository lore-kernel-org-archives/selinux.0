Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n47IIjav005370
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 14:18:45 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n47IMN1j020071
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 18:22:23 GMT
Date: Thu, 07 May 2009 14:18:43 -0400
Subject: Re: Fixes for libselinux/matchpathcon
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C6289E43.A6F98%csellers@tresys.com>
In-Reply-To: <49D377FC.1040303@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/1/09 10:19 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
<snip>
> 
> If matchpathcon returns ENOENT, we return <<none>>

matchpathcon doesn't set errno. The underlying selabel functions do, which
is why this works sometimes. Unfortunately, you don't know which of the
underlying functions set errno, so you display <<none>> if any of them set
errno to ENOENT. For instance, if the file_contexts file is missing, the
selabel_open() call sets errno to ENOENT. It would be better to change
matchpathcon() itself (and possibly it's underlying functions like
matchpathcon_init()) to report back errors depending on what failed.

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
