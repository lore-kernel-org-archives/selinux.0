Subject: RE: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <200503171915.j2HJFn8R000646@gotham.columbia.tresys.com>
References: <200503171915.j2HJFn8R000646@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 17 Mar 2005 15:07:43 -0500
Message-Id: <1111090063.8664.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-17 at 14:15 -0500, Karl MacMillan wrote:
> I do, however, have a concrete alternative to this patch. After
> thinking about this for a while, I think that the best alternative to this patch
> right now is macros and simple copying of policy.

Hmm...I wouldn't quite expect such a statement from the creators of
conditional policy support and binary policy modules ;)  

> One of the stated uses for this patch is to allow naïve users to create a policy
> based on an existing correct policy. Leaving aside whether it is a good idea for
> naïve users to write straight SELinux policy, the problem with the extends
> syntax is that it only allows for the creation of a superset of one or more
> existing types (I guess that it can also create a copy, but then there would be
> no reason for a new type).

It would allow easy expression of union types, per the earlier
discussion in the thread on multiple contexts (but in a way that is
analyzable based on policy rather than filesystem state).

> With the extends syntax the entire policy must be examined to
> understand what a type declaration actually allows if it includes an extend
> statement.

This isn't fundamentally different from type attributes, particularly as
the patch is implemented as a minor refinement on attributes.  In
effect, every type becomes an implicitly defined attribute that expands
to itself and any descendants.  And if KaiGai does change the patch to
require use of the @ prefix to explicitly cause expansion of the type,
with no expansion by default, it seems fairly straightforward to
identify all relevant rules that might be affected by an extends
declaration.  Other important point is that it has no impact on the
binary policy representation, so analysis based on binary policy remains
unchanged.

>  Macros are not perfect, but there is some hope that a single macro
> (or a handful if it chains) is all that will have to be examined to have a
> reasonable understanding of the allowed access resulting from a macro call.
> Discipline in macro writing can make this situation even better.

Attributes, set difference, and set complement make this problematic
already, right?

> I think that it is better to only add policy syntax when it solves a problem
> that cannot be currently solved.

There is presently no way to easily express a union of multiple types.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
