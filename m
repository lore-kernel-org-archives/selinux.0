Subject: Re: User range vs. context's range
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "Christopher J. PeBenito" <cpebenito@tresys.com>,
 SELinux List <selinux@tycho.nsa.gov>
References: <569FF52A.6040207@tresys.com> <569FFA78.2010302@tycho.nsa.gov>
 <56A0D998.7050409@tresys.com> <56A15253.6080505@tycho.nsa.gov>
 <56A23610.2020508@tresys.com> <56A237BF.8080702@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <56A24F5C.8090904@tycho.nsa.gov>
Date: Fri, 22 Jan 2016 10:48:44 -0500
MIME-Version: 1.0
In-Reply-To: <56A237BF.8080702@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/22/2016 09:07 AM, Stephen Smalley wrote:
> On 01/22/2016 09:00 AM, Christopher J. PeBenito wrote:
>> On 1/21/2016 4:49 PM, Stephen Smalley wrote:
>>> On 01/21/2016 08:14 AM, Christopher J. PeBenito wrote:
>>>> On 1/20/2016 4:22 PM, Stephen Smalley wrote:
>>>>> On 01/20/2016 03:59 PM, Christopher J. PeBenito wrote:
>>>>>> What is the intended behavior for a user's allowed range in the policy
>>>>>> vs. any labels in the policy (e.g. netifcon)?  My expectation is that
>>>>>> the allowed range should still apply, but it doesn't seem that
>>>>>> checkpolicy checks that, based on what I've seen.  For example, the new
>>>>>> sediff test policies have this user[1]:
>>>>>>
>>>>>> user added_user roles system level s1 range s1;
>>>>>>
>>>>>> and checkpolicy doesn't error on this[2] later in the policy:
>>>>>>
>>>>>> genfscon added_genfs / added_user:object_r:system:s0
>>>>>>
>>>>>> I think this should fail compilation since s0 is not in added_user's
>>>>>> allowed range.
>>>>>
>>>>> Not for objects (object_r), same as with role-type relation.
>>>>
>>>> I don't understand the logic for that.  For the role-type relation, all
>>>> types are implicitly added to object_r, which makes that behavior make
>>>> sense, but the user has an explicitly-stated allowed range.
>>>
>>> If that's true, it is only true of setools, not of libsepol or the
>>> kernel binary policy.  policydb_context_isvalid() omits the role-type
>>> and user-role relation checks if the role is object_r, and
>>> mls_context_isvalid() does likewise for the user-range relation check.
>>
>> Apologies for being misled by the long-time setools object_r behavior
>> (I'll undo that).  However, I still disagree with ignoring the
>> user-range check in the object_r case, because there is an explicit
>> user-range relationship written in the policy.
>
> It was only intended for subjects, not for objects.
> Whether or not a subject can create an object at a level outside its own range
> depends on the mls constraints.
>
>

So CIL does not treat object_r as special (except when creating the binary 
policy), so that genfscon statement would cause an error in CIL. Subject and 
object contexts are not treated differently by CIL, but that can be changed if 
needed. I hadn't known that there was a difference.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
