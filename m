Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA00664
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 12:35:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA10664
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 16:33:50 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA10660 for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 16:33:49 GMT
Date: Mon, 29 Apr 2002 12:34:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: insmod
In-Reply-To: <20020429162425.4B40D3EA8@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204291233550.19520-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 29 Apr 2002, Russell Coker wrote:

> insmod_t needs write access to sysctl_t and sysctl_kernel_t for managing the
> tainted flag.  I've had this in my tree for ages (and I hope this will be in
> the new release - it's been discussed here before).

Why sysctl_t?  I would only expect it to need write access to
sysctl_kernel_t for the tainted flag.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
