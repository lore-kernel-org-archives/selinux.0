Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA25129
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 12:54:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA11333
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 16:53:53 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id QAA11329
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 16:53:52 GMT
Date: Thu, 25 Oct 2001 12:54:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: randaL <randal@teleport.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: an offer to help with documentation  
In-Reply-To: <008b01c15d71$8b70d600$edaafea9@com>
Message-ID: <Pine.GSO.4.33.0110251245490.11191-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 25 Oct 2001, randaL wrote:

> Who is in charge of documentation, and what is the current status of
> these documents.  What format(s) are being used (plaintext, html,
> latex)?
> What are the priorities -- their expected completion dates?  Is
> additional help still needed in this area?

I don't think that these documents have been started, although much of the
necessary information is already available in some form in the existing
papers and technical reports.  The original technical reports and papers
were written using LaTeX, but we are now using DocBook SGML to write
documentation for the LSM-based SELinux security module, as recommended by
the Linux Documentation Project (http://www.linuxdoc.org).  This format is
being used for newer Linux kernel documentation (see
the files in Documentation/DocBook) in the kernel tree.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
