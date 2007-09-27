Subject: RE: I am concerned about putting genhomedircon
	changesinlibsemanage into Fedora 8.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <200709271446.l8REkqfW010331@tex.courtesan.com>
References: <200709271446.l8REkqfW010331@tex.courtesan.com>
Content-Type: text/plain
Date: Thu, 27 Sep 2007 16:07:31 -0400
Message-Id: <1190923651.13719.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-27 at 10:46 -0400, Todd C. Miller wrote:
> Daniel J Walsh wrote:
> 
> > Already have it.
> > 
> > This is a repatch off of libsemanage-2.0.9
> > 
> > It should include your stuff plus it gets the fallback_user by looking
> > up the __default__ login record.
> > 
> > That way if I change the __default__ record to use xguest_u, it will
> > build all user accounts with this context.
> > 
> > getpwnam_r returns 0 even if an account does not exist.
> > 
> > So you need to check the pointer.
> > 
> > A couple of other translation problems also.
> 
> Unfortunately, the return values for getpwnam_r() and getpwent_r()
> are inconsistent.  While getpwnam_r() returns 0 when the user does
> not exist, getpwent_r() returns ENOENT.  I decided to deal with
> both semantics in the same way so if they are every brought into
> line the code will still do the right thing.
> 
> I made similar fixes to yours for the seuser vs. user mismatches.
> A merge of your diff and mine follows.  I added some error condition
> fixes and made the style more consistent.
> 
>  - todd
> 
> Index: libsemanage/include/semanage/handle.h
> ===================================================================
> --- libsemanage/include/semanage/handle.h	(revision 2587)
> +++ libsemanage/include/semanage/handle.h	(working copy)
> @@ -69,6 +69,10 @@
>   * 1 for yes, 0 for no (default) */
>  void semanage_set_create_store(semanage_handle_t * handle, int create_store);
>  
> +/* set whether to generate homedir file context
> + * 1 for yes (default), 0 for no */
> +void semanage_set_rebuild_file_context(semanage_handle_t * handle, int do_rebuild_file_context);

Did you mean to include this change too?  When this separate patch was
first posted, my suggestion was that the library should internally
decide whether it was necessary to do this, not the caller.  Also it
doesn't seem to be doing what it says it does anymore - it only appears
to affect validation of file contexts via setfiles (which should happen
on module installs too), not whether genhomedircon runs.

> +
>  /* Set whether or not to disable dontaudits upon commit */
>  void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
>  
> Index: libsemanage/src/handle.h
> ===================================================================
> --- libsemanage/src/handle.h	(revision 2587)
> +++ libsemanage/src/handle.h	(working copy)
> @@ -58,6 +58,7 @@
>  	int is_connected;
>  	int is_in_transaction;
>  	int do_reload;		/* whether to reload policy after commit */
> +	int do_rebuild_file_context;	/* whether to generate homedircontext */

Ditto.

>  	int do_rebuild;		/* whether to rebuild policy if there were no changes */
>  	int modules_modified;
>  	int create_store;	/* whether to create the store if it does not exist
> Index: libsemanage/src/libsemanage.map
> ===================================================================
> --- libsemanage/src/libsemanage.map	(revision 2587)
> +++ libsemanage/src/libsemanage.map	(working copy)
> @@ -9,6 +9,7 @@
>  	  semanage_module_list_nth; semanage_module_get_name;
>  	  semanage_module_get_version; semanage_select_store;
>  	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
> +	  semanage_set_rebuild_file_context;

Ditto.

>  	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
>  	  semanage_iface_*; semanage_port_*; semanage_context_*;
>  	  semanage_node_*;
> Index: libsemanage/src/genhomedircon.c
> ===================================================================
> --- libsemanage/src/genhomedircon.c	(revision 2587)
> +++ libsemanage/src/genhomedircon.c	(working copy)
<snip>
> +static int check_line(genhomedircon_settings_t * s, Ustr *line)
> +{
> +	sepol_context_t *ctx_record = NULL;
> +	const char *ctx_str;
> +	int result;
> +
> +	ctx_str = extract_context(line);
> +	if (!ctx_str)
> +		return STATUS_ERR;
> +
> +	result = sepol_context_from_string(s->h_semanage->sepolh,
> +					   ctx_str, &ctx_record);
> +	if (result == STATUS_SUCCESS && ctx_record != NULL) {
> +		sepol_msg_set_callback(s->h_semanage->sepolh, NULL, NULL);
> +		result = sepol_context_check(s->h_semanage->sepolh,
> +					     s->policydb, ctx_record);
> +		sepol_msg_set_callback(s->h_semanage->sepolh,
> +				       semanage_msg_relay_handler, NULL);

As noted elsewhere, the last NULL needs to be s->h_semanage or
subsequent calls to the relay handler will seg fault.

<snip>
> @@ -496,6 +554,36 @@
>  	free(temp);
>  }
>  
> +static char *global_fallback_user;
> +static char *global_fallback_user_prefix;

Not suitable if you want threaded callers - needs to be moved into the
genhomedircon settings (best) or made a __thread variable.

> +static char *get_fallback_user(void)
> +{
> +	return global_fallback_user;
> +}
> +
> +static char *get_fallback_user_prefix(void)
> +{
> +	return global_fallback_user_prefix;
> +}
> +
> +static int set_fallback_user(const char *user, const char *prefix)
> +{
> +	free(global_fallback_user);
> +	free(global_fallback_user_prefix);
> +	global_fallback_user = strdup(user);
> +	global_fallback_user_prefix = strdup(prefix);
> +	if (!global_fallback_user || !global_fallback_user_prefix)
> +		return -1;
> +	return 0;
> +}
> +
> +static void free_fallback_user(void)
> +{
> +	free(global_fallback_user);
> +	free(global_fallback_user_prefix);
> +}
> +
>  static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
>  					     int *errors)
>  {

> Index: libsemanage/src/semanage_store.c
> ===================================================================
> --- libsemanage/src/semanage_store.c	(revision 2587)
> +++ libsemanage/src/semanage_store.c	(working copy)
> @@ -1148,7 +1148,7 @@
>  
>        skip_reload:
>  
> -	if ((r =
> +	if (sh->do_rebuild_file_context && (r =
>  	     semanage_exec_prog(sh, sh->conf->setfiles, store_pol,

This seems wrong - the interface says it controls whether homedir
contexts are generated, but this controls whether setfiles is run to
validate the contexts (which should happen on module installs too).

>  				store_fc)) != 0) {
>  		ERR(sh, "setfiles returned error code %d.", r);
<snip>
> Index: libsemanage/src/handle.c
> ===================================================================
> --- libsemanage/src/handle.c	(revision 2587)
> +++ libsemanage/src/handle.c	(working copy)
> @@ -68,6 +68,9 @@
>  	/* By default do not create store */
>  	sh->create_store = 0;
>  
> +	/* Rebuild the file_contexts by default */
> +	sh->do_rebuild_file_context = 1;
> +
>  	/* Set timeout: some default value for now, later use config */
>  	sh->timeout = SEMANAGE_COMMIT_READ_WAIT;
>  
> @@ -100,6 +103,15 @@
>  	return;
>  }
>  
> +void semanage_set_rebuild_file_context(semanage_handle_t * sh, int do_rebuild_file_context)
> +{
> +
> +	assert(sh != NULL);
> +
> +	sh->do_rebuild_file_context = do_rebuild_file_context;
> +	return;
> +}
> +
>  void semanage_set_create_store(semanage_handle_t * sh, int create_store)
>  {

More of the rebuild file context changes, unrelated to this patch.

> Index: libsemanage/Makefile
> ===================================================================
> --- libsemanage/Makefile	(revision 2587)
> +++ libsemanage/Makefile	(working copy)
> @@ -1,6 +1,9 @@
>  all: 
>  	$(MAKE) -C src all
>  
> +swigify: 
> +	$(MAKE) -C src swigify
> +
>  pywrap: 
>  	$(MAKE) -C src pywrap

This one is fine but is logically separate.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
