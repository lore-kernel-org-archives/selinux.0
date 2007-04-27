Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3RJR9Hp002859
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 15:27:09 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3RJR8Kw027501
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 19:27:08 GMT
Subject: Re: [RFC] Policy Representation Overview
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1177701267.3570.63.camel@sgc>
References: <1177701267.3570.63.camel@sgc>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 15:27:07 -0400
Message-Id: <1177702027.20753.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-27 at 19:14 +0000, Christopher J. PeBenito wrote:
> Here is an overview of the new policy representation [1].  It includes
> much of the initial design as we understand it, plus a few
> modifications.  The significant differences are:
> 
> 1. A single symbol table at the root node of the abstract syntax tree,
> rather than a symbol table per block.
> 

Not certain what this means - there is no symbol table at all. If you
mean the object pool the intention was that would always been in the
root of the tree.

> 2. The distinction between types and attributes.  The two implement the
> 'Typeset Object' interface, but are not subclasses to each other.
> 
> 3. The distinction of 'policy statements'.  Examples are 'typeattribute'
> and 'typealias'.
> 
> Here are the reasons for these three changes:
> 
> 1. A single symbol table allows for easier name symbol resolution.
> Consider if one optional block defines a symbol that another optional
> block uses.  With a single symbol table, the latter optional only need
> to search the top-most, authoritative symbol table for the symbol's
> existence.  Otherwise it would need to recurse into every single block
> to find the symbol as that the top-most did not define it.
> 

Again - still not certain what you are getting at. If you look at the
policy check patch that I sent the first thing that it does is build
indexes of symbols (name->object). That solves this problem without the
overhead of keeping these indexes updated when the tree is being
manipulated.

In fact, one of the explicit goals of this design is to store
information once and only once in the tree. The indexing and top-level
symbol tables in the current design have been nothing but a bother.

> 2. Although types and attributes may be used interchangably within AV
> rules, they are not valid tokens in many other parts of a policy.  For
> example, the default of a 'type_transition' must be a type, not an
> attribute.  Likewise, the one cannot assign an attribute to a type
> within 'typeattribute'; the operation is really adding the type to an
> attribute's type list.
> 

Sure, but type and attributes are already separate objects.

> 3. The inclusion of the statements simplify the process of linking in
> modules.  Because modules can have typeattribute statements, it is
> necessary to append a type to an attribute's type list.  It is possible
> that either the type or attribute is defined in the module; thus it is
> necessary to defer resolving the 'typeattribute' until after symbols
> have been linked.
> 

Ok - now I'm really confused. They typeattribute statement just
references strings. Whether they are valid simply depends on whether the
symbols are in scope and of the appropriate type.

I'm happy to take suggestions, but honestly, I'm not clear on what you
are trying to suggest.

Karl

> [1] http://oss.tresys.com/projects/setools/chrome/site/policy-rep/overview.pdf
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
