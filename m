Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0IL9VZm000420
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 16:09:31 -0500
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: selinux@tycho.nsa.gov
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <7adea64c-9095-2728-1220-6428260c48a8@tycho.nsa.gov>
Date: Wed, 18 Jan 2017 16:09:42 -0500
MIME-Version: 1.0
In-Reply-To: <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/18/2017 03:58 PM, Dominick Grift wrote:
> On 01/18/2017 09:53 PM, James Carter wrote:
>> Nicolas Iooss discovered that requiring a type in an optional block
>> after the type has already been declared in another optional block
>> results in a duplicate declaration error.
>>
>
> from what i have been told and from experience, types cannot, reliably,
> be declared in optional blocks.
>
> if the above is true, then the compiler should not allow one to declare
> a type in an optional block in the first place
>

Well, this ordering issue reported by Nicolas would definitely cause their 
declaration to be unreliable. ;)

I hope to make declaring types in optional blocks reliable.

Jim

>> The following policy will trigger the error.
>>
>> optional {
>>   type T1;
>> }
>>
>> optional {
>>   require { type T1; }
>> }
>>
>> In this case, although symtab_insert() in libsepol properly identifies
>> that the first T1 is a declaration while the second is a require, it
>> will return -2 which is the return value for a duplicate declaration
>> and expect the calling code to properly handle the situation. The
>> caller is require_symbol() in checkpolicy and it checks if the previous
>> declaration is in the current scope. If it is, then the require can be
>> ignored. It also checks to see if the declaration is a type and the
>> require an attribute or vice versa which is an error. The problem is
>> that -2 is returned if the declaration is not in scope which is
>> interpreted as a duplicate declaration error.
>>
>> The function should return 1 instead which means that they symbol was not
>> added and needs to be freed later.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>  checkpolicy/module_compiler.c | 16 +++-------------
>>  1 file changed, 3 insertions(+), 13 deletions(-)
>>
>> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
>> index 6e5483c..bb60f34 100644
>> --- a/checkpolicy/module_compiler.c
>> +++ b/checkpolicy/module_compiler.c
>> @@ -647,7 +647,6 @@ int require_symbol(uint32_t symbol_type,
>>  	} else if (retval == -2) {
>>  		/* ignore require statements if that symbol was
>>  		 * previously declared and is in current scope */
>> -		int prev_declaration_ok = 0;
>>  		if (is_id_in_scope(symbol_type, key)) {
>>  			if (symbol_type == SYM_TYPES) {
>>  				/* check that previous symbol has same
>> @@ -661,23 +660,14 @@ int require_symbol(uint32_t symbol_type,
>>  								    table, key);
>>  				assert(old_datum != NULL);
>>  				unsigned char old_isattr = old_datum->flavor;
>> -				prev_declaration_ok =
>> -				    (old_isattr == new_isattr ? 1 : 0);
>> -			} else {
>> -				prev_declaration_ok = 1;
>> +				if (old_isattr != new_isattr)
>> +					return -2;
>>  			}
>> -		}
>> -		if (prev_declaration_ok) {
>>  			/* ignore this require statement because it
>>  			 * was already declared within my scope */
>>  			stack_top->require_given = 1;
>> -			return 1;
>> -		} else {
>> -			/* previous declaration was not in scope or
>> -			 * had a mismatched type/attribute, so
>> -			 * generate an error */
>> -			return -2;
>>  		}
>> +		return 1;
>>  	} else if (retval < 0) {
>>  		return -3;
>>  	} else {		/* fall through possible if retval is 0 or 1 */
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
