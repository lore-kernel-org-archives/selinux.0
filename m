Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9QHhQd9017722
	for <selinux@tycho.nsa.gov>; Mon, 26 Oct 2009 13:43:26 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n9QHgTxj024639
	for <selinux@tycho.nsa.gov>; Mon, 26 Oct 2009 17:42:30 GMT
Date: Mon, 26 Oct 2009 13:43:24 -0400
Subject: Re: RPM support for SELinux
From: Chad Sellers <csellers@tresys.com>
To: Jeff Johnson <n3npq@mac.com>, Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C70B57FC.AB8F3%csellers@tresys.com>
In-Reply-To: <D61F5B71-5D0C-4250-A3C1-36700B6877B2@mac.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/23/09 5:27 PM, "Jeff Johnson" <n3npq@mac.com> wrote:

> 
> On Oct 23, 2009, at 9:22 AM, Joshua Brindle wrote:
>> 
>> That is not the purpose of this patchset, and it was never claimed
>> to be the purpose of this patchset.
>> 
>> The purpose of this patchset is to start integrating policy support
>> into RPM, and for RPM to remain completely trusted. I did say that
>> we have an ultimate goal of breaking RPM up into pieces so we could
>> remove trust from the main parts, and to eventually be able to run
>> RPM in different security domains depending on different aspects of
>> the RPM (where it came from, who signed it, who is running RPM, etc)
>> but that is not something this patch set can accomplish and indeed
>> is a long term goal.
>> 
>> We can't very well go off for a long time and come back with a
>> patchset that completely changes the architecture of RPM, we are
>> doing this development in the open and therefore each individual
>> patch set along the way brings us closer, it doesn't completely
>> solve the problem.
>> 
> 
> No you can't. Nor can you wander around making contradictory statements
> about what you intend publically.
> 
> So now the goal is "completely change the architecture of RPM" without
> any statement of purpose (other than that you think the change is
> needed)
> and you claim to be doing development in the open.
> 
> If you stated your goals more clearly, with perhaps an illustration of
> what you think needs doing, you might find better acceptance.
> 
> Each individual patch set I've seen is currently appearing, to somewhat
> negative comments not just from me, and then you wander off
> to re-appear with essentially the same patch set with almost exactly
> the same issues (like the opaqueness of bz2 blobs embedded
> in rpm headers, and the size of the unnormalized uncompressed
> policy data, and the difficulties of executing helpers in empty
> chroot's). Go read the comments, the issues were pointed out not just
> by me.
> 
> Could you please state your goals more clearly so that a developer
> might understand the reasoning behind an end-point that seems to
> include "completely changes
> the architecture of RPM" as an end-point (or why did you bother
> mentioning).
> 
> Otherwise, piecemeal patching (as in the current patch set) closely
> followed
> by claims that you are going to move to "hi-level compilers to install
> policy"
> (my paraphrase from memory) seems more like a randopm walk than
> anything else.
> 
OK, I'll do my best to explain our motivations. The goals for this patchset
are fairly simple, and are outlined in patch 00/12. The summary is that
there are a few specific problems that are currently preventing some
packagers from including policy in their packages, and this patchset aims to
fix those. Of course, we also have some longer term goals which we kept in
mind when writing this patchset to ensure that we did not shoot ourselves in
the foot, but this patchset does not address those goals yet.

Our longer term goals indeed center around reducing trust placed in rpm. We
are interested in two primary sides of this. One is to support running rpm
with different levels of trust depending on the situation. The other is to
try to separate the areas of rpm that require the most trust from those that
have been shown to be the riskiest. In working with other apps, making
changes along these lines, we've found that architectural changes are
sometimes necessary, which is what Josh was alluding to. That said, these
are long term goals that we have not begun to address, which is why we
haven't begun to talk about them on list. We should have told you these
goals earlier, but we are not hiding anything here as there is nothing to
hide.

I'm sorry if it seems that we are not responding to concerns raised. The
addition of a fallback mechanism to utilize library calls when in an empty
chroot instead of executing a helper was done specifically because of
concerns raised.

As far as issues like unnormalized policy data and using bz2 compression go,
I'm sorry but that's how policy works today. Could it be better? Sure (and I
don't want to have an argument here about what constitutes "better"), but
it's not right now. I know that you think the current SELinux policy format
is unworthy of becoming a first-class citizen in rpm. I just hope the rest
of the rpm community disagrees with you, because I really don't want to be
forced to use %post scripts for another couple years while people argue
about what is a worthy format.

Thanks,
Chad




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
