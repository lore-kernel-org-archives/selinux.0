Message-ID: <5554C006.5040605@tycho.nsa.gov>
Date: Thu, 14 May 2015 11:32:22 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] Fix more bin file processing core dumps
References: <1431614169-7963-1-git-send-email-richard_c_haines@btinternet.com>
 <5554BF27.50407@tycho.nsa.gov>
In-Reply-To: <5554BF27.50407@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/14/2015 11:28 AM, Stephen Smalley wrote:
> On 05/14/2015 10:36 AM, Richard Haines wrote:
>> The reading of bin files has been changed to follow that of loading
>> policy to catch over-runs. Entries that should be NULL terminated are
>> also checked. If any error, then process the text file. This should
>> fix all problems highlighted in [1].
>>
>> Tested with bin files built using sefcontext_compile PCRE_VERS 1 and 2.
>>
>> The following is a rough guide to the difference in processing a bin
>> file against a text file:
>>    6K entries - x5
>>    4K entries - x4
>>    1K entries - x3
>>    500 entries - x2
>>
>> [1] http://marc.info/?l=selinux&m=143101983922281&w=2
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> ---
>>  libselinux/src/label_file.c | 167 +++++++++++++++++++++++++++-----------------
>>  libselinux/src/label_file.h |  20 +++++-
>>  2 files changed, 121 insertions(+), 66 deletions(-)
>>
>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>> index c722f29..d6103d8 100644
>> --- a/libselinux/src/label_file.c
>> +++ b/libselinux/src/label_file.c
>> @@ -8,7 +8,6 @@
>>   * developed by Secure Computing Corporation.
>>   */
>>  
>> -#include <assert.h>
>>  #include <fcntl.h>
>>  #include <stdarg.h>
>>  #include <string.h>
>> @@ -248,9 +247,9 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>>  	struct mmap_area *mmap_area;
>>  
>>  	uint32_t i;
>> -	uint32_t *magic;
>> -	uint32_t *section_len;
>> -	uint32_t *plen;
>> +	uint32_t magic[2];
>> +	uint32_t section_len[2];
>> +	uint32_t plen[2];
> 
> Why isn't this just:
> uint32_t magic, section_len, plen;
> and use &magic, &section_len, &plen in calls to next_entry() and magic,
> section_len, and plen in place of *magic, *section_len, *plen.
> 
>> @@ -304,35 +303,36 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>>  	data->mmap_areas = mmap_area;
>>  
>>  	/* check if this looks like an fcontext file */
>> -	magic = (uint32_t *)addr;
>> -	if (*magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
>> +	rc = next_entry(magic, mmap_area, sizeof(uint32_t));
>> +	if (rc < 0 || *magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
>>  		return -1;
> 
> Then this becomes:
> rc = next_entry(&magic, mmap_area, sizeof(uint32_t));
> if (rc < 0 || magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
>     return -1;
> 
> Or, alternatively, you could do it as in libsepol and declare:
> uint32_t buf[2];

Sorry, should be buf[3] in that example.

> rc = next_entry(buf, mmap_area, sizeof buf);
> and read several values at one time, e.g. the magic as buf[0], the
> version as buf[1], and either the pcre version string length or the stem
> map length as buf[2].
> 
> BTW, there is no endianness conversion here, unlike libsepol for binary
> policies?  So you have to ensure that you generate file_contexts.bin on
> the same endian architecture as you use it?  That's a bit worrisome
> although probably not an issue at the moment.  Can't change that though
> without more substantial alteration and a version change, so don't worry
> about it for now.
> 
>> -	addr += sizeof(uint32_t);
>>  
>>  	/* check if this version is higher than we understand */
>> -	section_len = (uint32_t *)addr;
>> -	if (*section_len > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
>> +	rc = next_entry(section_len, mmap_area, sizeof(uint32_t));
>> +	if (rc < 0 || *section_len > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
>>  		return -1;
> 
> Kind of strange that we reuse a variable called section_len for the
> binary file format version, the pcre string version length, and the stem
> array length.
> 
>> -	addr += sizeof(uint32_t);
>>  
>>  	if (*section_len >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
>>  		len = strlen(pcre_version());
>> -		plen = (uint32_t *)addr;
>> -		if (*plen > mmap_area->len)
>> -			return -1; /* runs off the end of the map */
>> -		if (len != *plen)
>> -			return -1; /* pcre version length mismatch */
> 
> You want to retain the length comparison before doing the memcmp.
> 
>> -		addr += sizeof(uint32_t);
>> -		if (memcmp((char *)addr, pcre_version(), len))
>> +
>> +		rc = next_entry(plen, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0)
>> +			return -1;
>> +
>> +		/* Check for over-run then safe to do memcmp */
>> +		rc = next_entry(NULL, mmap_area, *plen);
>> +		if (rc < 0)
>> +			return -1;
>> +
>> +		if (memcmp((char *)mmap_area->addr - *plen,
>> +				   pcre_version(), len))
> 
> This is a strange idiom.  I'd prefer to either allocate a string and
> copy it in, as we do in libsepol for e.g. the policydb_str, or just
> perform the length check inline first and and don't call next_entry()
> until after comparing.
> 
>> @@ -349,12 +349,16 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>>  		int newid;
>>  
>>  		/* the length does not inlude the nul */
>> -		plen = (uint32_t *)addr;
>> -		addr += sizeof(uint32_t);
>> +		rc = next_entry(plen, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0)
>> +			goto err;
>>  
>>  		stem_len = *plen;
>> -		buf = (char *)addr;
>> -		addr += (stem_len + 1); // +1 is the nul
>> +		buf = (char *)mmap_area->addr;
>> +						/* +1 for null */
>> +		rc = next_entry(NULL, mmap_area, (stem_len + 1));
>> +		if (rc < 0)
>> +			goto err;
> 
> Likewise, and where do you check that buf[stem_len] == '\0'?
> Otherwise find_stem() can run off the end.  Also, can stem_len + 1
> overflow to 0?
> 
> This btw was another mistake in the file format; should have been at
> least consistent throughout as to whether or not strings were
> NUL-terminated and no real reason to include them in the file since we
> have to verify it is NUL-terminated at load anyway - might as well just
> add it at load time too.
> 
>>  
>>  		/* store the mapping between old and new */
>>  		newid = find_stem(data, buf, stem_len);
>> @@ -370,12 +374,15 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>>  	}
>>  
>>  	/* allocate the regex array */
>> -	section_len = (uint32_t *)addr;
>> -	addr += sizeof(*section_len);
>> +	rc = next_entry(section_len, mmap_area, sizeof(uint32_t));
>> +	if (rc < 0)
>> +		goto err;
>>  
>>  	for (i = 0; i < *section_len; i++) {
>>  		struct spec *spec;
>> -		int32_t stem_id;
>> +		int32_t stem_id[2];
>> +		int32_t meta_chars[2];
> 
> Don't need arrays here either.
> 
>> +		char *str_buf;
>>  
>>  		rc = grow_specs(data);
>>  		if (rc < 0)
>> @@ -385,53 +392,85 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>>  		spec->from_mmap = 1;
>>  		spec->regcomp = 1;
>>  
>> -		plen = (uint32_t *)addr;
>> -		addr += sizeof(uint32_t);
>> -		rc = -1;
>> -		spec->lr.ctx_raw = strdup((char *)addr);
>> -		if (!spec->lr.ctx_raw)
>> +		/* Process context by malloc space plen size, check for NULL,
>> +		 * then add ptr to spec->lr.ctx_raw. */
>> +		rc = next_entry(plen, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0)
>>  			goto err;
>>  
>> -		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
>> -			return -1;
>> -		addr += *plen;
>> +		str_buf = malloc(*plen);
>> +		if (!str_buf) {
>> +			rc = -1;
>> +			goto err;
>> +		}
>> +		rc = next_entry(str_buf, mmap_area, *plen);
>> +		if (rc < 0)
>> +			goto err;
>>  
>> -		plen = (uint32_t *)addr;
>> -		addr += sizeof(uint32_t);
>> -		spec->regex_str = (char *)addr;
>> -		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
>> -			return -1;
>> -		addr += *plen;
>> +		if (strlen(str_buf) != *plen - 1) {
> 
> No, check that str_buf[*plen-1] == '\0'; strlen(str_buf) will run off
> the end, potentially unbounded, if not terminated.
> 
>> +			free(str_buf);
>> +			rc = -1;
>> +			goto err;
>> +		}
>> +		spec->lr.ctx_raw = str_buf;
>> +
>> +		/* Process regex string by adding addr to spec->regex_str,
>> +		 * skip over entry to catch over-runs, then check if
>> +		 * NULL terminated. */
>> +		rc = next_entry(plen, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0)
>> +			goto err;
>>  
>> -		spec->mode = *(mode_t *)addr;
>> -		addr += sizeof(mode_t);
>> +		spec->regex_str = (char *)mmap_area->addr;
>> +		rc = next_entry(NULL, mmap_area, *plen);
>> +		if (rc < 0)
>> +			goto err;
>> +
>> +		if (strlen(spec->regex_str) != *plen - 1) {
>> +			rc = -1;
>> +			goto err;
>> +		}
> 
> Same as above.
> 
