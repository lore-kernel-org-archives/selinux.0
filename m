Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NKmigA001080
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:48:44 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NKcrNa015301
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 20:38:53 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1119558539.16753.74.camel@celtics.boston.redhat.com>
References: <200506231939.j5NJdXqc031369@gotham.columbia.tresys.com>
	 <1119558539.16753.74.camel@celtics.boston.redhat.com>
Content-Type: multipart/mixed; boundary="=-o0eptMv6aoLXCrfYRL6d"
Date: Thu, 23 Jun 2005 16:36:28 -0400
Message-Id: <1119558988.16753.79.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-o0eptMv6aoLXCrfYRL6d
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Take a look at attached headers,

More of them.

In selinux.h, search for create_policydb.

That's a library function for policycoreutils/load_policy.c.


--=-o0eptMv6aoLXCrfYRL6d
Content-Disposition: attachment; filename=sepol.h
Content-Type: text/x-chdr; name=sepol.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_H_
#define _SEPOL_H_

#include <sys/types.h>
#include <stdio.h>
#include <stdarg.h>

/* Draw in extra headers that should be visible from outside */

#include <sepol/booleans_extern.h>
#include <sepol/policydb_extern.h>

#include <sepol/user_record_extern.h>
#include <sepol/file_record_extern.h>
#include <sepol/port_record_extern.h>

#include <sepol/users_policy_extern.h>
#include <sepol/users_file_extern.h>
#include <sepol/fscon_file_extern.h>

/*==== Backwards Compatibility definitions ==== */

/* Given an existing binary policy (starting at 'data', with length 'len')
   and a boolean configuration file named by 'boolpath', rewrite the binary
   policy for the boolean settings in the boolean configuration file.
   The binary policy is rewritten in place in memory.
   Returns 0 upon success, or -1 otherwise. */
extern int sepol_genbools(void *data, size_t len, char *boolpath);

/* Given an existing binary policy (starting at 'data', with length 'len')
   and boolean settings specified by the parallel arrays ('names', 'values')
   with 'nel' elements, rewrite the binary policy for the boolean settings.  
   The binary policy is rewritten in place in memory.
   Returns 0 upon success or -1 otherwise. */
extern int sepol_genbools_array(
	void *data, size_t len, 
	char **names, int *values, int nel);

/* Given an existing binary policy (starting at 'data with length 'len')
   and user configurations living in 'usersdir', generate a new binary
   policy for the new user configurations.  Sets '*newdata' and '*newlen'
   to refer to the new binary policy image. */
extern int sepol_genusers(
	void *data, size_t len, 
	const char *usersdir,
	void **newdata, size_t *newlen);

static inline int sepol_genbools_policydb(
	policydb_ref_t policydb, char *boolpath) {

	return sepol_load_booleans(policydb, boolpath);
}

static inline int sepol_genusers_policydb( 
	policydb_ref_t policydb, const char* usersdir) {

	return sepol_load_users_file(policydb, usersdir);
}

/* ==== End backwards compatibility ==== */

/* Set internal policydb from a file for subsequent service calls. */
extern int sepol_set_policydb(policydb_ref_t policydb);
extern int sepol_set_policydb_from_file(FILE *fp);

/* Check context validity against currently set binary policy. */
extern int sepol_check_context(char *context);

/* Turn on or off sepol error messages. */
extern void sepol_debug(int on);

#endif

--=-o0eptMv6aoLXCrfYRL6d
Content-Disposition: attachment; filename=selinux.h
Content-Type: text/x-chdr; name=selinux.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SELINUX_H_
#define _SELINUX_H_

#include <stdlib.h>
#include <sys/types.h>
#include <stdarg.h>
#include <sepol/sepol.h>

#ifdef __cplusplus
extern "C"
{
#endif

extern void security_debug(int on);

/* Return 1 if we are running on a SELinux kernel, or 0 if not or -1 if we get an error. */
extern int is_selinux_enabled(void);
/* Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise. */
extern int is_selinux_mls_enabled(void);

typedef char* security_context_t;

/* Free the memory allocated for a context by any of the below get* calls. */
extern void freecon(security_context_t con);

/* Free the memory allocated for a context array by security_compute_user. */
extern void freeconary(security_context_t *con);

/* Wrappers for the /proc/pid/attr API. */

/* Get current context, and set *con to refer to it.
   Caller must free via freecon. */
extern int getcon(security_context_t *con);

/* Set the current security context to con.  
   Note that use of this function requires that the entire application
   be trusted to maintain any desired separation between the old and new 
   security contexts, unlike exec-based transitions performed via setexeccon.  
   When possible, decompose your application and use setexeccon()+execve() 
   instead. Note that the application may lose access to its open descriptors
   as a result of a setcon() unless policy allows it to use descriptors opened
   by the old context. */
extern int setcon(security_context_t con);

/* Get context of process identified by pid, and 
   set *con to refer to it.  Caller must free via freecon. */
extern int getpidcon(pid_t pid, security_context_t *con);

/* Get previous context (prior to last exec), and set *con to refer to it.
   Caller must free via freecon. */
extern int getprevcon(security_context_t *con);

/* Get exec context, and set *con to refer to it.
   Sets *con to NULL if no exec context has been set, i.e. using default.
   If non-NULL, caller must free via freecon. */
extern int getexeccon(security_context_t *con);

/* Set exec security context for the next execve. 
   Call with NULL if you want to reset to the default. */
extern int setexeccon(security_context_t con);

/* Get fscreate context, and set *con to refer to it.
   Sets *con to NULL if no fs create context has been set, i.e. using default.
   If non-NULL, caller must free via freecon. */
extern int getfscreatecon(security_context_t *con);

/* Set the fscreate security context for subsequent file creations.
   Call with NULL if you want to reset to the default. */
extern int setfscreatecon(security_context_t context);


/* Wrappers for the xattr API. */

/* Get file context, and set *con to refer to it.
   Caller must free via freecon. */
extern int getfilecon(const char *path, security_context_t *con);
extern int lgetfilecon(const char *path, security_context_t *con);
extern int fgetfilecon(int fd, security_context_t *con);

/* Set file context */
extern int setfilecon(const char *path, security_context_t con);
extern int lsetfilecon(const char *path, security_context_t con);
extern int fsetfilecon(int fd, security_context_t con);


/* Wrappers for the socket API */

/* Get context of peer socket, and set *con to refer to it.
   Caller must free via freecon. */
extern int getpeercon(int fd, security_context_t *con);


/* Wrappers for the selinuxfs (policy) API. */

typedef unsigned int access_vector_t;
typedef unsigned short security_class_t;

struct av_decision {
	access_vector_t allowed;
	access_vector_t decided;
	access_vector_t auditallow;
	access_vector_t auditdeny;
	unsigned int seqno;
};

/* Compute an access decision. */
extern int security_compute_av(security_context_t scon,
			       security_context_t tcon,
			       security_class_t tclass,
			       access_vector_t requested,
			       struct av_decision *avd);

/* Compute a labeling decision and set *newcon to refer to it.
   Caller must free via freecon. */
extern int security_compute_create(security_context_t scon,
				   security_context_t tcon,
				   security_class_t tclass,
				   security_context_t *newcon);

/* Compute a relabeling decision and set *newcon to refer to it.
   Caller must free via freecon. */
extern int security_compute_relabel(security_context_t scon,
				    security_context_t tcon,
				    security_class_t tclass,
				    security_context_t *newcon);

/* Compute a polyinstantiation member decision and set *newcon to refer to it.
   Caller must free via freecon. */
extern int security_compute_member(security_context_t scon,
				   security_context_t tcon,
				   security_class_t tclass,
				   security_context_t *newcon);

/* Compute the set of reachable user contexts and set *con to refer to 
   the NULL-terminated array of contexts.  Caller must free via freeconary. */
extern int security_compute_user(security_context_t scon,
				 const char *username,
				 security_context_t **con);

/* Translate boolean strict to name value pair. */
typedef struct {
	char *name;
	int value; 
} SELboolean;
	/* save a list of booleans in a single transaction.  */
extern int security_set_boolean_list(size_t boolcnt, 
				     SELboolean *boollist, 
				     int permanent);

/* Load policy boolean settings.
   Path may be NULL, in which case the booleans are loaded from
   the active policy boolean configuration file. */
extern int security_load_booleans(char *path);

/* Check the validity of a security context. */
extern int security_check_context(security_context_t con);

/* Get the enforce flag value. */
extern int security_getenforce(void);

/* Set the enforce flag value. */
extern int security_setenforce(int value);

/* Disable SELinux at runtime (must be done prior to initial policy load). */
extern int security_disable(void);

/* Get the policy version number. */
extern int security_policyvers(void);

/* Get the boolean names */
extern int security_get_boolean_names(char ***names, int *len);

/* Get the pending value for the boolean */
extern int security_get_boolean_pending(const char *name);

/* Get the active value for the boolean */
extern int security_get_boolean_active(const char *name);

/* Set the pending value for the boolean */
extern int security_set_boolean(const char *name, int value);

/* Commit the pending values for the booleans */
extern int security_commit_booleans(void);

/* Common helpers */

/* Return the security class value for a given class name. */
extern security_class_t string_to_security_class(const char *name);

/* Return an access vector for a given class and permission name. */
extern access_vector_t string_to_av_perm(security_class_t tclass, const char *name);

/* Display an access vector in a string representation. */
extern void print_access_vector(security_class_t tclass, access_vector_t av);

/* Set the function used by matchpathcon_init when displaying
   errors about the file_contexts configuration.  If not set,
   then this defaults to fprintf(stderr, fmt, ...). */
extern void set_matchpathcon_printf(void (*f)(const char *fmt, ...));

/* Set the function used by matchpathcon_init when checking the
   validity of a context in the file contexts configuration.  If not set,
   then this defaults to a test based on security_check_context().  
   The function is also responsible for reporting any such error, and
   may include the 'path' and 'lineno' in such error messages. */
extern void set_matchpathcon_invalidcon(int (*f)(const char *path, 
						 unsigned lineno, 
						 char *context));

/* Set flags controlling operation of matchpathcon_init or matchpathcon. */
#define MATCHPATHCON_BASEONLY 1 /* Only process the base file_contexts file. */
extern void set_matchpathcon_flags(unsigned int flags);

/* Load the file contexts configuration specified by 'path'
   into memory for use by subsequent matchpathcon calls.  
   If 'path' is NULL, then load the active file contexts configuration,
   i.e. the path returned by selinux_file_context_path().
   Unless the MATCHPATHCON_BASEONLY flag has been set, this
   function also checks for a 'path'.homedirs file and 
   a 'path'.local file and loads additional specifications 
   from them if present. */
extern int matchpathcon_init(const char *path);

/* Match the specified pathname and mode against the file contexts
   configuration and set *con to refer to the resulting context.
   'mode' can be 0 to disable mode matching.
   Caller must free via freecon.
   If matchpathcon_init has not already been called, then this function
   will call it upon its first invocation with a NULL path. */
extern int matchpathcon(const char *path,
			mode_t mode,
			security_context_t *con);

/* Same as above, but return a specification index for 
   later use in a matchpathcon_filespec_add() call - see below. */
extern int matchpathcon_index(const char *path,
			      mode_t mode,
			      security_context_t *con);

/* Maintain an association between an inode and a specification index,
   and check whether a conflicting specification is already associated
   with the same inode (e.g. due to multiple hard links).  If so, then
   use the latter of the two specifications based on their order in the 
   file contexts configuration.  Return the used specification index. */
extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *file);

/* Destroy any inode associations that have been added, e.g. to restart
   for a new filesystem. */
extern void matchpathcon_filespec_destroy(void);

/* Display statistics on the hash table usage for the associations. */
extern void matchpathcon_filespec_eval(void);

/* Check to see whether any specifications had no matches and report them.
   The 'str' is used as a prefix for any warning messages. */
extern void matchpathcon_checkmatches(char *str);

/* Match the specified media and against the media contexts 
   configuration and set *con to refer to the resulting context.
   Caller must free con via freecon. */
extern int matchmediacon(const char *media,
		 security_context_t *con);

/*
  selinux_getenforcemode reads the /etc/selinux/config file and determines 
  whether the machine should be started in enforcing (1), permissive (0) or 
  disabled (-1) mode.
 */
extern int selinux_getenforcemode(int *enforce);

/*
  selinux_policy_root reads the /etc/selinux/config file and returns 
  the directory path under which the compiled policy file and context 
  configuration files exist.
 */
extern const char *selinux_policy_root(void);

/* These functions return the paths to specific files under the 
   policy root directory. */
extern const char *selinux_binary_policy_path(void);
extern const char *selinux_failsafe_context_path(void);
extern const char *selinux_removable_context_path(void);
extern const char *selinux_default_context_path(void);
extern const char *selinux_user_contexts_path(void);
extern const char *selinux_file_context_path(void);
extern const char *selinux_media_context_path(void);
extern const char *selinux_contexts_path(void);
extern const char *selinux_booleans_path(void);
extern const char *selinux_customizable_types_path(void);
extern const char *selinux_users_path(void);

/* Check a permission in the passwd class.
   Return 0 if granted or -1 otherwise. */
extern int checkPasswdAccess(access_vector_t requested);

/* Set the path to the selinuxfs mount point explicitly.
   Normally, this is determined automatically during libselinux 
   initialization, but this is not always possible, e.g. for /sbin/init
   which performs the initial mount of selinuxfs. */
void set_selinuxmnt(char *mnt);

/* Execute a helper for rpm in an appropriate security context. */
extern int rpm_execcon(unsigned int verified, 
		       const char *filename, 
		       char *const argv[], char *const envp[]);

/* Returns whether a file context is customizable, and should not 
   be relabeled . */
extern int is_context_customizable (security_context_t scontext);

/* Create a policy database */
extern int security_create_policydb(
	policydb_ref_t* policydb,
	const char* sel_root,
	int setbools_arg);

/* Create a policydb from the default configuration */
static inline int security_create_default_policydb(policydb_ref_t* policydb) {
	return security_create_policydb(policydb, selinux_policy_root(), 1);
}

/* Destroy a policy database */
static inline void security_destroy_policydb(policydb_ref_t policydb) {
	policydb_destroy(policydb);
}

/* Load a policy database */
extern int security_load_policydb(policydb_ref_t policydb);

/* Load a policy image. */
extern int security_load_policy(void *data, size_t len);


#ifdef __cplusplus
}
#endif

#endif

--=-o0eptMv6aoLXCrfYRL6d--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
