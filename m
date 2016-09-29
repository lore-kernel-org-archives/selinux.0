Subject: Re: [PATCH] libsepol/cil: Check for too many permissions in classes
 and commons
To: Steve Lawrence <slawrence@tresys.com>, selinux@tycho.nsa.gov
References: <1475172471-25069-1-git-send-email-jwcart2@tycho.nsa.gov>
 <15dfed0a-c0cb-04de-d9b0-7aa43689e9c0@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <f326baae-48ca-75ed-eacf-d87b5501b740@tycho.nsa.gov>
Date: Thu, 29 Sep 2016 14:52:05 -0400
MIME-Version: 1.0
In-Reply-To: <15dfed0a-c0cb-04de-d9b0-7aa43689e9c0@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/29/2016 02:38 PM, Steve Lawrence wrote:
> On 09/29/2016 02:07 PM, James Carter wrote:
>> Fixes bug found by Nicolas Iooss as described below in the way suggested by Steve Lawrence.
>>
>> Nicolass reported:
>>
>> When compiling a CIL policy with more than 32 items in a class (e.g. in
>> (class capability (chown ...)) with many items),
>> cil_classorder_to_policydb() overflows perm_value_to_cil[class_index]
>> array. As this array is allocated on the heap through
>> calloc(PERMS_PER_CLASS+1, sizeof(...)), this makes secilc crash with the
>> following message:
>>
>>     *** Error in `/usr/bin/secilc': double free or corruption (!prev): 0x000000000062be80 ***
>>     ======= Backtrace: =========
>>     /usr/lib/libc.so.6(+0x70c4b)[0x7ffff76a7c4b]
>>     /usr/lib/libc.so.6(+0x76fe6)[0x7ffff76adfe6]
>>     /usr/lib/libc.so.6(+0x777de)[0x7ffff76ae7de]
>>     /lib/libsepol.so.1(+0x14fbda)[0x7ffff7b24bda]
>>     /lib/libsepol.so.1(+0x152db8)[0x7ffff7b27db8]
>>     /lib/libsepol.so.1(cil_build_policydb+0x63)[0x7ffff7af8723]
>>     /usr/bin/secilc[0x40273b]
>>     /usr/lib/libc.so.6(__libc_start_main+0xf1)[0x7ffff7657291]
>>     /usr/bin/secilc[0x402f7a]
>>
>> This bug has been found by fuzzing secilc with american fuzzy lop.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>
> Looks good to me.

It has been applied.

Jim

>
>>  libsepol/cil/src/cil_build_ast.c   | 9 +++++++++
>>  libsepol/cil/src/cil_internal.h    | 2 ++
>>  libsepol/cil/src/cil_resolve_ast.c | 6 ++++++
>>  3 files changed, 17 insertions(+)
>>
>> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
>> index 1505873..a96c2a9 100644
>> --- a/libsepol/cil/src/cil_build_ast.c
>> +++ b/libsepol/cil/src/cil_build_ast.c
>> @@ -377,6 +377,11 @@ int cil_gen_class(struct cil_db *db, struct cil_tree_node *parse_current, struct
>>  		if (rc != SEPOL_OK) {
>>  			goto exit;
>>  		}
>> +		if (class->num_perms > CIL_PERMS_PER_CLASS) {
>> +			cil_tree_log(parse_current, CIL_ERR, "Too many permissions in class '%s'", class->datum.name);
>> +			goto exit;
>> +		}
>> +
>>  	}
>>
>>  	return SEPOL_OK;
>> @@ -939,6 +944,10 @@ int cil_gen_common(struct cil_db *db, struct cil_tree_node *parse_current, struc
>>  	if (rc != SEPOL_OK) {
>>  		goto exit;
>>  	}
>> +	if (common->num_perms > CIL_PERMS_PER_CLASS) {
>> +		cil_tree_log(parse_current, CIL_ERR, "Too many permissions in common '%s'", common->datum.name);
>> +		goto exit;
>> +	}
>>
>>  	return SEPOL_OK;
>>
>> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
>> index 5875dc9..03672bb 100644
>> --- a/libsepol/cil/src/cil_internal.h
>> +++ b/libsepol/cil/src/cil_internal.h
>> @@ -37,6 +37,7 @@
>>
>>  #include <sepol/policydb/services.h>
>>  #include <sepol/policydb/policydb.h>
>> +#include <sepol/policydb/flask_types.h>
>>
>>  #include <cil/cil.h>
>>
>> @@ -270,6 +271,7 @@ enum cil_sym_array {
>>  extern int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM];
>>
>>  #define CIL_CLASS_SYM_SIZE	256
>> +#define CIL_PERMS_PER_CLASS (sizeof(sepol_access_vector_t) * 8)
>>
>>  struct cil_db {
>>  	struct cil_tree *parse;
>> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
>> index 8348d57..917adf8 100644
>> --- a/libsepol/cil/src/cil_resolve_ast.c
>> +++ b/libsepol/cil/src/cil_resolve_ast.c
>> @@ -717,6 +717,10 @@ int cil_resolve_classcommon(struct cil_tree_node *current, void *extra_args)
>>  	cil_symtab_map(&class->perms, __class_update_perm_values, &common->num_perms);
>>
>>  	class->num_perms += common->num_perms;
>> +	if (class->num_perms > CIL_PERMS_PER_CLASS) {
>> +		cil_tree_log(current, CIL_ERR, "Too many permissions in class '%s' when including common permissions", class->datum.name);
>> +		goto exit;
>> +	}
>>
>>  	return SEPOL_OK;
>>
>> @@ -1447,6 +1451,7 @@ int cil_resolve_classorder(struct cil_tree_node *current, void *extra_args)
>>  	return SEPOL_OK;
>>
>>  exit:
>> +	cil_list_destroy(&new, CIL_FALSE);
>>  	return rc;
>>  }
>>
>> @@ -3919,6 +3924,7 @@ exit:
>>  	__cil_ordered_lists_destroy(&extra_args.catorder_lists);
>>  	__cil_ordered_lists_destroy(&extra_args.sensitivityorder_lists);
>>  	cil_list_destroy(&extra_args.in_list, CIL_FALSE);
>> +	cil_list_destroy(&extra_args.unordered_classorder_lists, CIL_FALSE);
>>
>>  	return rc;
>>  }
>>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
