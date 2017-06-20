Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KJtSvL018746
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 15:55:28 -0400
Received: by mail-lf0-f66.google.com with SMTP id x81so17122778lfb.3
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 12:55:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497978728.12069.13.camel@tycho.nsa.gov>
References: <20170620163533.2558-1-jeffv@google.com>
 <1497978728.12069.13.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Jun 2017 15:55:21 -0400
Message-ID: <CAHC9VhRgqRe3_WkgzNO2HjH-23-_7iWDuHo1mDOyDqB1kN4LWQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: enable genfscon labeling for tracefs
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 20, 2017 at 1:12 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2017-06-20 at 09:35 -0700, Jeff Vander Stoep wrote:
>> In kernel version 4.1, tracefs was separated from debugfs into its
>> own filesystem. Prior to this split, files in
>> /sys/kernel/debug/tracing could be labeled during filesystem
>> creation using genfscon or later from userspace using setxattr. This
>> change re-enables support for genfscon labeling.
>>
>> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>
> I don't suppose we could get you to tackle
> https://github.com/SELinuxProject/selinux-kernel/issues/2
> so that we don't have to keep patching these filesystem type
> whitelists?

+1 for Stephen's request.  For what it's worth you'll also earn my
appreciation, or your beverage of choice the next time we are in the
same spot (I'd go for the drink if I were you, much more valuable).

> That said, given that this is a user-visible regression, I'm ok with
> this as the short term fix.
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Looks fine to me too, merged into selinux/next.

>> ---
>>  security/selinux/hooks.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 820c16e36af8..33fd061305c4 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -813,6 +813,7 @@ static int selinux_set_mnt_opts(struct
>> super_block *sb,
>>               sbsec->flags |= SE_SBPROC | SE_SBGENFS;
>>
>>       if (!strcmp(sb->s_type->name, "debugfs") ||
>> +         !strcmp(sb->s_type->name, "tracefs") ||
>>           !strcmp(sb->s_type->name, "sysfs") ||
>>           !strcmp(sb->s_type->name, "pstore"))
>>               sbsec->flags |= SE_SBGENFS;

-- 
paul moore
www.paul-moore.com
