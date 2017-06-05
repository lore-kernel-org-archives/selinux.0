Subject: Re: [PATCH 1/1] libsepol/cil: call cil_reset_context() when context
 is not NULL
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170605114741.12279-1-nicolas.iooss@m4x.org>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <f2f59c57-f552-10cd-004c-ca31603a142e@tycho.nsa.gov>
Date: Mon, 5 Jun 2017 11:58:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170605114741.12279-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/05/2017 07:47 AM, Nicolas Iooss wrote:
> cil_reset_context() dereferences its argument, which is thus expected
> not to be NULL. The if statement in cil_reset_ibpkeycon() verified the
> opposite condition. Fix this.
> 
> This issue has been found using clang's static analyzer.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks for the report.

> ---
>   libsepol/cil/src/cil_reset_ast.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> index 73034a97956b..dd047c8e0409 100644
> --- a/libsepol/cil/src/cil_reset_ast.c
> +++ b/libsepol/cil/src/cil_reset_ast.c
> @@ -290,7 +290,7 @@ static void cil_reset_filecon(struct cil_filecon *filecon)
>   
>   static void cil_reset_ibpkeycon(struct cil_ibpkeycon *ibpkeycon)
>   {
> -	if (!ibpkeycon->context)
> +	if (ibpkeycon->context)
>   		cil_reset_context(ibpkeycon->context);
>   }
>   
> 

The real issue is that it should be checking ibpkeycon->context_str instead.

I have merged a fix crediting you with reporting the issue.

Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
