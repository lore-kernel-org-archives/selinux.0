Date: Fri, 25 Jan 2002 14:04:13 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: Paul Krumviede <pwk@acm.org>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: network and module problems
In-Reply-To: <1011984582.1946.6.camel@phobos>
Message-ID: <Pine.GSO.4.33.0201251401231.7127-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 25 Jan 2002, Timothy Wood wrote:

> kernel: avc: denied { create } for pid=761 exe=/sbin/ip
> scontext=root:sysadm_r:sysadm_t tcontext=root:sysadm_r:sysadm_t
> tclass=netlink_socket

Yes, at present, there isn't a domain transition from sysadm_t to
netutils_t, so this isn't surprising.  But this wouldn't occur when run
by the rc scripts, and it doesn't explain why you would have a problem
when in permissive mode.   I still think you have a bad kernel
configuration (missing one or both of the Netlink or Routing messages
options).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
