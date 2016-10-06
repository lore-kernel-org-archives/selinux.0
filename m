Subject: Re: [PATCH v2 0/1] supporting RBACSEP in genhomedircon
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <cover.1475590141.git.gary.tierney@gmx.com>
 <31a14a92-c2e5-ae4e-7366-e7d6177dc178@tycho.nsa.gov>
 <0b43fee1-1a0c-8269-ee2b-a51aecd4ea01@gmail.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <afc6d84a-04be-6583-1ea7-00ba028cda1f@tycho.nsa.gov>
Date: Thu, 6 Oct 2016 12:49:47 -0400
MIME-Version: 1.0
In-Reply-To: <0b43fee1-1a0c-8269-ee2b-a51aecd4ea01@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/06/2016 11:29 AM, Dominick Grift wrote:
> On 10/06/2016 04:56 PM, James Carter wrote:
>> On 10/06/2016 07:09 AM, Gary Tierney wrote:
>>> New version of the previous genhomedircon-rbacsep patch with some
>>> changes.  A
>>> bit of a delay as I had to get in a libsepol/cil fix which was
>>> blocking this.
>>>
>>> 1. Remove semanage.conf option
>>> 2. Drop unrelated change
>>> 3. Adds a new homedir_role member to the genhomedircon_user struct.
>>> 4. Sets homedir_role if the SELinux users prefix is a valid role for
>>> that user.
>>> 5. Replaces all roles with homedir_role in context specifications if
>>> homedir_role is set.
>>>
>>> One issue that came up when writing these patches is that genhomedircon
>>> squashes logging [1] for some reason, which can result in no warning /
>>> info
>>> messages and an empty file_contexts.homedirs file if policy has been
>>> incorrectly configured.  Can we get rid of this behavior or add a flag to
>>> conditionally enable logging?
>>>
>>> Dominick Grift helpfully created some test images that demo DSSP
>>> policy working
>>> with both RBACSEP and non-RBACEP:
>>> https://tfirg.asu.su/2016/10/03/garys-patches/
>>>
>>> There are still some rough edges though, for example in policy you
>>> can't write a
>>> statement like: (userprefix id role) and put it in an abstract namespace,
>>> since it is interpreted as a literal:
>>>
>>> (block usersubj
>>>     (blockabstract usersubj)
>>>     (user id)
>>>     (role role)
>>>     (userrole id role)
>>>     (userprefix id role))
>>>
>>> (block wheel
>>>     (blockinherit usersubj))
>>>
>>> Which leaves us with a (userid, prefix) tuple of (wheel.id, role)
>>> [wheel.id
>>> might even just be id here, haven't checked if users are expanded or
>>> also taken
>>> as literals].
>>>
>>
>> Users are fully qualified, so it is "wheel.id". It is true though that
>> "role" in "(userprefix id role)" is taken as a string and is not
>> expanded. The only identifiers that are fully qualified are those that
>> will exist in the kernel policy and are stored in symbol tables.
>>
>> To get what you want you need to write:
>>
>> (block usersubj
>>     (blockabstract usersubj)
>>     (user id)
>>     (userlevel id (SENS))
>>     (userrange id ((SENS)(SENS (CAT))))
>>     (role role)
>>     (userrole id role))
>>
>> (block wheel
>>     (blockinherit usersubj))
>>
>> (userprefix wheel.id wheel.role)
>>
>> which is inconvenient. It seems to me that if the userprefix statement
>> is allowed in a block, then it makes sense to fully qualify it, but I
>> tend to see the prefix as a string, so it would make more sense to me to
>> just not allow it in blocks.
>
> It use to be a string, but that is no longer true with this patch. It is
> a role now. In my view it should be treated as such

This patch does not exactly make it a role. It treats it as a role if the prefix 
matches a valid role. The CIL compiler cannot assume that the prefix is a role. 
CIL could check to see if the prefix matches a role and fully qualify it if it 
does, but if it didn't match then it wouldn't be fully qualified and that 
doesn't seem like the desired behavior.

Jim

>
>>
>> This makes more sense in the following example.
>>
>> (block userdecl
>>     (blockabstract userdecl)
>>     (user u)
>>     (userlevel u (SENS))
>>     (userrange u ((SENS) (SENS (CAT))))
>>     (role r)
>>     (userrole u r))
>>
>> (block user
>>     (blockinherit userdecl))
>>
>> (userprefix user.u user)
>>
>> Where user is acting like a true prefix for user user.u and role user.r.
>>
>> Jim
>>
>>
>>> Though this is something I can look at later if all is well here.
>>>
>>> [1]
>>> https://github.com/SELinuxProject/selinux/blob/master/libsemanage/src/genhomedircon.c#L568-L572
>>>
>>>
>>> Gary Tierney (1):
>>>   genhomedircon: use userprefix as the role for homedir content
>>>
>>>  libsemanage/src/genhomedircon.c | 38
>>> +++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>>
>>
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
