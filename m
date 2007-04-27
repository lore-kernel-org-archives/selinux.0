Subject: Re: Next policyrep patches
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <46321964.3000302@manicmethod.com>
References: <1177686208.15215.7.camel@localhost.localdomain>
	 <46321964.3000302@manicmethod.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 11:56:38 -0400
Message-Id: <1177689398.3357.52.camel@moss-spartans.epoch.ncsc.mil>
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
> expander anymore, its really a code generator, do we want to change the 
> API to reflect that difference or just leave the current 
> sepol_expand_module function? I guess the general question is, how 
> destructive are we looking to be with the exported API?

For interfaces that are only used within the core selinux userland code,
I'd say we have significant freedom to change and/or remove them,
particularly as we have incremented the .so version.  For interfaces in
use by the selinux userland patches that have been integrated into
external packages, then we need to be more careful, although strictly
speaking we can make changes since we have changed the .so version there
as well.

The transition for distributions might be a bit painful though; we'll
ultimately need a mass rebuild to make the switch completely.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
