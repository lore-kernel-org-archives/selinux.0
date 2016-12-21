Subject: Re: [PATCH 6/7] libsemanage: genhomedircon: drop ustr dependency
To: Stephen Smalley <sds@tycho.nsa.gov>
References: <20161219130404.11496-1-nicolas.iooss@m4x.org>
 <20161219130404.11496-7-nicolas.iooss@m4x.org>
 <1482172359.28570.53.camel@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <ef9a8c06-7eb5-ff65-12e5-21b2e88ab645@m4x.org>
Date: Wed, 21 Dec 2016 16:15:58 +0100
MIME-Version: 1.0
In-Reply-To: <1482172359.28570.53.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 19/12/16 19:32, Stephen Smalley wrote:
> On Mon, 2016-12-19 at 14:04 +0100, Nicolas Iooss wrote:
>> ustr library uses old (pre-C99) "extern inline" semantic. This makes
>> it
>> incompatible with recent versions of gcc and clang, which default to
>> C99 standard. Distributions have shipped patched versions of this
>> library to fix issues (e.g. Gentoo package uses this patch:
>> https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-libs/ustr/files/us
>> tr-1.0.4-gcc_5-
>> check.patch?id=7dea6f8820f36bf389e6315044bea7507553bed0
>> ) but there is no upstream solution to make ustr compatible with C99
>> standard.
>>
>> The git tree of ustr (http://www.and.org/ustr/ustr.git) has not been
>> updated since 2008 and the developer of this project did not reply to
>> emails.
>>
>> Therefore update genhomedircon implementation in order to no longer
>> rely on ustr library.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>  libsemanage/src/genhomedircon.c | 137 +++++++++++++++++++-----------
>> ----------
>>  1 file changed, 66 insertions(+), 71 deletions(-)
>>
>> diff --git a/libsemanage/src/genhomedircon.c
>> b/libsemanage/src/genhomedircon.c
>> index 5e9d7224a06e..4b7352c8648a 100644
>> --- a/libsemanage/src/genhomedircon.c
>> +++ b/libsemanage/src/genhomedircon.c
>> @@ -239,46 +238,35 @@ static int fcontext_matches(const
>> semanage_fcontext_t *fcontext, void *varg)
>>  {
>>  	const char *oexpr = semanage_fcontext_get_expr(fcontext);
>>  	fc_match_handle_t *handp = varg;
>> -	struct Ustr *expr;
>> +	char *expr = NULL;
>>  	regex_t re;
>>  	int type, retval = -1;
>> +	size_t len;
>>  
>>  	/* Only match ALL or DIR */
>>  	type = semanage_fcontext_get_type(fcontext);
>>  	if (type != SEMANAGE_FCONTEXT_ALL && type !=
>> SEMANAGE_FCONTEXT_ALL)
>>  		return 0;
>>  
>> -	/* Convert oexpr into a Ustr and anchor it at the beginning
>> */
>> -	expr = ustr_dup_cstr("^");
>> -	if (expr == USTR_NULL)
>> -		goto done;
>> -	if (!ustr_add_cstr(&expr, oexpr))
>> -		goto done;
>> +	len = strlen(oexpr);
>>  
>>  	/* Strip off trailing ".+" or ".*" */
>> -	if (ustr_cmp_suffix_cstr_eq(expr, ".+") ||
>> -	    ustr_cmp_suffix_cstr_eq(expr, ".*")) {
>> -		if (!ustr_del(&expr, 2))
>> -			goto done;
>> -	}
>> +	if (len >= 2 && oexpr[len - 2] == '.' && strchr("+*",
>> oexpr[len - 1]))
>> +		len -= 2;
>>  
>>  	/* Strip off trailing "(/.*)?" */
>> -	if (ustr_cmp_suffix_cstr_eq(expr, "(/.*)?")) {
>> -		if (!ustr_del(&expr, 6))
>> -			goto done;
>> -	}
>> +	if (len >= 6 && !strncmp(oexpr + len - 6, "(/.*)?", 6))
>> +		len -= 2;
> 
> Should be len -= 6;
> Maybe we should make this code less fragile, e.g. #define the
> expressions and use sizeof(X)-1 for the lengths in the strncmp() and -=
> statements, wrap it all up with a macro.

Thanks for your review. I have modified my patches and will send a v2
once I tested them.
For the new macro in fcontext_matches(), here is the code I am testing:

	/* Define a macro to strip a literal string from the end of oexpr */
#define rstrip_oexpr_len(cstr, cstrlen) \
	do { \
		if (len >= cstrlen && !strncmp(oexpr + len - cstrlen, cstr, cstrlen)) \
			len -= cstrlen; \
	} while (0)
#define rstrip_oexpr(cstr) rstrip_oexpr_len(cstr, sizeof(cstr) - 1)

	rstrip_oexpr(".+");
	rstrip_oexpr(".*");
	rstrip_oexpr("(/.*)?");
	rstrip_oexpr("/");

#undef rstrip_oexpr_len
#undef rstrip_oexpr


What would you think of such an implementation?

Nicolas
