Message-ID: <54008135.1000605@tycho.nsa.gov>
Date: Fri, 29 Aug 2014 09:33:41 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>,
 SELinux List <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] policycoreutils: mcstrans: use string_to_av_perm() to
 calculate permission access vector
References: <1409258823-19823-1-git-send-email-slawrence@tresys.com>
 <54007CC1.70302@tycho.nsa.gov> <54007DC3.7090505@tresys.com>
In-Reply-To: <54007DC3.7090505@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/29/2014 09:18 AM, Steve Lawrence wrote:
> On 08/29/2014 09:14 AM, Stephen Smalley wrote:
>> On 08/28/2014 04:47 PM, Steve Lawrence wrote:
>>> mcstrans still uses CONTEXT__CONTAINS from av_permissions.h to calculate
>>> a permission access vector. However, av_permissions.h was deprecated, so
>>> it does not have access to the constant. This updates mcstrans to use
>>> string_to_av_perm() to get the value for context contains.
>>>
>>> Reported-by: Sven Vermeulen <sven.vermeulen@siphos.be>
>>> Signed-off-by: Steve Lawrence <slawrence@tresys.com>
>>
>> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>>
>> I guess we don't build mcstrans by default and thus this wasn't noticed
>> earlier?
>>
> 
> Yep. Any reason not to include it by default?

Not that I know of.  Possibly just historical since it was originally
separate from policycoreutils and Fedora packages it separately?

> 
>>> ---
>>>  policycoreutils/mcstrans/src/mcscolor.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/policycoreutils/mcstrans/src/mcscolor.c b/policycoreutils/mcstrans/src/mcscolor.c
>>> index fdb7048..66f99d2 100644
>>> --- a/policycoreutils/mcstrans/src/mcscolor.c
>>> +++ b/policycoreutils/mcstrans/src/mcscolor.c
>>> @@ -78,11 +78,12 @@ void finish_context_colors(void) {
>>>  static int check_dominance(const char *pattern, const char *raw) {
>>>  	security_context_t ctx;
>>>  	context_t con;
>>> -	unsigned int bit = CONTEXT__CONTAINS;
>>>  	struct av_decision avd;
>>>  	int rc = -1;
>>>  	context_t my_tmp;
>>>  	const char *raw_range;
>>> +	security_class_t context_class = string_to_security_class("context");
>>> +	access_vector_t context_contains_perm = string_to_av_perm(context_class, "contains");
>>>  
>>>  	con = context_new(raw);
>>>  	if (!con)
>>> @@ -108,11 +109,11 @@ static int check_dominance(const char *pattern, const char *raw) {
>>>  	if (!raw)
>>>  		goto out;
>>>  
>>> -	rc = security_compute_av_raw(ctx, (security_context_t)raw, string_to_security_class("context"), bit, &avd);
>>> +	rc = security_compute_av_raw(ctx, (security_context_t)raw, context_class, context_contains_perm, &avd);
>>>  	if (rc)
>>>  		goto out;
>>>  
>>> -	rc = (bit & avd.allowed) != bit;
>>> +	rc = (context_contains_perm & avd.allowed) != context_contains_perm;
>>>  out:
>>>  	free(ctx);
>>>  	context_free(my_tmp);
>>>
>>
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
