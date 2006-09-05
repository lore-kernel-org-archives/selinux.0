Message-ID: <44FD9F72.5040704@hp.com>
Date: Tue, 05 Sep 2006 12:01:54 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com,
        selinux@tycho.nsa.gov
Subject: Re: ipsec and getpeercon()
References: <36282A1733C57546BE392885C061859201512E72@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201512E72@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>When NetLabel accepts an incoming connection it sets the 
>>context of the
>>local socket to equal the context of the connection.  Since NetLabel
>>currently only supports sending the MLS label this context is 
>>created by
>>taking the non-MLS portion of the context (user:role:type) from the
>>parent socket and the MLS label from the connection.  This is how the
>>child socket is labeled
> 
> Thus far it's fine, but netlabel sets the peer_sid also to this context
> which
> would be incorrect. The TE portion of the "peer context" should ideally
> be obtained from either the xfrm sid if present or in its absence the node
> sid
> (in the compat case).

What would you propose the proper behavior for when there is no xfrm or
node sid?  It seems to be much more consistent (and desirable) to pull
the TE bits from a single source.  Also, from a practical point of view
I suspect it to be very unlikely that anyone would be using more than
one form of network labeling for a connection.  Meaning that I would
expect the common case for NetLabel to be no xfrm or node sid.

> In the secmark world, we will be setting peer_sid to the final secmark
> of the packet (post reconciliation). So, I am not as much worried about
> the above netlabel behavior (unless someone is intent on using the compat
> case in conjunction with cipso with any seriousness).

This is an important discussion but I think it's probably best until you
post the entire secid reconciliation patch so we are all on the same page.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
