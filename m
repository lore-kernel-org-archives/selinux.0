Message-ID: <44FDA56A.6080806@hp.com>
Date: Tue, 05 Sep 2006 12:27:22 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com,
        selinux@tycho.nsa.gov
Subject: Re: ipsec and getpeercon()
References: <36282A1733C57546BE392885C061859201512E82@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201512E82@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>What would you propose the proper behavior for when there is 
>>no xfrm or
>>node sid?
> 
> The netif sid and in it's absense, the unlabeled init sid.

I don't like using the default unlabeled sid, it implies that the packet
is not labeled when it is - just not with any TE information.

I think that when you get down to it, in the absence of a xfrm or node
sid any TE value in the case of getpeercon() is going to be equally
"right" or "wrong" as they are all generated values in absence of the TE
bits.  Using the socket's sid as a TE base makes the most sense to me as
that is what is used to make access decisions on accepting the packet
into the socket's receive buffer.

>> Also, from a practical 
>>point of view
>>I suspect it to be very unlikely that anyone would be using more than
>>one form of network labeling for a connection.  Meaning that I would
>>expect the common case for NetLabel to be no xfrm or node sid.
> 
> Well, a node/netif could be used to constrain the range of cipso labels
> that can come/leave thru to the node/interface. Example: Secret on one
> netif, TS on another.

Yep, that's possibile, but not required.  I suspect we can play
everybody's favorite game of "Guess What the User's Thinking!" all day
long if we like ;)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
