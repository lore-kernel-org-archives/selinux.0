Message-Id: <200503172142.j2HLfm8R001729@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: [RFC & PATCH] inherited type definition.
Date: Thu, 17 Mar 2005 16:41:48 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1111090063.8664.132.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Sent: Thursday, March 17, 2005 3:08 PM
> To: Karl MacMillan
> Cc: 'Kaigai Kohei'; 'KaiGai Kohei'; 'SELinux Mail List'; 
> selinux-dev@tresys.com
> Subject: RE: [RFC & PATCH] inherited type definition.
> 
> On Thu, 2005-03-17 at 14:15 -0500, Karl MacMillan wrote:
> > I do, however, have a concrete alternative to this patch. After 
> > thinking about this for a while, I think that the best 
> alternative to 
> > this patch right now is macros and simple copying of policy.
> 
> Hmm...I wouldn't quite expect such a statement from the 
> creators of conditional policy support and binary policy modules ;)  
> 

I know - I was hoping no one would notice. Seriously, I think that some things
are better done as part of the development environment. Additionally, I think
that the policy needs some better abstractions at the source level and that will
address some of these issues - see below.

> > One of the stated uses for this patch is to allow naïve users to 
> > create a policy based on an existing correct policy. Leaving aside 
> > whether it is a good idea for naïve users to write straight SELinux 
> > policy, the problem with the extends syntax is that it only 
> allows for 
> > the creation of a superset of one or more existing types (I 
> guess that 
> > it can also create a copy, but then there would be no 
> reason for a new type).
> 
> It would allow easy expression of union types, per the 
> earlier discussion in the thread on multiple contexts (but in 
> a way that is analyzable based on policy rather than 
> filesystem state).
> 

That's correct, but I argue that a complete union is seldom what is wanted. More
often we want a partial union, which is what the @ syntax is supposed to
express. I think, however, that macros can express this more directly and
readably.

> > With the extends syntax the entire policy must be examined to 
> > understand what a type declaration actually allows if it 
> includes an 
> > extend statement.
> 
> This isn't fundamentally different from type attributes, 
> particularly as the patch is implemented as a minor 
> refinement on attributes.

Sure, and I think that attributes are somewhat evil as well. Again, my
experience trying to understand policies leads me to say that more of the policy
that can be expressed directly through allow rules on types the better.
Automated analysis can unwind these indirections, but there is still significant
advantages to being able to understand source policies.

>  In effect, every type becomes an 
> implicitly defined attribute that expands to itself and any 
> descendants.  And if KaiGai does change the patch to require 
> use of the @ prefix to explicitly cause expansion of the 
> type, with no expansion by default, it seems fairly 
> straightforward to identify all relevant rules that might be 
> affected by an extends declaration.

If this change does happen I hope that the @ prefix will be required to cause
expansion. At this point, though, the amount of work required to change the
policy to use the @ where needed is on the same order as abstracting these types
into macros, and I think there would be additional benefits from the macro
abstraction that the @ markup does not have.

>  Other important point is 
> that it has no impact on the binary policy representation, so 
> analysis based on binary policy remains unchanged.
>

Certainly, but it is potentially an impact on source policy readability.
 
> >  Macros are not perfect, but there is some hope that a single macro 
> > (or a handful if it chains) is all that will have to be examined to 
> > have a reasonable understanding of the allowed access 
> resulting from a macro call.
> > Discipline in macro writing can make this situation even better.
> 
> Attributes, set difference, and set complement make this 
> problematic already, right?
> 

Yes - and I have already complained about those in another email. I'll be happy
to send a patch disallowing complement in allow rules if you would accept it :)

> > I think that it is better to only add policy syntax when it 
> solves a 
> > problem that cannot be currently solved.
> 
> There is presently no way to easily express a union of multiple types.
> 

I disagree - macros allow this. Also, what we want, I think, is not a union of
types but an abstract notion of access. Your earlier example of
samba_http_content_t is better expressed through:

allow_samba_read(foo_t)
allow_httpd_read(foo_t)

This is a direct statement of what we intend - allowing both samba and httpd to
read files of type foo_t. This is also easier conceptually for those new to
policy development. I think that we are fixing a symptom with the extends
approach. The real problem is that the current policy is not structured to
provide macros with well-defined access semantics. If policy was written with
the abstractions, like above, the type union problem would not exist.
Additionally, the macros provide more control (there can be multiple version
with slightly different access - not possible with the extends even with the @)
and provide a single point for documentation.

I would like to see how some real world problems would be solved with the
extends syntax. I feel confident that every example could be expressed more
clearly through a set of well-thought out macros.

Thanks,

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley <sds@tycho.nsa.gov>
> National Security Agency
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
