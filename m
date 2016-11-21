Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uALKeF2l029992
 for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2016 15:40:15 -0500
Received: by mail-ua0-f195.google.com with SMTP id 50so26894459uae.2
 for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2016 12:40:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7d43fa5a-5e41-b240-0237-abc0ff034b27@tycho.nsa.gov>
References: <1479482589-3889-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQEyJ_hgjLovcFxgJn4XUsLYVh836Ho-f7ygzB4BoT6zg@mail.gmail.com>
 <7d43fa5a-5e41-b240-0237-abc0ff034b27@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 21 Nov 2016 15:40:11 -0500
Message-ID: <CAHC9VhTuhri4rYQP_bwwz1H+vt6paca1Gy-wx93RwtXLwRJBkg@mail.gmail.com>
Subject: Re: [PATCH] selinux: keep SELinux in sync with new capability
 definitions
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 21, 2016 at 9:49 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/20/2016 05:29 PM, Paul Moore wrote:
>> On Fri, Nov 18, 2016 at 10:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> When a new capability is defined, SELinux needs to be updated.
>>> Trigger a build error if a new capability is defined without
>>> corresponding update to security/selinux/include/classmap.h's
>>> COMMON_CAP2_PERMS.  This is similar to BUILD_BUG_ON() guards
>>> in the SELinux nlmsgtab code to ensure that SELinux tracks
>>> new netlink message types as needed.
>>>
>>> Note that there is already a similar build guard in
>>> security/selinux/hooks.c to detect when more than 64
>>> capabilities are defined, since that will require adding
>>> a third capability class to SELinux.
>>>
>>> A nicer way to do this would be to extend scripts/selinux/genheaders
>>> or a similar tool to auto-generate the necessary definitions and code
>>> for SELinux capability checking from include/uapi/linux/capability.h.
>>> AppArmor does something similar in its Makefile, although it only
>>> needs to generate a single table of names.  That is left as future work.
>>>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>>  security/selinux/include/classmap.h | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>>> index 1f1f4b2..e2d4ad3a 100644
>>> --- a/security/selinux/include/classmap.h
>>> +++ b/security/selinux/include/classmap.h
>>> @@ -24,6 +24,10 @@
>>>  #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
>>>                 "wake_alarm", "block_suspend", "audit_read"
>>>
>>> +#if CAP_LAST_CAP > CAP_AUDIT_READ
>>> +#error New capability defined, please update COMMON_CAP2_PERMS.
>>> +#endif
>>
>> I think the obvious question here is why not use BUILD_BUG_ON() here?
>> I understand that it can be disabled, but it seems like the "good
>> neighbor" option compared to the #error pragma.
>
> I wanted the error to be triggered in the file that needs to be updated,
> and preferably close to the line that needs to be updated.
> BUILD_BUG_ON() and friends can only be used within a function, and there
> is no function in view in classmap.h.  We could put a BUILD_BUG_ON() in
> one of the functions that use secclass_map[], e.g. avc_dump_av(), but it
> will be less directly correlated to what needs to be updated - it won't
> be the correct file.

Okay, I see the value in keeping the error close to the root cause.  Merged.

-- 
paul moore
www.paul-moore.com
