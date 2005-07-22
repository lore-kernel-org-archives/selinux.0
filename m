Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MEuqgA006104
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 10:56:52 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MEq5YP021003
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:52:05 GMT
Message-ID: <42E10804.5030401@tresys.com>
Date: Fri, 22 Jul 2005 10:51:48 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Karl MacMillan <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com> <1122039886.24847.6.camel@celtics.boston.redhat.com>
In-Reply-To: <1122039886.24847.6.camel@celtics.boston.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070509040901040303080901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070509040901040303080901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ivan Gyurdiev wrote:

>>Solving the user-interface issues can be done more effectively, in my opinion,
>>by hiding both iptables and SElinux. My preference would be to extend the
>>SELinux policy language to be able to express the kind of controls that you are
>>interested in expressing and create a configuration tool (gui or text based)
>>that generates the policy. That would leave a policy.conf or equivalent that
>>could be analyzed for correctness.
>>    
>>
>
>I think whatever rules are automatically generated will be at a low
>level of complexity, because anything else would be better handled by
>writing policy. Given this, I think it will be trivial to generate
>additions to policy.conf to address your analysis concern. 
>
This is not very forward looking, needs will undoubtedly become more complex

>Where
>exactly this is done is an implementation detail :)
>
>  
>
sure but there are right ways to do this and not-so-right ways to do it.

>What's missing here, is a good API to work with policy, so that you
>can manipulate policy internals with anything other than checkpolicy.
>  
>
I'm pretty sure thats what we've been proposing

>That's why I'm asking for an intermediate representation. My particular
>implementation of it may not be very good (suggestions welcome), 
>but it's certainly better than what's out there - I don't think 
>passing in policy-dependent integer id's, and exposing internal data
>structures will make a successful api.
>  
>
The module format is an intermediate representation. I don't think 
anyone is suggesting we expose anything about the policy, the last few 
days of discussion has been about abstracting this. With respect to the 
proposed libsemanage API, please let us know what else you need, or 
better yet add some structs and functions and send an rfc. The more 
comprehensive semanage api is attached and can probably start being used 
for the user management and port management.

--------------070509040901040303080901
Content-Type: text/plain;
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
 */


/* High level module management functions. These are all part of
 * a transaction  
 */

int semanage_module_install(semanage_handle_t *,
                            char *module_data, size_t data_len);
int semanage_module_upgrade(semanage_handle_t *,
                            char *module_data, size_t data_len);
int semanage_module_install_base(semanage_handle_t *,
                                 char *module_data, size_t data_len);
int semanage_module_remove(semanage_handle_t *,
                           char *module_name);


/* semanage_module_info is for getting information on installed
   modules, only name and version at this time */
typedef struct semanage_module_info semanage_module_info_t;

int semanage_module_list(semanage_handle_t *,
                         semanage_module_info_t **, int *num_modules);
void semanage_module_info_free(semanage_module_info_t *);

const char *semanage_module_get_name(semanage_module_info_t *);
const char *semanage_module_get_version(semanage_module_info_t *);

/* accessors for mls and role support structs */
typedef struct semanage_mls semanage_role_t;
typedef struct semanage_role semanage_role_t;

const char* semanage_mls_get_range(semanage_mls *);
const char* semanage_mls_get_level(semanage_mls *);

int semanage_mls_set_range(semanage_mls *);
int semanage_mls_set_level(semanage_mls *);

const char* semanage_role_get_name(semanage_role *);

int semanage_role_set_name(semanage_role *);

/* semanage_user represents selinux users in the policy */
typedef struct semanage_user semanage_user_t;

/* semanage_user management functions */
int semanage_user_init(semanage_handle_t **);
int semanage_user_add(semanage_handle_t *, semanage_user_t *userdata);
int semanage_user_remove(semanage_handle_t *, semanage_user_t *userdata);
int semanage_user_list(semanage_handle_t *, semanage_user_t **users, int *num_users);
void semanage_user_free(semanage_user_t *);

/* semanage_user accessor functions */
const char* semanage_user_get_name(semanage_user_t *);
int semanage_user_get_roles(semanage_user_t *, semanage_role **roles, int num_roles);
int semanage_user_get_mls(semanage_user_t *, semanage_mls *mls);
 
int semanage_user_set_name(semange_user_t *);
int semanage_user_set_roles(semanage_user_t *, semanage_roles **roles, int num_roles);
int semanage_user_set_mls(semanage_user_t *, semanage_mls *mls);

/* semanage_homedir manages selinux_user->directory maps so that 
   we can expand home directory contexts */
typedef struct semanage_homedir semanage_homedir_t;

int semanage_homedir_add(semanage_handle_t *, semanage_homedir_t *homedir);
int semanage_homedir_remove(semanage_handle_t *, semanage_homedir_t *homedir);
int semanage_homedir_list(semanage_handle_t *, semanage_homedir_t **, int *num_homedirs);
void semanage_homedir_free(semanage_homedir_t *);

/* semanage_homedir accessors */

const char* semanage_homedir_get_user(semanage_handle_t *);
const char* semanage_homedir_get_path(semanage_handle_t *);

int semanage_homedir_set_user(semanage_handle_t *, char *user);
int semanage_homedir_set_path(semanage_handle_t *, char *path); 

/* semanage_boolean manages default boolean states */
typedef struct semanage_boolean semanage_boolean_t

int semanage_boolean_set(semanage_handle_t *, semanage_boolean_t *bool);
/* if for some reason the caller does not have permission to read a
 * particular boolean value, it will not be added to the returned
 * array */
int semanage_boolean_list(semanage_handle_t *, semanage_boolean_t **, int *num_bools);
void semanage_boolean_free(semanage_boolean_t *);

/* semanage_boolean accessors */

const char* semanage_boolean_get_name(semanage_boolean_t *);
const char semanage_boolean_get_state(semanage_boolean_t *);

int semanage_boolean_set_name(semanage_boolean_t *, char *name);
int semanage_boolean_set_state(semanage_boolean_t *, char state);

--------------070509040901040303080901
Content-Type: text/plain;
 name="semanage_structs.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage_structs.h"

/*
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

/* This defines the data structures which are exported opaquely through 
   semanage.h for policy management clients. */

struct semanage_handle {
	int con_id;		/* Connection ID */
	int policy_serial;	/* Policy serial number at connect time */
	char *err_buf;
}	

struct semanage_module_info {
	char *name;		/* Key */
	char *version;
}

struct semanage_role {
	char *name;		/* Key */
}

struct semanage_mls {
	char *level;
	char *range;
}

struct semanage_user {
	char *selinux_name;		/* Key */
	struct semanage_role **roles;
	int num_roles;
	struct semanage_mls *mls;
}

struct semanage_homedir {
	char *user;
	char *path;		/* Key */
}

struct semanage_boolean {
	char *name;		/* Key */
	char default_state;
}

--------------070509040901040303080901--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
