Subject: Re: [PATCH v2 2/2] expand_avrule_helper: cleanup
To: William Roberts <bill.c.roberts@gmail.com>
References: <1479332858-12948-1-git-send-email-william.c.roberts@intel.com>
 <1479332858-12948-2-git-send-email-william.c.roberts@intel.com>
 <4ed70a5b-a081-0fa2-0b73-d0daf1dad6e0@tycho.nsa.gov>
 <CAFftDdpLJBynXLJ==-eb6RQq6ZHLM-7b=XsDbqtvRm98+_0-sw@mail.gmail.com>
 <CAFftDdqNKA4a=EX9ujP0N8HnO8vOeJDSyRpzYakee5kFMRiTdQ@mail.gmail.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3348a2b9-69c2-4c5d-3844-a3cb49f7f2eb@tycho.nsa.gov>
Date: Thu, 17 Nov 2016 10:52:25 -0500
MIME-Version: 1.0
In-Reply-To: <CAFftDdqNKA4a=EX9ujP0N8HnO8vOeJDSyRpzYakee5kFMRiTdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/17/2016 10:46 AM, William Roberts wrote:
> Ill submit a patch for expand_terule_helper() as well, do we want to
> retain the assert(0); property on the 2 if/else if/else calsues? Do we
> just want to assume that specified is OK since it has never hit the
> assert? Do we want to just check specified up front and return an
> error:
> 
> if (!(specified & AVRULE_TRANSITION|AVRULE_MEMBER|AVRULE_CHANGE)) {
>     ERR(handle, "Invalid specification: %zu\n", specified);
>     return EXPAND_RULE_ERROR;
> }

Doing a runtime check as you suggest above is fine (except you need
different parenthesization).

> 
> On Thu, Nov 17, 2016 at 7:34 AM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
>> On Thu, Nov 17, 2016 at 5:36 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 11/16/2016 04:47 PM, william.c.roberts@intel.com wrote:
>>>> From: William Roberts <william.c.roberts@intel.com>
>>>>
>>>> General clean up for expand_avrule_helper:
>>>> 1. Minimize the conversions of AVRULE specification to AVTAB specification,
>>>>    they are almost the same, the one exception is AVRULE_DONTAUDIT.
>>>> 2. Clean up the if/else logic, collapse with a switch.
>>>> 3. Move xperms allocation and manipulation to its own helper.
>>>> 4. Only write avkey for values that change.
>>>>
>>>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>>>> ---
>>>>  libsepol/src/expand.c | 131 +++++++++++++++++++++++++-------------------------
>>>>  1 file changed, 66 insertions(+), 65 deletions(-)
>>>>
>>>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
>>>> index 3e16f58..fe8a99f 100644
>>>> --- a/libsepol/src/expand.c
>>>> +++ b/libsepol/src/expand.c
>>>> @@ -1781,6 +1781,47 @@ static int expand_terule_helper(sepol_handle_t * handle,
>>>>       return EXPAND_RULE_SUCCESS;
>>>>  }
>>>>
>>>> +/* 0 for success -1 indicates failure */
>>>> +static int allocate_xperms(sepol_handle_t * handle, avtab_datum_t * avdatump,
>>>> +                        av_extended_perms_t * extended_perms)
>>>> +{
>>>> +     unsigned int i;
>>>> +
>>>> +     avtab_extended_perms_t *xperms = avdatump->xperms;
>>>> +     if (!xperms) {
>>>> +             xperms = (avtab_extended_perms_t *)
>>>> +                     calloc(1, sizeof(avtab_extended_perms_t));
>>>> +             if (!xperms) {
>>>> +                     ERR(handle, "Out of memory!");
>>>> +                     return -1;
>>>> +             }
>>>> +             avdatump->xperms = xperms;
>>>> +     }
>>>> +
>>>> +     switch (extended_perms->specified) {
>>>> +     case AVRULE_XPERMS_IOCTLFUNCTION:
>>>> +             xperms->specified = AVTAB_XPERMS_IOCTLFUNCTION;
>>>> +             break;
>>>> +     case AVRULE_XPERMS_IOCTLDRIVER:
>>>> +             xperms->specified = AVTAB_XPERMS_IOCTLDRIVER;
>>>> +             break;
>>>> +     default:
>>>> +             return -1;
>>>> +     }
>>>> +
>>>> +     xperms->driver = extended_perms->driver;
>>>> +     for (i = 0; i < ARRAY_SIZE(xperms->perms); i++)
>>>> +             xperms->perms[i] |= extended_perms->perms[i];
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static uint32_t avrule_to_avtab_spec(uint32_t specification)
>>>> +{
>>>> +     return (specification == AVRULE_DONTAUDIT) ?
>>>> +             AVTAB_AUDITDENY : specification;
>>>> +}
>>>
>>> Doesn't seem to merit its own helper function since it is only ever used
>>> once and is a one-liner.
>>
>> It should be usable in: expand_terule_helper()
>>
>>>
>>>> +
>>>>  static int expand_avrule_helper(sepol_handle_t * handle,
>>>>                               uint32_t specified,
>>>>                               cond_av_list_t ** cond,
>>>> @@ -1790,44 +1831,21 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>>>>  {
>>>>       avtab_key_t avkey;
>>>>       avtab_datum_t *avdatump;
>>>> -     avtab_extended_perms_t *xperms;
>>>>       avtab_ptr_t node;
>>>>       class_perm_node_t *cur;
>>>> -     uint32_t spec = 0;
>>>> -     unsigned int i;
>>>>
>>>> -     if (specified & AVRULE_ALLOWED) {
>>>> -             spec = AVTAB_ALLOWED;
>>>> -     } else if (specified & AVRULE_AUDITALLOW) {
>>>> -             spec = AVTAB_AUDITALLOW;
>>>> -     } else if (specified & AVRULE_AUDITDENY) {
>>>> -             spec = AVTAB_AUDITDENY;
>>>> -     } else if (specified & AVRULE_DONTAUDIT) {
>>>> -             if (handle && handle->disable_dontaudit)
>>>> -                     return EXPAND_RULE_SUCCESS;
>>>> -             spec = AVTAB_AUDITDENY;
>>>> -     } else if (specified & AVRULE_NEVERALLOW) {
>>>> -             spec = AVTAB_NEVERALLOW;
>>>> -     } else if (specified & AVRULE_XPERMS_ALLOWED) {
>>>> -             spec = AVTAB_XPERMS_ALLOWED;
>>>> -     } else if (specified & AVRULE_XPERMS_AUDITALLOW) {
>>>> -             spec = AVTAB_XPERMS_AUDITALLOW;
>>>> -     } else if (specified & AVRULE_XPERMS_DONTAUDIT) {
>>>> -             if (handle && handle->disable_dontaudit)
>>>> +     /* bail early if dontaudit's are disabled and it's a dontaudit rule */
>>>> +     if ((specified & (AVRULE_DONTAUDIT|AVRULE_XPERMS_DONTAUDIT))
>>>> +          && handle && handle->disable_dontaudit)
>>>>                       return EXPAND_RULE_SUCCESS;
>>>> -             spec = AVTAB_XPERMS_DONTAUDIT;
>>>> -     } else if (specified & AVRULE_XPERMS_NEVERALLOW) {
>>>> -             spec = AVTAB_XPERMS_NEVERALLOW;
>>>> -     } else {
>>>> -             assert(0);      /* unreachable */
>>>> -     }
>>>> +
>>>> +     avkey.source_type = stype + 1;
>>>> +     avkey.target_type = ttype + 1;
>>>> +     avkey.specified = avrule_to_avtab_spec(specified);
>>>>
>>>>       cur = perms;
>>>>       while (cur) {
>>>> -             avkey.source_type = stype + 1;
>>>> -             avkey.target_type = ttype + 1;
>>>>               avkey.target_class = cur->tclass;
>>>> -             avkey.specified = spec;
>>>>
>>>>               node = find_avtab_node(handle, avtab, &avkey, cond, extended_perms);
>>>>               if (!node)
>>>> @@ -1839,13 +1857,15 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>>>>               }
>>>>
>>>>               avdatump = &node->datum;
>>>> -             if (specified & AVRULE_ALLOWED) {
>>>> -                     avdatump->data |= cur->data;
>>>> -             } else if (specified & AVRULE_AUDITALLOW) {
>>>> -                     avdatump->data |= cur->data;
>>>> -             } else if (specified & AVRULE_NEVERALLOW) {
>>>> +             switch (specified) {
>>>> +             case AVRULE_ALLOWED:
>>>> +             case AVRULE_AUDITALLOW:
>>>> +             case AVRULE_NEVERALLOW:
>>>>                       avdatump->data |= cur->data;
>>>> -             } else if (specified & AVRULE_AUDITDENY) {
>>>> +                     break;
>>>> +             case AVRULE_DONTAUDIT:
>>>> +                     cur->data = ~cur->data;
>>>
>>> Would prefer to keep them separate, and to not mutate cur at all, i.e.
>>>                         avdatump->data &= ~cur->data;
>>>                         break;
>>
>> Fine.
>>
>>>
>>>> +             case AVRULE_AUDITDENY:
>>>>                       /* Since a '0' in an auditdeny mask represents
>>>>                        * a permission we do NOT want to audit
>>>>                        * (dontaudit), we use the '&' operand to
>>>> @@ -1854,35 +1874,16 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>>>>                        * auditallow cases).
>>>>                        */
>>>>                       avdatump->data &= cur->data;
>>>> -             } else if (specified & AVRULE_DONTAUDIT) {
>>>> -                     avdatump->data &= ~cur->data;
>>>> -             } else if (specified & AVRULE_XPERMS) {
>>>> -                     xperms = avdatump->xperms;
>>>> -                     if (!xperms) {
>>>> -                             xperms = (avtab_extended_perms_t *)
>>>> -                                     calloc(1, sizeof(avtab_extended_perms_t));
>>>> -                             if (!xperms) {
>>>> -                                     ERR(handle, "Out of memory!");
>>>> -                                     return -1;
>>>> -                             }
>>>> -                             avdatump->xperms = xperms;
>>>> -                     }
>>>> -
>>>> -                     switch (extended_perms->specified) {
>>>> -                     case AVRULE_XPERMS_IOCTLFUNCTION:
>>>> -                             xperms->specified = AVTAB_XPERMS_IOCTLFUNCTION;
>>>> -                             break;
>>>> -                     case AVRULE_XPERMS_IOCTLDRIVER:
>>>> -                             xperms->specified = AVTAB_XPERMS_IOCTLDRIVER;
>>>> -                             break;
>>>> -                     default:
>>>> -                             return -1;
>>>> -                     }
>>>> -
>>>> -                     xperms->driver = extended_perms->driver;
>>>> -                     for (i = 0; i < ARRAY_SIZE(xperms->perms); i++)
>>>> -                             xperms->perms[i] |= extended_perms->perms[i];
>>>> -             } else {
>>>> +                     break;
>>>> +             case AVRULE_XPERMS_ALLOWED:
>>>> +             case AVRULE_XPERMS_AUDITALLOW:
>>>> +             case AVRULE_XPERMS_DONTAUDIT:
>>>> +             case AVRULE_XPERMS_NEVERALLOW:
>>>> +                     if (allocate_xperms(handle, avdatump, extended_perms))
>>>> +                             return EXPAND_RULE_ERROR;
>>>> +                     break;
>>>> +             default:
>>>> +                     ERR(handle, "Unknown specification: %x\n", specified);
>>>>                       assert(0);      /* should never occur */
>>>>               }
>>>>
>>>>
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>>
>>
>> --
>> Respectfully,
>>
>> William C Roberts
> 
> 
> 
