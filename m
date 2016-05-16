Subject: Re: [PATCH] checkpolicy: Fix checkmodule output message
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1463414965-5639-1-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0d491e44-9766-5616-ef40-38468b4ce292@tycho.nsa.gov>
Date: Mon, 16 May 2016 16:46:59 -0400
MIME-Version: 1.0
In-Reply-To: <1463414965-5639-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/16/2016 12:09 PM, Petr Lautrbach wrote:
> Originally checkmodule stated that it wrote to the input file instead of
> to the output file.

Thanks, applied.

> 
> Reported-By: Milos Malik <mmalik@redhat.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  checkpolicy/checkmodule.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
> index 418f77b..53cc5a0 100644
> --- a/checkpolicy/checkmodule.c
> +++ b/checkpolicy/checkmodule.c
> @@ -314,7 +314,7 @@ int main(int argc, char **argv)
>  
>  		if (!cil) {
>  			printf("%s:  writing binary representation (version %d) to %s\n",
> -				   argv[0], policyvers, file);
> +				   argv[0], policyvers, outfile);
>  
>  			if (write_binary_policy(&modpolicydb, outfp) != 0) {
>  				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
> 
