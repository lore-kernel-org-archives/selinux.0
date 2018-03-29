To: Yuli Khodorkovskiy <ykhodo@gmail.com>, selinux@tycho.nsa.gov
References: <20180329034003.2231-1-ykhodo@gmail.com>
 <20180329034003.2231-2-ykhodo@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f2409ffd-fc1e-f1ac-6618-740130a87d96@tycho.nsa.gov>
Date: Thu, 29 Mar 2018 08:37:14 -0400
MIME-Version: 1.0
In-Reply-To: <20180329034003.2231-2-ykhodo@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2 1/2] libselinux: verify file_contexts when using
 restorecon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/28/2018 11:40 PM, Yuli Khodorkovskiy wrote:
> In permissive mode, calling restorecon with a bad label in file_contexts
> does not verify the label's existence in the loaded policy. This
> results in any label successfully applying to a file, as long as the
> file exists.
> 
> This issue has two assumptions:
> 
> 1) file_contexts must be manually updated with the invalid label.
> Running `semanage fcontext` will error when attempting to add
> an invalid label to file_contexts.
> 2) the system must be in permissive. Although applying an invalid label
> in enforcing gives an error and fails, successfully labeling a file with a
> bad label could cause issues during policy development in permissive.
> 
> Instead, as each context is used, verify it is valid before blindly
> applying the label. If an error with validation occurs in restorecon,
> application of remaining valid labels will be uninterrupted as before.
> 
> Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>
> ---
>  libselinux/src/label.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 48f4d2d6..e642a97b 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -126,7 +126,7 @@ int selabel_validate(struct selabel_handle *rec,
>  {
>  	int rc = 0;
>  
> -	if (!rec->validating || contexts->validated)
> +	if (contexts->validated)
>  		goto out;
>  
>  	rc = selinux_validate(&contexts->ctx_raw);
> 

label.c: In function ‘selabel_validate’:
label.c:124:45: error: unused parameter ‘rec’ [-Werror=unused-parameter]
 int selabel_validate(struct selabel_handle *rec,
                                             ^~~
Need to drop the rec argument to selabel_validate() since it is no longer used.
