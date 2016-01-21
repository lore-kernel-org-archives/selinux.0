Subject: Re: User range vs. context's range
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
 SELinux List <selinux@tycho.nsa.gov>
References: <569FF52A.6040207@tresys.com> <569FFA78.2010302@tycho.nsa.gov>
 <56A0D998.7050409@tresys.com> <56A15253.6080505@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56A1562F.7070702@tycho.nsa.gov>
Date: Thu, 21 Jan 2016 17:05:35 -0500
MIME-Version: 1.0
In-Reply-To: <56A15253.6080505@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/21/2016 04:49 PM, Stephen Smalley wrote:
> On 01/21/2016 08:14 AM, Christopher J. PeBenito wrote:
>> On 1/20/2016 4:22 PM, Stephen Smalley wrote:
>>> On 01/20/2016 03:59 PM, Christopher J. PeBenito wrote:
>>>> What is the intended behavior for a user's allowed range in the policy
>>>> vs. any labels in the policy (e.g. netifcon)?  My expectation is that
>>>> the allowed range should still apply, but it doesn't seem that
>>>> checkpolicy checks that, based on what I've seen.  For example, the new
>>>> sediff test policies have this user[1]:
>>>>
>>>> user added_user roles system level s1 range s1;
>>>>
>>>> and checkpolicy doesn't error on this[2] later in the policy:
>>>>
>>>> genfscon added_genfs / added_user:object_r:system:s0
>>>>
>>>> I think this should fail compilation since s0 is not in added_user's
>>>> allowed range.
>>>
>>> Not for objects (object_r), same as with role-type relation.
>>
>> I don't understand the logic for that.  For the role-type relation, all
>> types are implicitly added to object_r, which makes that behavior make
>> sense, but the user has an explicitly-stated allowed range.
>
> If that's true, it is only true of setools, not of libsepol or the

By "that", I mean "all types are implicitly added to object_r".  I don't 
see that anywhere in libsepol or the kernel. I do see it in libqpol. 
But if you dump a kernel policy and look at object_r's role->types, they 
are empty.

> kernel binary policy.  policydb_context_isvalid() omits the role-type
> and user-role relation checks if the role is object_r, and
> mls_context_isvalid() does likewise for the user-range relation check.
