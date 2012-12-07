Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB71LgU4027228
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2012 20:21:42 -0500
Message-ID: <50C1448F.90404@schaufler-ca.com>
Date: Thu, 06 Dec 2012 17:21:19 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>
CC: John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        eparis@redhat.comc, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v9 1/2] LSM: Multiple concurrent LSMs
References: <201212042243.BJG73463.LFHFQFSJOOVOMt@I-love.SAKURA.ne.jp> <50BE92ED.9000400@schaufler-ca.com> <50BE9E22.9000104@canonical.com> <201212052341.IEB26527.FVJOLHOtMOSQFF@I-love.SAKURA.ne.jp> <50BFC078.8090509@canonical.com> <201212062249.IJC51548.OOtSJLOQHFFVMF@I-love.SAKURA.ne.jp> <50C0CED0.1000107@canonical.com> <CAGXu5j+jLx9y=MfBumy5sy8C=goWdicZ9dngqZVe2mjP=LoU3w@mail.gmail.com>
In-Reply-To: <CAGXu5j+jLx9y=MfBumy5sy8C=goWdicZ9dngqZVe2mjP=LoU3w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/6/2012 9:11 AM, Kees Cook wrote:
> On Thu, Dec 6, 2012 at 8:58 AM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 12/06/2012 05:49 AM, Tetsuo Handa wrote:
>>> John Johansen wrote:
>>>> This is not
>>>> something I want to do but if that is what is necessary to get stacking done
>>>> I will do it.
>>> Sharing existing interfaces by managing the format is a thorny path.
>>> Future LSM modules, if they are to use existing interfaces, might want to allow
>>> attributes up to 4000 bytes when overall length is limited to 4096 bytes.
>>>
>>>> Of course modifying apparmor doesn't take care of other LSMs so either certain
>>>> restrictions have to be part of the api for this interface or as Tetsuo suggests
>>>> a new interface would be needed.
>>> TOMOYO uses /sys/kernel/security/tomoyo/self_domain (handled by stateless
>>> tomoyo_read_self()/tomoyo_write_self()) for reading/updating current thread's
>>> attribute and /sys/kernel/security/tomoyo/.process_status (handled by
>>> stateful tomoyo_write_pid()/tomoyo_read_pid()) for reading arbitrary thread's
>>> attribute. I think that most programs will, if need to access attribute
>>> information, need to access only current thread's attribute. Therefore,
>>> /sys/kernel/security/tomoyo/self_domain handles only current thread and
>>> /sys/kernel/security/tomoyo/.process_status handles arbitrary threads.
>>>
>>> If AppArmor can migrate from existing /proc/pid/attr/ to its own interfaces
>>> like TOMOYO does, we can immediately get LSM stacking with "optionally either
>>> SELinux or SMACK" + "optionally AppArmor" + "optionally TOMOYO" + "optionally
>>> Yama" + "optionally other LSM modules". SELinux and SMACK are forever exclusive
>>> due to conflicts on other hooks.
>>>
>> So moving apparmor to use its own interface for setting values is reasonable,
>> though being able to fall back to /proc/<pid>/attr/* for none stacking cases
>> to support older userspace releases would be good.
>>
>> However getprocattr is a little more problematic as leveraging standard tools
>> that have been modified to support the security context (eg. ps -Z, etc) has
>> been standard practice, and is used a lot more than writing to /proc/<pid>/attr/*
>> Moving to our own interface looses this standard tool support.
>>
>> There are possible solutions, like multiplexing reading of /proc/<pid>/attr/*,
>> but not writes (yes I know its still problematic).
> Does it make sense to make attr read-only and leave its output
> multiplexed so "ps -Z" output is human readable?

This may work long term, but would break backward compatibility.

> Regardless, how about we just give attr to the "primary"

I much prefer referring to this as the "presented" LSM than
as the "primary". All LSMs are equal, one just gets to talk louder.

> LSM for now,

The disadvantage is that ps -Z, which simply reads /proc/pid/attr/current
has to get smarter all of a sudden.

> just to land this patch series? It's already a big patch, and I think
> it would be beneficial to get the bulk of the stacking logic in. We
> can improve the attr handling going forward, since that doesn't seem
> to affect the _structure_ of the changes.

For my next trick I'll try using the CONFIG_SECURITY_PRESENT value
if provided and the first LSM that includes a getprocattr hook otherwise.

Let me know if that sounds stupid.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
