Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Joshua D. Guttman disp: current'" <guttman@mitre.org>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
   "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>,
   "'Amy L. Herzog'" <aherzog@mitre.org>,
   "'John D. Ramsdell'" <ramsdell@mitre.org>,
   "'Galen B. Williamson'" <gwilliam@mitre.org>,
   "'Grant M. Wagner'" <gmw@tycho.ncsc.mil>, "'David Caplan'" <dac@tresys.com>
Subject: RE: Announce: SELinux conditional policy extensions
Date: Fri, 13 Feb 2004 14:14:11 -0500
Message-ID: <000c01c3f265$9139f860$020d010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <nhawu6r93im.fsf@malabar.mitre.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> The idea of dynamic changes to the policy makes me nervous.  It seems
> to make the job of understanding the meaning and consequences of  a
> policy -- already hard -- even more daunting.  And I don't really see
> important security goals that cannot be achieved the old way.
>
> Doesn't it seem to create a "policy reachability" problem similar to
> the old (undecidable) Harrison-Rizzo-Ullman problem?  Do you know
> whether it's decidable in general whether there's a sequence of steps
> by a particular set of users (let's say) that leads to a particular
> user being able to access a particular file?
> 
> Giving conditional access to a few specific services could
> alternatively be arranged by having some (trusted, non-kernel) gateway
> demons that either respond to requests when desired or don't, when
> the flag is set the other way. 

You don't have to convince us that analyzing TE policies for desired security
properties is difficult.  We've probably spent more time than anyone analyzing
real systems' TE policies and understand the challenge. Indeed the genesis of
our setools package and its core apol tool/library is to support complex policy
analysis.  

I don't agree that conditional policies make the problem different as you seem
to imply.  Indeed I would argue that at worse a conditional policy just requires
you to analyze multiple policies that just happen to be packaged into a single
policy file.  In essence each combination of possible Boolean values is a
distinct policy which needs to be analyzed for desired security properties.
This is not conceptually different than the current situation without
conditionals.  [We're evolving our apol tool to handle these conditionals in the
future to be able to help analyze these permutations.]  The problem remain
essentially the same. {NOTE:  Fraiser-Badger actually investigated the issue of
dynamic type enforcement, albeit in a more constrained manner, in their
"Ensuring Continuity During Dynamic Security Policy Reconfiguration in DTE"
paper some years ago.]

As with the current TE mechanism, the policy writer can make policy analysis and
certification more or less difficult, and the conditional mechanism doesn't
change the fact.  Some proposed example uses would have no TE policy impact
(e.g., means to control packages of auditallow statements.  If you don't want
the complexity of analyzing policy permutations as a result of conditionals,
don't use conditionals in your policy...that seems to be a simple enough
solution to your concern without taking the capability away from those who want
the flexibility.
 
> Is there a clearly defined minimum policy and maximum policy for every
> conditional policy?  Is there a clearly defined set (e.g. a lattice)
> of policies corresponding to the different possible dynamic
> configurations?  Is this lattice constructible in some
> straightforward way? 
> 
> And why should we incorporate a mechanism like this, if we haven't yet
> understood the answers to a bunch of questions like these?

Two answers: 1) I assert this mechanisms does not change the nature of the
analysis so your question is aimed at the SE Linux TE mechanism in general, not
the conditional policy extensions.  But even if it did...

2) Because SE Linux introduced "pragmatic" mandatory security to the world, and
it seems to be having success after our decades of failure of finding a means to
introduce strong mandatory security to the "mainstream."  My observations to
date are very few are concerned (rightly or wrongly) with rigorous policy
analysis, and are more concerned with a practical mechanism to provide greater
least privilege and system hardening.  Those that are more concerned with the
MLS-like and other traditional mandatory access control problem domains have
long misused BLP/Biba mandatory mechanism on low assurance solutions.  SE
Linux's TE is just starting to penetrate that problem domain in a positive way
(IMHO).  So we all get the collective challenge of supporting the
"mainstreaming" of a pragmatic TE mandatory mechanism, having to deal with the
larger pragmatic market pressing the mechanism into a flexible direction, while
being able to retain the key mandatory access control traits we desire and
expanding our analysis capability to support those traditional concerns.

In any case, the broader market will make or break the success of TE in Linux,
and we from the more traditional background have to find ways to adapt and
support this effort to make it successful.  

> May I ask you please to try to explain more precisely and in more
> detail than README-COND does, how this mechanism works and why it's
> really a good idea? 

The above is applicable small community of interest within SE Selinux and not
appropriate in a README file aimed at understanding use of the mechanism.  



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
