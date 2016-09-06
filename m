Subject: Re: [PATCH] libsepol: Produce more meaningful error messages for
 conflicting type rules
To: Guido Trentalancia <guido@trentalancia.net>, selinux@tycho.nsa.gov
References: <1472301855.5566.1.camel@trentalancia.net>
 <1473171653.17158.9.camel@trentalancia.net>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <b5e170be-33cc-fed7-ca07-f3d5752fe6cd@tycho.nsa.gov>
Date: Tue, 6 Sep 2016 13:54:55 -0400
MIME-Version: 1.0
In-Reply-To: <1473171653.17158.9.camel@trentalancia.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/06/2016 10:20 AM, Guido Trentalancia wrote:
> Hello.
>
> I received no feedback on this.
>
> I still believe it is a very useful patch, because at the moment it is
> very hard to track down the error from the error message.
>
> Guido
>
> On Sat, 27/08/2016 at 14.44 +0200, Guido Trentalancia wrote:
>> Produce more meaningful error messages when conflicting type
>> rules are found by libsepol.
>>
>> Fixes Debian bug #832331 (https://bugs.debian.org/832331).
>>
>> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>

Sorry for the delay, but applied now.

Thanks,
Jim

>> ---
>>  cil/src/cil_binary.c |    8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> --- libsepol-2.5/cil/src/cil_binary.c	2016-02-23
>> 17:31:41.000000000 +0100
>> +++ libsepol-2.5-conflicting_type_rules/cil/src/cil_binary.c	2
>> 016-08-27 14:31:44.307988662 +0200
>> @@ -973,7 +973,7 @@ avtab_datum_t *cil_cond_av_list_search(a
>>  	return NULL;
>>  }
>>
>> -int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t
>> src, uint32_t tgt, uint32_t obj, uint32_t res, cond_node_t
>> *cond_node, enum cil_flavor cond_flavor)
>> +int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t
>> src, uint32_t tgt, uint32_t obj, uint32_t res, struct cil_type_rule
>> *cil_rule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
>>  {
>>  	int rc = SEPOL_OK;
>>  	avtab_key_t avtab_key;
>> @@ -1008,7 +1008,7 @@ int __cil_insert_type_rule(policydb_t *p
>>  		 * non-duplicate rule using the same key.
>>  		 */
>>  		if (existing->datum.data != res) {
>> -			cil_log(CIL_ERR, "Conflicting type
>> rules\n");
>> +			cil_log(CIL_ERR, "Conflicting type rules
>> (scontext=%s tcontext=%s tclass=%s result=%s)\n", cil_rule->src_str,
>> cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
>>  			rc = SEPOL_ERR;
>>  		}
>>  		goto exit;
>> @@ -1034,7 +1034,7 @@ int __cil_insert_type_rule(policydb_t *p
>>  			search_datum =
>> cil_cond_av_list_search(&avtab_key, other_list);
>>  			if (search_datum == NULL) {
>>  				if (existing->datum.data != res) {
>> -					cil_log(CIL_ERR,
>> "Conflicting type rules\n");
>> +					cil_log(CIL_ERR,
>> "Conflicting type rules (scontext=%s tcontext=%s tclass=%s
>> result=%s)\n", cil_rule->src_str, cil_rule->tgt_str, cil_rule-
>>> obj_str, cil_rule->result_str);
>>  					rc = SEPOL_ERR;
>>  					goto exit;
>>  				}
>> @@ -1093,7 +1093,7 @@ int __cil_type_rule_to_avtab(policydb_t
>>  				rc =
>> __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
>>  				if (rc != SEPOL_OK) goto exit;
>>
>> -				rc = __cil_insert_type_rule(pdb,
>> kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value,
>> sepol_result->s.value, cond_node, cond_flavor);
>> +				rc = __cil_insert_type_rule(pdb,
>> kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value,
>> sepol_result->s.value, cil_rule, cond_node, cond_flavor);
>>  				if (rc != SEPOL_OK) goto exit;
>>  			}
>>  		}
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
