Message-ID: <555B3B2A.20404@tycho.nsa.gov>
Date: Tue, 19 May 2015 09:31:22 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH V3] Fix more bin file processing core dumps
References: <1432031183-3498-1-git-send-email-richard_c_haines@btinternet.com>
 <555B380D.7040905@tycho.nsa.gov>
In-Reply-To: <555B380D.7040905@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/19/2015 09:18 AM, Stephen Smalley wrote:
> On 05/19/2015 06:26 AM, Richard Haines wrote:
>> The reading of bin files has been changed to follow that of loading
>> policy to catch over-runs. Entries that should be NULL terminated are

NUL-terminated, not NULL terminated.  NUL == '\0'.  NULL == (void *)0.

>> also checked. If any error, then process the text file. This should
>> fix all problems highlighted in [1] with V2 fixing those in [2].
>> V3 corrects int32_t/uint32_t for *_len entries.
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
>> [2] http://marc.info/?l=selinux&m=143161763905159&w=2
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> ---
>>  libselinux/src/label_file.c | 204 ++++++++++++++++++++++++++++----------------
>>  libselinux/src/label_file.h |  20 ++++-
>>  2 files changed, 149 insertions(+), 75 deletions(-)
>>
>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>> index c722f29..64839e0 100644
>> --- a/libselinux/src/label_file.c
>> +++ b/libselinux/src/label_file.c
>> @@ -304,57 +300,80 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>>  	data->mmap_areas = mmap_area;
>>  
>>  	/* check if this looks like an fcontext file */
>> -	magic = (uint32_t *)addr;
>> -	if (*magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
>> +	rc = next_entry(&magic, mmap_area, sizeof(uint32_t));
>> +	if (rc < 0 || magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
>>  		return -1;
>> -	addr += sizeof(uint32_t);
>>  
>>  	/* check if this version is higher than we understand */
>> -	section_len = (uint32_t *)addr;
>> -	if (*section_len > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
>> +	rc = next_entry(&version, mmap_area, sizeof(uint32_t));
>> +	if (rc < 0 || version > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
>>  		return -1;
>> -	addr += sizeof(uint32_t);
>>  
>> -	if (*section_len >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
>> +	if (version >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
>>  		len = strlen(pcre_version());
>> -		plen = (uint32_t *)addr;
>> -		if (*plen > mmap_area->len)
>> -			return -1; /* runs off the end of the map */
>> -		if (len != *plen)
>> -			return -1; /* pcre version length mismatch */
>> -		addr += sizeof(uint32_t);
>> -		if (memcmp((char *)addr, pcre_version(), len))
>> -			return -1; /* pcre version content mismatch */
>> -		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
>> -			return -1; /* Buffer over-run */
>> -		addr += *plen;
>> +
>> +		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0 || entry_len <= 0)
>> +			return -1;
> 
> Can't be < 0 since it is uint32_t and don't need to separately check for
> == 0 because you check the length against the expected version string
> length below.
> 
>> +
>> +		/* Check version lengths */
>> +		if (len != entry_len)
>> +			return -1;
>> +
>> +		/* Check if pcre version mismatch */
>> +		str_buf = malloc(entry_len);
> 
> Need to malloc entry_len + 1 bytes in order to NUL-terminate it below
> without buffer overflow.
> Also, need to check that entry_len < UINT32_MAX before adding one to it.

Actually, you don't need the entry_len < UINT32_MAX test here because
you compare it with the expected length above already.  But you do need
it elsewhere when there is no expected length comparison and you add one
for a NUL byte.

> 
>> +		if (!str_buf)
>> +			return -1;
>> +
>> +		rc = next_entry(str_buf, mmap_area, entry_len);
>> +		if (rc < 0) {
>> +			free(str_buf);
>> +			return -1;
>> +		}
>> +
>> +		str_buf[entry_len] = 0;
> 
> Should probably be consistent, e.g. use = '\0' or = 0 throughout.
> I think the former is preferred stylistically and maybe for portability,
> although I don't know of any case where it would differ.
> 
>> +		if ((strcmp(str_buf, pcre_version()) != 0)) {
>> +			free(str_buf);
>> +			return -1;
>> +		}
>> +		free(str_buf);
>>  	}
>>  
>>  	/* allocate the stems_data array */
>> -	section_len = (uint32_t *)addr;
>> -	addr += sizeof(uint32_t);
>> +	rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
>> +	if (rc < 0 || stem_map_len <= 0)
>> +		return -1;
> 
> Can't be < 0 as it is uint32_t.
> 
>>  
>>  	/*
>>  	 * map indexed by the stem # in the mmap file and contains the stem
>>  	 * number in the data stem_arr
>>  	 */
>> -	stem_map_len = *section_len;
>>  	stem_map = calloc(stem_map_len, sizeof(*stem_map));
>>  	if (!stem_map)
>>  		return -1;
>>  
>> -	for (i = 0; i < *section_len; i++) {
>> +	for (i = 0; i < stem_map_len; i++) {
>>  		char *buf;
>>  		uint32_t stem_len;
>>  		int newid;
>>  
>>  		/* the length does not inlude the nul */
>> -		plen = (uint32_t *)addr;
>> -		addr += sizeof(uint32_t);
>> +		rc = next_entry(&stem_len, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0 || stem_len <= 0) {
>> +			rc = -1;
>> +			goto err;
>> +		}
> 
> Likewise, can't be < 0 due to type.
> 
>> +
>> +		buf = (char *)mmap_area->addr;
>> +		/* Check if buf is going to over-run before null check. */
>> +		rc = next_entry(NULL, mmap_area, (stem_len + 1));
> 
> But you should test that stem_len < UINT32_MAX before adding one to it
> so it doesn't wrap around.
> 
>> +		if (rc < 0)
>> +			goto err;
>>  
>> -		stem_len = *plen;
>> -		buf = (char *)addr;
>> -		addr += (stem_len + 1); // +1 is the nul
>> +		if (buf[stem_len] != '\0') {
>> +			rc = -1;
>> +			goto err;
>> +		}
>>  
>>  		/* store the mapping between old and new */
>>  		newid = find_stem(data, buf, stem_len);
>> @@ -370,12 +389,15 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>>  	}
>>  
>>  	/* allocate the regex array */
>> -	section_len = (uint32_t *)addr;
>> -	addr += sizeof(*section_len);
>> +	rc = next_entry(&regex_array_len, mmap_area, sizeof(uint32_t));
>> +	if (rc < 0 || regex_array_len <= 0) {
>> +		rc = -1;
>> +		goto err;
>> +	}
> 
> Can't be < 0.
> 
>>  
>> -	for (i = 0; i < *section_len; i++) {
>> +	for (i = 0; i < regex_array_len; i++) {
>>  		struct spec *spec;
>> -		int32_t stem_id;
>> +		int32_t stem_id, meta_chars;
>>  
>>  		rc = grow_specs(data);
>>  		if (rc < 0)
>> @@ -385,53 +407,89 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>>  		spec->from_mmap = 1;
>>  		spec->regcomp = 1;
>>  
>> -		plen = (uint32_t *)addr;
>> -		addr += sizeof(uint32_t);
>> -		rc = -1;
>> -		spec->lr.ctx_raw = strdup((char *)addr);
>> -		if (!spec->lr.ctx_raw)
>> +		/* Process context */
>> +		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0 || entry_len <= 0) {
>> +			rc = -1;
>>  			goto err;
>> +		}
> 
> Only need to check for entry_len != 0, < not possible.
> 
>>  
>> -		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
>> -			return -1;
>> -		addr += *plen;
>> +		str_buf = malloc(entry_len);
>> +		if (!str_buf) {
>> +			rc = -1;
>> +			goto err;
>> +		}
>> +		rc = next_entry(str_buf, mmap_area, entry_len);
>> +		if (rc < 0)
>> +			goto err;
>>  
>> -		plen = (uint32_t *)addr;
>> -		addr += sizeof(uint32_t);
>> -		spec->regex_str = (char *)addr;
>> -		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
>> -			return -1;
>> -		addr += *plen;
>> +		if (str_buf[entry_len - 1] != '\0') {
>> +			free(str_buf);
>> +			rc = -1;
>> +			goto err;
>> +		}
> 
> This is why you need the != 0 test above.
> 
>> +		spec->lr.ctx_raw = str_buf;
>> +
>> +		/* Process regex string */
>> +		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0 || entry_len <= 0) {
>> +			rc = -1;
>> +			goto err;
>> +		}
> 
> Don't need the < 0 part of the test, just != 0.
>>  
>> -		spec->mode = *(mode_t *)addr;
>> -		addr += sizeof(mode_t);
>> +		spec->regex_str = (char *)mmap_area->addr;
>> +		rc = next_entry(NULL, mmap_area, entry_len);
>> +		if (rc < 0)
>> +			goto err;
>> +
>> +		if (spec->regex_str[entry_len - 1] != '\0') {
>> +			rc = -1;
>> +			goto err;
>> +		}
>> +
>> +		/* Process mode */
>> +		rc = next_entry(&spec->mode, mmap_area, sizeof(mode_t));
>> +		if (rc < 0)
>> +			goto err;
>>  
>>  		/* map the stem id from the mmap file to the data->stem_arr */
>> -		stem_id = *(int32_t *)addr;
>> -		if (stem_id == -1 || stem_id >= stem_map_len)
>> +		rc = next_entry(&stem_id, mmap_area, sizeof(int32_t));
>> +		if (rc < 0)
>> +			goto err;
>> +
>> +		if (stem_id < 0 || stem_id >= stem_map_len)
>>  			spec->stem_id = -1;
>> -		else
>> +		 else
>>  			spec->stem_id = stem_map[stem_id];
>> -		addr += sizeof(int32_t);
>>  
>>  		/* retrieve the hasMetaChars bit */
>> -		spec->hasMetaChars = *(uint32_t *)addr;
>> -		addr += sizeof(uint32_t);
>> +		rc = next_entry(&meta_chars, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0)
>> +			goto err;
>>  
>> -		plen = (uint32_t *)addr;
>> -		addr += sizeof(uint32_t);
>> -		spec->regex = (pcre *)addr;
>> -		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
>> -			return -1;
>> -		addr += *plen;
>> +		spec->hasMetaChars = meta_chars;
>>  
>> -		plen = (uint32_t *)addr;
>> -		addr += sizeof(uint32_t);
>> -		spec->lsd.study_data = (void *)addr;
>> +		/* Process regex and study_data entries */
>> +		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0 || entry_len <= 0) {
>> +			rc = -1;
>> +			goto err;
>> +		}
> 
> Don't need the < 0 test, just != 0.
> 
>> +		spec->regex = (pcre *)mmap_area->addr;
>> +		rc = next_entry(NULL, mmap_area, entry_len);
>> +		if (rc < 0)
>> +			goto err;
> 
> Seems unsafe (we don't do anything to ensure that spec->regex is
> pointing to a valid pcre, or that its entry_len is some minimal size
> required for the underlying structure) but offhand I don't know if there
> is any function exported by libpcre that would allow us to validate it.
>  You don't have to address it; just noting it.  Was wondering if we
> could use pcre_fullinfo() to get the expected sizes and compare as we do
> when writing in sefcontext_compile(), but that presumes that re and sd
> are in fact already valid structures so I don't think it helps here.
> 
>> +
>> +		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
>> +		if (rc < 0 || entry_len <= 0) {
>> +			rc = -1;
>> +			goto err;
>> +		}
>> +		spec->lsd.study_data = (void *)mmap_area->addr;
>>  		spec->lsd.flags |= PCRE_EXTRA_STUDY_DATA;
>> -		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
>> -			return -1;
>> -		addr += *plen;
>> +		rc = next_entry(NULL, mmap_area, entry_len);
>> +		if (rc < 0)
>> +			goto err;
> 
> Likewise for spec->lsd.study_data.
> 
>>  
>>  		data->nspec++;
>>  	}
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
