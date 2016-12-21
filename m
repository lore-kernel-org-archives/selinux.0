Subject: Re: [PATCH 4/7] libsemanage: simplify string utilities functions
To: Stephen Smalley <sds@tycho.nsa.gov>
References: <20161219130404.11496-1-nicolas.iooss@m4x.org>
 <20161219130404.11496-5-nicolas.iooss@m4x.org>
 <1482162379.28570.29.camel@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Message-ID: <42541232-2a16-2dc8-b843-7c7e1f31fb81@m4x.org>
Date: Wed, 21 Dec 2016 16:23:18 +0100
MIME-Version: 1.0
In-Reply-To: <1482162379.28570.29.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 19/12/16 16:46, Stephen Smalley wrote:
> On Mon, 2016-12-19 at 14:04 +0100, Nicolas Iooss wrote:
>> Use string functions from C standard library instead of ustr. This
>> makes
>> the code simpler and make utilities.c no longer depend on ustr
>> library.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>  libsemanage/src/utilities.c | 64 +++++++++++++--------------------
>> ------------
>>  1 file changed, 18 insertions(+), 46 deletions(-)
>>
>> diff --git a/libsemanage/src/utilities.c
>> b/libsemanage/src/utilities.c
>> index f48ffa489d14..b5b92b085310 100644
>> --- a/libsemanage/src/utilities.c
>> +++ b/libsemanage/src/utilities.c
>> @@ -26,7 +26,6 @@
>>  #include <string.h>
>>  #include <sys/types.h>
>>  #include <assert.h>
>> -#include <ustr.h>
>>  
>>  #define TRUE 1
>>  #define FALSE 0
>> @@ -74,64 +73,37 @@ char *semanage_split_on_space(const char *str)
>>  {
>>  	/* as per the man page, these are the isspace() chars */
>>  	const char *seps = "\f\n\r\t\v ";
>> -	size_t slen = strlen(seps);
>> -	size_t off = 0, rside_len = 0;
>> -	char *retval = NULL;
>> -	Ustr *ustr = USTR_NULL, *temp = USTR_NULL;
>> +	size_t off = 0;
>>  
>>  	if (!str)
>> -		goto done;
>> -	if (!(ustr = ustr_dup_cstr(str)))
>> -		goto done;
>> -	temp =
>> -	    ustr_split_spn_chrs(ustr, &off, seps, slen, USTR_NULL,
>> -				USTR_FLAG_SPLIT_DEF);
>> -	if (!temp)
>> -		goto done;
>> -	/* throw away the left hand side */
>> -	ustr_sc_free(&temp);
>> -
>> -	rside_len = ustr_len(ustr) - off;
>> -	temp = ustr_dup_subustr(ustr, off + 1, rside_len);
>> -	if (!temp)
>> -		goto done;
>> -	retval = strdup(ustr_cstr(temp));
>> -	ustr_sc_free(&temp);
>> +		return NULL;
>>  
>> -      done:
>> -	ustr_sc_free(&ustr);
>> -	return retval;
>> +	/* skip one token and the spaces before and after it */
>> +	off = strspn(str, seps);
>> +	off += strcspn(str + off, seps);
>> +	off += strspn(str + off, seps);
>> +	return strdup(str + off);
>>  }
>>  
>>  char *semanage_split(const char *str, const char *delim)
>>  {
>> -	Ustr *ustr = USTR_NULL, *temp = USTR_NULL;
>> -	size_t off = 0, rside_len = 0;
>> -	char *retval = NULL;
>> +	char *retval;
>> +	size_t delim_len;
>>  
>>  	if (!str)
>> -		goto done;
>> +		return NULL;
>>  	if (!delim || !(*delim))
>>  		return semanage_split_on_space(str);
>> -	ustr = ustr_dup_cstr(str);
>> -	temp =
>> -	    ustr_split_cstr(ustr, &off, delim, USTR_NULL,
>> USTR_FLAG_SPLIT_DEF);
>> -	if (!temp)
>> -		goto done;
>> -	/* throw away the left hand side */
>> -	ustr_sc_free(&temp);
>> -
>> -	rside_len = ustr_len(ustr) - off;
>>  
>> -	temp = ustr_dup_subustr(ustr, off + 1, rside_len);
>> -	if (!temp)
>> -		goto done;
>> -	retval = strdup(ustr_cstr(temp));
>> -	ustr_sc_free(&temp);
>> +	retval = strstr(str, delim);
>> +	if (retval == NULL)
>> +		return NULL;
>>  
>> -      done:
>> -	ustr_sc_free(&ustr);
>> -	return retval;
>> +	delim_len = strlen(delim);
>> +	do {
>> +		retval += delim_len;
>> +	} while (!strncmp(retval, delim, delim_len));
> 
> This seems unnecessarily complicated.  Do we expect this to ever be
> called on a string containing repeating instances of the delimeter?

In the current code, semanage_split() is either called with delim=NULL
(in which case the call is "forwarded" to semanage_split_on_space()) or
with delim="=" in libsemanage/src/genhomedircon.c (in calls like path =
semanage_findval(PATH_ETC_USERADD, "HOME", "=");). In this last case, it
seems unlikely that parameter str contains several successive
occurrences of the equal sign.

I will drop this do{}while loop in the second version of this patchset.

Thanks,
Nicolas
