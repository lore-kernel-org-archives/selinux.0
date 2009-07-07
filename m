MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Patch 2/2 v7] libsemanage: maintain disable dontaudit state between handle commits
Date: Tue, 7 Jul 2009 14:21:32 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E012CD4CE@exchange2.columbia.tresys.com>
In-Reply-To: <1246990657.28321.282.camel@moss-pluto.epoch.ncsc.mil>
References: <4A5386C0.8070802@redhat.com> <1246989452.28321.277.camel@moss-pluto.epoch.ncsc.mil> <1246990001.28321.281.camel@moss-pluto.epoch.ncsc.mil> <1246990657.28321.282.camel@moss-pluto.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Christopher Pardy" <cpardy@redhat.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Tue, 2009-07-07 at 14:06 -0400, Stephen Smalley wrote:
> > On Tue, 2009-07-07 at 13:57 -0400, Stephen Smalley wrote:
> > > On Tue, 2009-07-07 at 13:32 -0400, Christopher Pardy wrote:
> > > > Currently any changes made to the policy which require 
> committing a handle cause dontaudit rules to be re-enabled. 
> This is confusing, and frustrating for users who want to edit 
> policy with dontaudit rules turned off. This patch allows 
> semanage to remember the last state of the dontaudit rules 
> and apply them as default whenever a handle is connected. 
> Additionally other functions may check for the file semanage 
> creates to determine if dontaudit rules are turned on. This 
> knowledge can be useful for tools like SETroubleshoot which 
> may want to change their behavior depending on the state of 
> the dontaudit rules. In the event that a the file cannot be 
> created a call to commit will fail.
> > > >    
> > > > Signed-off-by: Christopher Pardy <cpardy@redhat.com>
> > > 
> > > Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > > 
> > > I'll fix up the duplicate diff (you have a spelling 
> correction that 
> > > was already committed) and clean up a couple of minor 
> things when I 
> > > commit it along with the libsepol and semodule patches.
> > 
> > Oops.  I made a mistake - semanage_fname() is only the file suffix.
> > I'll switch it to use semanage_path(SEMANAGE_TMP, 
> > SEMANAGE_DISABLE_DONTAUDIT).
> 

Acked-by: Joshua Brindle <method@manicmethod.com>

> Final version of the patch.
> 
> diff --git a/libsemanage/include/semanage/handle.h 
> b/libsemanage/include/semanage/handle.h
> index 0123d1d..d56db9d 100644
> --- a/libsemanage/include/semanage/handle.h
> +++ b/libsemanage/include/semanage/handle.h
> @@ -69,6 +69,9 @@ void semanage_set_rebuild(semanage_handle_t 
> * handle, int do_rebuild);
>   * 1 for yes, 0 for no (default) */
>  void semanage_set_create_store(semanage_handle_t * handle, 
> int create_store);
>  
> +/*Get whether or not dontaudits will be disabled upon commit */ int 
> +semanage_get_disable_dontaudit(semanage_handle_t * handle);
> +
>  /* Set whether or not to disable dontaudits upon commit */  
> void semanage_set_disable_dontaudit(semanage_handle_t * 
> handle, int disable_dontaudit);
>  
> diff --git a/libsemanage/src/direct_api.c 
> b/libsemanage/src/direct_api.c index cfc1fed..56f7b05 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -20,6 +20,7 @@
>   */
>  
>  #include <sepol/module.h>
> +#include <sepol/handle.h>
>  #include <selinux/selinux.h>
>  
>  #include <assert.h>
> @@ -111,6 +112,7 @@ int 
> semanage_direct_is_managed(semanage_handle_t * sh)  int 
> semanage_direct_connect(semanage_handle_t * sh)  {
>  	char polpath[PATH_MAX];
> +	const char *path;
>  
>  	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(),
>  		 sh->conf->store_path);
> @@ -223,6 +225,13 @@ int 
> semanage_direct_connect(semanage_handle_t * sh)
>  	if (bool_activedb_dbase_init(sh, 
> semanage_bool_dbase_active(sh)) < 0)
>  		goto err;
>  
> +	/* set the disable dontaudit value */
> +	path = semanage_path(SEMANAGE_ACTIVE, 
> SEMANAGE_DISABLE_DONTAUDIT);
> +	if (access(path, F_OK) == 0)
> +		sepol_set_disable_dontaudit(sh->sepolh, 1);
> +	else
> +		sepol_set_disable_dontaudit(sh->sepolh, 0);
> +
>  	return STATUS_SUCCESS;
>  
>        err:
> @@ -645,7 +654,7 @@ static int 
> semanage_direct_commit(semanage_handle_t * sh)
>  	char **mod_filenames = NULL;
>  	char *sorted_fc_buffer = NULL, *sorted_nc_buffer = NULL;
>  	size_t sorted_fc_buffer_len = 0, sorted_nc_buffer_len = 0;
> -	const char *linked_filename = NULL, *ofilename = NULL;
> +	const char *linked_filename = NULL, *ofilename = NULL, *path;
>  	sepol_module_package_t *base = NULL;
>  	int retval = -1, num_modfiles = 0, i;
>  	sepol_policydb_t *out = NULL;
> @@ -669,6 +678,27 @@ static int 
> semanage_direct_commit(semanage_handle_t * sh)
>  	dbase_config_t *pfcontexts = semanage_fcontext_dbase_policy(sh);
>  	dbase_config_t *seusers = semanage_seuser_dbase_local(sh);
>  
> +	/* Create or remove the disable_dontaudit flag file. */
> +	path = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
> +	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
> +		FILE *touch;
> +		touch = fopen(path, "w");
> +		if (touch != NULL) {
> +			if (fclose(touch) != 0) {
> +				ERR(sh, "Error attempting to 
> create disable_dontaudit flag.");
> +				goto cleanup;
> +			}
> +		} else {
> +			ERR(sh, "Error attempting to create 
> disable_dontaudit flag.");
> +			goto cleanup;
> +		}
> +	} else {
> +		if (remove(path) == -1 && errno != ENOENT) {
> +			ERR(sh, "Error removing the 
> disable_dontaudit flag.");
> +			goto cleanup;
> +		}
> +	}
> +
>  	/* Before we do anything else, flush the join to its 
> component parts.
>  	 * This *does not* flush to disk automatically */
>  	if (users->dtable->is_modified(users->dbase)) { diff 
> --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c 
> index d677d3d..0605402 100644
> --- a/libsemanage/src/handle.c
> +++ b/libsemanage/src/handle.c
> @@ -110,6 +110,13 @@ void 
> semanage_set_create_store(semanage_handle_t * sh, int create_store)
>  	return;
>  }
>  
> +int semanage_get_disable_dontaudit(semanage_handle_t * sh) {
> +	assert(sh != NULL);
> +
> +	return sepol_get_disable_dontaudit(sh->sepolh);
> +}
> +
>  void semanage_set_disable_dontaudit(semanage_handle_t * sh, 
> int disable_dontaudit)  {
>  	assert(sh != NULL);
> diff --git a/libsemanage/src/libsemanage.map 
> b/libsemanage/src/libsemanage.map index b091344..4c2996e 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -15,7 +15,7 @@ LIBSEMANAGE_1.0 {
>  	  semanage_iface_*; semanage_port_*; semanage_context_*;
>  	  semanage_node_*;
>  	  semanage_fcontext_*; semanage_access_check; 
> semanage_set_create_store;
> -	  semanage_is_connected; semanage_set_disable_dontaudit;
> +	  semanage_is_connected; semanage_get_disable_dontaudit; 
> +semanage_set_disable_dontaudit;
>  	  semanage_mls_enabled;
>    local: *;
>  };
> diff --git a/libsemanage/src/semanage_store.c 
> b/libsemanage/src/semanage_store.c
> index 35999e0..6d4c3ce 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -114,6 +114,7 @@ static const char 
> *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
>  	"/users_extra",
>  	"/netfilter_contexts",
>  	"/file_contexts.homedirs",
> +	"/disable_dontaudit",
>  };
>  
>  /* A node used in a linked list of file contexts; used for sorting.
> diff --git a/libsemanage/src/semanage_store.h 
> b/libsemanage/src/semanage_store.h
> index 3cf33ac..112edb6 100644
> --- a/libsemanage/src/semanage_store.h
> +++ b/libsemanage/src/semanage_store.h
> @@ -58,6 +58,7 @@ enum semanage_sandbox_defs {
>  	SEMANAGE_USERS_EXTRA,
>  	SEMANAGE_NC,
>  	SEMANAGE_FC_HOMEDIRS,
> +	SEMANAGE_DISABLE_DONTAUDIT,
>  	SEMANAGE_STORE_NUM_PATHS
>  };
>  
> 
> --
> Stephen Smalley
> National Security Agency
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
