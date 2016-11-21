Subject: Re: [PATCH] label_file.h: actually use the results of compat_validate
To: Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov
References: <1479506281-69690-1-git-send-email-nnk@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fa63365f-7104-b672-d85d-6962cc9b4930@tycho.nsa.gov>
Date: Mon, 21 Nov 2016 09:27:05 -0500
MIME-Version: 1.0
In-Reply-To: <1479506281-69690-1-git-send-email-nnk@google.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/18/2016 04:58 PM, Nick Kralevich wrote:
> process_line called compat_validate, but never actually looked at the
> return value. When an invalid entry is found, a warning is printed, but
> since the upper layers of the code don't see the error, validation
> appears to succeed.
> 
> Steps to reproduce on Android:
> 
> 1) Edit system/sepolicy/private/file_contexts and create an entry with
> an invalid label.
> 2) Recompile Android, which executes out/host/linux-x86/bin/checkfc to
> check if file_contexts is valid.
> 
> Expected: Compile failure.
> Actual: Compile succeeds with warnings.

Thanks, applied.

> 
> Change-Id: I20fa18c7b11b5ffdd243c3274bedc4518431e1fb
> ---
>  libselinux/src/label_file.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 00c0a5c..4ac64d5 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -467,7 +467,7 @@ static inline int process_line(struct selabel_handle *rec,
>  	spec_hasMetaChars(&spec_arr[nspec]);
>  
>  	if (strcmp(context, "<<none>>") && rec->validating)
> -		compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
> +		return compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
>  
>  	return 0;
>  }
> 
