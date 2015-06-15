Message-ID: <557EDF33.5060707@tycho.nsa.gov>
Date: Mon, 15 Jun 2015 10:20:35 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: Enhance file context support
References: <1434371592-2694-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1434371592-2694-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/15/2015 08:33 AM, Richard Haines wrote:
> Update file contexts generation and loading to use common code. Also fix
> to correct sort order.
> 
> The file labeling code has also had minor formatting, white space
> removal etc. changes.
> 
> These changes bring file context processing in line with Android [1]
> apart from some minor build differences.
> 
> label_file.c - Move process_line function to label_file.h
> sefcontext_compile.c - Update to use common process_line code. Now frees
> all malloc'ed memory, checked by valgrind. Also added optional -o output
> file parameter - updated man page to reflect this change.
> 
> [1] https://android-review.googlesource.com/#/c/153580/
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/man/man8/sefcontext_compile.8 |  49 +++++-
>  libselinux/src/label_file.c              | 171 +++-----------------
>  libselinux/src/label_file.h              | 156 +++++++++++++++++-
>  libselinux/src/label_internal.h          |   2 +-
>  libselinux/utils/sefcontext_compile.c    | 268 ++++++++++++++++---------------
>  5 files changed, 354 insertions(+), 292 deletions(-)
> 

> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 60aae66..1d6c36e 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
<snip>
> -	if (strcmp(context, "<<none>>") && rec->validating)
> -		compat_validate(rec, &spec_arr[nspec].lr, path, lineno);

Before, we called compat_validate(), which first checks the legacy
callbacks for set_matchpathcon_*() and then calls selabel_validate() if
those are not set.

> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index a8d1e51..814b4de 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -3,6 +3,7 @@
> +	if (strcmp(context, "<<none>>") && rec->validating) {
> +		if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {

After, we call selabel_validate() directly.
