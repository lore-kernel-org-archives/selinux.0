Subject: Re: [PATCH] libsepol/cil: Provide error if classperms are empty
To: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>, selinux@tycho.nsa.gov
References: <1441911334-49764-1-git-send-email-ykhodorkovskiy@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <55F2EF88.5050403@tycho.nsa.gov>
Date: Fri, 11 Sep 2015 11:13:12 -0400
MIME-Version: 1.0
In-Reply-To: <1441911334-49764-1-git-send-email-ykhodorkovskiy@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/10/2015 02:55 PM, Yuli Khodorkovskiy wrote:
> Fixes https://github.com/SELinuxProject/cil/issues/7.
>
> This fixes a bug where cil_verify_classperms was executed on NULL
> classperms lists. A check is now performed when verifying
> classpermissions and classmap to ensure the classperms lists are not
> empty.
>
> Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>

Applied.

Thanks,
Jim

> ---
>   libsepol/cil/src/cil_verify.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 065de88..8272c0e 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -1494,13 +1494,22 @@ static int __cil_verify_classpermission(struct cil_tree_node *node)
>   	int rc = SEPOL_ERR;
>   	struct cil_classpermission *cp = node->data;
>
> +	if (cp->classperms == NULL) {
> +		cil_log(CIL_ERR, "Classpermission %s does not have a classpermissionset at line %d of %s\n", cp->datum.name, node->line, node->path);
> +		rc = SEPOL_ERR;
> +		goto exit;
> +	}
> +
>   	rc = __cil_verify_classperms(cp->classperms, &cp->datum);
>   	if (rc != SEPOL_OK) {
>   		cil_log(CIL_ERR, "Found circular class permissions involving the set %s at line %d of %s\n",cp->datum.name, node->line, node->path);
> -		return rc;
> +		goto exit;
>   	}
>
> -	return SEPOL_OK;
> +	rc = SEPOL_OK;
> +
> +exit:
> +	return rc;
>   }
>
>   struct cil_verify_map_args {
> @@ -1515,12 +1524,20 @@ static int __verify_map_perm_classperms(__attribute__((unused)) hashtab_key_t k,
>   	struct cil_verify_map_args *map_args = args;
>   	struct cil_perm *cmp = (struct cil_perm *)d;
>
> +	if (cmp->classperms == NULL) {
> +		cil_log(CIL_ERR, "Map class %s does not have a classmapping for %s at line %d of %s\n", map_args->class->datum.name, cmp->datum.name, map_args->node->line, map_args->node->path);
> +		map_args->rc = SEPOL_ERR;
> +		goto exit;
> +	}
> +
>   	rc = __cil_verify_classperms(cmp->classperms, &cmp->datum);
>   	if (rc != SEPOL_OK) {
>   		cil_log(CIL_ERR, "Found circular class permissions involving the map class %s and permission %s at line %d of %s\n", map_args->class->datum.name, cmp->datum.name, map_args->node->line, map_args->node->path);
>   		map_args->rc = SEPOL_ERR;
> +		goto exit;
>   	}
>
> +exit:
>   	return SEPOL_OK;
>   }
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
