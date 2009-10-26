Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9QImTax029307
	for <selinux@tycho.nsa.gov>; Mon, 26 Oct 2009 14:48:29 -0400
Received: from asmtpout027.mac.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9QIoI8v004089
	for <selinux@tycho.nsa.gov>; Mon, 26 Oct 2009 18:50:18 GMT
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Received: from falmouth.jbj.org
 (cpe-069-134-024-120.nc.res.rr.com [69.134.24.120])
 by asmtp027.mac.com (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec
 16 2008; 32bit)) with ESMTPSA id <0KS400GCCXK7NL30@asmtp027.mac.com> for
 selinux@tycho.nsa.gov; Mon, 26 Oct 2009 11:48:11 -0700 (PDT)
Subject: Re: RPM support for SELinux
From: Jeff Johnson <n3npq@mac.com>
In-reply-to: <C70B57FC.AB8F3%csellers@tresys.com>
Date: Mon, 26 Oct 2009 14:48:06 -0400
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
Message-id: <3AD91E25-4E07-49CC-8BF5-4656A4CE5DF0@mac.com>
References: <C70B57FC.AB8F3%csellers@tresys.com>
To: Chad Sellers <csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 26, 2009, at 1:43 PM, Chad Sellers wrote:

> On 10/23/09 5:27 PM, "Jeff Johnson" <n3npq@mac.com> wrote:
>
>>
>> On Oct 23, 2009, at 9:22 AM, Joshua Brindle wrote:
>>>
>>> That is not the purpose of this patchset, and it was never claimed
>>> to be the purpose of this patchset.
>>>
>>> The purpose of this patchset is to start integrating policy support
>>> into RPM, and for RPM to remain completely trusted. I did say that
>>> we have an ultimate goal of breaking RPM up into pieces so we could
>>> remove trust from the main parts, and to eventually be able to run
>>> RPM in different security domains depending on different aspects of
>>> the RPM (where it came from, who signed it, who is running RPM, etc)
>>> but that is not something this patch set can accomplish and indeed
>>> is a long term goal.
>>>
>>> We can't very well go off for a long time and come back with a
>>> patchset that completely changes the architecture of RPM, we are
>>> doing this development in the open and therefore each individual
>>> patch set along the way brings us closer, it doesn't completely
>>> solve the problem.
>>>
>>
>> No you can't. Nor can you wander around making contradictory  
>> statements
>> about what you intend publically.
>>
>> So now the goal is "completely change the architecture of RPM"  
>> without
>> any statement of purpose (other than that you think the change is
>> needed)
>> and you claim to be doing development in the open.
>>
>> If you stated your goals more clearly, with perhaps an illustration  
>> of
>> what you think needs doing, you might find better acceptance.
>>
>> Each individual patch set I've seen is currently appearing, to  
>> somewhat
>> negative comments not just from me, and then you wander off
>> to re-appear with essentially the same patch set with almost exactly
>> the same issues (like the opaqueness of bz2 blobs embedded
>> in rpm headers, and the size of the unnormalized uncompressed
>> policy data, and the difficulties of executing helpers in empty
>> chroot's). Go read the comments, the issues were pointed out not just
>> by me.
>>
>> Could you please state your goals more clearly so that a developer
>> might understand the reasoning behind an end-point that seems to
>> include "completely changes
>> the architecture of RPM" as an end-point (or why did you bother
>> mentioning).
>>
>> Otherwise, piecemeal patching (as in the current patch set) closely
>> followed
>> by claims that you are going to move to "hi-level compilers to  
>> install
>> policy"
>> (my paraphrase from memory) seems more like a randopm walk than
>> anything else.
>>
> OK, I'll do my best to explain our motivations. The goals for this  
> patchset
> are fairly simple, and are outlined in patch 00/12. The summary is  
> that
> there are a few specific problems that are currently preventing some
> packagers from including policy in their packages, and this patchset  
> aims to
> fix those. Of course, we also have some longer term goals which we  
> kept in
> mind when writing this patchset to ensure that we did not shoot  
> ourselves in
> the foot, but this patchset does not address those goals yet.
>
> Our longer term goals indeed center around reducing trust placed in  
> rpm. We
> are interested in two primary sides of this. One is to support  
> running rpm
> with different levels of trust depending on the situation. The other  
> is to
> try to separate the areas of rpm that require the most trust from  
> those that
> have been shown to be the riskiest. In working with other apps, making
> changes along these lines, we've found that architectural changes are
> sometimes necessary, which is what Josh was alluding to. That said,  
> these
> are long term goals that we have not begun to address, which is why we
> haven't begun to talk about them on list. We should have told you  
> these
> goals earlier, but we are not hiding anything here as there is  
> nothing to
> hide.
>
> I'm sorry if it seems that we are not responding to concerns raised.  
> The
> addition of a fallback mechanism to utilize library calls when in an  
> empty
> chroot instead of executing a helper was done specifically because of
> concerns raised.
>
> As far as issues like unnormalized policy data and using bz2  
> compression go,
> I'm sorry but that's how policy works today. Could it be better?  
> Sure (and I
> don't want to have an argument here about what constitutes  
> "better"), but
> it's not right now. I know that you think the current SELinux policy  
> format
> is unworthy of becoming a first-class citizen in rpm. I just hope  
> the rest
> of the rpm community disagrees with you, because I really don't want  
> to be
> forced to use %post scripts for another couple years while people  
> argue
> about what is a worthy format.
>

I will start with the last (and easiest) observation first:

"unworthy of becoming a first-class citizen in rpm"

	That statement isn't anywhere close to accurately stating my POV.
	Do not attempt to infer from the fact that I will never include the
	existing patch set (as is) @rpm5.org to guess what my actual opinion  
is.

	SELinux definitely needs a "packaging" solution for policy. Monolithic
	"policy-of-the-day" has obvious known failure points. Just look at how
	often SELinux policy is updated in Fedorable.

	Policy needs a clearly defined "upgrade" paradigm which is difficult
	conceptually for security tagging, which usually focussess on  
protecting
	a perimeter, or a domain, statically. Adding a sounder distribution
	mechanism that has a well defined "upgrade" mechaniusm is most  
definitely
	needed.

	And most definitely %post invocations are doomed. Just look at existing
	attempts to distribute policy through the only programmatic means to
	extend packaging, i.e. %post et al scripting. That is _NOT_ the right  
approach.

	And RPM is all about packaging. The issues I object to are how RPM is  
used,
	not wether RPM is used, to distribute policy in *.rpm.

	Whether the "RPM community" agrees with me or not, I don't give a  
hoot. I
	am solely concerned on RPM (and packaging) engineering these days. And
	you've missed essential details of what should have been done in the
	patch set to package policy.

For starters, you need to focus on a module, not a deeply complicated  
and intrusive
patch set directly in RPM. The problem is that RPM is _NEVER_ updated  
on existing
systems. SO any implementation directly in RPM will _NEVER_ be updated.

A specific module to be loaded by RPM, to be used at the handful of  
places where
SELinux policy installation occurs within RPM's state machines, can be  
updated
when needed. That is very much untrue for the deeply invasive patch  
you have chosen
to send instead.

Next, you've chosen to directly wire SELinux into RPM's state  
machines. Not
only should a module be attempted, but also a DSL specific for  
installing
policy. Having a recipe specific to installing policy is a far sounder
approach than a direct implementation. I believe Josh already knows  
this,
or he wouldn't be suggesting "high level compilers for installing  
policy".
The problem domain (as in DSL) for how policy is represented and  
transformed
is far more complicated than what I am suggesting:
	A DSL recipe rather than invoking semanage directly as helper or C  
routines.

(aside)
I have such a semanage DSL @rpm5.org. I stopped development on the DSL  
as soon as Josh
said that "high level compilers to install policy were expected soon".  
I also do
not see how the current patch-set can generalize usefully to a text  
distribution
to be fed to high-level compilers, which is part of the reason I won't  
bother
adding.

Having two mechanisms to install policy so that RPM runs in empty
chroot's is worse than either. This is a fundamental (and fundamentally
design flawed) expectation for RPM package management that has nothing
to do with distributing SELinux policy in *.rpm. Your patch set should
not have tried to solve those issues in a SELinux peculier way. FWIW,
you solved them adequately and well for SELinux, but not generally
for RPM.

(aside)
If the expectation is to be able to run RPM in empty chroot's, then
the available engineering solutions are quite obvious:
	_EVERYTHING_ necessary must be carried/copied into or otherwise
	made available for use, in the empty chroot.

"reducing trust"

	There's already history here, and (afaik) none of the existing
	implementation (which has already "completely changed the architecture
	of RPM") has ever been used.

	Since SELinux relies on a domain transition that is set when an
	executable is exec'd, RPM _ALREADY_ has been split into multiple
	executables that could have different reduced trust SElinux tags
	associated. Each executable is per-mode, so queries could have
	different tagging than installs.

	The separate executables are _NOT_ marked differently to the best of
	my knowledge, nor have they ever been. So stating intents of  
"completely
	change RPM architecture" have already happened and have _NOT_ been  
used.

Another claim, by Josh, stating as long term goal
		depending on different aspects of the RPM (where it came from, who  
signed it, who is running RPM, etc)
reminds of another piece of functionality, implemented for 4+ years,
that has never been used afaik.

There was a desire from SELinux to know whether a package was signed  
without biting
into complex issues of cryptography implementations within SELinux.
The SELInux goal was to base policy decisions on whether a RPM package  
was signed (or not).

Here is the API that RPM was requested to use(from selinux.h)

	/* Execute a helper for rpm in an appropriate security context. */
	extern int rpm_execcon(unsigned int verified,
                        const char *filename,
                        char *const argv[], char *const envp[]);

The 1st argument has never been used by SELinux, never been populated  
by RPM, in the last
4+ years afaik. ANd now I'm hearing Yet More Hand Waving about goals
with no details (or knowledge) of what is _ALREADY_ implemented.

Instead you're back (4+ years later) to "completely change the  
architecture of RPM"
all over again again again?

ANd you wonder (after 4+ years) why I am skeptical of the SELinux  
goals, and ask
for a more complete ROADMAP to be clearly stated publically? I have  
yet to
hear sufficent details from SELinux to even begin to assist with  
whatever
is being attempted in RPM.

73 de Jeff
	

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
