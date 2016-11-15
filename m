Subject: Re: [PATCH] libsepol: cil: remove double-free.
To: Daniel Cashman <dcashman@android.com>, selinux@tycho.nsa.gov
References: <1478891564-11770-1-git-send-email-dcashman@android.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7651ac08-514f-cdbb-a55c-9cc08c9b757e@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 10:52:45 -0500
MIME-Version: 1.0
In-Reply-To: <1478891564-11770-1-git-send-email-dcashman@android.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/11/2016 02:12 PM, Daniel Cashman wrote:
> From: dcashman <dcashman@android.com>
> 
> Test: Untested patch.
> Bug: https://code.google.com/p/android/issues/detail?id=226519
> Change-Id: Icaf992ba1487098f2c4f16ac1017012f611281e9
> Signed-off-by: Daniel Cashman <dcashman@android.com>

Thanks, applied.

> ---
>  libsepol/cil/src/cil_binary.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 5402272..a813201 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -843,7 +843,6 @@ int cil_catalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alias)
>  	key = cil_strdup(cil_alias->datum.fqn);
>  	rc = symtab_insert(pdb, SYM_CATS, key, sepol_alias, SCOPE_DECL, 0, NULL);
>  	if (rc != SEPOL_OK) {
> -		free(key);
>  		goto exit;
>  	}
>  	sepol_alias->s.value = sepol_cat->s.value;
> 
