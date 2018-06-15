To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20180609193031.2728-1-nicolas.iooss@m4x.org>
 <20180609193031.2728-3-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <048ad5b1-f187-9a57-79bf-ce39975c06d7@tycho.nsa.gov>
Date: Fri, 15 Jun 2018 09:06:16 -0400
MIME-Version: 1.0
In-Reply-To: <20180609193031.2728-3-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 3/3] libsepol/cil: use a colon instead of a semicolon to
 report rc
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/09/2018 03:30 PM, Nicolas Iooss wrote:
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied all three.

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 02259241ddfe..fb9d91745629 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -2923,7 +2923,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>  
>  					rc = cil_fill_ipaddr(pc->cl_head, ipaddr);
>  					if (rc != SEPOL_OK) {
> -						cil_log(CIL_ERR, "Failed to create anonymous ip address, rc; %d\n", rc);
> +						cil_log(CIL_ERR, "Failed to create anonymous ip address, rc: %d\n", rc);
>  						cil_destroy_ipaddr(ipaddr);
>  						goto exit;
>  					}
> 
