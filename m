Message-ID: <4235C937.3030404@kaigai.gr.jp>
Date: Tue, 15 Mar 2005 02:26:15 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
Subject: Re: [RFC & PATCH] inherited type definition.
References: <42346C17.3090301@kaigai.gr.jp> <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, Thanks for your comments.

> 1) Should the child domain inherit all rules that involved the parent
> domain at all, or only rules where the parent domain was the
> source/subject in the rule?  It looks like you have chosen the former,
> but this means that any domain that can act on the parent domain can act
> in the same manner on the child domain directly; not clear that this is
> always what you want.

In my patch, child domain/type inherit all rules including target/object
and area of ROLE clearly, not only source/subject.
(Those source/target is also included in TYPE_TRANSITION statements.)
Any permissions to parent means permissions to child/descendant concurrently.


> 2) Should the child domain inherit rules between the parent and the
> child, i.e. should the child be able to do anything to itself that the
> parent can do to it?  It looks like you are inheriting such rules, but
> is this always desirable, e.g. the parent may need permissions to set up
> the child, control it, kill it, etc that the child may not need to
> itself.

When parent has permissions to himself, child also has permissions to his
parent and himself(child). In my patch, to inherit type/domain always expand
descendant's permissions. I intend to define a child type/domain which has
tiny larger permission than own parent low cost.

I think definition of reductive permission child-type/domain is the next
action assignment. If child does not need a part of the parent's permissions,
those should be revoked by DENY statement for example.


> 3) What should happen with rules between the parent and itself?  It
> looks like you are translating "self" rules to only involve the child
> and its descendants, but this would still mean that any explicit rule of
> the form "allow parent_t parent_t:process sigkill;" would be inherited
> by the child, i.e. "allow child_t parent_t:process sigkill;", right?

It's a bit wrong.
When child_t inherit parent_t, "allow parent_t parent_t:process sigkill;"
is unrolled to "allow {parent_t child_t} {parent_t child_t}:process sigkill;"
The number of conbination is 4.

"allow parent_t self:process sigkill;" is unrolled as follows:
  "allow parent_t parent_t:process sigkill;"
  "allow parent_t child_t:process  sigkill;"
  "allow child_t  child_t:process  sigkill;"

child_t is dealt as self-domain from parent_t's viewpoint.
But parent_t is not dealed as self-domain from child_t's viewpoint,
because child_t has divaricated from parent_t yet.

This is my opinion, others may have different aspect to 'self'.
We should collect up how to deal 'self' on type-inheritance-tree, I think.


> 4) What should happen with transition rules that involve the parent?  In
> some cases, you will likely want to inherit them, but in others, you may
> want the child to transition to a separate derived domain from the one
> used by the parent.

parent_t/child_t shares same transition rule for same exec type.
Maybe, any kind of overriding semantics is necessary.

Thanks.
-- 
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
