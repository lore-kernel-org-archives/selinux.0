Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PI8YqX007806
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 14:08:34 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3PI8WIr002161
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 18:08:32 GMT
Subject: RE: [PATCH 01/33] libsepol: basic serilization support
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: James Antill <jantill@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1177521099.22450.15.camel@code.and.org>
References: <20070423213455.741326000@tresys.com>
	 <20070423213721.090230000@tresys.com>
	 <1177444855.10744.25.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71AE2@exchange.columbia.tresys.com>
	 <1177476585.3428.91.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71B39@exchange.columbia.tresys.com>
	 <1177514210.3428.117.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588B40435@exchange.columbia.tresys.com>
	 <1177515622.3428.126.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588B4043E@exchange.columbia.tresys.com>
	 <1177516853.3428.131.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588B4044B@exchange.columbia.tresys.com>
	 <1177521099.22450.15.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 14:08:30 -0400
Message-Id: <1177524510.3428.137.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-25 at 13:11 -0400, James Antill wrote:
> On Wed, 2007-04-25 at 12:25 -0400, Joshua Brindle wrote:
> 
> > So move boiler plate casting and checking to the call site? I guess we
> > can do that... :\
> 
>  Having a wrapper that does it for you isn't such a bad thing, and
> calling that wrapper serialize_sizet/unserialize_sizet or whatever isn't
> the worst thing in the world[1].

Like serialize_sizet_to_uint32.

>  The problem, from my POV, is that you check on the receiving side if
> size_t happens to be bigger than uint32_t[2]. You are basically sending
> a uint64_t over the network that can never hold a value bigger than a
> uint32_t, so everything gets to send extra zeros. This is very
> misleading, just say what you mean by having the protocol use uint32_t,
> and check at the sending side if the value > uint32_t can hold, if so
> error in some way.
> 

I would say that the problem is more general. The goal here is to
serialize data structures - i.e., convert the data structure to/from a
byte stream. Unfortunately, you are using data structures that you
cannot reliably turn into a byte stream.

So the solution is to change the data structures and check for overflow
when you insert into the data structure not when you [un]serialize the
structure. As James points out, this approach will put the error much
closer to the failure point. As it stands now the error is as far away
from the failure point as possible (and possibly on another system
entirely).

I would suggest:

sepol_sizet_to_uint32: conversion only - checks for overflow
sepol_serialize_uint32: serialize only

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
