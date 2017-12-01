Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB1Fat34001467
 for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2017 10:36:56 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 3ypJKd42Rjz3GDLG
 for <selinux@tycho.nsa.gov>; Fri,  1 Dec 2017 15:36:53 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 3ypJKd32WQz3GDLB
 for <selinux@tycho.nsa.gov>; Fri,  1 Dec 2017 15:36:53 +0000 (UTC)
Received: by mail-wr0-f195.google.com with SMTP id o2so10521210wro.5
 for <selinux@tycho.nsa.gov>; Fri, 01 Dec 2017 07:36:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdp34FQf45OEx+2AaVE62Y=imG2SstMySR9tN__=yoec4g@mail.gmail.com>
References: <151206074183.32567.881282052709289967.stgit@chester>
 <CAFftDdp34FQf45OEx+2AaVE62Y=imG2SstMySR9tN__=yoec4g@mail.gmail.com>
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 1 Dec 2017 10:34:51 -0500
Message-ID: <CAGH-Kgtzi_P9ZCLEd2_-6y4kn0eA6EHBA3OVvV=64czxUjRQQQ@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: ensure the context is NULL terminated
 in security_context_to_sid_core()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Nov 30, 2017 at 6:44 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Thu, Nov 30, 2017 at 8:52 AM, Paul Moore <pmoore@redhat.com> wrote:
>> From: Paul Moore <paul@paul-moore.com>
>>
>> The syzbot/syzkaller automated tests found a problem in
>> security_context_to_sid_core() during early boot (before we load the
>> SELinux policy) where we could potentially feed context strings without
>> NULL terminators into the strcmp() function.
>>
>> We already guard against this during normal operation (after the SELinux
>> policy has been loaded) by making a copy of the context strings and
>> explicitly adding a NULL terminator to the end.  The patch extends this
>> protection to the early boot case (no loaded policy) by moving the context
>> copy earlier in security_context_to_sid_core().
>>
>> Reported-by: syzbot <syzkaller@googlegroups.com>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/selinux/ss/services.c |   20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index 33cfe5d3d6cb..6ec4cdc8af8f 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -1413,27 +1413,27 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
>>         if (!scontext_len)
>>                 return -EINVAL;
>>
>> +       /* Copy the string to allow changes and ensure a NULL terminator */
>> +       scontext2 = kmalloc(scontext_len + 1, gfp_flags);
>> +       if (!scontext2)
>> +               return -ENOMEM;
>> +       memcpy(scontext2, scontext, scontext_len);
>> +       scontext2[scontext_len] = 0;
>
> Call me crazy, but can't we use kmemdup_nul() here?

Crazy good idea ;)

I didn't realize that function existed, I'll respin.  Thanks.

> /**
>  * kmemdup_nul - Create a NUL-terminated string from unterminated data
>  * @s: The data to stringify
>  * @len: The size of the data
>  * @gfp: the GFP mask used in the kmalloc() call when allocating memory
>  */
> char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)

-- 
paul moore
security @ redhat
