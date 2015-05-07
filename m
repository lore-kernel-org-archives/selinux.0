Message-ID: <554B9FB5.40408@tycho.nsa.gov>
Date: Thu, 07 May 2015 13:24:05 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: Fix core dumps with corrupt *.bin files
References: <1431009653-7230-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1431009653-7230-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/07/2015 10:40 AM, Richard Haines wrote:
> Check buffer address limits when processing *.bin files
> to catch any over-runs. On failure process text file instead.
> 
> To test, the bin files were corrupted by adding and removing
> various bits of data. Various file sizes were also checked and
> all were caught by the patch.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied, but see below.

> ---
>  libselinux/src/label_file.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index b3e5671..c722f29 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -325,6 +325,8 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>  		addr += sizeof(uint32_t);
>  		if (memcmp((char *)addr, pcre_version(), len))
>  			return -1; /* pcre version content mismatch */
> +		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
> +			return -1; /* Buffer over-run */

Technically this is too late; it already read *plen bytes starting at
addr via the memcmp above.  Also, what happens if *plen is large and
(addr + *plen) overflows?  Compare with the checking performed on every
fetch from the policy image via next_entry() in libsepol in the
PF_USE_MEMORY case, which is likewise loading from an in-memory policy
whether mmap'd or otherwise.

>  		addr += *plen;
>  	}
>  
> @@ -390,11 +392,15 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>  		if (!spec->lr.ctx_raw)
>  			goto err;
>  
> +		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
> +			return -1;

Similarly, too late.  Worse, the preceding code did a strdup() on the
addr without ever validating that it was NUL terminated.  Also seem to
be missing corresponding checking for the earlier stem reading code.

>  		addr += *plen;
>  
>  		plen = (uint32_t *)addr;
>  		addr += sizeof(uint32_t);
>  		spec->regex_str = (char *)addr;
> +		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
> +			return -1;

Not too late since we haven't yet dereferenced it, but no validation
that regex_str is NUL-terminated.

>  		addr += *plen;
>  
>  		spec->mode = *(mode_t *)addr;
> @@ -415,12 +421,16 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>  		plen = (uint32_t *)addr;
>  		addr += sizeof(uint32_t);
>  		spec->regex = (pcre *)addr;
> +		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
> +			return -1;
>  		addr += *plen;
>  
>  		plen = (uint32_t *)addr;
>  		addr += sizeof(uint32_t);
>  		spec->lsd.study_data = (void *)addr;
>  		spec->lsd.flags |= PCRE_EXTRA_STUDY_DATA;
> +		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
> +			return -1;
>  		addr += *plen;
>  
>  		data->nspec++;
> 
