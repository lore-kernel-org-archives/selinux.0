Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FEoDgA011715
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 10:50:13 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FEkdrE019524
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 14:46:39 GMT
Message-ID: <42D7CC53.9030803@tresys.com>
Date: Fri, 15 Jul 2005 10:46:43 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [RFC] selinux management API
Content-Type: multipart/mixed;
 boundary="------------080202030505020905020408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080202030505020905020408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

After some discussion about the newly introduced libsemod and the user 
management that Red Hat wants to introduce we've tried to come up with 
an API that all management applications can use, which allow management 
of many components of SELinux policy, including users, booleans states, 
and soon ports. It's written with the expectation to add more managed 
components later, without disturbing the API. We plan on make a new 
library called libsemanage with this API exported through a shared 
library and getting rid of libsemod.

This library should seamlessly handle management on systems with the 
current policy, policy modules or the policy management server. This way 
the management apps do not need to know what kind of SELinux system is 
running.

Comments are appreciated.


Joshua Brindle

--------------080202030505020905020408
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


int semanage_user_add(semanage_handle_t *,
                      char *selinux_user_name,
                      char **roles, int num_roles);
int semanage_user_remove(semanage_handle_t *,
                         char *selinux_user_name);
typedef struct semanage_user_info semanage_user_info_t;
int semanage_user_list(semanage_handle_t *,
                       semanage_user_info_t **, int *num_users);
void semanage_user_info_free(semanage_user_info_t *);


int semanage_homedir_add(semanage_handle_t *,
                         char *dirname, char *context);
int semanage_homedir_remove(semanage_handle_t *,
                            char *dirname);
typedef struct semanage_homedir_info semanage_homedir_info_t;
int semanage_homedir_list(semanage_handle_t *,
                          semanage_homedir_info_t **, int *num_homedirs);
void semanage_homedir_info_free(semanage_homedir_info_t *);


int semanage_boolean_set(semanage_handle_t *,
                         char *boolname, int new_bool_value, int permanent);
/* if for some reason the caller does not have permission to read a
 * particular boolean value, it will not be added to the returned
 * array */
typedef struct semanage_boolean_info semanage_boolean_info_t;
int semanage_boolean_list(semanage_handle_t *,
                          semanage_boolean_info_t **, int *num_bools);
void semanage_boolean_info_free(semanage_boolean_info_t *);


int semanage_tunable_set(semanage_handle_t *,
                         char *tunablename, int new_tunable_value);
typedef struct semanage_tunable_info semanage_tunable_info_t;
int semanage_tunable_list(semanage_handle_t *,
                          semanage_tunable_info_t **, int *num_tunables);
void semanage_tunable_info_free(semanage_tunable_info_t *);

--------------080202030505020905020408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
