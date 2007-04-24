Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3ONK7C3019398
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 19:20:07 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3ONK6PI009210
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 23:20:06 GMT
Subject: RE: [PATCH 25/33] libsemanage: policy server database hooks
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588A71AE4@exchange.columbia.tresys.com>
References: <20070423213455.741326000@tresys.com>
	 <20070423213744.959901000@tresys.com>
	 <1177450771.3428.18.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71AE4@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 19:20:00 -0400
Message-Id: <1177456800.3428.73.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-24 at 18:39 -0400, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > 
> > On Mon, 2007-04-23 at 17:35 -0400, jbrindle@tresys.com wrote:
> > > plain text document attachment (semanage.ps_api.diff) 
> > Implements all 
> > > database functions for a policy server backend.
> > 
> > Any thoughts on how this should be merged? I'm concerned 
> > about merging without a working policy server that has been 
> > reviewed as well.
> > 
> 
> Its available, review it ;)

I have - every time you have posted an RFC.

>  Note that it won't work with _just_ this
> patch set as it expects the enforcement hooks to be present. It should
> be trivial to comment out all the function pointers to get it to work
> without that though.
> 

But there is a working set of patches somewhere?

> > * What are your plans for the policy server - will it be 
> > proposed for inclusion upstream?
> > 
> 
> That was never my intention.
> 

Well - that is a problem in my opinion. I think we get two choices:

1) policy server and libsemanage are both upstream and are considered
closely coupled and developed in parallel.

2) protocol for communication with a policy server is well documented
and designed for interop with multiple server implementations.

If you want these huge, intrusive changes for code that won't be part of
upstream I think there needs to be some justification. Why should
upstream take on the maintenance of code that it ultimately can't fix
(because of a huge external dependency)? Why is this better as a
separate project? How will maintenance work? Is a different
implementation of the policy server really feasible or are the changes
really tailored to your specific implementation?

> > * What is the timeline for completion of the policy server?
> > 
> 
> I sent out an RFC/announcement a while back about its availability on
> oss.tresys.com, noone bothered to respond.
> 

I responded - http://marc.info/?l=selinux&m=117286669726063&w=2. That is
where I first asked about an exec based server.

> > * Are their any docs at all about the protocol?
> > 
> 
> Some, I'll dig them out and post them on oss.
> 
> > * Any progress on the exec-based policy server instead of the 
> > long running daemon?
> > 
> 
> The exec-based one has nothing to do with this patchset. The exec based
> policy server would merely run with the new and old policies as
> arguments and do its thing, it would not need to communicate with
> libsemanage.

I don't think that would work - how are you going to detect changes to
port labels or seusers? It would at least be massively inefficient.

You can simply exec the server and communicate over unix-domain sockets
(or a pair pipes). That would make the two servers very similar.

>  This patchset is for the long-running daemon that listens
> on a unix domain socket or tcp socket. The exec based one should come
> along with the hook code when that gets ported over to the new
> representation.
> 

What is the justification for the long-running daemon?

> > Basically - this patch set is too large to review, there have 
> > been no ongoing design discussions, there is no way to review 
> > large portions of the patch set due to external dependencies, 
> > and I have seen no proposed plan for merging.
> > 
> 
> There have been occasional RFC's that noone responded to. 
> 

I've responded to every RFC and stated these concerns every time. Trying
to suggest that nobody has responded is very inaccurate.

> > I have voiced these concerns previously and without at least 
> > some of the above I'm opposed merging at this time.
> > 
> 
> I believe you have some misconceptions about this patchset, read below.
> 

I don't think so. Basically - this forms the lowest part of the policy
server protocol. Trying to understand whether these patches make sense
in that context means understanding the system as a whole. Yes you have
posted pieces, but I have not seen something that works end-to-end.

Additionally, you keep posting these massive patch sets. They are not
reviewable in any sane way.

> > I would suggest as an alternative plan you do a depth-first 
> > submission instead of the breadth-first approach that you are 
> > currently attempting.
> > That would allow a review of the end-to-end design with a 
> > relatively small amount of code. From that point expanding 
> > the coverage would only require a quick review that the patch 
> > continues on the already accepted approach.
> > 
> > That steps that I suggest are:
> > 
> > * Choose a _single_ and _simple_ semanage operation to control.
> > Something like adding a role to a user.
> > 
> 
> This patchset nor the hooks currently available do access control on
> semanage operations. Only policy modules have enforcement hooks written

Yes, but they need to eventually and without that serializing all of
these data structures is not useful (at the moment). If they are only
going to be used for the policyrep then we should merge them later and
tailor them for that usage.

> > * Post a minimal policy server that can control this 
> > operation (preferably exec-based).
> > 
> 
> As part of the hooks, yes.
> 
> > * Post the libsemange code to communicate with the server 
> > _only_ that single operation.
> > 
> 
> That is silly, to choose a new backend for libsemanage you need all the
> function pointers. Filling in all of them with direct versions except
> for a single one would be at least confusing and at most would break
> badly since both the local semanage and the policy server would attempt
> to lock the store.
> 

Of course it would only work for a limited set of operations (and the
rest would likely return an error rather than having direct versions
substituted).

The point is that it would allow review of a smaller set of patches that
makes some sort of sense as a whole. Your submissions are not tailored
for thorough review and any feedback you receive is going to be shallow.
I think that is harmful in the long run.

If others (Steve and Darrell) want to merge these patches that's fine.
But based on the problems I have seen so far, the size of this patch
set, and the _many_ larger questions I'm opposed.

My biggest concern, honestly, is the long term viability and maintenance
of this code.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
