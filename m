Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA14134
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 08:00:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA01987
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 11:59:17 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA01983 for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 11:59:17 GMT
Date: Mon, 22 Jul 2002 07:59:57 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Charles R. Fuller" <charlesrfuller@netscape.net>
cc: <selinux@tycho.nsa.gov>
Subject: Re: booting problem
In-Reply-To: <3D388424.2050506@netscape.net>
Message-ID: <Pine.GSO.4.33.0207220757200.4503-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 19 Jul 2002, Charles R. Fuller wrote:

> The specific error is a kernel panic on boot of the selinux kernel and
> an error point to correcting the referrence for "ROOT="
>
> The reference "ROOT=" is the same for the none linux kernels.  Thanks
> for the help in advance.

Could you provide the exact output, along with a copy of your lilo.conf or
grub.conf (omitting any passwords, of course)?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
