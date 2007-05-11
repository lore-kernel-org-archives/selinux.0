Subject: Re: [RFC][PATCH] libselinux: Namespacing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1178887321.3504.152.camel@moss-spartans.epoch.ncsc.mil>
References: <1178827922.3504.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1178835154.12294.151.camel@code.and.org>
	 <1178887321.3504.152.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 11 May 2007 08:47:52 -0400
Message-Id: <1178887672.3504.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-11 at 08:42 -0400, Stephen Smalley wrote:
> On Thu, 2007-05-10 at 18:12 -0400, James Antill wrote:
> > On Thu, 2007-05-10 at 16:12 -0400, Stephen Smalley wrote:
> > > libselinux presently lacks proper namespacing of its functions.  This
> > > patch is just for comment on an approach to gradually fixing that
> > > problem, starting with just a trivial example for a single function.
> > > The idea is to switch over the real function to being properly
> > > namespaced, provide an alias under the old name in the symbol table for
> > > binary compatibility, and make the old name a macro in the public
> > > headers that expands to the new name so that source rebuilds against the
> > > new library will start using the new name.  Then at some point in the
> > > future, we drop the old name macro from the source API, forcing an
> > > update to external sources to build against newer headers, while leaving
> > > the alias present in the symbol table as long as we need compatibility
> > > with existing binaries.  Thoughts?
> > 
> >  The one thing I'd suggest is having some kind of compiler switch we can
> > use before we turn it off. For instance something like...
> > 
> > 
> > #ifndef SELINUX_COMPAT_API
> > #define SELINUX_COMPAT_API 1
> > #endif
> > 
> > #if SELINUX_COMPAT_API
> > 
> > /* ... */
> > #define freecon(x) selinux_freecon(x)
> > #endif
> > 
> > ...then we can move certain packages over immediately, and do "#define
> > SELINUX_COMPAT_API 0" in them ... and also change the default at some
> > point, but allow people to still access the compat. macros for a short
> > time.
> 
> And possibly use #error on the #else branch to give a useful diagnostic,
> e.g.:
> 
> Index: policyrep/libselinux/include/selinux/selinux.h
> ===================================================================
> --- policyrep/libselinux/include/selinux/selinux.h	(revision 2435)
> +++ policyrep/libselinux/include/selinux/selinux.h	(working copy)
> @@ -4,6 +4,10 @@
>  #include <sys/types.h>
>  #include <stdarg.h>
>  
> +#ifndef SELINUX_COMPAT_API
> +#define SELINUX_COMPAT_API 1
> +#endif
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> @@ -16,7 +20,12 @@
>  	typedef char *security_context_t;
>  
>  /* Free the memory allocated for a context by any of the below get* calls. */
> -	extern void freecon(security_context_t con);
> +	extern void selinux_freecon(security_context_t con);
> +#if SELINUX_COMPAT_API
> +#define freecon(c) selinux_freecon(c)
> +#else
> +#error "freecon replaced by selinux_freecon; please update callers."
> +#endif

Oops, that won't work.  Any way to embed an #error within a #define, so
that we can trigger the #error only upon encountering a freecon(x)?

>  
>  /* Free the memory allocated for a context array by security_compute_user. */
>  	extern void freeconary(security_context_t * con);
> 
> >  Also we really want to have some perl/whatever that goes through the
> > public API looking for symbols ... so we only have to do it once.
> 
> I was considering adding an explicit export map for libselinux, like we
> already have for libsepol and libsemanage, ala:
> 
> ---
> 
>  libselinux/src/Makefile       |    2 
>  libselinux/src/libselinux.map |  173 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+), 1 deletion(-)
> 
> Index: policyrep/libselinux/src/Makefile
> ===================================================================
> --- policyrep/libselinux/src/Makefile	(revision 2429)
> +++ policyrep/libselinux/src/Makefile	(working copy)
> @@ -48,7 +48,7 @@
>  	$(CC) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
>  
>  $(LIBSO): $(LOBJS)
> -	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
> +	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro
>  	ln -sf $@ $(TARGET) 
>  
>  %.o:  %.c policy.h
> Index: policyrep/libselinux/src/libselinux.map
> ===================================================================
> --- policyrep/libselinux/src/libselinux.map	(revision 0)
> +++ policyrep/libselinux/src/libselinux.map	(revision 0)
> @@ -0,0 +1,173 @@
> +LIBSELINUX_2.0 {
> +  global:	
> +	selinux_mnt;
> +
> +	is_selinux_enabled;
> +	is_selinux_mls_enabled;
> +	freecon;
> +	freeconary;
> +	getcon;
> +	getcon_raw;
> +	setcon;
> +	setcon_raw;
> +	getpidcon;
> +	getpidcon_raw;
> +	getprevcon;
> +	getprevcon_raw;
> +	getexeccon;
> +	getexeccon_raw;
> +	setexeccon;
> +	setexeccon_raw;
> +	getfscreatecon;
> +	getfscreatecon_raw;
> +	setfscreatecon;
> +	setfscreatecon_raw;
> +	getkeycreatecon;
> +	getkeycreatecon_raw;
> +	setkeycreatecon;
> +	setkeycreatecon_raw;
> +	getsockcreatecon;
> +	getsockcreatecon_raw;
> +	setsockcreatecon;
> +	setsockcreatecon_raw;
> +	getfilecon;
> +	getfilecon_raw;
> +	lgetfilecon;
> +	lgetfilecon_raw;
> +	fgetfilecon;
> +	fgetfilecon_raw;
> +	setfilecon;
> +	setfilecon_raw;
> +	lsetfilecon;
> +	lsetfilecon_raw;
> +	fsetfilecon;
> +	fsetfilecon_raw;
> +	getpeercon;
> +	getpeercon_raw;
> +	security_compute_av;
> +	security_compute_av_raw;
> +	security_compute_create;
> +	security_compute_create_raw;
> +	security_compute_relabel;
> +	security_compute_relabel_raw;
> +	security_compute_member;
> +	security_compute_member_raw;
> +	security_compute_user;
> +	security_compute_user_raw;
> +	security_load_policy;
> +	security_get_initial_context;
> +	security_get_initial_context_raw;
> +	selinux_mkload_policy;
> +	selinux_init_load_policy;
> +	security_set_boolean_list;
> +	security_check_context;
> +	security_check_context_raw;
> +	security_canonicalize_context;
> +	security_canonicalize_context_raw;
> +	security_getenforce;
> +	security_setenforce;
> +	security_disable;
> +	security_policyvers;
> +	security_get_boolean_names;
> +	security_get_boolean_pending;
> +	security_get_boolean_active;
> +	security_set_boolean;
> +	security_commit_booleans;
> +	string_to_security_class;
> +	security_class_to_string;
> +	security_av_perm_to_string;
> +	string_to_av_perm;
> +	security_av_string;
> +	print_access_vector;
> +	set_matchpathcon_printf;
> +	set_matchpathcon_invalidcon;
> +	set_matchpathcon_canoncon;
> +	set_matchpathcon_flags;
> +	matchpathcon_init;
> +	matchpathcon_init_prefix;
> +	matchpathcon_fini;
> +	matchpathcon;
> +	matchpathcon_index;
> +	matchpathcon_filespec_add;
> +	matchpathcon_filespec_destroy;
> +	matchpathcon_filespec_eval;
> +	matchpathcon_checkmatches;
> +	matchmediacon;
> +	selinux_getenforcemode;
> +	selinux_getpolicytype;
> +	selinux_policy_root;
> +	selinux_binary_policy_path;
> +	selinux_failsafe_context_path;
> +	selinux_removable_context_path;
> +	selinux_default_context_path;
> +	selinux_user_contexts_path;
> +	selinux_file_context_path;
> +	selinux_file_context_homedir_path;
> +	selinux_file_context_local_path;
> +	selinux_homedir_context_path;
> +	selinux_media_context_path;
> +	selinux_contexts_path;
> +	selinux_securetty_types_path;
> +	selinux_customizable_types_path;
> +	selinux_usersconf_path;
> +	selinux_translations_path;
> +	selinux_netfilter_context_path;
> +	selinux_path;
> +	selinux_check_passwd_access;
> +	checkPasswdAccess;
> +	selinux_check_securetty_context;
> +	set_selinuxmnt;
> +	rpm_execcon;
> +	is_context_customizable;
> +	selinux_trans_to_raw_context;
> +	selinux_raw_to_trans_context;
> +	getseuserbyname;
> +	selinux_file_context_cmp;
> +	selinux_file_context_verify;
> +	selinux_lsetfilecon_default;
> +
> +	context_new;
> +	context_str;
> +	context_free;
> +	context_type_get;
> +	context_range_get;
> +	context_role_get;
> +	context_user_get;
> +	context_type_set;
> +	context_range_set;
> +	context_role_set;
> +	context_user_set;
> +
> +	get_ordered_context_list;
> +	get_ordered_context_list_with_level;
> +	get_default_context;
> +	get_default_context_with_level;
> +	get_default_context_with_role;
> +	get_default_context_with_rolelevel;
> +	query_user_context;
> +	manual_user_enter_context;
> +
> +	selinux_default_type_path;
> +	get_default_type;
> +
> +	avc_sid_to_context;
> +	avc_sid_to_context_raw;
> +	avc_context_to_sid;
> +	avc_context_to_sid_raw;
> +	sidget;
> +	sidput;
> +	avc_get_initial_sid;
> +	avc_init;
> +	avc_cleanup;
> +	avc_reset;
> +	avc_destroy;
> +	avc_has_perm_noaudit;
> +	avc_has_perm;
> +	avc_audit;
> +	avc_compute_create;
> +	avc_add_callback;
> +	avc_cache_stats;
> +	avc_av_stats;
> +	avc_sid_stats;
> +  local: *;
> +};
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
