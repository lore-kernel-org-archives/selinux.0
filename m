MIME-Version: 1.0
In-Reply-To: <e0625548-0800-06b8-ff81-3530fb754261@tycho.nsa.gov>
References: <1479246156-18730-1-git-send-email-william.c.roberts@intel.com>
 <e44d88e7-3ff2-3684-1e0b-4d06feb5946d@tycho.nsa.gov>
 <CAFftDdro18bA2oApt6eP=qxCeHAZ8VFHcx2Bie909gWY=3XtSQ@mail.gmail.com>
 <CAFftDdpmhROK65HT+PuyuTyjkL7FZqdWKDDnAd+4E8p89ifwaQ@mail.gmail.com>
 <e0625548-0800-06b8-ff81-3530fb754261@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 16 Nov 2016 06:06:38 -0800
Message-ID: <CAFftDdoBpfUkCdvZngjyUuZMz66Nu5XTU-iidizT-_ArNUK2HQ@mail.gmail.com>
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

On Wed, Nov 16, 2016 at 5:59 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/15/2016 06:37 PM, William Roberts wrote:
>> On Tue, Nov 15, 2016 at 3:21 PM, William Roberts
>> <bill.c.roberts@gmail.com> wrote:
>>> On Tue, Nov 15, 2016 at 1:53 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 11/15/2016 04:42 PM, william.c.roberts@intel.com wrote:
>>>>> From: William Roberts <william.c.roberts@intel.com>
>>>>>
>>>>> The combining logic for dontaudit rules was wrong, causing
>>>>> a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
>>>>> rule.
>>>>>
>>>>> This is a reimplementation of:
>>>>>
>>>>> /commit 6201bb5e258e2b5bcc04d502d6fbc05c69d21d71 ("libsepol:
>>>>> fix checkpolicy dontaudit compiler bug")
>>>>
>>>> extraneous / and whitespace
>>>>
>>>>>
>>>>> that avoids the cumbersome pointer assignments on alloced.
>>>>>
>>>>> Reported-by: Nick Kralevich <nnk@google.com>
>>>>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>>>>> ---
>>>>>  libsepol/src/expand.c | 18 +++++++++++-------
>>>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
>>>>> index 004a029..78905d9 100644
>>>>> --- a/libsepol/src/expand.c
>>>>> +++ b/libsepol/src/expand.c
>>>>> @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t * state,
>>>>>  static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
>>>>>                                  avtab_t * avtab, avtab_key_t * key,
>>>>>                                  cond_av_list_t ** cond,
>>>>> -                                av_extended_perms_t *xperms)
>>>>> +                                av_extended_perms_t *xperms,
>>>>> +                                uint32_t spec)
>>>>
>>>> Sorry, it occurred to me belatedly that you already have the spec value
>>>> via key->specified (it is the avtab value, so it is the right one).  No
>>>> need for an additional argument.
>>>
>>> That's ideal, I saw its usage for XPERMS, but it's unclear why spec,
>>> key->specified and
>>> specified all exist within those call paths, seems clunky to me.
>>>
>>> It's likely not normalized so will need to bitwise and out the
>>> DONTAUDIT and AUDITDENY
>>> masks for the initialization value branch.
>>
>> So its assigned to the normalized spec around line 1831:
>> avkey.specified = spec;
>>
>> This means, couldn't the if/else nightmare below go to a switch, so
>> then the |= and &=
>> just share a case?
>
> Probably for |=.  With AUDITDENY vs DONTAUDIT there is the difference in
> whether we use cur->data or ~cur->data.
>
>> Also the spec intermediary could go away with a little massaging. Why
>> does this need
>> to be normalized, is their a case were the passed in specified has
>> more than one bit set?
>
> Well, we do need to convert from AVRULE_* to AVTAB_* regardless, and
> there is no AVTAB_DONTAUDIT, only AVTAB_AUDITDENY.  Doesn't appear that
> there can ever be more than one bit set anymore; originally a single
> avtab entry could store all of the allow/auditallow/auditdeny/transition
> values for a given (source type, target type, target class) triple, but
> I split them out long ago as part of optimizing the avtab memory usage.
>
Sweet. I have a patch coming that trims the fat out of this function.
