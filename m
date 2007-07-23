Subject: Re: libselinux man page changes to make translations easier.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4694EDC7.9090507@redhat.com>
References: <4694EDC7.9090507@redhat.com>
Content-Type: text/plain
Date: Mon, 23 Jul 2007 12:22:04 -0400
Message-Id: <1185207724.3724.0.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-07-11 at 10:48 -0400, Daniel J Walsh wrote:
> plain text document attachment (diff)
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_add_callback.3 libselinux-2.0.23/man/man3/avc_add_callback.3
> --- nsalibselinux/man/man3/avc_add_callback.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/avc_add_callback.3	2007-07-10 12:17:08.000000000 -0400
> @@ -6,26 +6,26 @@
>  avc_add_callback \- additional event notification for SELinux userspace object managers.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +

Why?  I don't understand how this simplifies translations, and it could
change the formatting of the man pages.

>  .B #include <selinux/avc.h>
>  .sp
>  .BI "int avc_add_callback(int (*" callback ")(uint32_t " event , 
>  .in +\w'int avc_add_callback(int (*callback)('u
>  .BI "security_id_t " ssid ,
> -.br
> +
>  .BI "security_id_t " tsid ,
> -.br
> +
>  .BI "security_class_t " tclass ,
> -.br
> +
>  .BI "access_vector_t " perms ,
> -.br
> +
>  .BI "access_vector_t *" out_retained "),"
>  .in
>  .in +\w'int avc_add_callback('u
>  .BI "uint32_t " events ", security_id_t " ssid , 
> -.br
> +
>  .BI "security_id_t " tsid ", security_class_t " tclass ,
> -.br
> +
>  .BI "access_vector_t " perms ");"
>  .in
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_cache_stats.3 libselinux-2.0.23/man/man3/avc_cache_stats.3
> --- nsalibselinux/man/man3/avc_cache_stats.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/avc_cache_stats.3	2007-07-10 12:17:08.000000000 -0400
> @@ -6,7 +6,7 @@
>  avc_cache_stats, avc_av_stats, avc_sid_stats \- obtain userspace SELinux AVC statistics.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/avc.h>
>  .sp
>  .BI "void avc_av_stats(void);"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_compute_create.3 libselinux-2.0.23/man/man3/avc_compute_create.3
> --- nsalibselinux/man/man3/avc_compute_create.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/avc_compute_create.3	2007-07-10 12:17:07.000000000 -0400
> @@ -6,7 +6,7 @@
>  avc_compute_create \- obtain SELinux label for new object.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/avc.h>
>  .sp
>  .BI "int avc_compute_create(security_id_t " ssid ", security_id_t " tsid ,
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_context_to_sid.3 libselinux-2.0.23/man/man3/avc_context_to_sid.3
> --- nsalibselinux/man/man3/avc_context_to_sid.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/avc_context_to_sid.3	2007-07-10 12:17:07.000000000 -0400
> @@ -6,7 +6,7 @@
>  avc_context_to_sid, avc_sid_to_context, sidput, sidget, avc_get_initial_sid \- obtain and manipulate SELinux security ID's.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/avc.h>
>  .sp
>  .BI "int avc_context_to_sid(security_context_t " ctx ", security_id_t *" sid ");"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_has_perm.3 libselinux-2.0.23/man/man3/avc_has_perm.3
> --- nsalibselinux/man/man3/avc_has_perm.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/avc_has_perm.3	2007-07-10 12:13:47.000000000 -0400
> @@ -6,7 +6,7 @@
>  avc_has_perm, avc_has_perm_noaudit, avc_audit, avc_entry_ref_init \- obtain and audit SELinux access decisions.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/avc.h>
>  .sp
>  .BI "void avc_entry_ref_init(struct avc_entry_ref *" aeref ");"
> @@ -14,21 +14,21 @@
>  .BI "int avc_has_perm(security_id_t " ssid ", security_id_t " tsid ,
>  .in +\w'int avc_has_perm('u
>  .BI "security_class_t " tclass ", access_vector_t " requested ,
> -.br
> +
>  .BI "struct avc_entry_ref *" aeref ", void *" auditdata ");"
>  .in
>  .sp
>  .BI "int avc_has_perm_noaudit(security_id_t " ssid ", security_id_t " tsid ,
>  .in +\w'int avc_has_perm('u
>  .BI "security_class_t " tclass ", access_vector_t " requested ,
> -.br
> +
>  .BI "struct avc_entry_ref *" aeref ", struct av_decision *" avd ");"
>  .in
>  .sp
>  .BI "void avc_audit(security_id_t " ssid ", security_id_t " tsid ,
>  .in +\w'void avc_audit('u
>  .BI "security_class_t " tclass ", access_vector_t " requested ,
> -.br
> +
>  .BI "struct av_decision *" avd ", int " result ", void *" auditdata ");"
>  .in
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/avc_init.3 libselinux-2.0.23/man/man3/avc_init.3
> --- nsalibselinux/man/man3/avc_init.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/avc_init.3	2007-07-10 12:13:43.000000000 -0400
> @@ -6,17 +6,17 @@
>  avc_init, avc_destroy, avc_reset, avc_cleanup \- userspace SELinux AVC setup and teardown.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/avc.h>
>  .sp
>  .BI "int avc_init(const char *" msgprefix , 
>  .in +\w'int avc_init('u
>  .BI "const struct avc_memory_callback *" mem_callbacks ,
> -.br
> +
>  .BI "const struct avc_log_callback *" log_callbacks ,
> -.br
> +
>  .BI "const struct avc_thread_callback *" thread_callbacks ,
> -.br
> +
>  .BI "const struct avc_lock_callback *" lock_callbacks ");"
>  .in
>  .sp
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/context_new.3 libselinux-2.0.23/man/man3/context_new.3
> --- nsalibselinux/man/man3/context_new.3	2007-01-17 11:11:35.000000000 -0500
> +++ libselinux-2.0.23/man/man3/context_new.3	2007-07-10 12:13:40.000000000 -0400
> @@ -4,27 +4,27 @@
>  
>  .SH "SYNOPSIS"
>  .B #include <selinux/context.h>
> -.br 
> +
>  .B "context_t context_new(const char *" context_str );
> -.br 
> +
>  .B "const char * context_str(context_t " con );
> -.br 
> +
>  .B "void context_free(context_t " con );
> -.br 
> +
>  .B "const char * context_type_get(context_t " con );
> -.br 
> +
>  .B "const char * context_range_get(context_t " con );
> -.br 
> +
>  .B "const char * context_role_get(context_t " con );
> -.br 
> +
>  .B "const char * context_user_get(context_t " con );
> -.br 
> +
>  .B "const char * context_type_set(context_t " con ", const char* " type);
> -.br 
> +
>  .B "const char * context_range_set(context_t " con ", const char* " range);
> -.br 
> +
>  .B "const char * context_role_set(context_t " con ", const char* " role );
> -.br 
> +
>  .B "const char * context_user_set(context_t " con ", const char* " user );
>  
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/freecon.3 libselinux-2.0.23/man/man3/freecon.3
> --- nsalibselinux/man/man3/freecon.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/freecon.3	2007-07-10 12:13:55.000000000 -0400
> @@ -5,7 +5,7 @@
>  .B #include <selinux/selinux.h>
>  .sp
>  .BI "void freecon(security_context_t "con );
> -.br 
> +
>  .BI "void freeconary(security_context_t *" con );
>  
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getcon.3 libselinux-2.0.23/man/man3/getcon.3
> --- nsalibselinux/man/man3/getcon.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/getcon.3	2007-07-10 12:14:08.000000000 -0400
> @@ -1,21 +1,21 @@
>  .TH "getcon" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
>  .SH "NAME"
>  getcon, getprevcon, getpidcon \- get SELinux security context of a process.
> -.br
> +
>  getpeercon - get security context of a peer socket.
> -.br
> +
>  setcon - set current security context of a process.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
>  .sp
>  .BI "int getcon(security_context_t *" context );
> -.br 
> +
>  .BI "int getprevcon(security_context_t *" context );
> -.br
> +
>  .BI "int getpidcon(pid_t " pid ", security_context_t *" context );
> -.br
> +
>  .BI "int getpeercon(int " fd ", security_context_t *" context);
> -.br
> +
>  .BI "int setcon(security_context_t " context);
>  
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getexeccon.3 libselinux-2.0.23/man/man3/getexeccon.3
> --- nsalibselinux/man/man3/getexeccon.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/getexeccon.3	2007-07-10 12:14:24.000000000 -0400
> @@ -1,16 +1,16 @@
>  .TH "getexeccon" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
>  .SH "NAME"
>  getexeccon, setexeccon \- get or set the SELinux security context used for executing a new process.
> -.br
> +
>  rpm_execcon \- run a helper for rpm in an appropriate security context
>  
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
>  .sp
>  .BI "int getexeccon(security_context_t *" context );
> -.br 
> +
>  .BI "int setexeccon(security_context_t "context );
> -.br 
> +
>  .BI "int rpm_execcon(unsigned int " verified ", const char *" filename ", char *const " argv "[] , char *const " envp "[]);
>  
>  .SH "DESCRIPTION"
> @@ -26,16 +26,16 @@
>  setexeccon to reset to the default policy behavior.  
>  The exec context is automatically reset after the next execve, so a
>  program doesn't need to explicitly sanitize it upon startup.  
> -.br
> +
>  
>  setexeccon can be applied prior to library
>  functions that internally perform an execve, e.g. execl*, execv*, popen,
>  in order to set an exec context for that operation.  
> -.br
> +
>  
>  Note: Signal handlers that perform an execve must take care to
>  save, reset, and restore the exec context to avoid unexpected behaviors.
> -.br
> +
>  
>  .B rpm_execcon
>  runs a helper for rpm in an appropriate security context.  The
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getfilecon.3 libselinux-2.0.23/man/man3/getfilecon.3
> --- nsalibselinux/man/man3/getfilecon.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/getfilecon.3	2007-07-10 12:17:06.000000000 -0400
> @@ -5,9 +5,9 @@
>  .B #include <selinux/selinux.h>
>  .sp
>  .BI "int getfilecon(const char *" path ", security_context_t *" con );
> -.br 
> +
>  .BI "int lgetfilecon(const char *" path ", security_context_t *" con );
> -.br 
> +
>  .BI "int fgetfilecon(int "fd ", security_context_t *" con );
>  .SH "DESCRIPTION"
>  .B getfilecon
> @@ -22,7 +22,6 @@
>  is identical to getfilecon, only the open file pointed to by filedes (as
>  returned by open(2)) is interrogated in place of path.
>  
> -.br
>  
>  The returned context should be freed with freecon if non-NULL.  
>  .SH "RETURN VALUE"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getfscreatecon.3 libselinux-2.0.23/man/man3/getfscreatecon.3
> --- nsalibselinux/man/man3/getfscreatecon.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/getfscreatecon.3	2007-07-10 12:17:06.000000000 -0400
> @@ -6,7 +6,7 @@
>  .B #include <selinux/selinux.h>
>  .sp
>  .BI "int getfscreatecon(security_context_t *" con );
> -.br 
> +
>  .BI "int setfscreatecon(security_context_t "context );
>  
>  .SH "DESCRIPTION"
> @@ -22,11 +22,11 @@
>  setfscreatecon to reset to the default policy behavior.  
>  The fscreate context is automatically reset after the next execve, so a
>  program doesn't need to explicitly sanitize it upon startup.  
> -.br
> +
>  setfscreatecon can be applied prior to library
>  functions that internally perform an file creation,
>  in order to set an file context on the objects.
> -.br
> +
>  
>  Note: Signal handlers that perform an setfscreate must take care to
>  save, reset, and restore the fscreate context to avoid unexpected behaviors.
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/get_ordered_context_list.3 libselinux-2.0.23/man/man3/get_ordered_context_list.3
> --- nsalibselinux/man/man3/get_ordered_context_list.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/get_ordered_context_list.3	2007-07-10 12:17:05.000000000 -0400
> @@ -4,7 +4,7 @@
>  
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/get_context_list.h>
>  .sp
>  .BI "int get_ordered_context_list(const char *" user ", security_context_t "fromcon ", security_context_t **" list );
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getseuserbyname.3 libselinux-2.0.23/man/man3/getseuserbyname.3
> --- nsalibselinux/man/man3/getseuserbyname.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/getseuserbyname.3	2007-07-10 12:17:04.000000000 -0400
> @@ -12,7 +12,7 @@
>  then be passed to other libselinux functions such as 
>  get_ordered_context_list_with_level and get_default_context_with_level.
>  
> -.br
> +
>  
>  The returned SELinux username and level should be freed by the caller
>  using free.  
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/is_context_customizable.3 libselinux-2.0.23/man/man3/is_context_customizable.3
> --- nsalibselinux/man/man3/is_context_customizable.3	2007-01-17 11:11:35.000000000 -0500
> +++ libselinux-2.0.23/man/man3/is_context_customizable.3	2007-07-10 12:17:04.000000000 -0400
> @@ -8,7 +8,7 @@
>  
>  .SH "DESCRIPTION"
>  .B is_context_customizable
> -.br
> +
>  This function checks whether the type of scon is in the /etc/selinux/SELINUXTYPE/context/customizable_types file.  A customizable type is a file context type that
>  administrators set on files, usually to allow certain domains to share the file content. restorecon and setfiles, by default, leave these context in place.
>  
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/matchmediacon.3 libselinux-2.0.23/man/man3/matchmediacon.3
> --- nsalibselinux/man/man3/matchmediacon.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/matchmediacon.3	2007-07-10 12:17:03.000000000 -0400
> @@ -6,14 +6,14 @@
>  .B #include <selinux/selinux.h>
>  .sp
>  .BI "int matchmediacon(const char *" media ", security_context_t *" con);"
> -.br 
> +
>  
>  .SH "DESCRIPTION"
> -.br
> +
>  .B matchmediacon 
>  matches the specified media type with the media contexts configuration and sets the security context "con" to refer to the resulting context. 
>  .sp
> -.br
> +
>  .B Note: 
>     Caller must free returned security context "con" using freecon.
>  .SH "RETURN VALUE"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/matchpathcon.3 libselinux-2.0.23/man/man3/matchpathcon.3
> --- nsalibselinux/man/man3/matchpathcon.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/matchpathcon.3	2007-07-10 12:15:33.000000000 -0400
> @@ -6,18 +6,18 @@
>  .B #include <selinux/selinux.h>
>  .sp
>  .BI "int matchpathcon_init(const char *" path ");"
> -.br
> +
>  .BI "int matchpathcon_fini(void);"
> -.br
> +
>  .BI "int matchpathcon(const char *" path ", mode_t " mode ", security_context_t *" con);
>  .sp
> -.br 
> +
>  .BI "void set_matchpathcon_printf(void (*" f ")(const char *" fmt ", ...));"
> -.br
> +
>  .BI "void set_matchpathcon_invalidcon(int (*" f ")(const char *"path ", unsigned " lineno ", char * " context "));"
> -.br
> +
>  .BI "void set_matchpathcon_flags(unsigned int " flags ");"
> -.br
> +
>  .SH "DESCRIPTION"
>  .B matchpathcon_init
>  loads the file contexts configuration specified by
> @@ -40,7 +40,7 @@
>  suffix are also looked up and loaded if present.  These files provide
>  dynamically generated entries for user home directories and for local
>  customizations.
> -.br 
> +
>  .sp
>  .B matchpathcon_fini
>  frees the memory allocated by a prior call to
> @@ -49,7 +49,7 @@
>  .B matchpathcon_init 
>  calls, or to free memory when finished using 
>  .B matchpathcon.
> -.br
> +
>  .sp
>  .B matchpathcon 
>  matches the specified pathname and mode against the file contexts
> @@ -72,14 +72,14 @@
>  .I path,
>  defaulting to the active file contexts configuration.
>  .sp
> -.br
> +
>  .B set_matchpathcon_printf
>  sets the function used by 
>  .B matchpathcon_init
>  when displaying errors about the file contexts configuration.  If not set, 
>  then this defaults to fprintf(stderr, fmt, ...).  This can be set to redirect
>  error reporting to a different destination.
> -.br
> +
>  .sp
>  .B set_matchpathcon_invalidcon
>  sets the function used by 
> @@ -100,7 +100,7 @@
>  and
>  .I lineno
>  in such error messages.
> -.br
> +
>  .sp
>  .B set_matchpathcon_flags
>  sets flags controlling the operation of 
> @@ -111,7 +111,7 @@
>  .B MATCHPATHCON_BASEONLY
>  flag is set, then only the base file contexts configuration file
>  will be processed, not any dynamically generated entries or local customizations.
> -.br
> +
>  .sp
>  .SH "RETURN VALUE"
>  Returns 0 on success or -1 otherwise.
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/security_class_to_string.3 libselinux-2.0.23/man/man3/security_class_to_string.3
> --- nsalibselinux/man/man3/security_class_to_string.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/security_class_to_string.3	2007-07-10 12:15:16.000000000 -0400
> @@ -8,7 +8,7 @@
>  
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/flask.h>
>  .sp
>  .BI "const char * security_class_to_string(security_class_t " tclass ");"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/security_compute_av.3 libselinux-2.0.23/man/man3/security_compute_av.3
> --- nsalibselinux/man/man3/security_compute_av.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/security_compute_av.3	2007-07-10 12:15:12.000000000 -0400
> @@ -6,7 +6,7 @@
>  
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/flask.h>
>  .sp
>  .BI "int security_compute_av(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/security_getenforce.3 libselinux-2.0.23/man/man3/security_getenforce.3
> --- nsalibselinux/man/man3/security_getenforce.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/security_getenforce.3	2007-07-10 12:15:08.000000000 -0400
> @@ -5,7 +5,7 @@
>  .B #include <selinux/selinux.h>
>  .sp
>  .B int security_getenforce();
> -.br
> +
>  .BI "int security_setenforce(int "value );
>  
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/security_load_booleans.3 libselinux-2.0.23/man/man3/security_load_booleans.3
> --- nsalibselinux/man/man3/security_load_booleans.3	2007-01-17 11:11:35.000000000 -0500
> +++ libselinux-2.0.23/man/man3/security_load_booleans.3	2007-07-10 12:17:02.000000000 -0400
> @@ -7,15 +7,15 @@
>  .B #include <selinux/selinux.h>
>  .sp
>  extern int security_load_booleans(char *path);
> -.br
> +
>  extern int security_get_boolean_names(char ***names, int *len);
> -.br
> +
>  extern int security_get_boolean_pending(const char *name);
> -.br
> +
>  extern int security_get_boolean_active(const char *name);
> -.br
> +
>  extern int security_set_boolean(const char *name, int value);
> -.br
> +
>  extern int security_commit_booleans(void);
>  
> 
> @@ -29,27 +29,27 @@
>  The SELinux API allows for a transaction based update.  So you can set several boolean values and the commit them all at once.
>  
>  security_load_booleans
> -.br
> +
>  Load policy boolean settings. Path may be NULL, in which case the booleans are loaded from the active policy boolean configuration file.
>  
>  security_get_boolean_names
> -.br
> +
>  Returns a list of boolean names, currently supported by the loaded policy.
>  
>  security_set_boolean 
> -.br
> +
>  Sets the pending value for boolean 
>  
>  security_get_boolean_pending
> -.br
> +
>  Return pending value for boolean
>  
>  security_get_boolean_active
> -.br
> +
>  Return active value for boolean
>  
>  security_commit_booleans
> -.br
> +
>  Commit all pending values for the booleans.
>  
>  .SH AUTHOR	
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selabel_lookup.3 libselinux-2.0.23/man/man3/selabel_lookup.3
> --- nsalibselinux/man/man3/selabel_lookup.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/selabel_lookup.3	2007-07-10 12:17:01.000000000 -0400
> @@ -6,20 +6,20 @@
>  selabel_lookup \- obtain SELinux security context from a string label.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/label.h>
>  .sp
>  .BI "int selabel_lookup(struct selabel_handle *" hnd ,
>  .in +\w'int selabel_lookup('u
>  .BI "security_context_t *" context ,
> -.br
> +
>  .BI "const char *" key ", int " type ");"
>  .in
>  .sp
>  .BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
>  .in +\w'int selabel_lookup_raw('u
>  .BI "security_context_t *" context ,
> -.br
> +
>  .BI "const char *" key ", int " type ");"
>  
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selabel_open.3 libselinux-2.0.23/man/man3/selabel_open.3
> --- nsalibselinux/man/man3/selabel_open.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/selabel_open.3	2007-07-10 12:17:00.000000000 -0400
> @@ -6,13 +6,13 @@
>  selabel_open, selabel_close \- userspace SELinux labeling interface.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/label.h>
>  .sp
>  .BI "struct selabel_handle *selabel_open(int " backend , 
>  .in +\w'struct selabel_handle *selabel_open('u
>  .BI "struct selinux_opt *" options ,
> -.br
> +
>  .BI "unsigned " nopt ");"
>  .in
>  .sp
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selabel_stats.3 libselinux-2.0.23/man/man3/selabel_stats.3
> --- nsalibselinux/man/man3/selabel_stats.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/selabel_stats.3	2007-07-10 12:16:59.000000000 -0400
> @@ -6,7 +6,7 @@
>  selabel_stats \- obtain SELinux labeling statistics.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/label.h>
>  .sp
>  .BI "void selabel_lookup(struct selabel_handle *" hnd ");"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_binary_policy_path.3 libselinux-2.0.23/man/man3/selinux_binary_policy_path.3
> --- nsalibselinux/man/man3/selinux_binary_policy_path.3	2007-01-17 11:11:35.000000000 -0500
> +++ libselinux-2.0.23/man/man3/selinux_binary_policy_path.3	2007-07-10 12:16:08.000000000 -0400
> @@ -10,27 +10,27 @@
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
>  .sp
> -.br
> +
>  extern const char *selinux_policy_root(void);
> -.br
> +
>  extern const char *selinux_binary_policy_path(void);
> -.br
> +
>  extern const char *selinux_failsafe_context_path(void);
> -.br
> +
>  extern const char *selinux_removable_context_path(void);
> -.br
> +
>  extern const char *selinux_default_context_path(void);
> -.br
> +
>  extern const char *selinux_user_contexts_path(void);
> -.br
> +
>  extern const char *selinux_file_context_path(void);
> -.br
> +
>  extern const char *selinux_media_context_path(void);
> -.br
> +
>  extern const char *selinux_securetty_types_path(void);
> -.br
> +
>  extern const char *selinux_contexts_path(void);
> -.br
> +
>  extern const char *selinux_booleans_path(void);
>  
> 
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_getenforcemode.3 libselinux-2.0.23/man/man3/selinux_getenforcemode.3
> --- nsalibselinux/man/man3/selinux_getenforcemode.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/selinux_getenforcemode.3	2007-07-10 12:16:51.000000000 -0400
> @@ -5,13 +5,13 @@
>  .B #include <selinux/selinux.h>
>  .sp
>  .B int selinux_getenforcemode(int *enforce);
> -.br
> +
>  
>  .SH "DESCRIPTION"
>  .B selinux_getenforcemode
>  Reads the contents of the /etc/selinux/config file to determine how the 
>  system was setup to run SELinux.
> -.br
> +
>  Sets the value of enforce to 1 if SELinux should be run in enforcing mode.
>  Sets the value of enforce to 0 if SELinux should be run in permissive mode.
>  Sets the value of enforce to -1 if SELinux should be disabled.
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_policy_root.3 libselinux-2.0.23/man/man3/selinux_policy_root.3
> --- nsalibselinux/man/man3/selinux_policy_root.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/selinux_policy_root.3	2007-07-10 12:16:49.000000000 -0400
> @@ -5,7 +5,7 @@
>  .B #include <selinux/selinux.h>
>  .sp
>  .B char *selinux_policy_root();
> -.br
> +
>  
>  .SH "DESCRIPTION"
>  .B selinux_policy_root
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_set_callback.3 libselinux-2.0.23/man/man3/selinux_set_callback.3
> --- nsalibselinux/man/man3/selinux_set_callback.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/selinux_set_callback.3	2007-07-10 12:16:48.000000000 -0400
> @@ -39,11 +39,11 @@
>  argument indicates the type of message and will be set to one of the following:
>  
>  .B SELINUX_ERROR
> -.br
> +
>  .B SELINUX_WARNING
> -.br
> +
>  .B SELINUX_INFO
> -.br
> +
>  .B SELINUX_AVC
>  
>  .TP
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/setfilecon.3 libselinux-2.0.23/man/man3/setfilecon.3
> --- nsalibselinux/man/man3/setfilecon.3	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man3/setfilecon.3	2007-07-10 12:12:18.000000000 -0400
> @@ -6,9 +6,9 @@
>  .B #include <selinux/selinux.h>
>  .sp
>  .BI "int setfilecon(const char *" path ", security_context_t "con );
> -.br 
> +
>  .BI "int lsetfilecon(const char *" path ", security_context_t "con );
> -.br 
> +
>  .BI "int fsetfilecon(int "fd ", security_context_t "con );
>  
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man5/selabel_file.5 libselinux-2.0.23/man/man5/selabel_file.5
> --- nsalibselinux/man/man5/selabel_file.5	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man5/selabel_file.5	2007-07-10 12:18:11.000000000 -0400
> @@ -6,13 +6,13 @@
>  selabel_file \- userspace SELinux labeling interface: file contexts backend.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/label.h>
>  .sp
>  .BI "int selabel_lookup(struct selabel_handle *" hnd ,
>  .in +\w'int selabel_lookup('u
>  .BI "security_context_t *" context ,
> -.br
> +
>  .BI "const char *" path ", int " mode ");"
>  
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man5/selabel_media.5 libselinux-2.0.23/man/man5/selabel_media.5
> --- nsalibselinux/man/man5/selabel_media.5	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man5/selabel_media.5	2007-07-10 12:18:11.000000000 -0400
> @@ -6,13 +6,13 @@
>  selabel_media \- userspace SELinux labeling interface: media contexts backend.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/label.h>
>  .sp
>  .BI "int selabel_lookup(struct selabel_handle *" hnd ,
>  .in +\w'int selabel_lookup('u
>  .BI "security_context_t *" context ,
> -.br
> +
>  .BI "const char *" device_name ", int " unused ");"
>  
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man5/selabel_x.5 libselinux-2.0.23/man/man5/selabel_x.5
> --- nsalibselinux/man/man5/selabel_x.5	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man5/selabel_x.5	2007-07-10 12:18:09.000000000 -0400
> @@ -6,13 +6,13 @@
>  selabel_x \- userspace SELinux labeling interface: X Window System contexts backend.
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> -.br
> +
>  .B #include <selinux/label.h>
>  .sp
>  .BI "int selabel_lookup(struct selabel_handle *" hnd ,
>  .in +\w'int selabel_lookup('u
>  .BI "security_context_t *" context ,
> -.br
> +
>  .BI "const char *" object_name ", int " object_type ");"
>  
>  .SH "DESCRIPTION"
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/matchpathcon.8 libselinux-2.0.23/man/man8/matchpathcon.8
> --- nsalibselinux/man/man8/matchpathcon.8	2007-06-21 05:16:39.000000000 -0400
> +++ libselinux-2.0.23/man/man8/matchpathcon.8	2007-07-10 11:38:39.000000000 -0400
> @@ -10,16 +10,16 @@
>  .SH OPTIONS
>  .B \-n
>  Do not display path.
> -.br
> +
>  .B \-N
>  Do not use translations.
> -.br
> +
>  .B \-f file_context_file
>  Use alternate file_context file
> -.br
> +
>  .B \-p prefix
>  Use prefix to speed translations
> -.br
> +
>  .B \-V
>  Verify file context on disk matches defaults
>  
> diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/selinux.8 libselinux-2.0.23/man/man8/selinux.8
> --- nsalibselinux/man/man8/selinux.8	2006-11-16 17:15:26.000000000 -0500
> +++ libselinux-2.0.23/man/man8/selinux.8	2007-07-10 11:38:21.000000000 -0400
> @@ -62,14 +62,13 @@
>  .B system-config-securitylevel
>  allows customization of these booleans and tunables.
>  
> -.br
>  Many domains that are protected by SELinux also include selinux man pages explainging how to customize their policy.  
>  
>  .SH FILE LABELING
>  
>  All files, directories, devices ... have a security context/label associated with them.  These context are stored in the extended attributes of the file system.
>  Problems with SELinux often arise from the file system being mislabeled. This can be caused by booting the machine with a non selinux kernel.  If you see an error message containing file_t, that is usually a good indicator that you have a serious problem with file system labeling.  
> -.br 
> +
>  The best way to relabel the file system is to create the flag file /.autorelabel and reboot.  system-config-securitylevel, also has this capability.  The restorcon/fixfiles commands are also available for relabeling files. 
>    
>  .SH AUTHOR	
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
