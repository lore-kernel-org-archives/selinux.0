Date: Wed, 3 Jul 2002 10:13:02 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: udp receive
In-Reply-To: <1025704604.3619.11.camel@phobos>
Message-ID: <Pine.GSO.4.33.0207031009090.29509-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 3 Jul 2002, Timothy Wood wrote:

> I'm getting a recvfrom error for rpc.rquotad when I try to run nfs
> services.  I can find a can_udp_send in the rpcd.te but I can not find
> anything like can_udp_recv.  Is there anything like this that I need to
> assign to the rpc.te in order to allow it to recv udp?

By the way, please note that the rpcd_t domain is simply a placeholder for
rpc daemons, and that you should really define an individual domain for
any rpc daemon that requires privilege (e.g. nfsd).  You should also
consider limiting this domain to true least privilege by removing
every_domain and only adding the bare minimum set of permissions needed
for operation.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
