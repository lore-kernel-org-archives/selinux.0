Subject: Re: [PATCH] libsepol/cil: ibendportcon fails to resolve in CIL policy
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <20170612083110.5042-1-richard_c_haines@btinternet.com>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <e814dcb4-c5bf-9333-9886-89fe01645851@tycho.nsa.gov>
Date: Mon, 12 Jun 2017 11:17:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170612083110.5042-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/12/2017 04:31 AM, Richard Haines wrote:
> Fix named ibendportcon context not resolving correctly.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Applied.

Thanks,
Jim

> ---
>   libsepol/cil/src/cil_build_ast.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 4258b18..04492e5 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -4698,7 +4698,7 @@ int cil_gen_ibendportcon(__attribute__((unused)) struct cil_db *db, struct cil_t
>   	}
>   
>   	if (!parse_current->next->next->next->cl_head) {
> -		ibendportcon->context_str = parse_current->next->next->data;
> +		ibendportcon->context_str = parse_current->next->next->next->data;
>   	} else {
>   		cil_context_init(&ibendportcon->context);
>   
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
