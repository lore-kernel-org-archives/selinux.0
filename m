Subject: Re: [PATCH 3/5] checkpolicy: fix memory leaks in genfscon statements
 parsing
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161226211832.7165-1-nicolas.iooss@m4x.org>
 <20161226211832.7165-3-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <177ad15b-41c7-b166-f833-562496222abe@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:27:33 -0500
MIME-Version: 1.0
In-Reply-To: <20161226211832.7165-3-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/26/2016 04:18 PM, Nicolas Iooss wrote:
> When parsing several genfscon statements for the same filesystem, the
> content of local variable "fstype" is never freed. Moreover variable
> "type" is never freed when define_genfs_context_helper() succeeds.
>
> Fix these leaks by calling free() appropriately.
>
> These leaks have been detected with gcc Address Sanitizer.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,

> ---
>  checkpolicy/policy_define.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index ff902787c2aa..780e325af65d 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -5288,6 +5288,9 @@ int define_genfs_context_helper(char *fstype, int has_type)
>  		else
>  			policydbp->genfs = newgenfs;
>  		genfs = newgenfs;
> +	} else {
> +		free(fstype);
> +		fstype = NULL;
>  	}
>
>  	newc = (ocontext_t *) malloc(sizeof(ocontext_t));
> @@ -5345,7 +5348,7 @@ int define_genfs_context_helper(char *fstype, int has_type)
>  		    (!newc->v.sclass || !c->v.sclass
>  		     || newc->v.sclass == c->v.sclass)) {
>  			yyerror2("duplicate entry for genfs entry (%s, %s)",
> -				 fstype, newc->u.name);
> +				 genfs->fstype, newc->u.name);
>  			goto fail;
>  		}
>  		len = strlen(newc->u.name);
> @@ -5359,6 +5362,7 @@ int define_genfs_context_helper(char *fstype, int has_type)
>  		p->next = newc;
>  	else
>  		genfs->head = newc;
> +	free(type);
>  	return 0;
>        fail:
>  	if (type)
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
