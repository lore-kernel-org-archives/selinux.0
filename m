Message-ID: <518BEF50.1060809@tycho.nsa.gov>
Date: Thu, 09 May 2013 14:47:44 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov, James Carter <jwcart2@tycho.nsa.gov>
Subject: Re: Disabling rules
References: <20130509183336.GA16336@siphos.be>
In-Reply-To: <20130509183336.GA16336@siphos.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/09/2013 02:33 PM, Sven Vermeulen wrote:
> Hi all,
>
> I was wondering if we could include a method for users or administrators to
> remove (or disable) particular allow statements from the policy, without the
> need to unload the module that provides the policy and replace it with a
> similar policy (offering the same types and such, but just doesn't include
> those rules the admin doesn't want to enable).
>
>>From my understanding, I think this has been discussed in the past, but not
> accepted due to it becoming a mess (for admins) to maintain such policies:
> in one module, rules would be allowed, and in another denied again.
>
> Still, we can disable dontaudits, disable an entire module or put a
> particular domain in permissive mode. Perhaps we could look into disabling
> certain statements as well?
>
> The reason I ask is that administrators might want to some just a fraction
> of the granted permissions in the default policy, without having to maintain
> an entire policy themselves. This could be useful for temporarily working
> around possible vulnerabilities.
>
> For (policy) developers as well, this could be a useful feature. One can
> selectively disable some rules and test out the impact. For instance,
> suppose we want to reduce the number of "open" permissions on certain files.
> Historically, "open" was granted as well, but we might want to look into
> inherited read/write access (without "open"). With such feature, we can test
> out the impact without the need to do the (intensive) policy updates first.
> Afterwards, the policy can then be properly reduced.
>
> I was considering using constraints to implement this myself (locally), but
> constraints cannot be added to modules (need to be in base according to the
> selinuxproject wiki).

This probably isn't what you mean/want, but you can certainly wrap 
blocks of TE rules with conditionals and then disable them at runtime 
via setsebool or semanage boolean already.

If you mean selecting what statements get disabled at runtime without 
previously wrapping them in a conditional in the original policy, then 
that sounds like some of the functionality that was being implemented by 
the CIL work, which had some notion of local policy transformations.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
