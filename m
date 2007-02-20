Subject: Re: libsemanage: function name consistency change for
	semanage_get_commit_number
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: kmacmillan@mentalrootkit.com, jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <200702061626.l16GQWxi017596@localhost.localdomain>
References: <200702061626.l16GQWxi017596@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:22:50 -0500
Message-Id: <1171984970.14363.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-06 at 11:26 -0500, Caleb Case wrote:
> All functions used in the callback structs have the same ending as the functions they call.  semanage_get_commit_number was the one exception and has been changed to semanage_direct_get_serial.
> ---
>  libsemanage/src/direct_api.c     |    6 +++---
>  libsemanage/src/semanage_store.c |    4 ++--
>  libsemanage/src/semanage_store.h |    2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> Index: selinux-pms-support/libsemanage/src/direct_api.c
> ===================================================================
> --- selinux-pms-support.orig/libsemanage/src/direct_api.c
> +++ selinux-pms-support/libsemanage/src/direct_api.c
> @@ -65,7 +65,7 @@ static int semanage_direct_list(semanage
>  				int *num_modules);
>  
>  static struct semanage_policy_table direct_funcs = {
> -	.get_serial = semanage_get_commit_number,
> +	.get_serial = semanage_direct_get_serial,
>  	.destroy = semanage_direct_destroy,
>  	.disconnect = semanage_direct_disconnect,
>  	.begin_trans = semanage_direct_begintrans,
> @@ -911,7 +911,7 @@ static int semanage_direct_list(semanage
>  		goto cleanup;
>  	}
>  	if (num_mod_files == 0) {
> -		retval = semanage_get_commit_number(sh);
> +		retval = semanage_direct_get_serial(sh);
>  		goto cleanup;
>  	}
>  
> @@ -954,7 +954,7 @@ static int semanage_direct_list(semanage
>  			free(version);
>  		}
>  	}
> -	retval = semanage_get_commit_number(sh);
> +	retval = semanage_direct_get_serial(sh);
>  
>        cleanup:
>  	sepol_policy_file_free(pf);
> Index: selinux-pms-support/libsemanage/src/semanage_store.c
> ===================================================================
> --- selinux-pms-support.orig/libsemanage/src/semanage_store.c
> +++ selinux-pms-support/libsemanage/src/semanage_store.c
> @@ -1151,7 +1151,7 @@ static int semanage_commit_sandbox(seman
>  	struct stat buf;
>  
>  	/* update the commit number */
> -	if ((commit_number = semanage_get_commit_number(sh)) < 0) {
> +	if ((commit_number = semanage_direct_get_serial(sh)) < 0) {
>  		return -1;
>  	}
>  	commit_number++;
> @@ -1412,7 +1412,7 @@ void semanage_release_active_lock(semana
>  /* Read the current commit number from the commit number file which
>   * the handle is pointing, resetting the file pointer afterwards.
>   * Return it (a non-negative number), or -1 on error. */
> -int semanage_get_commit_number(semanage_handle_t * sh)
> +int semanage_direct_get_serial(semanage_handle_t * sh)
>  {
>  	char buf[32];
>  	int fd, commit_number;
> Index: selinux-pms-support/libsemanage/src/semanage_store.h
> ===================================================================
> --- selinux-pms-support.orig/libsemanage/src/semanage_store.h
> +++ selinux-pms-support/libsemanage/src/semanage_store.h
> @@ -89,7 +89,7 @@ int semanage_get_trans_lock(semanage_han
>  int semanage_get_active_lock(semanage_handle_t * sh);
>  void semanage_release_trans_lock(semanage_handle_t * sh);
>  void semanage_release_active_lock(semanage_handle_t * sh);
> -int semanage_get_commit_number(semanage_handle_t * sh);
> +int semanage_direct_get_serial(semanage_handle_t * sh);
>  
>  int semanage_link_sandbox(semanage_handle_t * sh,
>  			  sepol_module_package_t ** base);

Merged to -stable and to -trunk.  It does seem a bit odd though to have
this one function with _direct_ in the name in semanage_store.c (vs.
having it live in direct_api.c).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
