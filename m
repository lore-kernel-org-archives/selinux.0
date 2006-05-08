Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k48LTaPp031753
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 17:29:36 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k48LTYEL021100
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 21:29:35 GMT
Date: Mon, 8 May 2006 17:29:33 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Karl MacMillan <kmacmillan@tresys.com>
cc: Joshua Brindle <method@gentoo.org>, selinux@tycho.nsa.gov,
        netdev@vger.kernel.org, netfilter-devel@lists.samba.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC] SECMARK 1.0
In-Reply-To: <1147110088.32719.56.camel@jackjack.columbia.tresys.com>
Message-ID: <Pine.LNX.4.64.0605081719440.18947@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>  <445E288B.4040908@gentoo.org>
  <Pine.LNX.4.64.0605071323330.9423@d.namei> <1147110088.32719.56.camel@jackjack.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 8 May 2006, Karl MacMillan wrote:

> Something like CONNMARK seems preferable to me (perhaps even allowing
> type_transition rules to give the related packets a unique type). This
> makes the labeling reflect the real security property of the packets.

That's arguable.  The real security property afaict is that the packets 
are of some state (established or related to an existing connection).  It 
is implicit in the mechanism that they're tracked as part of an authorized 
connection.

> Yes, we are trusting the conntrack to mark the packets accurately, but
> it makes the policy match the intent. Otherwise it is not possible to
> reason about information flow using just the policy.

Why not?  You just state that all established and related packets reaching 
vsftpd are valid, and that no invalid packets can deliver data to the 
application.  You can play tricks and stick a label on a packet but that 
doesn't change what's actually happening or your ability to reason about 
it.  You assume conntrack works correctly (and if it doesn't, then 
labeling connections will break, too).

> Are there serious downsides to this approach?

Yes, it's an ugly hack which is not needed.

> > You can always not use conntrack and emulate the existing controls, as 
> > well.
> 
> Yes, but gaining connection tracking is a major advantage of this
> approach over the existing controls.

The point is to show that this scheme provides much stonger security 
assurrances, and that if you wished, you could easily rervert to stateless 
filtering and have the "correct" labels on the packets; which would be 
worse.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
