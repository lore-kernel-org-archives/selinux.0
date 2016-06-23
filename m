Subject: Re: [PATCH] libselinux: compare absolute pathname in matchpathcon -V
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1466431818-20937-1-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <defd6e4d-0485-4fae-0c3c-aa79a5a10ced@tycho.nsa.gov>
Date: Thu, 23 Jun 2016 13:06:57 -0400
MIME-Version: 1.0
In-Reply-To: <1466431818-20937-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/20/2016 10:10 AM, Petr Lautrbach wrote:
> filepath needs to be resolved first in order to be correctly found by
> selabel_lookup_raw()
> 
> Fixes:
> $ matchpathcon -V passwd
> passwd has context system_u:object_r:passwd_file_t:s0, should be
> system_u:object_r:passwd_file_t:s0
> 
> $ echo $?
> 1
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
>  libselinux/src/matchpathcon.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> index 3868711..a2f2c3e 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -471,6 +471,17 @@ int selinux_file_context_verify(const char *path, mode_t mode)
>  	char * con = NULL;
>  	char * fcontext = NULL;
>  	int rc = 0;
> +	char stackpath[PATH_MAX + 1];
> +	char *p = NULL;
> +
> +	if (S_ISLNK(mode)) {
> +		if (!realpath_not_final(path, stackpath))
> +			path = stackpath;
> +	} else {
> +		p = realpath(path, stackpath);
> +		if (p)
> +			path = p;
> +	}
>  
>  	rc = lgetfilecon_raw(path, &con);
>  	if (rc == -1) {
> 
