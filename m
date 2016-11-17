Subject: Re: [PATCH v2 2/2] expand_avrule_helper: cleanup
To: William Roberts <bill.c.roberts@gmail.com>
References: <1479332858-12948-1-git-send-email-william.c.roberts@intel.com>
 <1479332858-12948-2-git-send-email-william.c.roberts@intel.com>
 <4ed70a5b-a081-0fa2-0b73-d0daf1dad6e0@tycho.nsa.gov>
 <CAFftDdpLJBynXLJ==-eb6RQq6ZHLM-7b=XsDbqtvRm98+_0-sw@mail.gmail.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <229fc9cd-6b77-db53-52db-591d5c8a8a36@tycho.nsa.gov>
Date: Thu, 17 Nov 2016 10:50:44 -0500
MIME-Version: 1.0
In-Reply-To: <CAFftDdpLJBynXLJ==-eb6RQq6ZHLM-7b=XsDbqtvRm98+_0-sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/17/2016 10:34 AM, William Roberts wrote:
> On Thu, Nov 17, 2016 at 5:36 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 11/16/2016 04:47 PM, william.c.roberts@intel.com wrote:
>>> From: William Roberts <william.c.roberts@intel.com>
>>>
>>> General clean up for expand_avrule_helper:
>>> 1. Minimize the conversions of AVRULE specification to AVTAB specification,
>>>    they are almost the same, the one exception is AVRULE_DONTAUDIT.
>>> 2. Clean up the if/else logic, collapse with a switch.
>>> 3. Move xperms allocation and manipulation to its own helper.
>>> 4. Only write avkey for values that change.
>>>
>>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>>> ---
>>>  libsepol/src/expand.c | 131 +++++++++++++++++++++++++-------------------------
>>>  1 file changed, 66 insertions(+), 65 deletions(-)
>>>
>>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
>>> index 3e16f58..fe8a99f 100644
>>> --- a/libsepol/src/expand.c
>>> +++ b/libsepol/src/expand.c
>>> @@ -1781,6 +1781,47 @@ static int expand_terule_helper(sepol_handle_t * handle,
>>>       return EXPAND_RULE_SUCCESS;
>>>  }
>>>
>>> +/* 0 for success -1 indicates failure */
>>> +static int allocate_xperms(sepol_handle_t * handle, avtab_datum_t * avdatump,
>>> +                        av_extended_perms_t * extended_perms)
>>> +{
>>> +     unsigned int i;
>>> +
>>> +     avtab_extended_perms_t *xperms = avdatump->xperms;
>>> +     if (!xperms) {
>>> +             xperms = (avtab_extended_perms_t *)
>>> +                     calloc(1, sizeof(avtab_extended_perms_t));
>>> +             if (!xperms) {
>>> +                     ERR(handle, "Out of memory!");
>>> +                     return -1;
>>> +             }
>>> +             avdatump->xperms = xperms;
>>> +     }
>>> +
>>> +     switch (extended_perms->specified) {
>>> +     case AVRULE_XPERMS_IOCTLFUNCTION:
>>> +             xperms->specified = AVTAB_XPERMS_IOCTLFUNCTION;
>>> +             break;
>>> +     case AVRULE_XPERMS_IOCTLDRIVER:
>>> +             xperms->specified = AVTAB_XPERMS_IOCTLDRIVER;
>>> +             break;
>>> +     default:
>>> +             return -1;
>>> +     }
>>> +
>>> +     xperms->driver = extended_perms->driver;
>>> +     for (i = 0; i < ARRAY_SIZE(xperms->perms); i++)
>>> +             xperms->perms[i] |= extended_perms->perms[i];
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static uint32_t avrule_to_avtab_spec(uint32_t specification)
>>> +{
>>> +     return (specification == AVRULE_DONTAUDIT) ?
>>> +             AVTAB_AUDITDENY : specification;
>>> +}
>>
>> Doesn't seem to merit its own helper function since it is only ever used
>> once and is a one-liner.
> 
> It should be usable in: expand_terule_helper()

No mapping required there.
