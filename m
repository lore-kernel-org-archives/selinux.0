Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NKfIgA000985
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:41:18 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NKVRNa015046
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 20:31:27 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506231939.j5NJdXqc031369@gotham.columbia.tresys.com>
References: <200506231939.j5NJdXqc031369@gotham.columbia.tresys.com>
Content-Type: multipart/mixed; boundary="=-9NAJokBLZz2hjJmoOjvP"
Date: Thu, 23 Jun 2005 16:28:58 -0400
Message-Id: <1119558539.16753.74.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9NAJokBLZz2hjJmoOjvP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Why have a file per user?

I thought that's what you were suggesting - store per user contexts
in their own file, and then re-generate the end result from that.

Alternatively it could all be in one big file, but then I 
don't have any information what came from where. Regenerating
the regexps from the template (1) requires delete
to have the same information as add, which is otherwise
not necessary. Currently that consists of the home dirs, but
in the future it could consist of other stuff too, and
(2) requires me to match every line in homedirs against
every template expression, which just seems unnecessary.

> > > Can you give an overview of these patches - what you are trying to
> > accomplish in
> > > more detail and the design?
> > 
> > Well I was trying to accomplish the following:
> > 
> > - add -R flag to useradd, and have it automatically validate
> > and add user roles, and generate user contexts (and add user to running
> > policy)
> > 
> > - have userdel undo the above
> > 
> > - have usermod modify user roles in file and policy, and on default
> > role change, recreate the contexts.
> > 
> 
> We were planning on deprecating seuser because of general bit rot. It does do
> all of this (through wrappers, etc) so if any of that code is useful feel free
> to grab it (it's GPL).

Is seuser a library or a command line tool? I want to write a library..

I'm not sure how much help I need, since I have already made sufficient
progress on this - I can successfully complete add, and 
then delete and modify shouldn't be all that hard, once
I decide what to do about finding the user contexts.

I still need to add more validation, and rollback...

> > - expose the net_contexts file through the libsepol library
> > 
> 
> Changes or just query?

Changes, eventually.
Actually Dan's telling me that for starters I need to
get net_contexts.local set up, but I'm looking forward
to manipulating this file automatically in the future.

> > In addition I am doing the following changes, which affect you:
> > 
> > - modify all libsepol functions to work via policydb and
> > not (data,len) image (because there's no reason to policydb_read
> > on each function call...)
> > 
> 
> Definitely a good idea.

it still takes 4 seconds for useradd to load the policy.
It's awfully slow.... that's 2x policydb_read, because of
the verify-after-write. 

> > - make policydb an opaque data structure to address the
> > exposure created above
> > 
> 
> Great - and then various helper functions can be added incrementally until there
> is a full API.

Right....however I'm making an incompatible change here.
policydb_destroy has been changed to free the policy, which
requires all policydb structures to be created on the heap 
via policydb_create. I have to fix existing users.

> 
> Hmm . . . why have the records so directly tied to files? Seems like the API
> needs to be a little higher level to actually make it work with something like
> an LDAP backend.

They are not... the record structure itself is located in a separate 
file. The create/destroy/set/get methods are packaged with the record.
The record thing isn't much more than a wrapper around a struct.
I don't use internal selinux datums for this, because I want to stay
close to the format used in the outside world (human readable strings).

The parse/print methods are packaged separately, because they are
file dependent. The record_iterate and record_modify_file are obviously
file dependent. Someone can implement the top level functions
in a different way with a different backend. 

> Thanks for the overview - it has clarified some things for me. I'm trying to get
> a handle on how we want things to look in the future. One concern is that this
> api uses libsepol - e.g. it makes it clear to the caller that it is manipulating
> a policy file. We have been discussing / imagining an API that will be forward
> portable to the policy server where the act of adding a user might involve and
> IPC call to the server and be significantly more abstract than a policy
> manipulation. 

Take a look at attached headers, and see if you can make suggestions.
Yes, I know I should probably prefix those records with something sane,
but I haven't done that yet.

I'm considering removing the user/type/role/mls fields from 
port and fscon, and making that part of the common context_record.h
instead.

> Not certain, therefore, that libsepol is the correct place for the
> client api (e.g. the one used by useradd). Thoughts?

It's difficult to me to write forward portable code, when I don't
know the future :) 

--=-9NAJokBLZz2hjJmoOjvP
Content-Disposition: attachment; filename=booleans_extern.h
Content-Type: text/x-chdr; name=booleans_extern.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_BOOLEANS_EXTERN_H
#define _SEPOL_BOOLEANS_EXTERN_H

#include <sepol/policydb_extern.h>

extern int sepol_load_booleans(
	policydb_ref_t policydb, 
	const char *sel_path);

extern int sepol_load_booleans_array(
	policydb_ref_t policydb, 
	char **names, int *values, 
	int nel);

#endif

--=-9NAJokBLZz2hjJmoOjvP
Content-Disposition: attachment; filename=context_record_extern.h
Content-Type: text/x-chdr; name=context_record_extern.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_CONTEXT_RECORD_EXTERN_H_
#define _SEPOL_CONTEXT_RECORD_EXTERN_H_ 

#include <stdlib.h>
#include <string.h>

struct context_record;
typedef struct context_record* context_record_t;

/* User */
extern const char* cr_get_user(context_record_t con);
extern int cr_set_user(context_record_t con, const char* user);

/* Role */
extern const char* cr_get_role(context_record_t con);
extern int cr_set_role(context_record_t con, const char* role);

/* Type */
extern const char* cr_get_type(context_record_t con);
extern int cr_set_type(context_record_t con, const char* type);

/* MLS */
extern const char* cr_get_mls(context_record_t con);
extern int cr_set_mls(context_record_t con, const char* mls_range);

/* Create/Destroy */
extern context_record_t cr_create();
extern void cr_destroy(context_record_t con);

#endif /* _SEPOL_CONTEXT_RECORD_EXTERN_H_ */

--=-9NAJokBLZz2hjJmoOjvP
Content-Disposition: attachment; filename=file_record_extern.h
Content-Type: text/x-chdr; name=file_record_extern.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_FILE_RECORD_EXTERN_H_
#define _SEPOL_FILE_RECORD_EXTERN_H_ 

#include <stdlib.h>
#include <string.h>

struct file_record;
typedef struct file_record* file_record_t;

#define FR_CLASS_ALL   0
#define FR_CLASS_REG   1
#define FR_CLASS_DIR   2
#define FR_CLASS_CHAR  3
#define FR_CLASS_BLOCK 4
#define FR_CLASS_SOCK  5
#define FR_CLASS_LINK  6
#define FR_CLASS_FIFO  7

/* Expression */
extern const char* fr_get_expr(file_record_t file);
extern int fr_set_expr(file_record_t file, const char* expr);

/* Class */
extern int fr_get_class(file_record_t file);
extern void fr_set_class(file_record_t file, int class);

/* User */
extern const char* fr_get_user(file_record_t file);
extern int fr_set_user(file_record_t file, const char* user);

/* Role */
extern const char* fr_get_role(file_record_t file);
extern int fr_set_role(file_record_t file, const char* role);

/* Type */
extern const char* fr_get_type(file_record_t file);
extern int fr_set_type(file_record_t file, const char* type);

/* MLS */
extern const char* fr_get_mls(file_record_t file);
extern int fr_set_mls(file_record_t file, const char* mls_range);

/* Create/Destroy */
extern file_record_t fr_create();
extern void fr_destroy(file_record_t file);

#endif /* _SEPOL_FILE_RECORD_EXTERN_H_ */

--=-9NAJokBLZz2hjJmoOjvP
Content-Disposition: attachment; filename=fscon_file_extern.h
Content-Type: text/x-chdr; name=fscon_file_extern.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_USERS_FILE_EXTERN_H
#define _SEPOL_USERS_FILE_EXTERN_H

#include <sepol/user_record_extern.h>
#include <sepol/policydb_extern.h>

extern int sepol_fscon_user_add(
	policydb_ref_t policydb,
	user_record_t user,
	const char* sel_root);

extern int sepol_fscon_user_del(
	policydb_ref_t policydb,
	const char* name,
	const char* sel_root);

#endif

--=-9NAJokBLZz2hjJmoOjvP
Content-Disposition: attachment; filename=policydb_extern.h
Content-Type: text/x-chdr; name=policydb_extern.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_POLICYDB_EXTERN_H_
#define _SEPOL_POLICYDB_EXTERN_H_

struct policydb;

typedef struct policydb* policydb_ref_t;

extern int policydb_create(policydb_ref_t* p);

extern void policydb_destroy(policydb_ref_t p);

extern int policydb_from_image(void* data, size_t len, policydb_ref_t* p);

extern int policydb_to_image(policydb_ref_t p, void **newdata, size_t *newlen);

#endif

--=-9NAJokBLZz2hjJmoOjvP
Content-Disposition: attachment; filename=port_record_extern.h
Content-Type: text/x-chdr; name=port_record_extern.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_PORT_RECORD_EXTERN_H_
#define _SEPOL_PORT_RECORD_EXTERN_H_ 

#include <stdlib.h>
#include <string.h>

struct port_record;
typedef struct port_record* port_record_t;

#define PR_PROTO_UDP 0
#define PR_PROTO TCP 1

/* Protocol */
extern int pr_get_proto(port_record_t pr);
extern void pr_set_proto(port_record_t pr, int proto);

/* Port */
extern int pr_get_port(port_record_t pr);
extern void pr_set_port(port_record_t pr, int port);

/* User */
extern const char* pr_get_user(port_record_t pr);
extern int pr_set_user(port_record_t pr, const char* user);

/* Role */
extern const char* pr_get_role(port_record_t pr);
extern int pr_set_role(port_record_t pr, const char* role);

/* Type */
extern const char* pr_get_type(port_record_t pr);
extern int pr_set_type(port_record_t pr, const char* type);

/* MLS */
extern const char* pr_get_mls(port_record_t pr);
extern int pr_set_mls(port_record_t pr, const char* mls_range);

/* Create/Destroy */
extern port_record_t pr_create();
extern void pr_destroy(port_record_t pr);

#endif /* _SEPOL_PORT_RECORD_EXTERN_H_ */

--=-9NAJokBLZz2hjJmoOjvP
Content-Disposition: attachment; filename=user_record_extern.h
Content-Type: text/x-chdr; name=user_record_extern.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_USER_RECORD_EXTERN_H_
#define _SEPOL_USER_RECORD_EXTERN_H_

#include <string.h>

struct user_record;
typedef struct user_record* user_record_t;

/* Name */
extern const char* ur_get_name(user_record_t user);
extern int ur_set_name(user_record_t user, const char* name);

/* Home directory */
extern const char* ur_get_home(user_record_t user);
extern int ur_set_home(user_record_t user, const char* home);

/* MLS */
extern const char* ur_get_mls_level(user_record_t user);
extern int ur_set_mls_level(user_record_t user, const char* mls_level);
extern const char* ur_get_mls_range(user_record_t user);
extern int ur_set_mls_range(user_record_t user, const char* mls_range);

/* Role management */
extern int ur_get_num_roles(user_record_t user);
extern const char* ur_get_def_role(user_record_t user);
extern int ur_add_role(user_record_t user, const char* role);
extern int ur_del_role(user_record_t user, const char* role);
extern int ur_has_role(user_record_t user, const char* role);
extern int ur_set_def_role(user_record_t user, const char* role);
extern int ur_reset_roles(user_record_t user);
extern void ur_iter_init(user_record_t user);
extern const char* ur_next_role(user_record_t user);

/* Create/destroy */
extern user_record_t ur_create();
extern void ur_destroy(user_record_t user);

#endif /* _SEPOL_USER_RECORD_EXTERN_H_ */

--=-9NAJokBLZz2hjJmoOjvP
Content-Disposition: attachment; filename=users_file_extern.h
Content-Type: text/x-chdr; name=users_file_extern.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_USERS_FILE_EXTERN_H
#define _SEPOL_USERS_FILE_EXTERN_H

#include <sepol/user_record_extern.h>
#include <sepol/policydb_extern.h>

extern int sepol_load_users_file(
	policydb_ref_t policydb,
	const char* sel_root);

extern int sepol_add_user_file(
	policydb_ref_t policydb,
	const char* sel_root,
	user_record_t user);

extern int sepol_del_user_file(
	policydb_ref_t policydb,
	const char* sel_root,
	const char* username);

extern int sepol_set_roles_file(
	policydb_ref_t policydb,
	const char* sel_root,
	const char* username,
	const char** roles);

extern int sepol_add_role_file(
	policydb_ref_t policydb,
	const char* sel_root,
	const char* username,
	const char* role);

extern int sepol_del_role_file(
	policydb_ref_t policydb,
	const char* sel_root,
	const char* username,
	const char* role);

#endif /* _SEPOL_USERS_FILE_EXTERN_H */

--=-9NAJokBLZz2hjJmoOjvP
Content-Disposition: attachment; filename=users_policy_extern.h
Content-Type: text/x-chdr; name=users_policy_extern.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_USERS_POLICY_EXTERN_H_
#define _SEPOL_USERS_POLICY_EXTERN_H_

#include <sepol/policydb_extern.h>
#include <sepol/user_record_extern.h>

/* Del users */
extern void sepol_set_delusers(int on);

/* Clear unused users */
extern void sepol_clear_unused_users(
	policydb_ref_t policydb);

/* Add/delete/load users from the policy */
extern int sepol_add_user_policy(
	policydb_ref_t policydb, 
	user_record_t user);

extern int sepol_del_user_policy(
	policydb_ref_t policydb, 
	const char *username);

extern int sepol_load_user_policy(
	policydb_ref_t policydb, 
	user_record_t user);

#endif /* _SEPOL_USERS_POLICY_EXTERN_H_ */

--=-9NAJokBLZz2hjJmoOjvP--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
