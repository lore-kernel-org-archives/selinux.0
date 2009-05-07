Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n47K5pBI020929
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 16:05:51 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n47K4CwP018511
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 20:04:12 GMT
Date: Thu, 07 May 2009 16:05:49 -0400
Subject: Re: We have moved matchpathcon to /sbin from /usr/sbin
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C628B75D.A6FB2%csellers@tresys.com>
In-Reply-To: <49D37881.6040102@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/1/09 10:21 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> Some init scripts wanted to use matchpathcon before /usr is mounted.

Looks fine except for adding the now split out matchpathcon to the clean
target. I'll fix that in the merge.

Acked-by: Chad Sellers <csellers@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
