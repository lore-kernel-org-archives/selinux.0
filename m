Message-ID: <1495112377.5475.2.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] libsepol: remove unused attribute on a used argument
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Thu, 18 May 2017 08:59:37 -0400
In-Reply-To: <20170517205324.18805-1-nicolas.iooss@m4x.org>
References: <20170517205324.18805-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-17 at 22:53 +0200, Nicolas Iooss wrote:
> Since commit 58962eb3d847 ("libsepol,checkpolicy: add binary module
> support for xperms") function display_avrule() has been using its "p"
> argument even though it was previously marked unused. This makes
> clang
> report:
> 
>     policydb.c:3276:7: error: 'p' was marked unused but was used
>     [-Werror,-Wused-but-marked-unused].
>         if (p->policyvers < MOD_POLICYDB_VERSION_XPERMS_IOCTL) {
>             ^
> 
> Remove the attribute to make the code consistent again.

Applied with corrected description.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/policydb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 069eb7e66540..b1530955aa39 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -3212,8 +3212,7 @@ common_read, class_read, role_read, type_read,
> user_read,
>  
>  /************** module reading functions below **************/
>  
> -static avrule_t *avrule_read(policydb_t * p
> -			     __attribute__ ((unused)), struct
> policy_file *fp)
> +static avrule_t *avrule_read(policydb_t * p, struct policy_file *fp)
>  {
>  	unsigned int i;
>  	uint32_t buf[2], len;
