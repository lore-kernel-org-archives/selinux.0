Message-ID: <559A9829.4030308@tycho.nsa.gov>
Date: Mon, 06 Jul 2015 11:00:57 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov,
 Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH v2] libselinux: Fix file labels for regexes with metachars
References: <1435784200-36822-1-git-send-email-jeffv@google.com>
In-Reply-To: <1435784200-36822-1-git-send-email-jeffv@google.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/01/2015 04:56 PM, Jeff Vander Stoep wrote:
> File labels assigned using the lookup_best_match() function do not
> assign the best match if its regex contains metacharacters.
> 
> For non-exact regex matches, lookup_best_match() finds the closest match
> by tracking the length of the matching prefix. Prefix match is tracked via
> the prefix_len variable. This was previously calculated and set in
> the spec_hasMetaChars() function. Commit 3cb6078 removed the
> prefix_len calculation, this commit restores it.
> 
> v2 changes:
> label_file.c - set prefix_len in load_mmap. Needed for binary file_contexts
> files.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  libselinux/src/label_file.c | 2 ++
>  libselinux/src/label_file.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 4faf808..05ddbe9 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -337,6 +337,8 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
>  			goto err;
>  
>  		spec->hasMetaChars = meta_chars;
> +		if (spec->hasMetaChars)
> +			spec->prefix_len = strlen(spec->regex_str);

This doesn't seem right, as the prefix_len should be the length of the
fixed prefix prior to any meta characters.  We could either store the
prefix len as in Richard's patch or recompute it here (e.g. call
spec_hasMetaChars).

>  
>  		/* Process regex and study_data entries */
>  		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 73bcbba..30bc911 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -148,6 +148,7 @@ static inline void spec_hasMetaChars(struct spec *spec)
>  	end = c + len;
>  
>  	spec->hasMetaChars = 0;
> +	spec->prefix_len = len;
>  
>  	/* Look at each character in the RE specification string for a
>  	 * meta character. Return when any meta character reached. */
> @@ -164,6 +165,7 @@ static inline void spec_hasMetaChars(struct spec *spec)
>  		case '(':
>  		case '{':
>  			spec->hasMetaChars = 1;
> +			spec->prefix_len = c - spec->regex_str;
>  			return;
>  		case '\\':	/* skip the next character */
>  			c++;
> 
