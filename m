Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joshua Brindle'" <jbrindle@tresys.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "James Morris" <jmorris@namei.org>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>,
        "Paul Moore" <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 10:54:01 -0600
Message-ID: <001401c6fe9f$803af340$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588514A3C@exchange.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I think he's asking why both SA's aren't labeled as the peer on each
> side:
> 
> Side 1: socket client_t
> Outgoing SA: server_t
> Incomging SA: server_t
> 
> Side 2: socket server_t
> Outgoing SA: client_t
> Incoming SA: client_t
> 
> That way client_t has to be able to send to and recv from server_t, 
> Likewise server_t has to be able to send to and recv from client_t.

The problem is that when a client requires an SA to talk to the server,
there's currently no way to know that the server is at server_t. There's
currently no way for the IKE daemon (racoon) to figure this out when
negotiating an SA.

> 
> The SA labeling semantics can be changed at this point, they are just
> userland drive, correct?

Not entirely. racoon currently receives the context to use from the
spd (upstream kernel) or the sending socket (lspp kernel, soon to be
submitted for upstreaming).

> Last time I used them the labeling semantics
> weren't what AFAIK they are suppose to be anyway (eg., every SA was
> labeled client_t, not one labeled clien_t and the other labeled
> server_t)

This shouldn't be the case with the lastest lspp kernel.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
