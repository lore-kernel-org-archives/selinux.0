Subject: Re: [PATCH] libsepol: Only apply bounds checking to source types in
 rules
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1461959620-26532-1-git-send-email-jwcart2@tycho.nsa.gov>
 <aa5d62a6-d704-0673-7ca5-c2ae0af11f4a@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <5723BF41.906@tycho.nsa.gov>
Date: Fri, 29 Apr 2016 16:08:33 -0400
MIME-Version: 1.0
In-Reply-To: <aa5d62a6-d704-0673-7ca5-c2ae0af11f4a@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/29/2016 04:06 PM, Stephen Smalley wrote:
> On 04/29/2016 03:53 PM, James Carter wrote:
>> The current bounds checking of both source and target types
>> requires allowing any domain that has access to the child domain
>> to also have the same permissions to the parent, which is undesirable.
>> Drop the target bounds expansion and checking.
>>
>> Making this change fully functional requires a corresponding kernel
>> change; this change only allows one to build policies that would
>> otherwise violate the bounds checking on target type.  The kernel
>> change is required to allow the permissions at runtime.
>>
>> Based on patch by Stephen Smalley.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>

Applied.

Jim

>> ---
>>   libsepol/src/hierarchy.c | 37 -------------------------------------
>>   1 file changed, 37 deletions(-)
>>
>> diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
>> index 6f73195..b24b39e 100644
>> --- a/libsepol/src/hierarchy.c
>> +++ b/libsepol/src/hierarchy.c
>> @@ -121,18 +121,6 @@ static int bounds_expand_rule(sepol_handle_t *handle, policydb_t *p,
>>   		}
>>   	}
>>
>> -	if (ebitmap_get_bit(&p->attr_type_map[tgt - 1], parent - 1)) {
>> -		avtab_key.target_type = parent;
>> -		ebitmap_for_each_bit(&p->attr_type_map[src - 1], tnode, i) {
>> -			if (!ebitmap_node_get_bit(tnode, i))
>> -				continue;
>> -			avtab_key.source_type = i + 1;
>> -			rc = bounds_insert_rule(handle, avtab, global, other,
>> -						&avtab_key, &datum);
>> -			if (rc) goto exit;
>> -		}
>> -	}
>> -
>>   exit:
>>   	return rc;
>>   }
>> @@ -329,31 +317,6 @@ static int bounds_check_rule(sepol_handle_t *handle, policydb_t *p,
>>   			if (rc) goto exit;
>>   		}
>>   	}
>> -	if (ebitmap_get_bit(&p->attr_type_map[tgt - 1], child - 1)) {
>> -		avtab_key.target_type = parent;
>> -		ebitmap_for_each_bit(&p->attr_type_map[src - 1], tnode, i) {
>> -			if (!ebitmap_node_get_bit(tnode, i))
>> -				continue;
>> -			avtab_key.source_type = i + 1;
>> -			if (avtab_key.source_type == child) {
>> -				/* Checked above */
>> -				continue;
>> -			}
>> -			d = bounds_not_covered(global_avtab, cur_avtab,
>> -					       &avtab_key, data);
>> -			if (!d) continue;
>> -			td = p->type_val_to_struct[i];
>> -			if (td && td->bounds) {
>> -				avtab_key.source_type = td->bounds;
>> -				d = bounds_not_covered(global_avtab, cur_avtab,
>> -						       &avtab_key, data);
>> -				if (!d) continue;
>> -			}
>> -			(*numbad)++;
>> -			rc = bounds_add_bad(handle, i+1, child, class, d, bad);
>> -			if (rc) goto exit;
>> -		}
>> -	}
>>
>>   exit:
>>   	return rc;
>>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
