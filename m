Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: Dominick Grift <dac.override@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
 <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <ba5c64b3-ae89-15a8-0b02-c5d5dc36b7eb@tycho.nsa.gov>
Date: Fri, 20 Jan 2017 10:16:06 -0500
MIME-Version: 1.0
In-Reply-To: <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/19/2017 04:22 PM, Dominick Grift wrote:
> On 01/19/2017 06:21 PM, Stephen Smalley wrote:
>> On Wed, 2017-01-18 at 21:58 +0100, Dominick Grift wrote:
>>> On 01/18/2017 09:53 PM, James Carter wrote:
>>>>
>>>> Nicolas Iooss discovered that requiring a type in an optional block
>>>> after the type has already been declared in another optional block
>>>> results in a duplicate declaration error.
>>>>
>>>
>>> from what i have been told and from experience, types cannot,
>>> reliably,
>>> be declared in optional blocks.
>>
>> If true, that is likely a linker issue rather than a checkpolicy issue.
>> But that would make optionals rather useless if true.
>
> Let me present it in a different way then:
>
> Should one be able to, reliably, "blockinherit" in optionals?
>
> This is the commit in dssp1 where i hit the dead-end with declaring
> types in optionals:
>
> https://github.com/DefenSec/dssp-contrib/commit/45236da4030f0a541c26753e13a91f69411d022e
>
> I asked slawrence to have a look at the policy, and he indicated to me
> that blocks cannot be inherited in optionals.
>
> The compiler accepts it but the policy becomes inconsistent
>

By inconsistent, do you mean that an the binary policy produced is not valid, or 
something else?

Macro definitions are not allowed in optionals, so if you have a macro 
definition in a block, that should cause an error. Other than that, I can't 
think of what would cause problems.

Jim

>>
>>>
>>> if the above is true, then the compiler should not allow one to
>>> declare
>>> a type in an optional block in the first place
>>>
>>>>
>>>> The following policy will trigger the error.
>>>>
>>>> optional {
>>>>   type T1;
>>>> }
>>>>
>>>> optional {
>>>>   require { type T1; }
>>>> }
>>>>
>>>> In this case, although symtab_insert() in libsepol properly
>>>> identifies
>>>> that the first T1 is a declaration while the second is a require,
>>>> it
>>>> will return -2 which is the return value for a duplicate
>>>> declaration
>>>> and expect the calling code to properly handle the situation. The
>>>> caller is require_symbol() in checkpolicy and it checks if the
>>>> previous
>>>> declaration is in the current scope. If it is, then the require can
>>>> be
>>>> ignored. It also checks to see if the declaration is a type and the
>>>> require an attribute or vice versa which is an error. The problem
>>>> is
>>>> that -2 is returned if the declaration is not in scope which is
>>>> interpreted as a duplicate declaration error.
>>>>
>>>> The function should return 1 instead which means that they symbol
>>>> was not
>>>> added and needs to be freed later.
>>>>
>>>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>>>> ---
>>>>  checkpolicy/module_compiler.c | 16 +++-------------
>>>>  1 file changed, 3 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/checkpolicy/module_compiler.c
>>>> b/checkpolicy/module_compiler.c
>>>> index 6e5483c..bb60f34 100644
>>>> --- a/checkpolicy/module_compiler.c
>>>> +++ b/checkpolicy/module_compiler.c
>>>> @@ -647,7 +647,6 @@ int require_symbol(uint32_t symbol_type,
>>>>  	} else if (retval == -2) {
>>>>  		/* ignore require statements if that symbol was
>>>>  		 * previously declared and is in current scope */
>>>> -		int prev_declaration_ok = 0;
>>>>  		if (is_id_in_scope(symbol_type, key)) {
>>>>  			if (symbol_type == SYM_TYPES) {
>>>>  				/* check that previous symbol has
>>>> same
>>>> @@ -661,23 +660,14 @@ int require_symbol(uint32_t symbol_type,
>>>>  								
>>>>   table, key);
>>>>  				assert(old_datum != NULL);
>>>>  				unsigned char old_isattr =
>>>> old_datum->flavor;
>>>> -				prev_declaration_ok =
>>>> -				    (old_isattr == new_isattr ? 1
>>>> : 0);
>>>> -			} else {
>>>> -				prev_declaration_ok = 1;
>>>> +				if (old_isattr != new_isattr)
>>>> +					return -2;
>>>>  			}
>>>> -		}
>>>> -		if (prev_declaration_ok) {
>>>>  			/* ignore this require statement because
>>>> it
>>>>  			 * was already declared within my scope */
>>>>  			stack_top->require_given = 1;
>>>> -			return 1;
>>>> -		} else {
>>>> -			/* previous declaration was not in scope
>>>> or
>>>> -			 * had a mismatched type/attribute, so
>>>> -			 * generate an error */
>>>> -			return -2;
>>>>  		}
>>>> +		return 1;
>>>>  	} else if (retval < 0) {
>>>>  		return -3;
>>>>  	} else {		/* fall through possible if retval
>>>> is 0 or 1 */
>>>>
>>>
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho
>>> .nsa.gov.
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
