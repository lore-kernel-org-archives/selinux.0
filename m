Subject: Re: [PATCH 1/1] libselinux: audit2why: remove unused module_state
 structure
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161117214356.22792-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <44fdb827-bfff-cdb0-87a7-044f8d6fa684@tycho.nsa.gov>
Date: Fri, 18 Nov 2016 08:55:58 -0500
MIME-Version: 1.0
In-Reply-To: <20161117214356.22792-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/17/2016 04:43 PM, Nicolas Iooss wrote:
> This structure has been empty since its introduction and makes clang
> complain when $(filter-out -Werror, $(CFLAGS)) is removed in the
> Makefile target for audit2why.lo:
> 
>     audit2why.c:443:1: error: empty struct has size 0 in C, size 1 in
>     C++ [-Werror,-Wc++-compat]
>       struct module_state {
>       ^
>       1 error generated.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>  libselinux/src/audit2why.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index abe1701616fc..3d312a10a589 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -440,14 +440,11 @@ static PyMethodDef audit2whyMethods[] = {
>  
>  #if PY_MAJOR_VERSION >= 3
>  /* Module-initialization logic specific to Python 3 */
> -struct module_state {
> -	/* empty for now */
> -};
>  static struct PyModuleDef moduledef = {
>  	PyModuleDef_HEAD_INIT,
>  	"audit2why",
>  	NULL,
> -	sizeof(struct module_state),
> +	0,
>  	audit2whyMethods,
>  	NULL,
>  	NULL,
> 
