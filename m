MIME-Version: 1.0
Subject: RE: Labeled networking packets
Content-Type: text/plain;
	charset="US-ASCII"
Date: Sat, 23 Sep 2006 10:13:35 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015735C9@chaos.tcs.tcs-sec.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Chad Hanson" <chanson@TrustedCS.com>,
        "Darrel Goeddel" <DGoeddel@TrustedCS.com>, <dwalsh@redhat.com>,
        <jmorris@redhat.com>, <latten@austin.ibm.com>,
        "Paul Moore" <paul.moore@hp.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
> 
<snip>
> We put a design doc out 3 months or so back (alerting selinux 
> list at least 2 times 
> http://marc.theaimsgroup.com/?l=linux-netdev&m=115136637800361&w=2),
> thought got the buy in, and went ahead and implemented it.
> 

I never had an indication of the type trans calculation of the incoming
socket, from the list above:
1.	Set the packet's secmark to the iptables context (R1a).
2.	If it is an ipsec packet,
...
		Yes: Set the secmark to ipsec label (replacing iptables
context
		     set in step 1) (R1b).

However (at least for me) the ramifications of using the secmark (I
think there is a vocabulary issue above) label from iptables in labeling
the socket weren't immediately obvious, this all took a while to sink
in...

> What baffles me is that people even had problems using 
> secmark as it currently exists, just a few days back. It 
> tells me people look at what has come along, and THEN find 
> (lack of) uses for it.
> 

Seems like that is a fact of development.. How many times do you design
an API for a library and then find that it is inadequate when you write
a user for it.. Sometimes you get lucky, sometimes not. There were also
quite a few misconceptions (on my part and on others) about how labeled
networking was expected to work so it took a little while to catch up.

> Let's go back to the drawing board, first of all define the 
> problems we are trying to solve, and come up with a design.
> 

My single requirement is that getpeercon() returns the full context of
the remote process (or some translation negotiated by racoon). 

For clarity sake, what are your own requirements? I can't follow the top
secret coming in a secret interface thing. If the interface is secret
the ipsec sa will be secret, the secmark labels will be secret and the
enforcement won't let it in (which is desirable right?) Why is a type
transition necessary for this situation?

Also, Stephen mentioned a couple times that using netlabel and ipsec is
ok basically to allow course grained ranged ipsec associations and finer
grained netlabel labels for the actual level. Assuming that we are sure
we can deal with it when (if) netlabel handles full contexts I guess I
don't have a problem with this anymore. It wouldn't be any kind of
transition though (I think). It would just be that the contexts were
compared and if netlabel is within the range it takes priority, if it is
outside the range it should be an error and the packet should be
rejected.

If we use racoon to negotiate the label of the SA, and racoon is made to
be flexible (eg., if you want the domain it can use that, if you want
the data label you could use that) then I don't see any reason why you
(or anyone) would want to use the secmark label anymore, right? 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
