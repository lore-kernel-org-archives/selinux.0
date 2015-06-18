Message-ID: <5582CD29.3040905@tycho.nsa.gov>
Date: Thu, 18 Jun 2015 09:52:41 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 02/10 v2] libsepol: Treat types like an attribute in the
 attr_type_map.
References: <1434571134-31452-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1434571134-31452-3-git-send-email-jwcart2@tycho.nsa.gov>
 <5582CA84.5090503@tycho.nsa.gov>
In-Reply-To: <5582CA84.5090503@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/18/2015 09:41 AM, Stephen Smalley wrote:
> On 06/17/2015 03:58 PM, James Carter wrote:
>> Types are treated as attributes that contain only themselves. This
>> is how types are already treated in the type_attr_map.
>>
>> Treating types this way makes finding rules that apply to a given
>> type much easier.
> 
> Can you provide an example of the difference it makes?

What I mean here is include the example or cite where this will be used
in the patch description itself.  I can see that you use it in the later
patches but it would be good to note the intended use case here, as
previously we never used attr_type_map unless flavor == TYPE_ATRIB.

> 
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>  libsepol/src/expand.c   | 24 ++++++++++++++++--------
>>  libsepol/src/policydb.c |  4 ++++
>>  2 files changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
>> index 478eaff..85fbe0f 100644
>> --- a/libsepol/src/expand.c
>> +++ b/libsepol/src/expand.c
>> @@ -2311,25 +2311,33 @@ static int type_attr_map(hashtab_key_t key
>>  	policydb_t *p = state->out;
>>  	unsigned int i;
>>  	ebitmap_node_t *tnode;
>> +	int value;
>>  
>>  	type = (type_datum_t *) datum;
>> +	value = type->s.value;
>> +
>>  	if (type->flavor == TYPE_ATTRIB) {
>> -		if (ebitmap_cpy(&p->attr_type_map[type->s.value - 1],
>> -				&type->types)) {
>> -			ERR(state->handle, "Out of memory!");
>> -			return -1;
>> +		if (ebitmap_cpy(&p->attr_type_map[value - 1], &type->types)) {
>> +			goto out;
>>  		}
>>  		ebitmap_for_each_bit(&type->types, tnode, i) {
>>  			if (!ebitmap_node_get_bit(tnode, i))
>>  				continue;
>> -			if (ebitmap_set_bit(&p->type_attr_map[i],
>> -					    type->s.value - 1, 1)) {
>> -				ERR(state->handle, "Out of memory!");
>> -				return -1;
>> +			if (ebitmap_set_bit(&p->type_attr_map[i], value - 1, 1)) {
>> +				goto out;
>>  			}
>>  		}
>> +	} else {
>> +		if (ebitmap_set_bit(&p->attr_type_map[value - 1], value - 1, 1)) {
>> +			goto out;
>> +		}
>>  	}
>> +
>>  	return 0;
>> +
>> +out:
> 
> Should probably call this err: or oom: instead to avoid confusion if
> anyone later introduces an out: label for successful return path.
> 
>> +	ERR(state->handle, "Out of memory!");
>> +	return -1;
>>  }
>>  
>>  /* converts typeset using typemap and expands into ebitmap_t types using the attributes in the passed in policy.
>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
>> index 1677eb5..670aef8 100644
>> --- a/libsepol/src/policydb.c
>> +++ b/libsepol/src/policydb.c
>> @@ -3936,6 +3936,10 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
>>  			/* add the type itself as the degenerate case */
>>  			if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
>>  				goto bad;
>> +			if (p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
>> +				if (ebitmap_set_bit(&p->attr_type_map[i], i, 1))
>> +					goto bad;
>> +			}
>>  		}
>>  	}
> 
> It appears to me that this won't break any existing users of
> attr_type_map AFAICS because they all check flavor == TYPE_ATTRIB first.
> 
> I was wondering though if we are being inconsistent with type_attr_map.
>  We do set the type itself here upon policydb_read() of an existing
> kernel policy, but do we do it when first generating the type_attr_map
> by libsepol?
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
