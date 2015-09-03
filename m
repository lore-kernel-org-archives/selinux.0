Subject: Re: [PATCH] libsemanage: store users_extra in the policy store
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <1441305154-29073-1-git-send-email-slawrence@tresys.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55E89F6E.5090303@tycho.nsa.gov>
Date: Thu, 3 Sep 2015 15:28:46 -0400
MIME-Version: 1.0
In-Reply-To: <1441305154-29073-1-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/03/2015 02:32 PM, Steve Lawrence wrote:
> users_extra is needed by genhomedircon and when listing seusers, so it
> must be kept in the policy store. Also move the FC_TMPL unlink() closer
> to where the FC_TMPL is created; not a functional change, but eaiser to
> follow.
> 
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Well, I actually acked the previous one, but this one's fine too.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  libsemanage/src/direct_api.c             | 7 +++----
>  libsemanage/utils/semanage_migrate_store | 1 +
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 6e49cae..68dd0d1 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1272,6 +1272,9 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>  		if (retval < 0)
>  			goto cleanup;
>  
> +		/* remove FC_TMPL now that it is now longer needed */
> +		unlink(semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL));
> +
>  		pfcontexts->dtable->drop_cache(pfcontexts->dbase);
>  
>  		/* SEUsers */
> @@ -1413,10 +1416,6 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>  	sepol_policydb_free(out);
>  	out = NULL;
>  
> -	/* remove files that are automatically generated and no longer needed */
> -	unlink(semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL));
> -	unlink(semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA));
> -
>  	if (sh->do_rebuild || modified || bools_modified || fcontexts_modified) {
>  		retval = semanage_install_sandbox(sh);
>  	}
> diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
> index 297c71b..b5eefaa 100755
> --- a/libsemanage/utils/semanage_migrate_store
> +++ b/libsemanage/utils/semanage_migrate_store
> @@ -247,6 +247,7 @@ if __name__ == "__main__":
>  		"file_contexts.local",
>  		"seusers",
>  		"users.local",
> +		"users_extra",
>  		"users_extra.local",
>  		"disable_dontaudit",
>  		"preserve_tunables",
> 
