Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2AKL9f5003318
 for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2017 15:21:10 -0500
Received: by mail-ua0-f196.google.com with SMTP id y16so15574993uay.3
 for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2017 12:21:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1489177036.6824.57.camel@tycho.nsa.gov>
References: <20170209155823.22148-1-runcom@redhat.com>
 <CAHC9VhSL3ZS3R2r39+qzYmvU1=8-jC2nzqkXNQ0Yk3+okKd7jw@mail.gmail.com>
 <1489177036.6824.57.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Mar 2017 15:21:07 -0500
Message-ID: <CAHC9VhSL1dm9b7ZohYyCU0PjKbbtYLe7XX7Xv3CsQQx4CtG_Fw@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labeling for cgroupfs
To: Stephen Smalley <sds@tycho.nsa.gov>, Antonio Murdaca <amurdaca@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, vgoyal@redhat.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Mar 10, 2017 at 3:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2017-03-10 at 15:01 -0500, Paul Moore wrote:
>> On Thu, Feb 9, 2017 at 10:58 AM, Antonio Murdaca <amurdaca@redhat.com
>> > wrote:
>> >
>> > This patch allows genfscon per-file labeling for cgroupfs. For
>> > instance,
>> > this allows to label the "release_agent" file within each
>> > cgroup mount and limit writes to it.
>> >
>> > Signed-off-by: Antonio Murdaca <runcom@redhat.com>
>> > ---
>> >  security/selinux/hooks.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>>
>> Now that the merge window is behind us, let's get this merged, but
>> could you update it to use the selinux_policycap_cgroupseclabel
>> policy
>> capability?  See 2651225b5ebcdde ("selinux: wrap cgroup seclabel
>> support with its own policy capability") for more information.
>
> I don't think that is necessary.  This change unlike the other one
> should not yield any difference in behavior with existing policy; it
> just allows one to specify fine-grained labeling for cgroup nodes in
> future policy.  It doesn't affect any userspace interface.

Yes, I thought about that, and if the policy capability was already
present in a released kernel then I wouldn't worry about it much, but
since the policy capability still only lives in the v4.11-rcX kernels
I'd prefer to see this code wrapped with the policy capability ...
even if all it really does is give me that warm fuzzy feeling.

>> Also, how goes the testing?
>>
>> >
>> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> > index 9a8f12f..5a3138e 100644
>> > --- a/security/selinux/hooks.c
>> > +++ b/security/selinux/hooks.c
>> > @@ -808,6 +808,8 @@ static int selinux_set_mnt_opts(struct
>> > super_block *sb,
>> >
>> >         if (!strcmp(sb->s_type->name, "debugfs") ||
>> >             !strcmp(sb->s_type->name, "sysfs") ||
>> > +           !strcmp(sb->s_type->name, "cgroup") ||
>> > +           !strcmp(sb->s_type->name, "cgroup2") ||
>> >             !strcmp(sb->s_type->name, "pstore"))
>> >                 sbsec->flags |= SE_SBGENFS;
>> >
>> > --
>> > 2.9.3
>> >
>> > _______________________________________________
>> > Selinux mailing list
>> > Selinux@tycho.nsa.gov
>> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> > To get help, send an email containing "help" to Selinux-request@tyc
>> > ho.nsa.gov.
>>



-- 
paul moore
www.paul-moore.com
