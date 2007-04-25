Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3P4gQKI030273
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 00:42:26 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3P4gPEA012912
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 04:42:25 GMT
Subject: RE: [PATCH 25/33] libsemanage: policy server database hooks
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588A71AE5@exchange.columbia.tresys.com>
References: <20070423213455.741326000@tresys.com>
	 <20070423213744.959901000@tresys.com>
	 <1177450771.3428.18.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71AE4@exchange.columbia.tresys.com>
	 <1177456800.3428.73.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71AE5@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 00:42:24 -0400
Message-Id: <1177476144.3428.83.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-24 at 19:57 -0400, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 

<snip>

> > Well - that is a problem in my opinion. I think we get two choices:
> > 
> > 1) policy server and libsemanage are both upstream and are 
> > considered closely coupled and developed in parallel.
> > 
> > 2) protocol for communication with a policy server is well 
> > documented and designed for interop with multiple server 
> > implementations.
> > 
> 
> I was going to go for #2. It doesn't matter that much to me though, we
> could put the policy server in the upstream tree.
> 

For #2 I think we need much more documentation and design review because
it basically becomes a public protocol. That is why I think #1 is better
- then we can just say they are closely coupled and the protocol between
the components is private. It will still need versioning, etc., but
because they are maintained together we will have more freedom.

> > If you want these huge, intrusive changes for code that won't 
> > be part of upstream I think there needs to be some 
> > justification. Why should upstream take on the maintenance of 
> > code that it ultimately can't fix (because of a huge external 
> > dependency)? Why is this better as a separate project? How 
> > will maintenance work? Is a different implementation of the 
> > policy server really feasible or are the changes really 
> > tailored to your specific implementation?
> > 
> 
> It's a generic protocol and we provide generic hooks (we actually
> provide more data in the hooks than my specific implementation uses). I
> don't know how useful another implementation would be, though.
> 

I don't think another implementation would be useful, which is why I
think it is better just to upstream the policy server.

> > > > * What is the timeline for completion of the policy server?
> > > > 
> > > 
> > > I sent out an RFC/announcement a while back about its 
> > availability on 
> > > oss.tresys.com, noone bothered to respond.
> > > 
> > 
> > I responded - 
> > http://marc.info/?l=selinux&m=117286669726063&w=2. That is 
> > where I first asked about an exec based server.
> > 
> 
> Err.. Right, sorry about that
> 
> > > > * Are their any docs at all about the protocol?
> > > > 
> > > 
> > > Some, I'll dig them out and post them on oss.
> > > 
> > > > * Any progress on the exec-based policy server instead of 
> > the long 
> > > > running daemon?
> > > > 
> > > 
> > > The exec-based one has nothing to do with this patchset. The exec 
> > > based policy server would merely run with the new and old 
> > policies as 
> > > arguments and do its thing, it would not need to communicate with 
> > > libsemanage.
> > 
> > I don't think that would work - how are you going to detect 
> > changes to port labels or seusers? It would at least be 
> > massively inefficient.
> > 
> 
> The policy server will eventually have to implement access control on
> ocontext changes and we could just pass the whole active and previous
> directories to it to do the things not in policies, like seusers.

It seems a shame to not use the information that we would already have
about what changed.

>  I
> guess we could make it work with a socket pair though.
> 

That seems to be a gain in efficiency and makes it possible to easily
have a daemon or an exec-based version.

> > You can simply exec the server and communicate over 
> > unix-domain sockets (or a pair pipes). That would make the 
> > two servers very similar.
> > 
> > >  This patchset is for the long-running daemon that listens 
> > on a unix 
> > > domain socket or tcp socket. The exec based one should come 
> > along with 
> > > the hook code when that gets ported over to the new representation.
> > > 
> > 
> > What is the justification for the long-running daemon?
> > 
> 
> Network management.
> 

Well - I still think that it is better to just allow proper local
management and let higher-level tools (like
http://reductivelabs.com/projects/puppet/ for example) do the remote
management parts. Plus, I really hesitate to expose something like this
on the network on every client. Using something like puppet lets you use
a pull model.


<snip>

> > > 
> > > This patchset nor the hooks currently available do access 
> > control on 
> > > semanage operations. Only policy modules have enforcement hooks 
> > > written
> > 
> > Yes, but they need to eventually and without that serializing 
> > all of these data structures is not useful (at the moment). 
> > If they are only going to be used for the policyrep then we 
> > should merge them later and tailor them for that usage.
> > 
> 
> They should be useful for both cases. We'll need them for policyrep soon
> and for policy server later, I was hoping to have them up and
> generalized for both usages.
> 

Ok - looking through these again. If you take out the silly duplication
between libsemanage / libsepol, just one set of serialization patches
are fairly small. I'm not opposed in principal to merging that after the
comments are addressed 
(just for libsepol - I think we should remove the libsemanage code).

After that, could you post some more in-depth discussion about the
networking bits?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
