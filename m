Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA20218
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 08:38:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA13923
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 13:37:37 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA13919
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 13:37:37 GMT
Date: Mon, 19 Nov 2001 08:37:53 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tracy R Reed <treed@ultraviolet.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SELinux policy configuration tutorial?
In-Reply-To: <20011116190059.L24702@ultraviolet.org>
Message-ID: <Pine.GSO.4.33.0111190826490.24517-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 16 Nov 2001, Tracy R Reed wrote:

> I am having problems understanding how to define policies and how the
> roles, domains, types, etc. work to do this. I am slowly making my way
> through the documentation on the web site but I find most of it to be
> quite inscrutable. Has anyone written up a general tutorial on how all of
> this stuff works in practice?

I don't think anyone has written a general tutorial.  However, you'll find
quite a bit of useful information in the security server section of the
first technical report, the entire second technical report, and the OLS
2001 paper, all of which are on the web site.  Several people outside of
the SELinux project have already contributed to the example policy
configuration, including both refinement of the existing domains and new
domains (e.g. Mark Westerman's mount_t, ipsec_t and gdm_t domains,
Yuichi Nakamura's named_t domain, David Wheeler's ping_t and hwclock_t
domains).  Feel free to ask specific questions about policy configuration
on the list.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
