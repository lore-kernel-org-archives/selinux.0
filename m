Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3RFv3fk020151
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 11:57:03 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3RFv2Eq005637
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 15:57:02 GMT
Subject: Re: Next policyrep patches
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46321964.3000302@manicmethod.com>
References: <1177686208.15215.7.camel@localhost.localdomain>
	 <46321964.3000302@manicmethod.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 11:55:01 -0400
Message-Id: <1177689301.15215.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-27 at 11:40 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > Here is my plan for the next set of policyrep patches:
> >
> > 1. Basic policy objects (sepol/policy.h). Basic object system and
> > top-level objects for the policy representation.
> >
> > 2. Policy components (each as a separate patch). For example, type
> > declarations (which would include type and typealias) would be a patch
> > adding include/sepol/types.h and src/types.c.
> >
> > For existing components (like booleans), I would like to merge the
> > record and component files. So booleans.h and boolean_record.h would be
> > merged. Objections?
> >
> >   
> fine with me.
> > 3. When all of the components are merged I'll send the parser changes.
> > This is the first patch that will cause breakage. Any objection to
> > checkmodule being broken for a while?
> >   
> Its well understood that the branch is going to be broken for a while, 
> there is no way around that if we expect to do the development in a 
> distributed way.
> 
> I'd like the components and tree structure as soon as possible so that 
> we can start work on the linker and generator (expander).
> 
> This brings up some other questions, there is no such thing as an 
> expander anymore, its really a code generator,

Seems basically the same to me - the current module format and the
policyrep format accomplish similar things in different ways.

>  do we want to change the 
> API to reflect that difference or just leave the current 
> sepol_expand_module function? 

It has to change somewhat because it won't be taking a policydb anymore.
We are also going to be working with sepol_policy objects, which can
have modules:

sepol_policy
     |
     |---- sepol_module ("foo")
     |             |
     |             |----- [statements]
     |
     |---- sepol_module ("bar")
                   |
                   |----- [statements]


So it seems like it should be:

sepol_policy_expand(struct sepol_handle *h, struct sepol_policy *p, 
                    struct sepol_policydb **out, int check_constraints);

1. Why not allocate the out policy?
2. Seems like verbose or not should be handled via the debug options for
the handle.

> I guess the general question is, how 
> destructive are we looking to be with the exported API?

Good question - I would prefer it to change as little as possible, but I
guess we need some changes.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
