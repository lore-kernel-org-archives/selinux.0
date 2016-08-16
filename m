Subject: Re: [PATCH v4 7/7] libsepol: fix overflow and 0 length allocations
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "jwcart2@tycho.nsa.gov" <jwcart2@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
References: <1471368517-20552-1-git-send-email-william.c.roberts@intel.com>
 <1471368517-20552-8-git-send-email-william.c.roberts@intel.com>
 <476DC76E7D1DF2438D32BFADF679FC5601284AA3@ORSMSX103.amr.corp.intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3795c006-03cd-f177-41c9-56439aa67d44@tycho.nsa.gov>
Date: Tue, 16 Aug 2016 14:40:13 -0400
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5601284AA3@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/16/2016 01:45 PM, Roberts, William C wrote:
> 
> 
>> -----Original Message-----
>> From: Roberts, William C
>> Sent: Tuesday, August 16, 2016 10:29 AM
>> To: selinux@tycho.nsa.gov; jwcart2@tycho.nsa.gov; seandroid-
>> list@tycho.nsa.gov; sds@tycho.nsa.gov
>> Cc: Roberts, William C <william.c.roberts@intel.com>
>> Subject: [PATCH v4 7/7] libsepol: fix overflow and 0 length allocations
>>
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> Throughout libsepol, values taken from sepolicy are used in places where length
>> == 0 or length == <saturated> matter, find and fix these.
>>
>> Also, correct any type mismatches noticed along the way.
>>
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> ---
>>  libsepol/src/conditional.c    |  3 +-
>>  libsepol/src/context.c        | 16 +++++++---
>>  libsepol/src/context_record.c | 72 +++++++++++++++++++++++++++++----------
>> ----
>>  libsepol/src/module.c         | 13 ++++++++
>>  libsepol/src/module_to_cil.c  |  4 ++-
>>  libsepol/src/policydb.c       | 52 +++++++++++++++++++++++++++++--
>>  libsepol/src/private.h        |  3 ++
>>  7 files changed, 130 insertions(+), 33 deletions(-)
>>
>> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c index
>> ea47cdd..8680eb2 100644
>> --- a/libsepol/src/conditional.c
>> +++ b/libsepol/src/conditional.c
>> @@ -589,7 +589,8 @@ int cond_read_bool(policydb_t * p,
>>  		goto err;
>>
>>  	len = le32_to_cpu(buf[2]);
>> -
>> +	if (zero_or_saturated(len))
>> +		goto err;
>>  	key = malloc(len + 1);
>>  	if (!key)
>>  		goto err;
>> diff --git a/libsepol/src/context.c b/libsepol/src/context.c index 420ee16..a88937f
>> 100644
>> --- a/libsepol/src/context.c
>> +++ b/libsepol/src/context.c
>> @@ -10,6 +10,7 @@
>>  #include "context.h"
>>  #include "handle.h"
>>  #include "mls.h"
>> +#include "private.h"
>>
>>  /* ----- Compatibility ---- */
>>  int policydb_context_isvalid(const policydb_t * p, const context_struct_t * c)
>> @@ -297,10 +298,18 @@ int context_from_string(sepol_handle_t * handle,
>>  	char *con_cpy = NULL;
>>  	sepol_context_t *ctx_record = NULL;
>>
>> +	if (zero_or_saturated(con_str_len)) {
>> +		ERR(handle, "Invalid context length");
>> +		goto err;
>> +	}
>> +
>>  	/* sepol_context_from_string expects a NULL-terminated string */
>>  	con_cpy = malloc(con_str_len + 1);
>> -	if (!con_cpy)
>> -		goto omem;
>> +	if (!con_cpy) {
>> +		ERR(handle, "out of memory");
>> +		goto err;
>> +	}
>> +
>>  	memcpy(con_cpy, con_str, con_str_len);
>>  	con_cpy[con_str_len] = '\0';
>>
>> @@ -315,9 +324,6 @@ int context_from_string(sepol_handle_t * handle,
>>  	sepol_context_free(ctx_record);
>>  	return STATUS_SUCCESS;
>>
>> -      omem:
>> -	ERR(handle, "out of memory");
>> -
>>        err:
>>  	ERR(handle, "could not create context structure");
>>  	free(con_cpy);
>> diff --git a/libsepol/src/context_record.c b/libsepol/src/context_record.c index
>> ac2884a..0a8bbf6 100644
>> --- a/libsepol/src/context_record.c
>> +++ b/libsepol/src/context_record.c
>> @@ -5,6 +5,7 @@
>>
>>  #include "context_internal.h"
>>  #include "debug.h"
>> +#include "private.h"
>>
>>  struct sepol_context {
>>
>> @@ -279,44 +280,69 @@ int sepol_context_from_string(sepol_handle_t *
>> handle,
>>
>>  hidden_def(sepol_context_from_string)
>>
>> +static inline int safe_sum(size_t *sum, const size_t augends[], const
>> +size_t cnt) {
>> +
>> +	size_t a, i;
>> +
>> +	*sum = 0;
>> +	for(i=0; i < cnt; i++) {
>> +		/* sum should not be smaller than the addend */
>> +		a = augends[i];
>> +		*sum += a;
>> +		if (*sum < a) {
>> +			return i;
> 
> Damn it...this does not work when index 0 is the bad one... I'll wait till
> Tomorrow and aggregate responses again.

Use __builtin_add_overflow()?
