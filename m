Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBCFmQke017789
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 10:48:26 -0500
Message-ID: <50C8A757.3050907@schaufler-ca.com>
Date: Wed, 12 Dec 2012 07:48:39 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
References: <50C65DE2.5090909@schaufler-ca.com> <201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp> <50C751D3.60409@schaufler-ca.com> <201212122159.CEC09839.HMOFtQFLJSVFOO@I-love.SAKURA.ne.jp>
In-Reply-To: <201212122159.CEC09839.HMOFtQFLJSVFOO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/12/2012 4:59 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> On 12/11/2012 4:28 AM, Tetsuo Handa wrote:
>>> CONFIG_SECURITY_PRESENT must be always PRESENT_FIRST and only one LSM module
>>> which provides ops->getprocattr and/or ops->setprocattr is allowed to register.
>> No.
>> Absolutely not.
>>
>> That restriction would make composing security modules completely
>> useless. At least for me. Sorry, but Smack + AppArmor is one of my
>> success criteria. I have introduced a smackfs/current interface
>> in this patch, but I plan to abandon that in favor of the enhanced
>> proc/.../attr entries we've been discussing.
> My suggestion was
>
>   Step 1: Start LSM stacking without supporting "SELinux + AppArmor" or
>           "SMACK + AppArmor".

I will repeat myself.

No.
Absolutely not.

>   Step 2: Wait for a year or so for migrating from conflicting /proc/pid/attr/
>           interface to non-conflicting interfaces.

No. I don't have another year to wait. Were I willing to wait
I'd have let someone else try to wrestle this elephant.

>   Step 3: Kill conflicting /proc/pid/attr/ interface and support
>           "SELinux + AppArmor" or "SMACK + AppArmor" so that not-yet-migrated
>           userspace tools no longer recognize that "LSM is enabled" rather than
>           recognize that "LSM is enabled" but cannot work correctly.

The problem here is that I can't kill the old interfaces. Ever.
Some 2nd Lieutenant in Gaithersburg is busy installing a RHEL system
right now for which he spent the past two years getting approval.
It has classified programs on it. It will run until he makes Colonel.
The "security interfaces" will not change, and that means no updates
once the old attr interfaces go away. 

>
> but your will is
>
>   Step 1: Start LSM stacking with supporting "SELinux + AppArmor" or
>           "SMACK + AppArmor" with tolerating malfunctioningly working userspace
>           tools.

You're suggesting that we don't change the kernel until the
applications are fixed. No one is going to change the applications
until the kernel is fixed.

>
> isn't it?
>
> I suggested you to *eventually* break not-yet-migrated userspace tools in order
> to *eventually* make it possible to stack "SELinux + AppArmor" or
> "SMACK + AppArmor". 
>
> You purposely *immediately* break non-present LSM module's userspace tools in
> order to *immediately* make it possible to stack "SELinux + AppArmor" or
> "SMACK + AppArmor".
>
> But I'm fine with your will provided that SELinux/SMACK/AppArmor developers and
> their users can agree with your will.

I'm also making development of tools for the multiple LSM case
possible. Someone has to lead.

>> I have not given up hope on secid using LSM combinations, either.
>> I really would prefer that there be no limitations.
>>
>>
>>> This is a mandatory requirement for not to break userspace tools for
>>> non-present LSM modules by supplying /proc/pid/attr/ interface that is
>>> malfunction for non-present LSM modules.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
