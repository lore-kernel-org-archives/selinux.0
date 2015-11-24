Subject: Re: [PATCH] libselinux: Correct line count for property and service
 contexts files
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1448286761-4903-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5654D91D.5060301@tycho.nsa.gov>
Date: Tue, 24 Nov 2015 16:39:41 -0500
MIME-Version: 1.0
In-Reply-To: <1448286761-4903-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/23/2015 08:52 AM, Richard Haines wrote:
> When a line number is displayed for context errors they are
> x2 the correct value, so reset line count for each pass.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
>   libselinux/src/label_android_property.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
> index 712eecb..fea1f8f 100644
> --- a/libselinux/src/label_android_property.c
> +++ b/libselinux/src/label_android_property.c
> @@ -132,7 +132,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>   	const char *path = NULL;
>   	FILE *fp;
>   	char line_buf[BUFSIZ];
> -	unsigned int lineno = 0, maxnspec, pass;
> +	unsigned int lineno, maxnspec, pass;
>   	int status = -1;
>   	struct stat sb;
>
> @@ -166,6 +166,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>   	maxnspec = UINT_MAX / sizeof(spec_t);
>   	for (pass = 0; pass < 2; pass++) {
>   		data->nspec = 0;
> +		lineno = 0;
>
>   		while (fgets(line_buf, sizeof(line_buf) - 1, fp)
>   		       && data->nspec < maxnspec) {
>
