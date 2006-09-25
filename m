Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1159196366.3450.13.camel@localhost.localdomain>
References: <36282A1733C57546BE392885C0618592015735C9@chaos.tcs.tcs-sec.com>
	 <1159196366.3450.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 13:58:38 -0400
Message-Id: <1159207118.15305.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 10:59 -0400, Karl MacMillan wrote:
> Thinking about this over the weekend, it seems to me that we are still
> talking around the problem a bit. We essentially have 2 goals:
> 
>     1) Packet labeling - assigning labels to the _data_ transferred
>        over the network. Secmark does only this and - from what I can 
>        tell - this has been the primary motivation for Netlabel and 
>        ipsec.

I think that you need to draw a distinction between secmark (internal
marking of packets within the local network stack for access control
purposes to replace and generalize the old netif/node/port labels and
checks) and labeled networking (preserving the actual security label of
the data as it propagates through the network stack and across the
wire).  In the original secmark scheme, the secmark does not reflect the
security properties of the sender (data originator) at all in many
instances (e.g. all packets on an inbound connection to apache get
http_server_packet_t, regardless of which side sent them, and packets on
an outbound connection to apache get http_client_packet_t which tells us
about their destination not their sender).  The secmark also encodes
contextual information like the connection direction
(http_server_packet_t for an inbound connection vs. http_client_packet_t
for an outbound connection), whereas labeled networking does not encode
such information in the label and would require separate checks to
provide such a distinction, as the send/recv checks themselves do not
provide that distinction.

>     2) Domain (process) context transmission - essentially, making 
>        getpeercon work for non-local sockets. The important thing here 
>        is that this is separate and distinct from the label of the 
>        packet. getpeercon (which is not just a poorly named function - 
>        the semantic is intentional and useful) should return the full 
>        context of the process on the other end of the network 
>        connection.

getpeercon was always to get the context of the peer socket, as that is
the endpoint and serves logically as a proxy for the remote process or
processes that are allowed to access the socket.  But this isn't
necessarily distinct from a packet/data label in the labeled networking
sense, because it does reflect the security properties of the sender of
the data, which is the logical default for the packet/data label in the
absence of any explicitly specified value (for which no kernel interface
presently exists for either AF_LOCAL or AF_INET, ever since we lost the
extended socket calls of the old SELinux).

> There have been various suggestions about how to reconcile these two
> goals, essentially via encoding additional data via range and type
> transitions. I believe that this _will never work_. It is not possible
> to recover the domain context fully from the packet label - if nothing
> else the user and role will be lost (e.g., a data label would likely use
> object_r), which is unacceptable for the imagined uses of getpeercon.

Actually, it _could_ work, with suitable definition of the transition
function, but it may be unwieldy in the resulting policy.  And there is
still the issue of how to sanely write a single policy that allows
everything to work correctly, which I was trying to delve into in my
earlier email.

> The choices I see are:
> 
>     1) Leave netlabel and ipsec as packet labeling _only_. Somehow 
>        reconcile / prioritize the various packet labels.
>
>     2) Make netlabel and ipsec transmit the sending domain context 
>        _only_. Somehow reconcile the various domain labels.
>
>     3) Allow ipsec to transmit 2 contexts or designate that Netlabel 
>        passes 1 kind of remote label and ipsec transmits the other 
>        (e.g., netlabel labels the packet while ipsec transmits the 
>        sending domain context).

I thin the only real choices are:
1) Add a separate field to the sk_buff for use by labeled networking so
that we don't have to overload secmark in this manner, or
2) Deal with the secid reconciliation, but work out the policy
implications.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
