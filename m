Message-ID: <1484336691.32375.70.camel@tycho.nsa.gov>
Subject: Re: [PATCH] policy_define.c: don't free memory returned from
 queue_head()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov
Date: Fri, 13 Jan 2017 14:44:51 -0500
In-Reply-To: <20170113191559.12505-1-nnk@google.com>
References: <20170113191559.12505-1-nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-01-13 at 11:15 -0800, Nick Kralevich wrote:
> Unlike queue_remove(), queue_head() does not modify the queue, but
> rather, returns a pointer to an element within the queue. Freeing the
> memory associated with a value returned from that function corrupts
> subsequent users of the queue, who may try to reference this
> now-deallocated memory.
> 
> This causes the following policy generation errors on Android:
> 
>   FAILED:
>  
> out/target/product/bullhead/obj/ETC/plat_sepolicy.cil_intermediates/p
> lat_policy_nvr.cil
>   /bin/bash -c "out/host/linux-x86/bin/checkpolicy -M -C -c 30 -o
>  
> out/target/product/bullhead/obj/ETC/plat_sepolicy.cil_intermediates/p
> lat_policy_nvr.cil
>  
> out/target/product/bullhead/obj/ETC/plat_sepolicy.cil_intermediates/p
> lat_policy.conf"
>   system/sepolicy/public/app.te:241:ERROR 'only ioctl extended
> permissions
>   are supported' at token ';' on line 6784:
>   #line 241
>   } };
>   checkpolicy:  error(s) encountered while parsing configuration
> 
> because the value of "id" in:
> 
>   id = queue_remove(id_queue);
>   if (strcmp(id,"ioctl") == 0) {
>     ...
>   } else {
>     yyerror("only ioctl extended permissions are supported");
>     ...
>   }
> 
> is now garbage.
> 
> This is a partial revert of the following commit:
> 
>   c1ba8311 checkpolicy: free id where it was leaked

Thanks, applied.

> 
> Signed-off-by: Nick Kralevich <nnk@google.com>
> ---
>  checkpolicy/policy_define.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/checkpolicy/policy_define.c
> b/checkpolicy/policy_define.c
> index d158ad0..6bfadbe 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2012,7 +2012,6 @@ int define_te_avtab_xperms_helper(int which,
> avrule_t ** rule)
>  		    (class_perm_node_t *)
> malloc(sizeof(class_perm_node_t));
>  		if (!cur_perms) {
>  			yyerror("out of memory");
> -			free(id);
>  			ret = -1;
>  			goto out;
>  		}
> @@ -2048,7 +2047,6 @@ int define_te_avtab_xperms_helper(int which,
> avrule_t ** rule)
>  		}
>  	}
>  
> -	free(id);
>  	ebitmap_destroy(&tclasses);
>  
>  	avrule->perms = perms;
