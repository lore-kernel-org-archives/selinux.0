Subject: Re: Support for multiple types in typeattribute
To: selinux@tycho.nsa.gov, Alex Klyubin <klyubin@google.com>
References: <CALCgPKuwzCk5gfxxYsACyYZs_8X1rELNfXkaY5KfsFJ4VtO9oQ@mail.gmail.com>
 <334f2cb3-cbb4-4f9f-bbc6-63aa5828ed36@gmail.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <caa65034-eacd-9230-8352-88ac01b4d036@tycho.nsa.gov>
Date: Fri, 24 Feb 2017 14:06:25 -0500
MIME-Version: 1.0
In-Reply-To: <334f2cb3-cbb4-4f9f-bbc6-63aa5828ed36@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/24/2017 01:00 PM, Dominick Grift wrote:
> On 02/24/2017 06:39 PM, Alex Klyubin wrote:
>> Hi,
>>
>> typeattribute currently accepts only a single type as its first argument.
>> It associates the provided type with the attribute provided as the second
>> argument. Is there a reason why typeattribute doesn't support multiple
>> types specified as the first argument? The idea being that it would
>> associate each of those types with the attribute.
>>
>> For example, the first argument to typeattribute could use the same syntax
>> as used for the first argument of allow and neverallow. typeattribute could
>> then expand this set of types, attributes, and exclusions into the set of
>> matching types and then associate each of the types with the provided
>> attribute.
>>

There is no reason (that I know of) why it couldn't be changed to work the way 
you suggest other than someone having the time and desire to make the change. I 
honestly don't know if it would be difficult to make the change or not. It 
doesn't seem like it would, but ...

>> The reason I'm asking is because in Android SELinux policy we're bumping
>> against the need to associate attribute A with the set of types which are
>> grouped using attribute G. We could add a typeattribute for each type
>> associated with G, but that (1) duplicates the grouping which is already
>> expressed via G, and (2) makes it very cumbersome/brittle to keep both A
>> and G associated with exactly the same set of types. In particular, because
>> Android SELinux policy source tree is distributed between a large number of
>> Android devices and organizations, requiring that any time you associate a
>> type with G you must also associate it with A is suboptimal, not to mention
>> that making such a change in the existing policies requires to change each
>> policy.
>>

This is why, as Dominck mentions below, that CIL allows you to use an expression 
that can include types and attributes to associate types to an attribute.

In November I added the ability to create a policy.conf from the CIL AST with 
the libsepol function cil_write_policy_conf() or from CIL policy using the 
program secil2conf. Those might be useful to you.

Jim

>> To make life more interesting, there's also a need to associate A with a
>> subset of G, for example, G minus some type or two.
>>
>
> CIL is a bit more flexible. You can associate type attributes with type
> attributes and do things like:
>
>     (typeattributeset
>         not_dyntransition_subj_type_or_unconfined_subj_type_attribute
>             (not
>                 (
>                     dyntransition_subj_type_attribute
>                     unconfined_subj_type_attribute
>                 )
>             )
>     )
>
> and:
>
>     (typeattributeset except_obj_type_attribute
>         (and
>             (
>                 obj_type_attribute
>             )
>             (not
>                 (
>                     auth_obj_type_attribute
>                     exception_obj_type_attribute
>                     sec_obj_type_attribute
>                 )
>             )
>         )
>     )
>
>
>
>> Kind Regards,
>> Alex
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
