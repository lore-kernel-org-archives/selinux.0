Date: Wed, 3 Jul 2002 10:08:55 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: udp receive
In-Reply-To: <1025704604.3619.11.camel@phobos>
Message-ID: <Pine.GSO.4.33.0207031002290.29509-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 3 Jul 2002, Timothy Wood wrote:

> I'm getting a recvfrom error for rpc.rquotad when I try to run nfs
> services.  I can find a can_udp_send in the rpcd.te but I can not find
> anything like can_udp_recv.  Is there anything like this that I need to
> assign to the rpc.te in order to allow it to recv udp?

I need more detail from the audit message, in particular the two types
from the scontext and tcontext fields. The can_udp_send macro
(defined in macros/global_macros.te) grants appropriate permissions for
the sender domain and the receiver domain, so you likely just need a
can_udp_send macro between the particular sender and receiver.  Of course,
this is only significant for loopback communication (or if you are using
the experimental labeled networking support for network communication),
since the packets are otherwise labeled based on the receiving network
interface and are handled by the can_network macro.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
