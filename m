Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FIGVgA013328
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 14:16:33 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FICorE010703
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 18:12:50 GMT
Message-ID: <42D7FC9A.7000901@tresys.com>
Date: Fri, 15 Jul 2005 14:12:42 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [RFC] selinux management API
References: <42D7CC53.9030803@tresys.com> <1121442990.4488.87.camel@celtics.boston.redhat.com>
In-Reply-To: <1121442990.4488.87.camel@celtics.boston.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------030907040604080905030906"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030907040604080905030906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I think this summarizes the dialog well Ivan, thanks.

Attached is an updated header file that uses structs for all 
add/remove/update functions so that arbitrary information can be added 
to any of them later, accessors would accompany all these structs but 
aren't in this header.

Joshua

Ivan Gyurdiev wrote:

> To expand on that, the plan is to make libsemanage (new name for
> libsemod) become the central access point for anything that manipulates
> the policy. It would implement things like policy access, configuration
> files, and transaction guarantees.
>
> Libsepol, which currently handles access to the binary policy file,
> would become a static backend library for libsemanage and checkpolicy -
> it would supply common code to work with the policy image.
>
> Libselinux would only contain code necessary for access decisions,
> and communicating with the kernel policy.
>
> ===========================
>
> During a teleconference meeting with Tresys, and Stephen, we
> discussed Karl's proposal for mapping users to selinux users
> many-to-one (see previous discussions), and several key points were
> established:
>
> 1) Granularity at the Unix user level (and not just the selinux user
> level) is useful for implementing the categories for the MCS policy
> that Redhat is developing. As a result, we plan to move MLS categories
> from the selinux user config file into the map file (or alternative
> backend), where they can be associated with users, and not just selinux
> users. The set of accessible categories will be configured by login
> programs. Sensitivities would remain associated with selinux users.
>
> 2) It is desirable for the selinux libraries to have no knowledge
> of Unix users, and to only work with SELinux users. So, instead
> of changing get_ordered_context_list to accomplish the discussed
> mapping, all callers will be changed to pass in the sel user.
> API compatibility is not broken, until the fallback to the user_u
> default user is removed from get_ordered_context_list.
>
> 3) It is important to be able to select from multiple backends
> for storing the user-to-sel_user mappings, just like you can
> select where to store the users. The current plan is to add
> a "selusers" field in nsswitch.conf, and write the corresponding
> support in libnss_files.so. In the course of doing that, we cannot
> add library dependencies to libnss_files.so, so any parser and related
> code has to be self-contained.
>
> 4) Management of file_contexts is still a point of contention, and I
> am not clear exactly how the current API as proposed by Tresys will
> solve this problem.
>
> 5) I would also like to see single record query functions implemented
> by the libsemanage APIs (as opposed to iterating lists), as well as
> a way to modify records. I think the add methods should take a
> structure.
>
> 6) It is also planned to change the configuration files from being
> the authoritative data source, to something that's merged into
> the binary policy on every transaction (not every function call).
> What this means is, when a user is added, the modifications
> will be written to the binary file, and load_policy and init
> will no longer read the config file on startup, and risk failure.
> The purpose of config files is as the source to be compiled
> into the binary policy, not loaded on every boot. On upgrades,
> a utility (genpolicy) would read in all relevant files and
> modules (Tresys' loadable modules work), and construct the
> new image.
>
> I hope this summarizes what we've been discussing off-list
> to some degree. Please make corrections as necessary.
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--------------030907040604080905030906
Content-Type: text/x-chdr;
 name="semanage.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage.h"

/* This #include needed to get struct timeval. */
#include <sys/time.h>

/* All accesses with semanage is through a "semanage_handle".  This
 * handler may be with the monolithic policy, directly to a module
 * store, or with a policy management server.  The handler represents
 * a persistent connection to that policy manager.  It is created
 * through a semanage_connect() call and must be afterwards
 * deallocated with semanage_handle_free(). */
typedef struct semanage_handle semanage_handle_t;

/* "Connect" to a manager, as specified in the file
 * /etc/selinux/semanage.conf.  This function always allocates a new
 * semanage_handle_t and assigns it to the passed reference pointer.
 * The caller is later responsible for deallocating the pointer by
 * calling semanage_handle_free().  If the connect fails then this
 * function returns a negative value, else it returns zero. */
int semanage_connect(semanage_handle_t **);

/* Disconnect from the manager given by the handle.  If already
 * disconnected then this function does nothing.  Return 0 if
 * disconnected properly or already disconnected, negative value on
 * error. */
int semanage_disconnect(semanage_handle_t *);

/* Deallocate all space associated with a semanage_handle_t, including
 * the pointer itself.  CAUTION: this function does not disconnect
 * from the manager; be sure that a semanage_disconnect() was
 * previously called. */
void semanage_handle_free(semanage_handle_t *);

/* Return a string describing the most recently encountered error
 * associated with a semanage_handle_t.  The returned string must not
 * be modified by the caller.  Be aware that this string is not
 * persistent; future calls to this library may alter the buffer
 * contents. */
const char *semanage_strerror(semanage_handle_t *);


/* Attempt to obtain a transaction lock on the manager.  If another
 * process has the lock then this function may block, depending upon
 * the timeout value.  The timeout parameter acts similarly to
 * select(2).
 *
 * Note that if the semanage_handle has not yet obtained a transaction
 * lock whenever a writer function is called, there will be an
 * implicit call to this function with timeout set to zero (i.e.,
 * return immediately if unable to obtain). */
int semanage_begin_transaction(semanage_handle_t *,
                               struct timeval *timeout);

/* Attempt to commit all changes since this transaction began.  If the
 * commit is successful then increment the "policy sequence number"
 * and then release the transaction lock.
 */
int semanage_commit(semanage_handle_t *);


/* META NOTES
 *
 * All of the below functions exepct a semanage_handle as its first
 * parameter.  If an error occurs then the function returns a negative
 * value.  Call semanage_strerror() to retrieve a string that fully
 * describes the error.
 *
 * For all functions a non-negative number indicates success.  The
 * particular returned value is the "policy sequence number".  This
 * number keeps tracks of policy revisions and is used to detect if
 * one semanage client has committed policy changes while another is
 * still connected.
 *
 * The info structs are nebulous at this time.  They will have
 * accessor functions from which to retrieve particular information.
 * The particular accessors are unknown at this time; as design
 * progresses those accessors will be decided.  Two such proposed
 * accessors are:

const char *semanage_module_get_name(semanage_module_info_t *);
const char *semanage_module_get_version(semanage_module_info_t *);

 */

int semanage_module_install(semanage_handle_t *,
                            char *module_data, size_t data_len);
int semanage_module_upgrade(semanage_handle_t *,
                            char *module_data, size_t data_len);
int semanage_module_install_base(semanage_handle_t *,
                                 char *module_data, size_t data_len);
int semanage_module_remove(semanage_handle_t *,
                           char *module_name);
typedef struct semanage_module_info semanage_module_info_t;
int semanage_module_list(semanage_handle_t *,
                         semanage_module_info_t **, int *num_modules);
void semanage_module_info_free(semanage_module_info_t *);


typedef struct semanage_user semanage_user_t;

int semanage_user_add(semanage_handle_t *, semanage_user_t *userdata);
int semanage_user_remove(semanage_handle_t *, semanage_user_t *userdata);
int semanage_user_list(semanage_handle_t *, semanage_user_t **users, int *num_users);
void semanage_user_free(semanage_user_t *);


typedef struct semanage_homedir semanage_homedir_t;

int semanage_homedir_add(semanage_handle_t *, semanage_homedir_t *homedir);
int semanage_homedir_remove(semanage_handle_t *, semanage_homedir_t *homedir);
int semanage_homedir_list(semanage_handle_t *, semanage_homedir_t **, int *num_homedirs);
void semanage_homedir_free(semanage_homedir_t *);


typedef struct semanage_boolean semanage_boolean_t;
int semanage_boolean_set(semanage_handle_t *, semanage_boolean_t *bool);
/* if for some reason the caller does not have permission to read a
 * particular boolean value, it will not be added to the returned
 * array */
int semanage_boolean_list(semanage_handle_t *, semanage_boolean_t **, int *num_bools);
void semanage_boolean_free(semanage_boolean_t *);

typedef struct semanage_tunable semanage_tunable_t;
int semanage_tunable_set(semanage_handle_t *, semanage_tunable_t *tunable); 
int semanage_tunable_list(semanage_handle_t *, semanage_tunable_t **list, int num_tunables);
void semanage_tunable_free(semanage_tunable_t *);

--------------030907040604080905030906--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
