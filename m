Subject: Re: [PATCH 1/7] libsepol: do not dereference a NULL pointer when
 stack_init() fails
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170328214152.17545-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <590c3842-e11e-f47d-fe1f-40ace94abf6e@tycho.nsa.gov>
Date: Wed, 29 Mar 2017 14:02:15 -0400
MIME-Version: 1.0
In-Reply-To: <20170328214152.17545-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/28/2017 05:41 PM, Nicolas Iooss wrote:
> In cond_expr_to_cil() when stack_init(&stack) fails, stack is set to
> NULL and the execution flow jumps to label "exit". This triggers a call
> to stack_pop(stack) which dereferences a NULL pointer in "if (stack->pos
> == -1)".
>
> This issue has been found using clang's static analyzer.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I applied these seven patches.

Thanks,
Jim

> ---
>  libsepol/src/module_to_cil.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 308ada4f1381..5c98c29bcf13 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1363,11 +1363,12 @@ exit:
>  	free(new_val);
>  	free(val1);
>  	free(val2);
> -	while ((val1 = stack_pop(stack)) != NULL) {
> -		free(val1);
> +	if (stack != NULL) {
> +		while ((val1 = stack_pop(stack)) != NULL) {
> +			free(val1);
> +		}
> +		stack_destroy(&stack);
>  	}
> -	stack_destroy(&stack);
> -
>  	return rc;
>  }
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
