Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4AK0Ipn015560
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 16:00:18 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4AK0FUk028599
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 20:00:15 GMT
Subject: Re: [PATCH] Basic policy representation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "J. Tang" <jtang@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1178826153.5665.125.camel@localhost.localdomain>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
	 <1178735753.5665.38.camel@localhost.localdomain>
	 <1178738540.2951.16.camel@localhost.localdomain>
	 <1178750819.5665.100.camel@localhost.localdomain>
	 <1178753217.21282.12.camel@localhost.localdomain>
	 <1178826153.5665.125.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 May 2007 16:00:13 -0400
Message-Id: <1178827213.24335.82.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-10 at 15:42 -0400, J. Tang wrote:
> On Wed, 2007-05-09 at 19:26 -0400, Karl MacMillan wrote:
> > I don't see why - the import function will just create the bare rules
> > and declarations and the normal resolution functions can work. The
> > requirements would just be thrown out.
> 
> An existing module could have this:
> 
> optional o {
>   type A, B, C;  # type A is not used by this optional
>   allow B C: d e;
> }
> 
> Within the proposed design, how is type A represented?  It is neither
> used within a rule nor is it a definition.

Perhaps you mean (as the syntax above is not supported):

require {
	type A, B, C;
}

Otherwise this is just a plain type declaration / definition (not
certain there is a difference for types).

So for the proposed design the require statement would be a no-op, while
the type declarations would be represented by sepol_type objects.

>   It is a declaration, under
> classic compiler terminology.  The given design does not seem to make a
> distinction between declarations and definitions.
> 

Not certain there is a real differences - we basically have:

1) type declarations - introduce a symbol into the type namespace (no
difference between declaration and definition)
2) type alias - introduce a alternative symbol into the type namespace
(no difference between declaration and definition)
3) attributes - here there is a distinction between the declaration and
the distributed definition, but you could likely just remove the
declaration.

Regardless - what are you getting at? As far as I can see the tree
structure can represent the required semantics correctly. I'm also
confident that any shortcomings can be addressed by tweaks to the basic
design I've proposed.

It seems like you are obliquely hinting that there is an overall design
problem. If so, please stop and just state any concerns you have about
the design directly.

> > >   allow A B : C d;
> > >   allow x y : z d;
> > Perhaps - it depends on whether there is a string pool at the root of
> > the tree the object is in. If there is a string pool, however, there
> > will only be one instance.
> 
> Here are three scenarios:
> 
> 1.  Both rules are declared unconditionally.  This is a monolithic
> policy.
> 
> 2.  First allow rule is declared unconditonally, the second rule within
> a conditional.  This is a monolithic policy.
> 
> 3.  The two rules are from different modules.  Their respective ASTs are
> presumably joined during linking.
> 
> For which of these scenario(s) is there a string pool "at the root of
> the tree the [rules are] in"?  If so, it holds that there is only one
> instance of "d", and thus am I correct in saying that permissions are
> indeed instances of sepol_objpools?
> 

For all cases there may or may not be a string pool at the root of the
policy tree (sepol_policy).

I don't know what else to say other than you need to read the patches
more closely - you are not understanding the string pools. They are
simply an optimization - everything in all of the objects can safely be
assumed to simply be strings (or bools, or sets of strings, etc). You
would never instantiate an sepol_objpool as a permission - it just
doesn't make sense.

> > > In the statement
> > >   type A alias {B C D E F}
> > > will this create five instances of a SEPOL_TYPEID_TYPEALIAS or just
> > one?
> > The code I posted for comments would create 0 - you would just have a
> > type declaration. The goal is to represent the policy in the same
> > structure as the source - it helps for policy generation.
> 
> Follow-up question: In the statement
> 
>   typealias A alias {B C D E F};
> 
> will this create five instances of a SEPOL_TYPEID_TYPEALIAS or just one?

Just one.

> It is unclear by the supplied documentation what the intended behavior
> is.
> 

Please read the code more closely - both the current patches and the old
RFCs.

> > If you want to print out the tree structure you need this. Is there
> > some
> > reason to not export this?
> 
> Why would not the user call sepol_object_tostring() from the topmost
> node?
> 

The tostring functions only print a single node in the tree. To answer
your more general question, though, they might want to do special
formatting, export the nodes in some way, or any of a million other
things. Again, why not export this?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
