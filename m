Message-ID: <559A97CB.9090302@tycho.nsa.gov>
Date: Mon, 06 Jul 2015 10:59:23 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: Fix file labels for regexes with metachars
References: <1435764673-33925-1-git-send-email-jeffv@google.com>
In-Reply-To: <1435764673-33925-1-git-send-email-jeffv@google.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/01/2015 11:31 AM, Jeff Vander Stoep wrote:
> File labels assigned using the lookup_best_match() function do not
> assign the best match if its regex contains metacharacters.
> 
> For non-exact regex matches, lookup_best_match() finds the closest match
> by tracking the length of the matching prefix. Prefix match is tracked via
> the prefix_len variable. This was previously calculated and set in
> the spec_hasMetaChars() function. Commit 3cb6078 removed the
> prefix_len calculation, this commit restores it.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Thanks, applied.

> ---
>  libselinux/src/label_file.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
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
