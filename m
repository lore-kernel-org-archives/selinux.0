To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <20180412102601.32191-1-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <22b8ccd4-1a6c-0a5a-ecfc-b17853027545@tycho.nsa.gov>
Date: Thu, 12 Apr 2018 11:07:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180412102601.32191-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] libsemanage: do not change file mode of seusers and
 users_extra
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/12/2018 06:26 AM, Vit Mojzis wrote:
> Commit 8702a865e08b5660561e194a83e4a363061edc03 causes file mode of
> seusers and users_extra to change based on the value defined in config
> file whenever direct_commit is called and policy is not rebuilt.
> (e.g. when setting a boolean).
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1512639

I think this patch is correct and expect to apply it, but am left wondering about the permissions
on /var/lib/selinux/targeted in general.  It appears that we are inconsistent in our file modes
on files under /var/lib/selinux/targeted/active, e.g. file_contexts.homedirs, *.local, and modules/*/* are 0644,
whereas other files are 0600.  Of course, given that the directories are 0600, only root can even lookup files under
these directories regardless of their individual file modes so it isn't as though those files are truly accessible.
Looks like there are other uses of sh->conf->file_mode that are suspect in semanage_direct_commit() for files
in the store, whereas I think it should only be used for installed files (i.e. /etc/selinux/targeted/*).

> 
> $ ll /var/lib/selinux/targeted/active/users_extra
> -rw-------. 1 root root 101 11. dub 17.31 /var/lib/selinux/targeted/active/users_extra
> $ ll /var/lib/selinux/targeted/active/seusers
> -rw-------. 1 root root 73 11. dub 17.31 /var/lib/selinux/targeted/active/seusers
> $ semanage boolean -m --on httpd_can_network_connect
> $ ll /var/lib/selinux/targeted/active/seusers
> -rw-r--r--. 1 root root 73 23. bře 16.59 /var/lib/selinux/targeted/active/seusers
> $ ll /var/lib/selinux/targeted/active/users_extra
> -rw-r--r--. 1 root root 101 23. bře 16.59 /var/lib/selinux/targeted/active/users_extra
> $ rpm -Vq selinux-policy-targeted
> .M.....T.    /var/lib/selinux/targeted/active/seusers
> .M.....T.    /var/lib/selinux/targeted/active/users_extra
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsemanage/src/direct_api.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index e7ec952f..c58961be 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1481,7 +1481,7 @@ rebuild:
>  			retval = semanage_copy_file(path,
>  						    semanage_path(SEMANAGE_TMP,
>  								  SEMANAGE_STORE_SEUSERS),
> -						    sh->conf->file_mode);
> +						    0);
>  			if (retval < 0)
>  				goto cleanup;
>  			pseusers->dtable->drop_cache(pseusers->dbase);
> @@ -1499,7 +1499,7 @@ rebuild:
>  			retval = semanage_copy_file(path,
>  						    semanage_path(SEMANAGE_TMP,
>  								  SEMANAGE_USERS_EXTRA),
> -						    sh->conf->file_mode);
> +						    0);
>  			if (retval < 0)
>  				goto cleanup;
>  			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
> 
