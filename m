Date: Fri, 25 Jan 2002 13:54:13 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Paul Krumviede <pwk@acm.org>
cc: Timothy Wood <timothy@hallcomp.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: network and module problems
In-Reply-To: <90286525.1011954170@localhost>
Message-ID: <Pine.GSO.4.33.0201251353230.7127-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 25 Jan 2002, Paul Krumviede wrote:

> is this true for both 2.4.16 and 2.4.17 kernels? i just looked at my RH7.2
> system, and the kernel config file for the 2.4.16 build has CONFIG_NETLINK,
> CONFIG_RTNETLINK and CONFIG_NETLINK_DEV, while the 2.4.17
> kernel only has CONFIG_NETLINK_DEV (and Documentation/Configure.help
> implies that the other 2 are only for 2.5 kernels)...
>
> so maybe going to the new release would have avoided this confusion
> after all.

I think that the two "basic" netlink options were mainstreamed in 2.4.17.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
