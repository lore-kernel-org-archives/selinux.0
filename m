Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA03668
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 09:52:47 -0400 (EDT)
Date: Tue, 1 Oct 2002 09:51:56 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: policy version
In-Reply-To: <20021001153015.A24185@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210010944400.1579-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 1 Oct 2002, Tom wrote:

> However, one 100% reliable denial remains in the networking code,
> namely that I do not have any networking at all. All network access
> (ping, http, ftp, etc) throws an error about "unlabeled packet". This
> is in permissive mode. And the kernel does not even have labelled IP
> networking enabled.

If you mean the 'Unlabeled outbound packet' messages, those are only
warnings not denials, and should not prevent the flow of network traffic.
I can likely remove these printk's entirely; they were to help track down
an earlier problem with assigning labels to outbound packets.  When in
enforcing mode, any outgoing unlabeled packets will be denied by the
corresponding permission checks.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
