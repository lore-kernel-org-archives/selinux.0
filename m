Subject: Re: concept of a permissive domain
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1190147094.14037.135.camel@moss-spartans.epoch.ncsc.mil>
References: <1189537981.3407.51.camel@localhost.localdomain>
	 <46E6FB25.5070507@redhat.com>
	 <1189545987.4823.6.camel@localhost.localdomain>
	 <1189692512.18713.61.camel@moss-spartans.epoch.ncsc.mil>
	 <1189694812.3538.20.camel@localhost.localdomain>
	 <1189695443.18713.95.camel@moss-spartans.epoch.ncsc.mil>
	 <46E98E93.40206@redhat.com>
	 <1189712298.18713.116.camel@moss-spartans.epoch.ncsc.mil>
	 <1189714612.3391.74.camel@localhost.localdomain>
	 <1190147094.14037.135.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 24 Sep 2007 10:59:02 -0400
Message-Id: <1190645942.4732.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-18 at 16:24 -0400, Stephen Smalley wrote:
> On Thu, 2007-09-13 at 16:16 -0400, Eric Paris wrote:
> > On Thu, 2007-09-13 at 15:38 -0400, Stephen Smalley wrote:
> > > On Thu, 2007-09-13 at 15:25 -0400, Daniel J Walsh wrote:

[...]

> > We need denial rules, we just don't have to call them that.  We just
> > need to define how dontaudit and auditallow rules work in this new type
> > of domain.  Then decide if that somehow interferes if the domain is not
> > a permissive domain.  Aside from Karl's little flub, noone is arguing we
> > should change anything having to do with enforcing=0 or enforcing=1 and
> > a non-permissive-domain.  We don't need to rewrite how dontaudit rules
> > affect enforcing domains or non-enforcing-systems, we just need an
> > extended definition for permissive domains.  Seems dontaudit and
> > auditallow can work very nicely to solve real practical problems
> > constraining large applications in environments which may not be friends
> > to problems introduced by SELinux.  Everyone agrees running an
> > application and just allowing whatever it asks for isn't the best way to
> > write policy, but when it's all you have, and all you are going to
> > reasonably have I'm not hearing a argument why we can't do what Dan
> > wants, other than 'that's not what it means today.'
> > 
> > dontaudit as an 'implicit denial in permissive domains' isn't what we
> > have today, but then again, we don't have permissive domains today.
> 
> I think we need to be careful that we aren't making SELinux harder to
> understand.  You are introducing a new construct that doesn't correspond
> precisely with either "unconfined" domains under enforcing mode or all
> domains under permissive mode today, and then you'll have to explain to
> users how they each differ and how to use them in a coherent way.


I understand the concern, but I think that the concept is pretty simple
to understand. What is harder is the subtle operational differences.

>   Maybe
> it would be useful to talk again about why we can't go with the "make
> the domain unconfined in policy and use auditallow" approach.  There is
> the log-once aspect of permissive mode, but possibly that could be made
> selectable for domains, and there is the difference in the log messages
> (granted vs. denied), but the tools can certainly deal with that.
> 

To get a tool to do this you would essentially need to work on the final
policy. It would:

1. Determine the set of all possible access (which requires the ability
to enumerate all classes/perms and types).

2. Determine the set of access explicitly allowed for the permissive
domain.

3. Take the difference of those sets and insert auditallow rules for
that access.

Note that this would be different that unconfined because it would
likely allow all perms for all object classes for all types.
Alternatively we could try to determine what access an unconfined domain
is granted and use that set instead. The main problem is that access is
only available in the preprocessed policy (e.g., to sepolgen), while
this tool really needs to operate on the final, expanded policy.

The downsides of this approach:

1) Lots of additional rules.
2) The tool will be somewhat painful to write - not clear who will do
that.
3) Correctness seems harder to achieve versus the kernel route to me.
4) Absent a way to generate single denial rules via policy, we will also
have to change sepolgen to use granted rules. This will end up exposed
to the user (they will have to ask for it) and it means that we can't
use auditallow rules for these domains in general.

> Also, one other thing to keep in mind for the permissive domain concept
> is that permission checks don't always fall neatly into the domain-type
> form and that domains tend to flow to related objects (sockets, packets,
> proc inodes, etc), so it is possibly insufficient and/or unsafe to
> determine whether to apply permissive mode on the source context in all
> cases.  Requires some investigation of all of the checks today.
> 

Yeah - that's going to be tricky. The tool would have the same problem -
it would have to generate some rules with the domain as target.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
