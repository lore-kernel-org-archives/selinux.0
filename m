Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA25318
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 11:58:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA16014
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 15:58:08 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id PAA16010
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 15:58:08 GMT
Date: Mon, 16 Jul 2001 11:57:33 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: James Morris <jmorris@intercode.com.au>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: development of SELinux
In-Reply-To: <Pine.LNX.4.31.0107131154360.20323-100000@blackbird.intercode.com.au>
Message-ID: <Pine.SOL.3.95.1010716114458.15233U-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 13 Jul 2001, James Morris wrote:

> Also, a technical report is cited in Ajaya's networking paper titled "A
> Network Access Control Model for Flask" by Stephen S.  Is this report
> available to the public?

It wasn't really a technical report.  I analyzed the network protocol
implementation and wrote a set of rough notes that defined the
object classes, permissions, and control requirements for it.
Ajay used those notes as the basis of his work.  You'll find a more
up-to-date description of the same material in the Networking section
of the SELinux kernel document
(http://www.nsa.gov/selinux/slinux-abs.html).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
