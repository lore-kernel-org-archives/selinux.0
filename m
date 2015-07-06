Message-ID: <559A9872.4070406@tycho.nsa.gov>
Date: Mon, 06 Jul 2015 11:02:10 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: Fix binary file labels for regexes with
 metachars
References: <1436007429-3740-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1436007429-3740-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/04/2015 06:57 AM, Richard Haines wrote:
> File labels assigned using the lookup_best_match() function do not
> assign the best match if its regex contains metacharacters in the
> binary file_contexts file version.
> 
> This change adds a new entry in the binary file with the calculated
> prefix length that is then read when processing the file. This fix
> also bumps SELINUX_COMPILED_FCONTEXT_MAX_VERS.
> 
> This patch relies on patch [1] that fixes the same problem
> for text based file_contexts files.
> 
> [1] http://marc.info/?l=selinux&m=143576498713964&w=2
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/label_file.c           | 11 ++++++++++-
>  libselinux/src/label_file.h           |  3 ++-
>  libselinux/utils/sefcontext_compile.c |  8 ++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 4faf808..b4ee15d 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -261,7 +261,7 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
>  	for (i = 0; i < regex_array_len; i++) {
>  		struct spec *spec;
>  		int32_t stem_id, meta_chars;
> -		uint32_t mode = 0;
> +		uint32_t mode = 0, prefix_len = 0;
>  
>  		rc = grow_specs(data);
>  		if (rc < 0)
> @@ -337,6 +337,15 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
>  			goto err;
>  
>  		spec->hasMetaChars = meta_chars;
> +		/* and prefix length for use by selabel_lookup_best_match */
> +		if (version >= SELINUX_COMPILED_FCONTEXT_PREFIX_LEN) {
> +			rc = next_entry(&prefix_len, mmap_area,
> +					    sizeof(uint32_t));
> +			if (rc < 0)
> +				goto err;
> +
> +			spec->prefix_len = prefix_len;
> +		}

Not opposed, but wondering if it is worth storing this versus just
recomputing it by calling spec_hasMetaChars() again.  I suppose it is
consistent with the fact that we were storing hasMetaChars in the binary
file in the first place though...

>  
>  		/* Process regex and study_data entries */
>  		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 73bcbba..1818dd6 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -12,8 +12,9 @@
>  #define SELINUX_COMPILED_FCONTEXT_NOPCRE_VERS	1
>  #define SELINUX_COMPILED_FCONTEXT_PCRE_VERS	2
>  #define SELINUX_COMPILED_FCONTEXT_MODE		3
> +#define SELINUX_COMPILED_FCONTEXT_PREFIX_LEN	4
>  
> -#define SELINUX_COMPILED_FCONTEXT_MAX_VERS	SELINUX_COMPILED_FCONTEXT_MODE
> +#define SELINUX_COMPILED_FCONTEXT_MAX_VERS	SELINUX_COMPILED_FCONTEXT_PREFIX_LEN
>  
>  /* Prior to version 8.20, libpcre did not have pcre_free_study() */
>  #if (PCRE_MAJOR < 8 || (PCRE_MAJOR == 8 && PCRE_MINOR < 20))
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
> index a93105d..4160632 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -68,6 +68,7 @@ out:
>   *	       mode_t for <= SELINUX_COMPILED_FCONTEXT_PCRE_VERS
>   *	s32  - stemid associated with the regex
>   *	u32  - spec has meta characters
> + *	u32  - The specs prefix_len if >= SELINUX_COMPILED_FCONTEXT_PREFIX_LEN
>   *	u32  - data length of the pcre regex
>   *	char - a bufer holding the raw pcre regex info
>   *	u32  - data length of the pcre regex study daya
> @@ -141,6 +142,7 @@ static int write_binary_file(struct saved_data *data, int fd)
>  		char *context = specs[i].lr.ctx_raw;
>  		char *regex_str = specs[i].regex_str;
>  		mode_t mode = specs[i].mode;
> +		size_t prefix_len = specs[i].prefix_len;
>  		int32_t stem_id = specs[i].stem_id;
>  		pcre *re = specs[i].regex;
>  		pcre_extra *sd = get_pcre_extra(&specs[i]);
> @@ -186,6 +188,12 @@ static int write_binary_file(struct saved_data *data, int fd)
>  		if (len != 1)
>  			goto err;
>  
> +		/* For SELINUX_COMPILED_FCONTEXT_PREFIX_LEN */
> +		to_write = prefix_len;
> +		len = fwrite(&to_write, sizeof(to_write), 1, bin_file);
> +		if (len != 1)
> +			goto err;
> +
>  		/* determine the size of the pcre data in bytes */
>  		rc = pcre_fullinfo(re, NULL, PCRE_INFO_SIZE, &size);
>  		if (rc < 0)
> 
