Message-ID: <4C10EB8D.6060608@gmail.com>
Date: Thu, 10 Jun 2010 06:41:33 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: warning: the frame size of 1072 bytes is larger than 1024 bytes
References: <4C106F0F.8020000@gmail.com> <1276172855.25808.17.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1276172855.25808.17.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/10/2010 05:27 AM, Stephen Smalley wrote:
> On Wed, 2010-06-09 at 21:50 -0700, Justin P. Mattock wrote:
>> I've racked my brain with this one today
>> with no results, but only what/where(maybe)
>> is the cause for this:
>>
>> policydb_destroy(&oldpolicydb);
>>
>> if I change the&oldpolicydb to
>> either&newpolicydb or&policydb
>> I can get a clean compile without any
>> warning message like below.
>>
>> security/selinux/ss/services.c: In function 'security_load_policy':
>> security/selinux/ss/services.c:1882: warning: the frame size of 1072
>> bytes is larger than 1024 bytes
>>
>> is this a bug in policydb?
>> any ideas on this one?
>
> This is just a warning that the stack frame size for
> security_load_policy() exceeds the limit specified by CONFIG_FRAME_WARN
> (set under the Kernel hacking menu). On 64-bit it defaults to 2048; else
> it defaults to 1024.
>
> You can just change your CONFIG_FRAME_WARN setting (to 0 to disable
> checking altogether, or increase it to retain checking but allow this
> case).
>
> The code fix would be to change security_load_policy() to allocate
> oldpolicydb and newpolicydb on the heap rather than temporarily storing
> them on the stack.
>

That worked.. set my .config to 0
and voila kernel compiles without that warning
message. I've been looking at that
warning message for years now, and all due to me
setting  CONFIG_FRAME_WARN(duh!!)

As for the real fix to the issue

 > The code fix would be to change security_load_policy() to allocate
 > oldpolicydb and newpolicydb on the heap rather than temporarily storing
 > them on the stack.

Id have to do some research on this. A quick search
does give archives of other peoples patches when such warning
messages are received in the kernel, but looking at them, there a bit
large of changes i.g. changing oldpolicydb and newpolicydb
to allocate themselves on the heap rather than on the stack.
(but could be wrong).

Thanks for the info on this..

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
