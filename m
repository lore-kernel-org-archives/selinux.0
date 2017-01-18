Subject: Re: [PATCH 1/1] checkpolicy: do not leak memory when declaring a type
 which has been required
To: Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Iooss
 <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170114131255.17598-1-nicolas.iooss@m4x.org>
 <1484689623.20454.25.camel@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <9faf1fa1-00cc-20a6-d942-2fceaed7c593@tycho.nsa.gov>
Date: Wed, 18 Jan 2017 08:37:48 -0500
MIME-Version: 1.0
In-Reply-To: <1484689623.20454.25.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/17/2017 04:47 PM, Stephen Smalley wrote:
> On Sat, 2017-01-14 at 14:12 +0100, Nicolas Iooss wrote:
>> This kind of strange construction is currently accepted by
>> checkmodule
>> but it makes memory to be leaked in declare_type():
>>
>>     optional {
>>         require { type TYPE1; }
>>     }
>>     optional {
>>         require { attribute ATTR; }
>>         type TYPE1, ATTR;
>>     }
>>
>> Moreover reversing the order of these two optional blocks leads to an
>> (expected) error:
>>
>>     ERROR 'duplicate declaration of type/attribute' at token 'TYPE1'
>>     on line 14:
>>             require { type TYPE1; }
>
> I could be wrong, but this error seems wrong to me.  It isn't declaring
> the type multiple times but instead is requiring it in one optional
> block (with an empty body besides the require) and then declaring it in
> another.  Technically, that should turn on the first optional block
> during link/expand IIUC.  cc'ing some others
>

The error looks wrong to me as well.

Jim

>>
>> Make checkmodule fails with an error when encourntering the first
>> construction.
>>
>> Moreover the construction below also makes memory to be leaked:
>>
>>     optional {
>>         require { type TYPE2; attribute ATTR; }
>>         typeattribute TYPE2 ATTR;
>>     }
>>     type TYPE2;
>>
>> This example is valid and is used by several refpolicy modules. In
>> declare_type(), declare_symbol() returns 1, stack_top->parent is NULL
>> and the scope of TYPE2 has been updated when declare_symbol() called
>> symtab_insert(). When these conditions are met, declare_type() should
>> return the currently existing type in the policy database.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>
>> I have tested this patch both with "make test" and by compiling the
>> current master branch of refpolicy. I have not tested it to build any
>> Android policy.
>>
>>  checkpolicy/module_compiler.c | 31 +++++++++++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/checkpolicy/module_compiler.c
>> b/checkpolicy/module_compiler.c
>> index 6e5483c17540..04d09d1445a3 100644
>> --- a/checkpolicy/module_compiler.c
>> +++ b/checkpolicy/module_compiler.c
>> @@ -308,7 +308,7 @@ role_datum_t *declare_role(unsigned char isattr)
>>  type_datum_t *declare_type(unsigned char primary, unsigned char
>> isattr)
>>  {
>>  	char *id;
>> -	type_datum_t *typdatum;
>> +	type_datum_t *typdatum, *old_datum;
>>  	int retval;
>>  	uint32_t value = 0;
>>
>> @@ -335,10 +335,37 @@ type_datum_t *declare_type(unsigned char
>> primary, unsigned char isattr)
>>  	typdatum->flavor = isattr ? TYPE_ATTRIB : TYPE_TYPE;
>>
>>  	retval = declare_symbol(SYM_TYPES, id, typdatum, &value,
>> &value);
>> -	if (retval == 0 || retval == 1) {
>> +	if (retval == 0) {
>>  		if (typdatum->primary) {
>>  			typdatum->s.value = value;
>>  		}
>> +	} else if (retval == 1) {
>> +		/* the type has been previously marked as required
>> */
>> +		assert(stack_top->type == 1);
>> +		if (stack_top->parent == NULL) {
>> +			/* in global scope, the type has previously
>> been required and is now declared.
>> +			 * policydbp->scope[SYM_TYPES] has been
>> updated by declare_symbol() */
>> +			old_datum = (type_datum_t *)
>> hashtab_search(policydbp->p_types.table, id);
>> +
>> +			/* check that previous symbol has the same
>> type/attribute-ness */
>> +			if (typdatum->flavor == old_datum->flavor) {
>> +				type_datum_destroy(typdatum);
>> +				free(typdatum);
>> +				typdatum = old_datum;
>> +			} else {
>> +				yyerror("declaration of
>> type/attribute with an unexpected flavor");
>> +				type_datum_destroy(typdatum);
>> +				free(typdatum);
>> +				typdatum = NULL;
>> +			}
>> +			free(id);
>> +		} else {
>> +			yyerror("declaration of type/attribute after
>> it has been required");
>> +			free(id);
>> +			type_datum_destroy(typdatum);
>> +			free(typdatum);
>> +			return NULL;
>> +		}
>>  	} else {
>>  		/* error occurred (can't have duplicate type
>> declarations) */
>>  		free(id);


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
