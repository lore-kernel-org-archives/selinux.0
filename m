Subject: Re: [PATCH] selinux: fix bug in conditional rules handling
To: Paul Moore <paul@paul-moore.com>
References: <1448312861-3574-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhSwTYJbGJpip5yLH9E7ZOHYG_xe-2Bsnmr7SReDoOcx3w@mail.gmail.com>
Cc: selinux@tycho.nsa.gov, bigon@debian.org, jeffv@google.com
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56538559.3050403@tycho.nsa.gov>
Date: Mon, 23 Nov 2015 16:30:01 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSwTYJbGJpip5yLH9E7ZOHYG_xe-2Bsnmr7SReDoOcx3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/23/2015 04:23 PM, Paul Moore wrote:
> On Mon, Nov 23, 2015 at 4:07 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> commit fa1aa143ac4a ("selinux: extended permissions for ioctls") introduced
>> a bug into the handling of conditional rules, skipping the processing
>> entirely when the caller does not provide an extended permissions (xperms)
>> structure.  Access checks from userspace using /sys/fs/selinux/access
>> do not include such a structure since that interface does not presently
>> expose extended permission information.  As a result, conditional rules
>> were being ignored entirely on userspace access requests, producing
>> denials when access was allowed by conditional rules in the policy.
>> Fix the bug by only skipping computation of extended permissions
>> in this situation, not the entire conditional rules processing.
>>
>> Reported-by: Laurent Bigonville <bigon@debian.org>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   security/selinux/ss/conditional.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Looks fine to me, thanks for the fix guys.  I'm going to mark this for
> stable unless I hear a strong objection from anyone.

Yes, definitely should go to stable.

>
>> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
>> index 18643bf..456e1a9 100644
>> --- a/security/selinux/ss/conditional.c
>> +++ b/security/selinux/ss/conditional.c
>> @@ -638,7 +638,7 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
>>   {
>>          struct avtab_node *node;
>>
>> -       if (!ctab || !key || !avd || !xperms)
>> +       if (!ctab || !key || !avd)
>>                  return;
>>
>>          for (node = avtab_search_node(ctab, key); node;
>> @@ -657,7 +657,7 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
>>                  if ((u16)(AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
>>                      (node->key.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
>>                          avd->auditallow |= node->datum.u.data;
>> -               if ((node->key.specified & AVTAB_ENABLED) &&
>> +               if (xperms && (node->key.specified & AVTAB_ENABLED) &&
>>                                  (node->key.specified & AVTAB_XPERMS))
>>                          services_compute_xperms_drivers(xperms, node);
>>          }
>> --
>> 2.4.3
>>
>
>
>
