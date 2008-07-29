Subject: Re: [PATCH 2/3] Thread/Child-Domain Assignment
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Scott Schmit <i.grok@comcast.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080729122523.GA27206@arithon.mars.sol>
References: <487C7698.60503@ak.jp.nec.com>
	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>
	 <487D5A3D.6090801@ak.jp.nec.com>
	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>
	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>
	 <4889CC5F.3030500@ak.jp.nec.com> <4889CF38.6010301@ak.jp.nec.com>
	 <488EC3A0.5010000@ak.jp.nec.com>  <20080729122523.GA27206@arithon.mars.sol>
Content-Type: text/plain
Date: Tue, 29 Jul 2008 09:28:01 -0400
Message-Id: <1217338081.20373.189.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-07-29 at 08:25 -0400, Scott Schmit wrote:
> On Tue, Jul 29, 2008 at 04:15:44PM +0900, KaiGai Kohei wrote:
> > KaiGai Kohei wrote:
> > > [2/3] thread-context-checkpolicy.1.patch
> > >   This patch add a new statement of TYPEDOMINATE for policy language.
> > > 
> > >     TYPEDOMINATE <parent type>  <chile type> [, <child type> ...] ;
> > > 
> > >   It defines expilct hierarchical relationship between two types.
> > >   Existing name based hierarchy is dealt as TYPEDOMINATE is described
> > >   implicitly.
> > 
> > I reconsidered that the statement should be replaced as follows,
> > because "DOMINATE" is an associated term with MLS and roles/users
> > also have name based hierarchy ideas now.
> > 
> >   HIERARCHY <parent type> TYPES <child type> [, <child type> ...];
> >   HIERARCHY <parent role> ROLES <child role> [, <child role> ...];
> >   HIERARCHY <parent user> USERS <child user> [, <child user> ...];
> > 
> 
> I agree that TYPEDOMINATE is not a good choice. In dominance, you're
> saying "whatever privileges x, y, & z have, give me those too."
> 
> I like to think of it as the parent type "circumscribing" or limiting
> its children -- the parent draws a line in the sand and says "<child>,
> you can grant yourself whatever permissions you want (hopefully no more
> than you need), but whatever you do, don't cross this line!" The terms
> used to should make that obvious. "Circumscribe" is fun to say, but
> awkward to type, so how about:
> 
>     TYPELIMIT <parent type> { <child type> [, <child type> ...] } ;
>     ROLELIMIT <parent role> { <child role> [, <child role> ...] } ;
> 
> It would read better to say:
> 
>     TYPE <parent type> LIMITS { <child type> [, <child type> ...] } ;
>     ROLE <parent role> LIMITS { <child role> [, <child role> ...] } ;
> 
> but that conflicts with existing syntax. Hence the patterning after
> attributes and aliasing.

I don't think we necessarily have to be constrained by existing syntax.
Adding TYPE identifier LIMITS id_comma_list ';' to the grammar doesn't
seem to present any problems.  Not sure if LIMITS is the best term
either though, maybe BOUNDS.

> I'm not sure what hierarchy for users implies, or why it's needed. If we
> have adequate support for hierarchy/dominance in roles, doesn't that
> suffice for users? After all, users can't do anything their roles don't
> permit them to. I guess I see users as a slightly different case because
> they are going to be more per-system than roles or types, so if you
> don't trust system administrators to set a user's roles correctly, you
> shouldn't make them a sysadmin. Or am I missing something?

User identity in SELinux (in the security context) isn't quite the same
thing as Linux usernames/accounts; there is a many-to-one mapping from
the Linux usernames to SELinux user identities, and the SELinux user
identity is in fact a "role authorization set".

In early SELinux, we did use a one-to-one mapping, but ran into problems
with admins not wanting to add or remove users to their SELinux policy
(requiring regenerating, distributing and reloading policy into the
kernel on each system) when managing users on their network.  That led
first to a fallback SELinux user identity (user_u), and later to the
seusers mapping.  So today the SELinux user identity is an abstract
identity (e.g. "user_u", "staff_u", "unconfined_u") that maps to a given
role set.

There is also work investigating use of SELinux user identity as the
role (see rbacsep and (u|r)bacsep threads).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
