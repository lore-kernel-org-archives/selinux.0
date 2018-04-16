Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3GEPjQM029094
 for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2018 10:25:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 40PrJf2JhWz62qn
 for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2018 14:25:38 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 40PrJf0ZnTz62r8
 for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2018 14:25:38 +0000 (UTC)
Received: by mail-ot0-f194.google.com with SMTP id d9-v6so17555745oth.10
 for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2018 07:25:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180416141101.zcovkknupxcgiwf2@madcap2.tricolour.ca>
References: <6b939250a519668af109adf877d85ff018b217d7.1523316267.git.rgb@redhat.com>
 <CAFqZXNuEwxp7vThtVH1oYSE5bAisvwNpBH3ry9tyL5BPSwXK=g@mail.gmail.com>
 <20180416141101.zcovkknupxcgiwf2@madcap2.tricolour.ca>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 16 Apr 2018 16:25:19 +0200
Message-ID: <CAFqZXNsiTU7nqcuttjtjpDnU6Ua_+Ff8HcUCSuBHqT9DFCLx8w@mail.gmail.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, SElinux list <selinux@tycho.nsa.gov>,
 Linux Security Module list <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH ghak46 V1] audit: normalize MAC_STATUS record
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2018-04-16 16:11 GMT+02:00 Richard Guy Briggs <rgb@redhat.com>:
> On 2018-04-16 09:26, Ondrej Mosnacek wrote:
>> 2018-04-10 1:34 GMT+02:00 Richard Guy Briggs <rgb@redhat.com>:
>> > There were two formats of the audit MAC_STATUS record, one of which was more
>> > standard than the other.  One listed enforcing status changes and the
>> > other listed enabled status changes with a non-standard label.  In
>> > addition, the record was missing information about which LSM was
>> > responsible and the operation's completion status.  While this record is
>> > only issued on success, the parser expects the res= field to be present.
>> >
>> > old enforcing/permissive:
>> > type=MAC_STATUS msg=audit(1523312831.378:24514): enforcing=0 old_enforcing=1 auid=0 ses=1
>> > old enable/disable:
>> > type=MAC_STATUS msg=audit(1523312831.378:24514): selinux=0 auid=0 ses=1
>> >
>> > List both sets of status and old values and add the lsm= field and the
>> > res= field.
>> >
>> > Here is the new format:
>> > type=MAC_STATUS msg=audit(1523293828.657:891): enforcing=0 old_enforcing=1 auid=0 ses=1 enabled=1 old-enabled=1 lsm=selinux res=1
>> >
>> > This record already accompanied a SYSCALL record.
>> >
>> > See: https://github.com/linux-audit/audit-kernel/issues/46
>> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> > ---
>> >  security/selinux/selinuxfs.c | 11 +++++++----
>> >  1 file changed, 7 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>> > index 00eed84..00b21b2 100644
>> > --- a/security/selinux/selinuxfs.c
>> > +++ b/security/selinux/selinuxfs.c
>> > @@ -145,10 +145,11 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>> >                 if (length)
>> >                         goto out;
>> >                 audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
>> > -                       "enforcing=%d old_enforcing=%d auid=%u ses=%u",
>> > +                       "enforcing=%d old_enforcing=%d auid=%u ses=%u"
>> > +                       " enabled=%d old-enabled=%d lsm=selinux res=1",
>>
>> This is just a tiny nit but why does "old_enforcing" use an underscore
>> and "old-enabled" a dash? Shouldn't the style be consistent across
>> fields?
>
> Yes, but my understanding is a preference for underscore, and not to
> change existing field names.

Ah, I just noticed that the field is already used elsewhere in the
code, so it makes sense to keep it the same. I thought at first that
it is just a typo.

>
> Steve?
>
>> Just my two cents...
>
> These details are worth noticing, thank you.
>
>> >                         new_value, selinux_enforcing,
>> >                         from_kuid(&init_user_ns, audit_get_loginuid(current)),
>> > -                       audit_get_sessionid(current));
>> > +                       audit_get_sessionid(current), selinux_enabled, selinux_enabled);
>> >                 selinux_enforcing = new_value;
>> >                 if (selinux_enforcing)
>> >                         avc_ss_reset(0);
>> > @@ -272,9 +273,11 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>> >                 if (length)
>> >                         goto out;
>> >                 audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
>> > -                       "selinux=0 auid=%u ses=%u",
>> > +                       "enforcing=%d old_enforcing=%d auid=%u ses=%u"
>> > +                       " enabled=%d old-enabled=%d lsm=selinux res=1",
>> > +                       selinux_enforcing, selinux_enforcing,
>>
>> ^ also here
>>
>> >                         from_kuid(&init_user_ns, audit_get_loginuid(current)),
>> > -                       audit_get_sessionid(current));
>> > +                       audit_get_sessionid(current), 0, 1);
>> >         }
>> >
>> >         length = count;
>>
>> Ondrej Mosnacek <omosnace at redhat dot com>
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
