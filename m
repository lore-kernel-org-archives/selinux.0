Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2VJI9LN029281
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 15:18:12 -0400
Received: by mail-ua0-f194.google.com with SMTP id 105so39568uat.1
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 12:18:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490975541.31110.12.camel@tycho.nsa.gov>
References: <20170331152118.GA8141@mwanda>
 <1490975541.31110.12.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Mar 2017 15:18:09 -0400
Message-ID: <CAHC9VhT7njoVyHgyiTQhCcvZEYrTE_XZRLxT4+JJPiH3W88AUw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix an uninitialized variable bug
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 William Roberts <william.c.roberts@intel.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Mar 31, 2017 at 11:52 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2017-03-31 at 18:21 +0300, Dan Carpenter wrote:
>> We removed this initialization as a cleanup but it is probably
>> required.
>>
>> The concern is that "nel" can be zero.  I'm not an expert on SELinux
>> code but I think it looks possible to write an SELinux policy which
>> triggers this bug.  GCC doesn't catch this, but my static checker
>> does.
>>
>> Fixes: 9c312e79d6af ("selinux: Delete an unnecessary variable
>> initialisation in range_read()")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Nice catch, thanks!
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Yes, indeed.  Thanks Dan, I should have caught this when merging Markus' patch.

Merged.

>> diff --git a/security/selinux/ss/policydb.c
>> b/security/selinux/ss/policydb.c
>> index 658247f98dc1..0080122760ad 100644
>> --- a/security/selinux/ss/policydb.c
>> +++ b/security/selinux/ss/policydb.c
>> @@ -1832,7 +1832,7 @@ u32 string_to_av_perm(struct policydb *p, u16
>> tclass, const char *name)
>>
>>  static int range_read(struct policydb *p, void *fp)
>>  {
>> -     struct range_trans *rt;
>> +     struct range_trans *rt = NULL;
>>       struct mls_range *r = NULL;
>>       int i, rc;
>>       __le32 buf[2];

-- 
paul moore
www.paul-moore.com
