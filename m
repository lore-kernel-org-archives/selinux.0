Message-ID: <36282A1733C57546BE392885C061859201512E72@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Joy Latten
	 <latten@austin.ibm.com>,
        latten@us.ibm.com, Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>,
        selinux@tycho.nsa.gov
Subject: RE: ipsec and getpeercon()
Date: Tue, 5 Sep 2006 11:43:35 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> When NetLabel accepts an incoming connection it sets the 
> context of the
> local socket to equal the context of the connection.  Since NetLabel
> currently only supports sending the MLS label this context is 
> created by
> taking the non-MLS portion of the context (user:role:type) from the
> parent socket and the MLS label from the connection.  This is how the
> child socket is labeled

Thus far it's fine, but netlabel sets the peer_sid also to this context
which
would be incorrect. The TE portion of the "peer context" should ideally
be obtained from either the xfrm sid if present or in its absence the node
sid
(in the compat case).

In the secmark world, we will be setting peer_sid to the final secmark
of the packet (post reconciliation). So, I am not as much worried about
the above netlabel behavior (unless someone is intent on using the compat
case in conjunction with cipso with any seriousness).

> and this is the context reported to userspace
> when a getpeercon() call is made when NetLabel is in use.
> 
> Once NetLabel supports full contexts there will not be any need to use
> the parent socket's context.
> 
> -- 
> paul moore
> linux security @ hp
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
