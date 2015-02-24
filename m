Message-ID: <54ECACC5.9070303@tycho.nsa.gov>
Date: Tue, 24 Feb 2015 11:54:29 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux:  label_file:  handle newlines in file names
References: <1424792581-17675-1-git-send-email-sds@tycho.nsa.gov>
 <54ECAA93.50602@tresys.com>
In-Reply-To: <54ECAA93.50602@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/24/2015 11:45 AM, Steve Lawrence wrote:
> On 02/24/2015 10:43 AM, Stephen Smalley wrote:
>> From: Nick Kralevich <nnk@google.com>
>>
>> restorecon on file names with newlines are not handled properly.
>> Use PCRE_DOTALL so that dots in regular expressions match all
>> characters, and don't exclude the newline character.
>>
>> See https://www.mail-archive.com/seandroid-list@tycho.nsa.gov/msg02001.html
>> for background.
>>
>> Change-Id: I0dde8f2567305f746d19ebd75a9e2add7406eb9a
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  libselinux/src/label_file.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>> index 71b085a..9d116eb 100644
>> --- a/libselinux/src/label_file.c
>> +++ b/libselinux/src/label_file.c
>> @@ -129,7 +129,7 @@ static int compile_regex(struct saved_data *data, struct spec *spec, const char
>>  	*cp = '\0';
>>  
>>  	/* Compile the regular expression. */
>> -	spec->regex = pcre_compile(anchored_regex, 0, &tmperrbuf, &erroff, NULL);
>> +	spec->regex = pcre_compile(anchored_regex, PCRE_DOTALL, &tmperrbuf, &erroff, NULL);
>>  	free(anchored_regex);
>>  	if (!spec->regex) {
>>  		if (errbuf)
>>
> 
> Do we need a similar change in sefcontext_compile.c? It also looks like
> mcstrans compiles regular expressions, but I don't think those are
> related to matching paths.

Yes for sefcontext_compile.c (doesn't exist in Android's libselinux,
which does not yet include the file_contexts.bin support).
