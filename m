Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3I9ZSI7024286
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 05:35:29 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3I9ZPKX024077
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 09:35:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Athey <jathey@tresys.com>
Subject: Re: FCGlob
Date: Wed, 18 Apr 2007 11:35:34 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200704172007.54844.russell@coker.com.au> <1176836859.8847.15.camel@exodus.columbia.tresys.com>
In-Reply-To: <1176836859.8847.15.camel@exodus.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200704181035.38290.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 18 April 2007 05:07, James Athey <jathey@tresys.com> wrote:
> On Tue, 2007-04-17 at 21:07 +1100, Russell Coker wrote:
> > Page 3 states that a down-side is "the tree would be a binary file and
> > not human readable any more".  Why would this be so?
>
> Perhaps this part of the paper could have been clearer.  The only reason
> to leave the file_contexts in a binary format would be to save time when
> parsing them into the tree for use by matchpathcon and semanage.  In
> retrospect, this suggestion was premature; code first, optimize later,
> right?

That depends.  If one of the major aims of the code is to improve performance 
then a certain degree of optimisation should be done to prove it's worth.

> > As for regex's that have no clear meaning, the only thing to do is to
> > remove them and wait for the original policy author to complain.  There
> > are many regular expressions that never matched anything and probably
> > many more that match old versions of software.
>
> Old versions of software matter.  For example, RHEL 4 is a supported
> platform for reference policy, and any file contexts that are specific
> to RHEL4 need to stay in the policy, marked off with an
> ifdef(`distro_rhel4' if necessary.

Why do you want to do that?  The Red Hat support agreement was always that if 
you use any policy other than the one that they ship then you must reproduce 
bugs on either the Red Hat policy or a machine with SE Linux disabled (often 
permissive-mode would do).  Given this situation why would there be demand 
for a newer policy on RHEL4?  Red Hat is still providing policy updates for 
RHEL4 as needed.

There is also nothing stopping anyone from maintaining a separate policy tree 
for RHEL4.  Why compromise development of the new tree when we can have 
separate trees and avoid the effort?

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
