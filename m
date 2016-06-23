Subject: Re: [PATCH] checkpolicy: Fix typos in test/dispol
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1466423441-32172-1-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <31bf2f9c-af58-e28d-ebda-b17752c57ed8@tycho.nsa.gov>
Date: Thu, 23 Jun 2016 13:05:04 -0400
MIME-Version: 1.0
In-Reply-To: <1466423441-32172-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/20/2016 07:50 AM, Petr Lautrbach wrote:
> Reported-By: Milos Malik <mmalik@redhat.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  checkpolicy/test/dispol.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks, applied.

> 
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index 86f5688..a78ce81 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -252,11 +252,11 @@ int display_cond_expressions(policydb_t * p, FILE * fp)
>  int display_handle_unknown(policydb_t * p, FILE * out_fp)
>  {
>  	if (p->handle_unknown == ALLOW_UNKNOWN)
> -		fprintf(out_fp, "Allow unknown classes and permisions\n");
> +		fprintf(out_fp, "Allow unknown classes and permissions\n");
>  	else if (p->handle_unknown == DENY_UNKNOWN)
> -		fprintf(out_fp, "Deny unknown classes and permisions\n");
> +		fprintf(out_fp, "Deny unknown classes and permissions\n");
>  	else if (p->handle_unknown == REJECT_UNKNOWN)
> -		fprintf(out_fp, "Reject unknown classes and permisions\n");
> +		fprintf(out_fp, "Reject unknown classes and permissions\n");
>  	return 0;
>  }
>  
> @@ -349,7 +349,7 @@ int menu(void)
>  	printf("\nSelect a command:\n");
>  	printf("1)  display unconditional AVTAB\n");
>  	printf("2)  display conditional AVTAB (entirely)\n");
> -	printf("3)  display conditional AVTAG (only ENABLED rules)\n");
> +	printf("3)  display conditional AVTAB (only ENABLED rules)\n");
>  	printf("4)  display conditional AVTAB (only DISABLED rules)\n");
>  	printf("5)  display conditional bools\n");
>  	printf("6)  display conditional expressions\n");
> 
