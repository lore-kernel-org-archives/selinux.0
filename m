To: russell@coker.com.au
Cc: <mayerf@tresys.com>,
   "'Joshua D. Guttman disp: current'" <guttman@mitre.org>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>,
   "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>,
   "'Amy L. Herzog'" <aherzog@mitre.org>,
   "'Galen B. Williamson'" <gwilliam@mitre.org>,
   "'Grant M. Wagner'" <gmw@tycho.ncsc.mil>, "'David Caplan'" <dac@tresys.com>,
   ramsdell@mitre.org
Subject: Re: Announce: SELinux conditional policy extensions
References: <000c01c3f265$9139f860$020d010a@columbia.tresys.com>
	<200402141451.08044.russell@coker.com.au>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 20 Feb 2004 08:05:53 -0500
In-Reply-To: <200402141451.08044.russell@coker.com.au>
Message-ID: <ogtu11lyk7i.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au> writes:

> On Sat, 14 Feb 2004 06:14, "Frank Mayer" <mayerf@tresys.com> wrote:

> > 2) Because SE Linux introduced "pragmatic" mandatory security to
> > the world, and it seems to be having success after our decades of
> > failure of finding a means to introduce strong mandatory security
> > to the "mainstream."  My observations to date are very few are
> > concerned (rightly or wrongly) with rigorous policy analysis, and
> > are more concerned with a practical mechanism to provide greater
> > least privilege and system hardening.
> 
> Yes, this is an issue that can not be under-estimated.
> 
> Currently my work is tending towards providing less protection so
> that it is more acceptable to the majority of users.  My personal
> preference of the trade-off between security and usability is to
> have more security than most people will be prepared to accept.  But
> we have to do what's necessary to get the user-base.

In my opinion, adding more complexity to the policy enforcement
mechanism is likely to drive away new users.  Why should people be
interested in an operating system that provides mandatory access
control if they find its access control policy incomprehensible?

SE Linux policies are difficult to understand even with policies that
make no use of the conditional policy extension.  Consider the
situation surrounding information flow analysis.  Both MITRE and
Tresys have produced tools that perform an information flow analysis.
In a comprehensible system, it would be obvious how the two flow
analyses relate.  I have yet to see a plausible account of the two
flow analyses in a common framework.

I have one suggestion for making SE Linux policies more
comprehensible.  Suppose the semantics of a class is defined by
binding it to one or more LSM hook functions that perform access
control.  In this way, the author of a policy file would know that an
allow statement that refers to, say, the file class is making a
statement about permissions associated with the LSM file access
control hooks, and statements that refer to the inode class is making
a statement about permissions associated with the LSM inode access
control hooks.

Of course, the SE Linux Security Module implements a binding of
classes to access control hooks, but documentation available to policy
writers I've seen does not encourage the writers to rely on any
particular binding.

John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
