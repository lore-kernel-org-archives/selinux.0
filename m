Subject: Re: [PATCH 2/2] expand_avrule_helper: cleanup
To: William Roberts <bill.c.roberts@gmail.com>,
 William Roberts <william.c.roberts@intel.com>
References: <1479323571-8501-1-git-send-email-william.c.roberts@intel.com>
 <1479323571-8501-2-git-send-email-william.c.roberts@intel.com>
 <CAFftDdrMH63b2Y37HToZVmoWgqm0_fdD9w8LNZJjXeypC44vng@mail.gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <24ae9eb5-3f0b-d7cf-500e-c00b6f99a092@tycho.nsa.gov>
Date: Wed, 16 Nov 2016 14:50:06 -0500
MIME-Version: 1.0
In-Reply-To: <CAFftDdrMH63b2Y37HToZVmoWgqm0_fdD9w8LNZJjXeypC44vng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/16/2016 02:32 PM, William Roberts wrote:
> sediff reports no delta between policies built on master and these 2 patches.

Not possible.  checkpolicy segfaults with these patches.
Probably didn't rebuild it after rebuilding libsepol.
Anyway, you can just use cmp to compare the policies here; they should
be byte-for-byte identical.

> 
> On Wed, Nov 16, 2016 at 11:12 AM,  <william.c.roberts@intel.com> wrote:
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> General clean up for expand_avrule_helper:
>> 1. Stop converting AVRULE specification to AVTAB specification, they are the
>>    same.
>> 2. Clean up if/else logic, collapse with a switch.
>> 3. Move xperms allocation and manipulation to its own helper.
>> 4. Stop checking handle for NULL, handle must never be NULL. Previous code and
>>    current code use ERR(), which depends on handle.
>> 5. Only write avkey for values that change.
>>
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> ---
>>  libsepol/src/expand.c | 124 ++++++++++++++++++++++++--------------------------
>>  1 file changed, 59 insertions(+), 65 deletions(-)
>>
>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
>> index 3e16f58..81a827e 100644
>> --- a/libsepol/src/expand.c
>> +++ b/libsepol/src/expand.c
>> @@ -1781,6 +1781,41 @@ static int expand_terule_helper(sepol_handle_t * handle,
>>         return EXPAND_RULE_SUCCESS;
>>  }
>>
>> +/* 0 for success -1 indicates failure */
>> +static int allocate_xperms(sepol_handle_t * handle, avtab_datum_t * avdatump,
>> +                          av_extended_perms_t * extended_perms)
>> +{
>> +       unsigned int i;
>> +
>> +       avtab_extended_perms_t *xperms = avdatump->xperms;
>> +       if (!xperms) {
>> +               xperms = (avtab_extended_perms_t *)
>> +                       calloc(1, sizeof(avtab_extended_perms_t));
>> +               if (!xperms) {
>> +                       ERR(handle, "Out of memory!");
>> +                       return -1;
>> +               }
>> +               avdatump->xperms = xperms;
>> +       }
>> +
>> +       switch (extended_perms->specified) {
>> +       case AVRULE_XPERMS_IOCTLFUNCTION:
>> +               xperms->specified = AVTAB_XPERMS_IOCTLFUNCTION;
>> +               break;
>> +       case AVRULE_XPERMS_IOCTLDRIVER:
>> +               xperms->specified = AVTAB_XPERMS_IOCTLDRIVER;
>> +               break;
>> +       default:
>> +               return -1;
>> +       }
>> +
>> +       xperms->driver = extended_perms->driver;
>> +       for (i = 0; i < ARRAY_SIZE(xperms->perms); i++)
>> +               xperms->perms[i] |= extended_perms->perms[i];
>> +
>> +       return 0;
>> +}
>> +
>>  static int expand_avrule_helper(sepol_handle_t * handle,
>>                                 uint32_t specified,
>>                                 cond_av_list_t ** cond,
>> @@ -1790,44 +1825,20 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>>  {
>>         avtab_key_t avkey;
>>         avtab_datum_t *avdatump;
>> -       avtab_extended_perms_t *xperms;
>>         avtab_ptr_t node;
>>         class_perm_node_t *cur;
>> -       uint32_t spec = 0;
>> -       unsigned int i;
>>
>> -       if (specified & AVRULE_ALLOWED) {
>> -               spec = AVTAB_ALLOWED;
>> -       } else if (specified & AVRULE_AUDITALLOW) {
>> -               spec = AVTAB_AUDITALLOW;
>> -       } else if (specified & AVRULE_AUDITDENY) {
>> -               spec = AVTAB_AUDITDENY;
>> -       } else if (specified & AVRULE_DONTAUDIT) {
>> -               if (handle && handle->disable_dontaudit)
>> -                       return EXPAND_RULE_SUCCESS;
>> -               spec = AVTAB_AUDITDENY;
>> -       } else if (specified & AVRULE_NEVERALLOW) {
>> -               spec = AVTAB_NEVERALLOW;
>> -       } else if (specified & AVRULE_XPERMS_ALLOWED) {
>> -               spec = AVTAB_XPERMS_ALLOWED;
>> -       } else if (specified & AVRULE_XPERMS_AUDITALLOW) {
>> -               spec = AVTAB_XPERMS_AUDITALLOW;
>> -       } else if (specified & AVRULE_XPERMS_DONTAUDIT) {
>> -               if (handle && handle->disable_dontaudit)
>> +       /* bail early if dontaudit's are disabled and it's a dontaudit rule */
>> +       if ((specified & (AVRULE_DONTAUDIT|AVRULE_XPERMS_DONTAUDIT)) && handle->disable_dontaudit)
>>                         return EXPAND_RULE_SUCCESS;
>> -               spec = AVTAB_XPERMS_DONTAUDIT;
>> -       } else if (specified & AVRULE_XPERMS_NEVERALLOW) {
>> -               spec = AVTAB_XPERMS_NEVERALLOW;
>> -       } else {
>> -               assert(0);      /* unreachable */
>> -       }
>> +
>> +       avkey.source_type = stype + 1;
>> +       avkey.target_type = ttype + 1;
>> +       avkey.specified = specified;
>>
>>         cur = perms;
>>         while (cur) {
>> -               avkey.source_type = stype + 1;
>> -               avkey.target_type = ttype + 1;
>>                 avkey.target_class = cur->tclass;
>> -               avkey.specified = spec;
>>
>>                 node = find_avtab_node(handle, avtab, &avkey, cond, extended_perms);
>>                 if (!node)
>> @@ -1839,13 +1850,15 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>>                 }
>>
>>                 avdatump = &node->datum;
>> -               if (specified & AVRULE_ALLOWED) {
>> -                       avdatump->data |= cur->data;
>> -               } else if (specified & AVRULE_AUDITALLOW) {
>> +               switch (specified) {
>> +               case AVRULE_ALLOWED:
>> +               case AVRULE_AUDITALLOW:
>> +               case AVRULE_NEVERALLOW:
>>                         avdatump->data |= cur->data;
>> -               } else if (specified & AVRULE_NEVERALLOW) {
>> -                       avdatump->data |= cur->data;
>> -               } else if (specified & AVRULE_AUDITDENY) {
>> +                       break;
>> +               case AVRULE_DONTAUDIT:
>> +                       cur->data = ~cur->data;
>> +               case AVRULE_AUDITDENY:
>>                         /* Since a '0' in an auditdeny mask represents
>>                          * a permission we do NOT want to audit
>>                          * (dontaudit), we use the '&' operand to
>> @@ -1854,35 +1867,16 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>>                          * auditallow cases).
>>                          */
>>                         avdatump->data &= cur->data;
>> -               } else if (specified & AVRULE_DONTAUDIT) {
>> -                       avdatump->data &= ~cur->data;
>> -               } else if (specified & AVRULE_XPERMS) {
>> -                       xperms = avdatump->xperms;
>> -                       if (!xperms) {
>> -                               xperms = (avtab_extended_perms_t *)
>> -                                       calloc(1, sizeof(avtab_extended_perms_t));
>> -                               if (!xperms) {
>> -                                       ERR(handle, "Out of memory!");
>> -                                       return -1;
>> -                               }
>> -                               avdatump->xperms = xperms;
>> -                       }
>> -
>> -                       switch (extended_perms->specified) {
>> -                       case AVRULE_XPERMS_IOCTLFUNCTION:
>> -                               xperms->specified = AVTAB_XPERMS_IOCTLFUNCTION;
>> -                               break;
>> -                       case AVRULE_XPERMS_IOCTLDRIVER:
>> -                               xperms->specified = AVTAB_XPERMS_IOCTLDRIVER;
>> -                               break;
>> -                       default:
>> -                               return -1;
>> -                       }
>> -
>> -                       xperms->driver = extended_perms->driver;
>> -                       for (i = 0; i < ARRAY_SIZE(xperms->perms); i++)
>> -                               xperms->perms[i] |= extended_perms->perms[i];
>> -               } else {
>> +                       break;
>> +               case AVRULE_XPERMS_ALLOWED:
>> +               case AVRULE_XPERMS_AUDITALLOW:
>> +               case AVRULE_XPERMS_DONTAUDIT:
>> +               case AVRULE_XPERMS_NEVERALLOW:
>> +                       if (allocate_xperms(handle, avdatump, extended_perms))
>> +                               return EXPAND_RULE_ERROR;
>> +                       break;
>> +               default:
>> +                       ERR(handle, "Unkown specification: %x\n", specified);
>>                         assert(0);      /* should never occur */
>>                 }
>>
>> --
>> 2.7.4
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
> 
