Message-Id: <200509281531.j8SFVVYs010390@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, <selinux@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: RE: [PATCH] semanage-functionality 4/17
Date: Wed, 28 Sep 2005 11:31:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1127919144.25945.74.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Wednesday, September 28, 2005 10:52 AM
> To: Karl MacMillan
> Cc: Ivan Gyurdiev; selinux@tycho.nsa.gov; 'Joshua Brindle'
> Subject: Re: [PATCH] semanage-functionality 4/17
> 
> On Tue, 2005-09-27 at 08:46 -0400, Karl MacMillan wrote:
> > This patch adds semanage.h - this is the new public interface for
> > libsemanage.
> 
> diff -purN -x .svn libsemanage/include/semanage/semanage.h
> libsemanage/include/semanage/semanage.h
> --- libsemanage/include/semanage/semanage.h	1969-12-31
> 19:00:00.000000000 -0500
> +++ libsemanage/include/semanage/semanage.h	2005-09-26
> 09:59:04.000000000 -0400
> <snip>
> +/* This #include needed to get struct timeval. */
> +#include <sys/time.h>
> 
> I don't see why this is needed in the header.  Will move to the particular
> .c file
> in question.
> 

Struct timeval used to be used in the API - the header wasn't properly
removed when this was removed.

> +/* All accesses with semanage is through a "semanage_handle".  This
> + * handler may be with the monolithic policy, directly to a module
> + * store, or with a policy management server.  The handler represents
> + * a persistent connection to that policy manager.  It is created
> + * through a semanage_connect() call and must be afterwards
> + * deallocated with semanage_handle_destroy(). */
> +typedef struct semanage_handle semanage_handle_t;
> 
> It seems cleaner to separate create from connect, to parallel the
> separation of disconnect from destroy.  Further, the implementation
> already makes this easy to do; just need to make the
> semanage_handle_create function exported and change connect to take an
> already created handle rather than creating one of its own.  Barring
> objections, I will do this.
> 
> Also, moving to handle.h, #include'd by this and other headers that use
> it.
> 

Sounds fine to me.

> +/* Initialize the library - this needs to be called first. This loads
> + * any defaults from the configuration files and performs any other
> + * needed initialization.
> + *
> + * returns:
> + *	0	success
> + *	-1	general error
> + *	-2	error parsing configuration files
> + *
> + * WARNING: This function is NOT thread-safe.
> + */
> +int semanage_init(void);
> 
> Seems odd, particularly given that the implementation doesn't use it or
> rely on it.  I'd expect it to be done via library constructor instead,
> with the other functions just checking a flag on entry to verify
> successful initialization (bailing immediately with an error otherwise).
> Will drop barring objections.
> 

Go ahead and drop, but I would like to add it back in the future. I'm not a
big fan of library constructors, but we can do it that way if you would
prefer (partially, it makes it harder to use this as a static library I
believe).

Part of this is that config scheme currently doesn't make sense (this was
discussed in the past). The current config has 3 things:

1) Information on how to connect, etc.

2) Verification programs to run on commit.

3) Information on the location and commandline args to programs like
load_policy.

I think that 1 should move to /etc/selinux/config. This will require changes
to libselinux. Objections?

2 should be part of each policy, e.g., /etc/selinux/targeted/semanage.conf.
This is really the current config file.

3 should be dropped in favor of Makefile variables or moved to
/etc/selinux/config. I can't imagine a different load_policy per policy. 

> +/* "Connect" to a manager, as specified in the file
> + * /etc/selinux/semanage.conf.	This function always allocates a new
> + * semanage_handle_t and assigns it to the passed reference pointer.
> + * The caller is later responsible for deallocating the pointer by
> + * calling semanage_handle_destroy().  If the connect fails then this
> + * function returns a negative value, else it returns zero.
> + */
> +int semanage_connect(semanage_handle_t **);
> 
> Will split out the create interface as noted above.
> Unclear as to whether these also go to handle.h or a separate
> transaction.h.
> 

Why not just handle.h for connections and transactions instead of the a
separate transaction.h and handle.h?

> +/* Disconnect from the manager given by the handle.  If already
> + * disconnected then this function does nothing.  Return 0 if
> + * disconnected properly or already disconnected, negative value on
> + * error. */
> +int semanage_disconnect(semanage_handle_t *);
> 
> Will move to same place as connect.
> 
> +/* Deallocate all space associated with a semanage_handle_t, including
> + * the pointer itself.	CAUTION: this function does not disconnect
> + * from the manager; be sure that a semanage_disconnect() was
> + * previously called. */
> +void semanage_handle_destroy(semanage_handle_t *);
> 
> Will move to handle.h.
> 
> +/* Return a string describing the most recently encountered error
> + * associated with a semanage_handle_t.	 The returned string must
not
> + * be modified by the caller.  Be aware that this string is not
> + * persistent; future calls to this library may alter the buffer
> + * contents, so make a copy of it if necessary.
> + */
> +const char *semanage_strerror(semanage_handle_t *);
> 
> Will move to handle.h.
> 
> +/* Attempt to obtain a transaction lock on the manager.	 If another
> + * process has the lock then this function may block, depending upon
> + * the timeout value in the handle.
> + *
> + * Note that if the semanage_handle has not yet obtained a transaction
> + * lock whenever a writer function is called, there will be an
> + * implicit call to this function. */
> +int semanage_begin_transaction(semanage_handle_t *);
> 
> Will move to transaction.h.
> 

See above - seems like putting this in handle.h would be easier.

> +/* Attempt to commit all changes since this transaction began.	If
the
> + * commit is successful then increment the "policy sequence number"
> + * and then release the transaction lock.  Return that policy number
> + * afterwards, or -1 on error.
> + */
> +int semanage_commit(semanage_handle_t *);
> 
> Will move to transaction.h.
> 
> +/* META NOTES
> + *
> + * All of the below functions expect a semanage_handle as its first
> + * parameter.  If an error occurs then the function returns a negative
> + * value.  Call semanage_strerror() to retrieve a string that fully
> + * describes the error.
> + *
> + * For all functions a non-negative number indicates success. For query
> + * fucntions a >=0 returned value is the "policy sequence number".  This
> + * number keeps tracks of policy revisions and is used to detect if
> + * one semanage client has committed policy changes while another is
> + * still connected.
> + */
> 
> Will move to handle.h.
> 
> +/* High level module management functions. These are all part of
> + * a transaction
> + */
> +
> +int semanage_module_install(semanage_handle_t *,
> +			    char *module_data, size_t data_len);
> +int semanage_module_upgrade(semanage_handle_t *,
> +			    char *module_data, size_t data_len);
> +int semanage_module_install_base(semanage_handle_t *,
> +				 char *module_data, size_t data_len);
> +int semanage_module_remove(semanage_handle_t *,
> +			   char *module_name);
> +
> +
> +/* semanage_module_info is for getting information on installed
> +   modules, only name and version at this time */
> +typedef struct semanage_module_info semanage_module_info_t;
> +
> +int semanage_module_list(semanage_handle_t *,
> +			 semanage_module_info_t **, int *num_modules);
> +void semanage_module_info_datum_destroy(semanage_module_info_t *);
> +semanage_module_info_t *semanage_module_list_nth(semanage_module_info_t
> *list, int n);
> +const char *semanage_module_get_name(semanage_module_info_t *);
> +const char *semanage_module_get_version(semanage_module_info_t *);
> 
> Will move to modules.h.
> 
> +/* accessors for mls and role support structs */
> +typedef struct semanage_mls semanage_mls_t;
> +typedef struct semanage_role semanage_role_t;
> +
> +const char* semanage_mls_get_range(semanage_mls_t *);
> +const char* semanage_mls_get_level(semanage_mls_t *);
> +
> +int semanage_mls_set_range(semanage_mls_t *);
> +int semanage_mls_set_level(semanage_mls_t *);
> +
> +const char* semanage_role_get_name(semanage_role_t *);
> +
> +int semanage_role_set_name(semanage_role_t *, char *name);
> +
> +/* semanage_user represents selinux users in the policy */
> +typedef struct semanage_user semanage_user_t;
> +
> +/* semanage_user management functions */
> +int semanage_user_init(semanage_handle_t **);
> +int semanage_user_add(semanage_handle_t *, semanage_user_t *userdata);
> +int semanage_user_remove(semanage_handle_t *, char *userdata);
> +int semanage_user_list(semanage_handle_t *, semanage_user_t **users, int
> *num_users);
> +int semanage_user_change(semanage_handle_t *, semanage_user_t *userdata,
> char *key);
> +void semanage_user_free(semanage_user_t *);
> +
> +/* semanage_user accessor functions */
> +const char* semanage_user_get_name(semanage_user_t *);
> +int semanage_user_get_roles(semanage_user_t *, semanage_role_t **roles,
> int num_roles);
> +int semanage_user_get_mls(semanage_user_t *, semanage_mls_t *mls);
> +
> +int semanage_user_set_name(semanage_user_t *, char *name);
> +int semanage_user_set_roles(semanage_user_t *, semanage_role_t **roles,
> int num_roles);
> +int semanage_user_set_mls(semanage_user_t *, semanage_mls_t *mls);
> +
> +/* semanage_homedir manages selinux_user->directory maps so that
> +   we can expand home directory contexts */
> +typedef struct semanage_homedir semanage_homedir_t;
> +
> +int semanage_homedir_add(semanage_handle_t *, semanage_homedir_t
> *homedir);
> +int semanage_homedir_remove(semanage_handle_t *, semanage_homedir_t
> *homedir);
> +int semanage_homedir_list(semanage_handle_t *, semanage_homedir_t **, int
> *num_homedirs);
> +void semanage_homedir_free(semanage_homedir_t *);
> +
> +/* semanage_homedir accessors */
> +
> +const char* semanage_homedir_get_user(semanage_handle_t *);
> +const char* semanage_homedir_get_path(semanage_handle_t *);
> +
> +int semanage_homedir_set_user(semanage_handle_t *, char *user);
> +int semanage_homedir_set_path(semanage_handle_t *, char *path);
> +
> +/* semanage_boolean manages default boolean states */
> +typedef struct semanage_boolean semanage_boolean_t;
> +
> +int semanage_boolean_set(semanage_handle_t *, semanage_boolean_t *bool);
> +/* if for some reason the caller does not have permission to read a
> + * particular boolean value, it will not be added to the returned
> + * array -- only if something enforces that (eg. policy server) */
> +int semanage_boolean_list(semanage_handle_t *, semanage_boolean_t **, int
> *num_bools);
> +void semanage_boolean_free(semanage_boolean_t *);
> +
> +/* semanage_boolean accessors */
> +
> +const char *semanage_boolean_get_name(semanage_boolean_t *);
> +char semanage_boolean_get_state(semanage_boolean_t *);
> +
> +int semanage_boolean_set_name(semanage_boolean_t *, char *name);
> +int semanage_boolean_set_state(semanage_boolean_t *, char state);
> 
> Dropping all of these.
> 

Agreed. Are you making these changes, or do you want an updated patch?

Karl

> --
> Stephen Smalley
> National Security Agency

------
Karl MacMillan
Tresys Technology
http://www.tresys.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
