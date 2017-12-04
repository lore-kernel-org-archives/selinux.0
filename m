Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB4H1Jjv017829
 for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2017 12:01:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 3yrB3c58DXz20Mxk
 for <selinux@tycho.nsa.gov>; Mon,  4 Dec 2017 17:01:16 +0000 (UTC)
Received: from UPBD19PA13.eemsg.mil (unknown [192.168.18.15])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 3yrB3c3C5Zz20MxX
 for <selinux@tycho.nsa.gov>; Mon,  4 Dec 2017 17:01:16 +0000 (UTC)
Received: by mail-lf0-f65.google.com with SMTP id f18so19948095lfg.8
 for <selinux@tycho.nsa.gov>; Mon, 04 Dec 2017 09:01:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdrx0hcnZb6jk5_ooCR6vovGTBw2XP=CBoS5qRQroHWHGQ@mail.gmail.com>
References: <151216389973.29858.4790300595820219259.stgit@chester>
 <CAFftDdrx0hcnZb6jk5_ooCR6vovGTBw2XP=CBoS5qRQroHWHGQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 Dec 2017 12:01:10 -0500
Message-ID: <CAHC9VhRKM1qMenSxVshagKB8DQ8LxynAAb04PmhBRs5FkqecZA@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Paul Moore <pmoore@redhat.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2] selinux: ensure the context is NUL
 terminated in security_context_to_sid_core()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 1, 2017 at 5:21 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Fri, Dec 1, 2017 at 1:31 PM, Paul Moore <pmoore@redhat.com> wrote:
>> From: Paul Moore <paul@paul-moore.com>
>>
>> The syzbot/syzkaller automated tests found a problem in
>> security_context_to_sid_core() during early boot (before we load the
>> SELinux policy) where we could potentially feed context strings without
>> NUL terminators into the strcmp() function.
>>
>> We already guard against this during normal operation (after the SELinux
>> policy has been loaded) by making a copy of the context strings and
>> explicitly adding a NUL terminator to the end.  The patch extends this
>> protection to the early boot case (no loaded policy) by moving the context
>> copy earlier in security_context_to_sid_core().
>>
>> Reported-by: syzbot <syzkaller@googlegroups.com>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/selinux/ss/services.c |   18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index 33cfe5d3d6cb..d05496deb229 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -1413,27 +1413,25 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
>>         if (!scontext_len)
>>                 return -EINVAL;
>>
>> +       /* Copy the string to allow changes and ensure a NUL terminator */
>> +       scontext2 = kmemdup_nul(scontext, scontext_len, gfp_flags);
>> +       if (!scontext2)
>> +               return -ENOMEM;
>> +
>>         if (!ss_initialized) {
>>                 int i;
>>
>>                 for (i = 1; i < SECINITSID_NUM; i++) {
>> -                       if (!strcmp(initial_sid_to_string[i], scontext)) {
>> +                       if (!strcmp(initial_sid_to_string[i], scontext2)) {
>>                                 *sid = i;
>> -                               return 0;
>> +                               goto out;
>>                         }
>>                 }
>>                 *sid = SECINITSID_KERNEL;
>> -               return 0;
>> +               goto out;
>>         }
>>         *sid = SECSID_NULL;
>>
>> -       /* Copy the string so that we can modify the copy as we parse it. */
>> -       scontext2 = kmalloc(scontext_len + 1, gfp_flags);
>> -       if (!scontext2)
>> -               return -ENOMEM;
>> -       memcpy(scontext2, scontext, scontext_len);
>> -       scontext2[scontext_len] = 0;
>> -
>>         if (force) {
>>                 /* Save another copy for storing in uninterpreted form */
>>                 rc = -ENOMEM;
>>
>>
>
> I like negative diffstats.
>
> <Reviewed-By William Roberts william.c.roberts@intel.com>

So do I, it's one of the few pleasures I have in this job.

Merged into selinux/next, thanks for the review.

-- 
paul moore
www.paul-moore.com
