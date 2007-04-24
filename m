Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OMdndC018055
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:39:49 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3OMdlps020472
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 22:39:47 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 25/33] libsemanage: policy server database hooks
Date: Tue, 24 Apr 2007 18:39:25 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588A71AE4@exchange.columbia.tresys.com>
In-Reply-To: <1177450771.3428.18.camel@localhost.localdomain>
References: <20070423213455.741326000@tresys.com> <20070423213744.959901000@tresys.com> <1177450771.3428.18.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Mon, 2007-04-23 at 17:35 -0400, jbrindle@tresys.com wrote:
> > plain text document attachment (semanage.ps_api.diff) 
> Implements all 
> > database functions for a policy server backend.
> 
> Any thoughts on how this should be merged? I'm concerned 
> about merging without a working policy server that has been 
> reviewed as well.
> 

Its available, review it ;) Note that it won't work with _just_ this
patch set as it expects the enforcement hooks to be present. It should
be trivial to comment out all the function pointers to get it to work
without that though.

> * What are your plans for the policy server - will it be 
> proposed for inclusion upstream?
> 

That was never my intention.

> * What is the timeline for completion of the policy server?
> 

I sent out an RFC/announcement a while back about its availability on
oss.tresys.com, noone bothered to respond.

> * Are their any docs at all about the protocol?
> 

Some, I'll dig them out and post them on oss.

> * Any progress on the exec-based policy server instead of the 
> long running daemon?
> 

The exec-based one has nothing to do with this patchset. The exec based
policy server would merely run with the new and old policies as
arguments and do its thing, it would not need to communicate with
libsemanage. This patchset is for the long-running daemon that listens
on a unix domain socket or tcp socket. The exec based one should come
along with the hook code when that gets ported over to the new
representation.

> Basically - this patch set is too large to review, there have 
> been no ongoing design discussions, there is no way to review 
> large portions of the patch set due to external dependencies, 
> and I have seen no proposed plan for merging.
> 

There have been occasional RFC's that noone responded to. 

> I have voiced these concerns previously and without at least 
> some of the above I'm opposed merging at this time.
> 

I believe you have some misconceptions about this patchset, read below.

> I would suggest as an alternative plan you do a depth-first 
> submission instead of the breadth-first approach that you are 
> currently attempting.
> That would allow a review of the end-to-end design with a 
> relatively small amount of code. From that point expanding 
> the coverage would only require a quick review that the patch 
> continues on the already accepted approach.
> 
> That steps that I suggest are:
> 
> * Choose a _single_ and _simple_ semanage operation to control.
> Something like adding a role to a user.
> 

This patchset nor the hooks currently available do access control on
semanage operations. Only policy modules have enforcement hooks written
and all that is available on oss.tresys.com.

> * Post a minimal policy server that can control this 
> operation (preferably exec-based).
> 

As part of the hooks, yes.

> * Post the libsemange code to communicate with the server 
> _only_ that single operation.
> 

That is silly, to choose a new backend for libsemanage you need all the
function pointers. Filling in all of them with direct versions except
for a single one would be at least confusing and at most would break
badly since both the local semanage and the policy server would attempt
to lock the store.

> * Create an example policy that controls this operation that 
> can be used to test and demonstrate the functionality.
> 

Example policy that controls what we have hooks for is available in
tests and on oss.tresys.com.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
