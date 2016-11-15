MIME-Version: 1.0
In-Reply-To: <e44d88e7-3ff2-3684-1e0b-4d06feb5946d@tycho.nsa.gov>
References: <1479246156-18730-1-git-send-email-william.c.roberts@intel.com>
 <e44d88e7-3ff2-3684-1e0b-4d06feb5946d@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 15 Nov 2016 15:21:58 -0800
Message-ID: <CAFftDdro18bA2oApt6eP=qxCeHAZ8VFHcx2Bie909gWY=3XtSQ@mail.gmail.com>
Subject: Re: [PATCH take2 v4] libsepol: fix checkpolicy dontaudit compiler bug
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 Nick Kralevich <nnk@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 15, 2016 at 1:53 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/15/2016 04:42 PM, william.c.roberts@intel.com wrote:
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> The combining logic for dontaudit rules was wrong, causing
>> a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
>> rule.
>>
>> This is a reimplementation of:
>>
>> /commit 6201bb5e258e2b5bcc04d502d6fbc05c69d21d71 ("libsepol:
>> fix checkpolicy dontaudit compiler bug")
>
> extraneous / and whitespace
>
>>
>> that avoids the cumbersome pointer assignments on alloced.
>>
>> Reported-by: Nick Kralevich <nnk@google.com>
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> ---
>>  libsepol/src/expand.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
>> index 004a029..78905d9 100644
>> --- a/libsepol/src/expand.c
>> +++ b/libsepol/src/expand.c
>> @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t * state,
>>  static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
>>                                  avtab_t * avtab, avtab_key_t * key,
>>                                  cond_av_list_t ** cond,
>> -                                av_extended_perms_t *xperms)
>> +                                av_extended_perms_t *xperms,
>> +                                uint32_t spec)
>
> Sorry, it occurred to me belatedly that you already have the spec value
> via key->specified (it is the avtab value, so it is the right one).  No
> need for an additional argument.

That's ideal, I saw its usage for XPERMS, but it's unclear why spec,
key->specified and
specified all exist within those call paths, seems clunky to me.

It's likely not normalized so will need to bitwise and out the
DONTAUDIT and AUDITDENY
masks for the initialization value branch.

>
>>  {
>>       avtab_ptr_t node;
>>       avtab_datum_t avdatum;
>> @@ -1640,6 +1641,11 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
>>
>>       if (!node) {
>>               memset(&avdatum, 0, sizeof avdatum);
>> +             /*
>> +              * AUDITDENY, aka DONTAUDIT, is &= assigned, versus != for others.
>> +              * Initialize data accordingly.
>> +              */
>> +             avdatum.data = (spec == AVRULE_AUDITDENY) ? ~0 : 0;
>>               /* this is used to get the node - insertion is actually unique */
>>               node = avtab_insert_nonunique(avtab, key, &avdatum);
>>               if (!node) {
>> @@ -1750,7 +1756,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
>>                       return EXPAND_RULE_CONFLICT;
>>               }
>>
>> -             node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
>> +             node = find_avtab_node(handle, avtab, &avkey, cond, NULL, 0);
>>               if (!node)
>>                       return -1;
>>               if (enabled) {
>> @@ -1824,7 +1830,8 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>>               avkey.target_class = cur->tclass;
>>               avkey.specified = spec;
>>
>> -             node = find_avtab_node(handle, avtab, &avkey, cond, extended_perms);
>> +             node = find_avtab_node(handle, avtab, &avkey, cond,
>> +                                    extended_perms, spec);
>>               if (!node)
>>                       return EXPAND_RULE_ERROR;
>>               if (enabled) {
>> @@ -1850,10 +1857,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>>                        */
>>                       avdatump->data &= cur->data;
>>               } else if (specified & AVRULE_DONTAUDIT) {
>> -                     if (avdatump->data)
>> -                             avdatump->data &= ~cur->data;
>> -                     else
>> -                             avdatump->data = ~cur->data;
>> +                     avdatump->data &= ~cur->data;
>>               } else if (specified & AVRULE_XPERMS) {
>>                       xperms = avdatump->xperms;
>>                       if (!xperms) {
>>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
