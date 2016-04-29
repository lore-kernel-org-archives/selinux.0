Subject: Re: [PATCH v3 5/8] genhomedircon: Add uid and gid to struct user_entry
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461931491-25420-1-git-send-email-jason@perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <36c020fa-ee65-b24f-c5c6-5577a3822aa4@tycho.nsa.gov>
Date: Fri, 29 Apr 2016 16:28:55 -0400
MIME-Version: 1.0
In-Reply-To: <1461931491-25420-1-git-send-email-jason@perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/29/2016 08:04 AM, Jason Zaman wrote:
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> ---
>  libsemanage/src/genhomedircon.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 1a7882c..41fd7ff 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -852,7 +872,19 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
>  		}
>  		if (ignore(pwent->pw_dir))
>  			continue;
> -		if (push_user_entry(&head, name, seuname,
> +
> +		len = snprintf(uid, sizeof(uid), "%u", pwent->pw_uid);
> +		if (len < 0 || len >= sizeof(uid)) {
> +			*errors = STATUS_ERR;
> +			goto cleanup;
> +		}
> +		len = snprintf(gid, sizeof(gid), "%u", pwent->pw_gid);
> +		if (len < 0 || len >= sizeof(gid)) {
> +			*errors = STATUS_ERR;
> +			goto cleanup;
> +		}
> +
> +		if (push_user_entry(&head, name, uid, gid, seuname,
>  				    prefix, pwent->pw_dir, level) != STATUS_SUCCESS) {
>  			*errors = STATUS_ERR;
>  			break;
> 

$ make DESTDIR=~/obj clean install > make.out
genhomedircon.c: In function ‘get_users’:
genhomedircon.c:910:22: error: comparison between signed and unsigned
integer expressions [-Werror=sign-compare]
   if (len < 0 || len >= sizeof(uid)) {
                      ^
genhomedircon.c:915:22: error: comparison between signed and unsigned
integer expressions [-Werror=sign-compare]
   if (len < 0 || len >= sizeof(gid)) {
                      ^
cc1: all warnings being treated as errors
make[2]: *** [genhomedircon.o] Error 1
make[1]: *** [install] Error 2
make: *** [install] Error 1
