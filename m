Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iACIgTIi012442
	for <selinux@tycho.nsa.gov>; Fri, 12 Nov 2004 13:42:29 -0500 (EST)
Date: Fri, 12 Nov 2004 13:42:32 -0500
From: Amy L Herzog <aherzog@mitre.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20041112184232.GK15243@golconda.mitre.org>
References: <4182959B.4080503@trustedcs.com> <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
  >
  > Question for people writing policy analysis tools (some cc'd):
  > What impact do you see such a change having on the ability to
  > analyze policies?  How difficult would it be to have your tools
  > collapse the domains in one of these "dynamic transition groups"
  > into a single equivalence class for information flow analysis?

Sorry to jump in a bit late on this. For our information flow analysis
tools, our instinct is to simply expand the LTS we build from the
policy to include the 'process dyntransition' permission (with a
write-like flow, just like the current 'process transition'
permission). Although it would be fairly easy to collapse domains that
have full dynamic transition permissions to one another, doing so
wouldn't affect the truth of any information flow assertions
(i.e. system security goals) in the system.

For the same reasons many have mentioned in this thread, summed up by
Stephen's comments below, we don't feel that these changes offer
sufficient reason to alter our information flow analysis strategy by
taking timing into consideration. While analysis tools that take into
account particular trust assumptions the user is making about a
program's behavior might be useful, we see that as a fundamentally
different approach than the one we've chosen.

So in terms of impact on us as policy analysis tool writers, it's
minimal. There is a small additional impact on end-users of our tools,
who would presumably need to include the "trusted" programs in the
list of allowable exceptions to some information flow assertions.

I think this proposed change in fact makes it *more* important to
perform some kind of information flow analysis on your policy,
actually. I can easily imagine use of the dynamic context rules (over
time, by successive policy administrators) having serious and
unintended consequences. And perhaps the only way to reliably keep
track of such consequences is to have a clear picture of which
information flow invariants should hold true for your system, and a
clear way of checking your policy against those assertions.

A final note is that dynamic context switching is likely to have
consequences on automatic policy generation as well. We've talked
about this internally some, at least in the context of what the MITRE
polgen tools do for policy generation. For us, the biggest impact is
that when we generate policy using existing types for system
resources, we don't as part of the *generation* process examine the
policy graph rooted at those resources. But again, the impact here is
just that post-generation analysis of your entire (newly expanded)
policy becomes much more crucial. 

-Amy

Stephen Smalley wrote:
  >
  > From the kernel POV, any code in the application has the potential
  > to execute with the maximum set of permissions granted to any
  > domain in the "domain transition group", or in reality, their
  > union.  You may carefully write your application to shed and gain
  > permissions as needed, but an exploit of a flaw in that
  > application may indeed succeed in getting code to execute in that
  > process with that maximum set of permissions.  Hence, the
  > application still has to be "trusted" to exercise that maximal set
  > of permissions, and has a corresponding assurance burden.  In
  > contrast, if you decompose the application, the kernel can ensure
  > that only the specific code that should execute with privilege
  > does so, and the trust burden on the rest of the application is
  > greatly reduced.  See the difference?






-- 
Amy Herzog
Lead INFOSEC Engineer
The MITRE Corporation
G026 - Secure Technology Solutions
781.271.5271

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
