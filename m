Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA15845
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 13:03:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA25313
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 17:02:00 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA25309 for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 17:02:00 GMT
Date: Mon, 10 Jun 2002 13:02:47 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: mingetty on SuSE
In-Reply-To: <3D047478.87AD2BD1@dr-baldeweg.de>
Message-ID: <Pine.GSO.4.33.0206101259260.13767-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 10 Jun 2002, Carsten Grohmann wrote:

> I use mingetty on my SuSE 7.1. Mingetty needs read access to many
> different types in the proc directory to run correct.
> Now me question: Is it possible to limit the access to the different
> types only to the proc directory? I think no, but I hope anyone has an
> solution. In the other case I can not get mingetty the permissions,
> because it can read to much files. What getty programs do you use?

mingetty also runs on our machines, but I don't see this behavior.
I assume that you mean that mingetty is probing the /proc/PID entries, and
thus you are seeing audit messages for the various domains.  Unless
mingetty truly needs access to other domains' /proc/PID files, I'd suggest
using dontaudit (or auditdeny, if you haven't applied the dontaudit
patch) rules to suppress the audit messages but continue denying access.
See the xdm.te file or the user_macros.te file for examples.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
