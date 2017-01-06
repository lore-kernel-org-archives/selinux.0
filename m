Subject: Re: [PATCH 1/5] checkpolicy: fix memory usage in define_bool_tunable()
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161226211832.7165-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <fcf6b777-6c91-cef4-9337-d512141614c1@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:23:49 -0500
MIME-Version: 1.0
In-Reply-To: <20161226211832.7165-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/26/2016 04:18 PM, Nicolas Iooss wrote:
> In an error path of define_bool_tunable(), variable id is freed after
> being used by a successful call to declare_symbol(). This may cause
> trouble as this pointer may have been used as-is in the policy symtab
> hash table.
>
> Moreover bool_value is never freed after being used. Fix this memory
> leak too. This leak has been detected with gcc Address Sanitizer.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,

> ---
>  checkpolicy/policy_define.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 864788992e5c..2ad98c3c851e 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1704,11 +1704,11 @@ int define_bool_tunable(int is_tunable)
>  	bool_value = (char *)queue_remove(id_queue);
>  	if (!bool_value) {
>  		yyerror("no default value for bool definition?");
> -		free(id);
>  		return -1;
>  	}
>
>  	datum->state = (int)(bool_value[0] == 'T') ? 1 : 0;
> +	free(bool_value);
>  	return 0;
>        cleanup:
>  	cond_destroy_bool(id, datum, NULL);
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
