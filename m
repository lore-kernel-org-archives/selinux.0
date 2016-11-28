Subject: Re: [PATCH 5/5] libsepol: detect duplicated symbol IDs
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20161123220646.23504-1-nicolas.iooss@m4x.org>
 <20161123220646.23504-5-nicolas.iooss@m4x.org>
 <2721d890-5d43-510c-374a-3878a4ebd0cb@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <f2e4a7d2-3437-6011-d02c-4957ac8b61c7@m4x.org>
Date: Mon, 28 Nov 2016 20:19:01 +0100
MIME-Version: 1.0
In-Reply-To: <2721d890-5d43-510c-374a-3878a4ebd0cb@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 28/11/16 15:28, Stephen Smalley wrote:
> On 11/23/2016 05:06 PM, Nicolas Iooss wrote:
>> A valid policy would not have two symbols (classes, roles, users...)
>> sharing the same unique identifier. Make policydb_read() rejects such
>> policy files.
>>
>> When ..._val_to_name translation tables were allocated with malloc(),
>> change to calloc() in order to initialize the tables with NULLs.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>  libsepol/src/conditional.c |  5 +++++
>>  libsepol/src/policydb.c    | 45 ++++++++++++++++++++++++++++++++++++++++-----
>>  2 files changed, 45 insertions(+), 5 deletions(-)
>>
>> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
>> index e1bc961b2b52..8b2060ce3ff2 100644
>> --- a/libsepol/src/conditional.c
>> +++ b/libsepol/src/conditional.c
>> @@ -25,6 +25,7 @@
>>  #include <sepol/policydb/conditional.h>
>>  
>>  #include "private.h"
>> +#include "debug.h"
>>  
>>  /* move all type rules to top of t/f lists to help kernel on evaluation */
>>  static void cond_optimize(cond_av_list_t ** l)
>> @@ -551,6 +552,10 @@ int cond_index_bool(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>>  	if (!booldatum->s.value || booldatum->s.value > p->p_bools.nprim)
>>  		return -EINVAL;
>>  
>> +	if (p->p_bool_val_to_name[booldatum->s.value - 1] != NULL ) {
>> +		ERR(NULL, "duplicated boolean ID %u", booldatum->s.value);
> 
> Similarly, we could pass down the fp->handle from the caller by wrapping
> the policydb_t *p and the sepol_handle_t *handle in an args struct and
> passing that as the (void*) arg to the index functions.  Or we could
> live without this level of error messages and just return failure silently.

With the first option, the prototype of indexing functions
policydb_index_...() would need to be updated to take a handle argument.
This change in the API would be propagated to checkpolicy, which uses
these functions.
The second option (return -EINVAL without printing anything) is already
what is done when the value is out of bounds and is much simpler to
implement, so it is the one I prefer. I will send a v2 with this.

[...]

>> @@ -863,6 +867,11 @@ static int class_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>>  	p = (policydb_t *) datap;
>>  	if (!cladatum->s.value || cladatum->s.value > p->p_classes.nprim)
>>  		return -EINVAL;
>> +	if (p->p_class_val_to_name[cladatum->s.value - 1] != NULL ||
>> +	    p->class_val_to_struct[cladatum->s.value - 1] != NULL ) {
> 
> Do we really need to test both?

As p->..._val_to_struct and p->p_..._val_to_name arrays are always
updated together, I agree one of the test is redundant. I will drop the
second one in the v2 (and I will also remove the extra whitespace which
managed to slip in the condition).

Thanks for your review,

Nicolas
