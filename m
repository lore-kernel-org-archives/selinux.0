Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA24855
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 09:33:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA23661
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 13:33:32 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA23657
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 13:33:31 GMT
Date: Mon, 2 Jul 2001 09:33:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: SELinux "vs" trustedBSD
In-Reply-To: <Pine.LNX.4.30.0107021217200.4791-100000@linux16.zdv.uni-tuebingen.de>
Message-ID: <Pine.SOL.3.95.1010702092306.1066B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2 Jul 2001, Jan Petranek wrote:

> Has anyone already compared trustedBSD to SELinux? Or seen any papers on
> it? The documentation provided on the trustedBSD-website seems a little
> sparse.

TrustedBSD is developing a variety of trusted operating system features
for FreeBSD, including mandatory access controls, while SELinux has
specifically focused on developing flexible mandatory access controls for
Linux.  The TrustedBSD mandatory access controls are currently limited
to hardcoded policies such as multi-level security and Biba integrity, but
they plan on migrating to a more flexible MAC architecture in the future.
The TrustedBSD project has the ability to directly commit their features
(as they mature) into the FreeBSD kernel, since their lead developer
is also a FreeBSD core team member, whereas we lack such a direct path
into the Linux kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
