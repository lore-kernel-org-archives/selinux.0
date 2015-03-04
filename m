Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t24I7UTs028132
 for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2015 13:07:30 -0500
Received: by obcuy5 with SMTP id uy5so1418056obc.11
 for <selinux@tycho.nsa.gov>; Wed, 04 Mar 2015 10:07:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54F06DF1.8070605@tycho.nsa.gov>
References: <1424987742-15120-1-git-send-email-jeffv@google.com>
 <54F06DF1.8070605@tycho.nsa.gov>
Date: Wed, 4 Mar 2015 13:07:27 -0500
Message-ID: <CAHC9VhRwTvimSHLToG9mkk5jiM7N3CJCR6pR2Sa_mJsHcDwtog@mail.gmail.com>
Subject: Re: [PATCH] avc: remove unnecessary pointer reassignment
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: jvanderstoep@gmail.com, James Morris <james.l.morris@oracle.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Feb 27, 2015 at 8:15 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 02/26/2015 04:54 PM, Jeff Vander Stoep wrote:
>> Commit f01e1af445fa ("selinux: don't pass in NULL avd to avc_has_perm_noaudit")
>> made this pointer reassignment unnecessary. Avd should continue to reference
>> the stack-based copy.
>>
>> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>


Thanks everyone for the patch and the review.  I'll merge this next
week into selinux#next.

>> ---
>>  security/selinux/avc.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>> index afcc0ae..3c17dda 100644
>> --- a/security/selinux/avc.c
>> +++ b/security/selinux/avc.c
>> @@ -724,12 +724,10 @@ inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>>       rcu_read_lock();
>>
>>       node = avc_lookup(ssid, tsid, tclass);
>> -     if (unlikely(!node)) {
>> +     if (unlikely(!node))
>>               node = avc_compute_av(ssid, tsid, tclass, avd);
>> -     } else {
>> +     else
>>               memcpy(avd, &node->ae.avd, sizeof(*avd));
>> -             avd = &node->ae.avd;
>> -     }
>>
>>       denied = requested & ~(avd->allowed);
>>       if (unlikely(denied))
>>
>



-- 
paul moore
www.paul-moore.com
