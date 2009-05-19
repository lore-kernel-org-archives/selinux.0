Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4JGGjHV012827
	for <selinux@tycho.nsa.gov>; Tue, 19 May 2009 12:16:45 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n4JGGqOp008146
	for <selinux@tycho.nsa.gov>; Tue, 19 May 2009 16:16:53 GMT
Date: Tue, 19 May 2009 12:16:37 -0400
Subject: Re: This patch fixes the exception handling in libselinux-python
 bindings
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C63853A5.A735D%csellers@tresys.com>
In-Reply-To: <4A11A48A.1020307@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/18/09 2:10 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> Basically we need to search for all interfaces that return an int and
> set those up as python exception handlers.

I presume this supercedes the patch submitted on March 4 titled "Patch to
python bindings" which used a single generic exception handler. Is that
correct? Why the switch from a generic exception handler to a shell script
to generate lots of specific exception handlers?

Thanks,
Chad 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
