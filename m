Message-ID: <55832B99.7060907@tycho.nsa.gov>
Date: Thu, 18 Jun 2015 16:35:37 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 04/10 v2] libsepol: Refactored bounds (hierarchy) checking
 code
References: <1434571134-31452-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1434571134-31452-5-git-send-email-jwcart2@tycho.nsa.gov>
 <5582CE01.50800@tycho.nsa.gov> <55832977.9010804@tycho.nsa.gov>
 <55832A22.1040103@tycho.nsa.gov>
In-Reply-To: <55832A22.1040103@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/18/2015 04:29 PM, Stephen Smalley wrote:
> On 06/18/2015 04:26 PM, James Carter wrote:
>> On 06/18/2015 09:56 AM, Stephen Smalley wrote:
>>> On 06/17/2015 03:58 PM, James Carter wrote:
>>>> The largest change to the user and role bounds checking was to put
>>>> them in their own functions, so they could be called independently.
>>>>
>>>> The type bounds checking was changed to check one type bounds at
>>>> a time. An expanded avtab is still created, but now only the rules
>>>> of the parent type are expanded. If violations are discovered,
>>>> a list of avtab_ptr_t's provides details. This list is used to
>>>> display error messages for backwards compatibility and will be
>>>> used by CIL to provide a more detailed error message.
>>>>
>>>> Memory usage is reduced from 9,355M to 126M and time is reduced
>>>> from 9 sec to 2 sec.
>>>>
>>>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>>>
>>> Can we optimize the case where there are no bounded users/roles/types at
>>> all in the policy, and quickly return in that situation?  Seems like we
>>> could just quickly walk them and check to see if any are bounded before
>>> we start doing anything else.  Surprised we don't already do that.
>>>
>>
>> I am not sure how to do it faster.
>>
>> I am walking the types table [The statement:
>> hashtab_map(p->p_types.table, bounds_check_type_callback, &args);] and
>> only calling bounds_check_type() if the type has a bounds.
>>
>> Is there a faster way?
>
> So is there any avtab allocation if there are no bounded types?
> That's what I wanted to ensure we avoid or at least minimize.
>

There is no avtab allocation unless there is a bounded type. And when there are, 
it is only rules that involve the parent that are expanded.

> I was surprised that you indicated that we have significant memory and
> time usage from the old hierarchy checker since there are no bounded
> types in the default policy; I had assumed that it would optimize for
> that case, just as we quickly bail out of the assertion checker if there
> are no neverallows before even doing an avtab_init.
>

I was surprised as well, but that is the case.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
