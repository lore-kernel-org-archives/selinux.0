Message-ID: <557AD6A8.6030601@tresys.com>
Date: Fri, 12 Jun 2015 08:55:04 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>,
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 03/10] libsepol: Refactored neverallow checking.
References: <1434047207-25503-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1434047207-25503-4-git-send-email-jwcart2@tycho.nsa.gov>
 <5579EA96.5020108@tycho.nsa.gov>
In-Reply-To: <5579EA96.5020108@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 6/11/2015 4:07 PM, Stephen Smalley wrote:
> On 06/11/2015 02:26 PM, James Carter wrote:
>> Instead of creating an expanded avtab, generating all of the avtab
>> keys corresponding to a neverallow rule and searching for a match,
>> walk the nodes in the avtab and use the attr_type_map and ebitmap
>> functions to find matching rules.
>>
>> Memory usage is reduced from 370M to 125M and time is reduced from
>> 14 sec to 2 sec. (Bounds checking commented out in both cases.)
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>  libsepol/include/sepol/policydb/policydb.h |   2 +-
>>  libsepol/src/assertion.c                   | 225 ++++++++++++++++++-----------
>>  2 files changed, 145 insertions(+), 82 deletions(-)
>>
>> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
>> index 1d8310c..b3cf9db 100644
>> --- a/libsepol/include/sepol/policydb/policydb.h
>> +++ b/libsepol/include/sepol/policydb/policydb.h
>> @@ -652,7 +652,7 @@ extern void level_datum_init(level_datum_t * x);
>>  extern void level_datum_destroy(level_datum_t * x);
>>  extern void cat_datum_init(cat_datum_t * x);
>>  extern void cat_datum_destroy(cat_datum_t * x);
>> -
>> +extern int check_assertion(policydb_t *p, avrule_t *avrule);
>>  extern int check_assertions(sepol_handle_t * handle,
>>  			    policydb_t * p, avrule_t * avrules);
>>  
>> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
>> index c335968..35698df 100644
>> --- a/libsepol/src/assertion.c
>> +++ b/libsepol/src/assertion.c
>> @@ -27,11 +27,16 @@
>>  
>>  #include "debug.h"
>>  
>> -static void report_failure(sepol_handle_t *handle, policydb_t *p,
>> -			   const avrule_t * avrule,
>> +struct avtab_match_args {
>> +	sepol_handle_t *handle;
>> +	policydb_t *p;
>> +	avrule_t *avrule;
>> +	unsigned long errors;
>> +};
>> +
>> +static void report_failure(sepol_handle_t *handle, policydb_t *p, const avrule_t *avrule,
>>  			   unsigned int stype, unsigned int ttype,
>> -			   const class_perm_node_t *curperm,
>> -			   const avtab_ptr_t node)
>> +			   const class_perm_node_t *curperm, uint32_t perms)
>>  {
>>  	if (avrule->source_filename) {
>>  		ERR(handle, "neverallow on line %lu of %s (or line %lu of policy.conf) violated by allow %s %s:%s {%s };",
>> @@ -39,69 +44,164 @@ static void report_failure(sepol_handle_t *handle, policydb_t *p,
>>  		    p->p_type_val_to_name[stype],
>>  		    p->p_type_val_to_name[ttype],
>>  		    p->p_class_val_to_name[curperm->tclass - 1],
>> -		    sepol_av_to_string(p, curperm->tclass,
>> -				       node->datum.data & curperm->data));
>> +		    sepol_av_to_string(p, curperm->tclass, perms));
> 
> So you're reporting the entire list of permissions from the allow rule,
> not just the offending ones?  I guess I could go either way; the old
> approach was more indicative of what the problem was, while the new is
> closer to what they might find in source (albeit after macro expansion).

My preference would be to only list the offending permissions.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
