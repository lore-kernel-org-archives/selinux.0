Message-ID: <44D382C4.9070705@trustedcs.com>
Date: Fri, 04 Aug 2006 12:24:20 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Valdis.Kletnieks@vt.edu, James Morris <jmorris@namei.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH 0/2] new and improved range_transition statements
References: <44CA2919.4010708@trustedcs.com>	 <1154351236.26550.14.camel@localhost.localdomain>	 <1154354184.1447.23.camel@moss-spartans.epoch.ncsc.mil>	 <200607311428.k6VESR6m004599@turing-police.cc.vt.edu>	 <1154356995.1447.64.camel@moss-spartans.epoch.ncsc.mil>	 <200607311510.k6VFAhrw006155@turing-police.cc.vt.edu> <1154697573.3919.18.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1154697573.3919.18.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-07-31 at 11:10 -0400, Valdis.Kletnieks@vt.edu wrote:
> 
>>On Mon, 31 Jul 2006 10:43:15 EDT, Stephen Smalley said:
>>
>>
>>>I agree that it is too late for 2.6.18, but just to clarify - the kernel
>>>patch preserves backward compatibility for older binary policy
>>>formats.  
>>>
>>>As far as compatibility is concerned, FC4 will need some kind of
>>>userland update when it updates to a kernel with the new policy format;
>>>otherwise, init will give up when it cannot find policy.21 or policy.20
>>>(older sysvinit selinux patch only tried n and (n-1)), and the policy in
>>>FC4 was version 19.
>>
>>Given that Andrew Morton is currently having a cow over the fact that
>>2.6.18-rc3 includes a change that breaks the udev that shipped with FC3,
>>we might want to make sure we have all our ducks lined up....
>>
>>(To be fair, the udev change is one that breaks any udev more than 10 months
>>or so old...)
> 
> 
> After a bit of discussion (see bug 201242 in the redhat bugzilla) about
> updating FC4 userland, it seems that we should try to address this
> compatibility concern for legacy userland in the kernel.  We could first
> upstream the patch below, then re-base the range_transition kernel patch
> against it.  This patch makes the maximum policy version a kernel config
> option so that it can be adjusted down to accommodate legacy userland,
> with instructions and examples in the help text of the config option on
> how to determine what value to use.  The range_transition kernel patch
> would then adjust the "range" and "default" attributes of this new
> config option to reflect the new version support, while users could
> still build kernels to an older version.  Thoughts?

This patch will certainly provide a solution to the problem.  However, I wonder
if most people that would have had the problem in the first place (those with
old userspace components) will still run into the problem for their first kernel
build because they did not know alter the config for the situation.  So we'll
likely need to advertise this change accordingly ;).  At least it will be an
easier fix than updating the SELinux userland components and init.  I can rebase
the range_transition patch when this goes upstream (of course there is not much
to it...)

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
