Message-ID: <791924EBDA572C4FA970D4A94AA95DA309E3B5@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@tcs-sec.com>
To: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: [patch] policydb - MLS
Date: Tue, 2 Mar 2004 14:29:03 -0500 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4008C.9F02D180"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4008C.9F02D180
Content-Type: text/plain;
	charset="iso-8859-1"


I have attached a patch to checkpolicy and the kernel to allow MLS to work
correctly with new conditional policy extensions. The problem is an ordering
issue in the symbol table array.

_______________________________________________________________
Chad Hanson				mailto:chanson@tcs-sec.com
Trusted Computer Solutions		Phone: 217-384-0028 x12
121 W Goose Alley			Fax: 217-384-0288
Urbana IL 61801

 <<policydb.h>>  <<linux-2.6.3.patch>> 


------_=_NextPart_000_01C4008C.9F02D180
Content-Type: application/octet-stream;
	name="policydb.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policydb.h"

/*=0A=
 * A policy database (policydb) specifies the=0A=
 * configuration data for the security policy.=0A=
 *=0A=
 * Author : Stephen Smalley, <sds@epoch.ncsc.mil>=0A=
 */=0A=
=0A=
/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan =
<kmacmillan@tresys.com>=0A=
 *=0A=
 * 	Added conditional policy language extensions=0A=
 *=0A=
 * Copyright (C) 2003 - 2004 Tresys Technology, LLC=0A=
 *	This program is free software; you can redistribute it and/or =
modify=0A=
 *  	it under the terms of the GNU General Public License as published =
by=0A=
 *	the Free Software Foundation, version 2.=0A=
 */=0A=
=0A=
#ifndef _SS_POLICYDB_H_=0A=
#define _SS_POLICYDB_H_=0A=
=0A=
#include "symtab.h"=0A=
#include "avtab.h"=0A=
#include "sidtab.h"=0A=
#include "context.h"=0A=
#include "constraint.h"=0A=
=0A=
/*=0A=
 * A datum type is defined for each kind of symbol=0A=
 * in the configuration data:  individual permissions,=0A=
 * common prefixes for access vectors, classes,=0A=
 * users, roles, types, sensitivities, categories, etc.=0A=
 */=0A=
=0A=
/* Permission attributes */=0A=
struct perm_datum {=0A=
	u32 value;		/* permission bit + 1 */=0A=
#ifdef CONFIG_SECURITY_SELINUX_MLS=0A=
#define MLS_BASE_READ    1	/* MLS base permission `read' */=0A=
#define MLS_BASE_WRITE   2	/* MLS base permission `write' */=0A=
#define MLS_BASE_READ_RANGE  4	/* MLS base permission `read_range' =
*/=0A=
#define MLS_BASE_WRITE_RANGE 8	/* MLS base permission `write_range' =
*/=0A=
	u32 base_perms;		/* MLS base permission mask */=0A=
#endif=0A=
};=0A=
=0A=
/* Attributes of a common prefix for access vectors */=0A=
struct common_datum {=0A=
	u32 value;			/* internal common value */=0A=
	struct symtab permissions;	/* common permissions */=0A=
};=0A=
=0A=
/* Class attributes */=0A=
struct class_datum {=0A=
	u32 value;			/* class value */=0A=
	char *comkey;			/* common name */=0A=
	struct common_datum *comdatum;	/* common datum */=0A=
	struct symtab permissions;	/* class-specific permission symbol table =
*/=0A=
	struct constraint_node *constraints;	/* constraints on class =
permissions */=0A=
#ifdef CONFIG_SECURITY_SELINUX_MLS=0A=
	struct mls_perms mlsperms;	/* MLS base permission masks */=0A=
#endif=0A=
};=0A=
=0A=
/* Role attributes */=0A=
struct role_datum {=0A=
	u32 value;			/* internal role value */=0A=
	struct ebitmap dominates;	/* set of roles dominated by this role */=0A=
	struct ebitmap types;		/* set of authorized types for role */=0A=
};=0A=
=0A=
struct role_trans {=0A=
	u32 role;		/* current role */=0A=
	u32 type;		/* program executable type */=0A=
	u32 new_role;		/* new role */=0A=
	struct role_trans *next;=0A=
};=0A=
=0A=
struct role_allow {=0A=
	u32 role;		/* current role */=0A=
	u32 new_role;		/* new role */=0A=
	struct role_allow *next;=0A=
};=0A=
=0A=
/* Type attributes */=0A=
struct type_datum {=0A=
	u32 value;		/* internal type value */=0A=
	unsigned char primary;	/* primary name? */=0A=
};=0A=
=0A=
/* User attributes */=0A=
struct user_datum {=0A=
	u32 value;			/* internal user value */=0A=
	struct ebitmap roles;		/* set of authorized roles for user */=0A=
#ifdef CONFIG_SECURITY_SELINUX_MLS=0A=
	struct mls_range_list *ranges;	/* list of authorized MLS ranges for =
user */=0A=
#endif=0A=
};=0A=
=0A=
=0A=
#ifdef CONFIG_SECURITY_SELINUX_MLS=0A=
/* Sensitivity attributes */=0A=
struct level_datum {=0A=
	struct mls_level *level;	/* sensitivity and associated categories =
*/=0A=
	unsigned char isalias;	/* is this sensitivity an alias for another? =
*/=0A=
};=0A=
=0A=
/* Category attributes */=0A=
struct cat_datum {=0A=
	u32 value;		/* internal category bit + 1 */=0A=
	unsigned char isalias;  /* is this category an alias for another? =
*/=0A=
};=0A=
#endif=0A=
=0A=
/* Boolean data type */=0A=
struct cond_bool_datum {=0A=
	__u32 value;		/* internal type value */=0A=
	int state;=0A=
};=0A=
=0A=
struct cond_node;=0A=
=0A=
/*=0A=
 * The configuration data includes security contexts for=0A=
 * initial SIDs, unlabeled file systems, TCP and UDP port numbers,=0A=
 * network interfaces, and nodes.  This structure stores the=0A=
 * relevant data for one such entry.  Entries of the same kind=0A=
 * (e.g. all initial SIDs) are linked together into a list.=0A=
 */=0A=
struct ocontext {=0A=
	union {=0A=
		char *name;	/* name of initial SID, fs, netif, fstype, path */=0A=
		struct {=0A=
			u8 protocol;=0A=
			u16 low_port;=0A=
			u16 high_port;=0A=
		} port;		/* TCP or UDP port information */=0A=
		struct {=0A=
			u32 addr;=0A=
			u32 mask;=0A=
		} node;		/* node information */=0A=
	} u;=0A=
	union {=0A=
		u32 sclass;  /* security class for genfs */=0A=
		u32 behavior;  /* labeling behavior for fs_use */=0A=
	} v;=0A=
	struct context context[2];	/* security context(s) */=0A=
	u32 sid[2];	/* SID(s) */=0A=
	struct ocontext *next;=0A=
};=0A=
=0A=
struct genfs {=0A=
	char *fstype;=0A=
	struct ocontext *head;=0A=
	struct genfs *next;=0A=
};=0A=
=0A=
/* symbol table array indices */=0A=
#define SYM_COMMONS 0=0A=
#define SYM_CLASSES 1=0A=
#define SYM_ROLES   2=0A=
#define SYM_TYPES   3=0A=
#define SYM_USERS   4=0A=
#define SYM_BOOLS   5=0A=
#ifdef CONFIG_SECURITY_SELINUX_MLS=0A=
#define SYM_LEVELS  6=0A=
#define SYM_CATS    7=0A=
#define SYM_NUM     8=0A=
#else=0A=
#define SYM_NUM     6=0A=
#endif=0A=
=0A=
/* object context array indices */=0A=
#define OCON_ISID  0	/* initial SIDs */=0A=
#define OCON_FS    1	/* unlabeled file systems */=0A=
#define OCON_PORT  2	/* TCP and UDP port numbers */=0A=
#define OCON_NETIF 3	/* network interfaces */=0A=
#define OCON_NODE  4	/* nodes */=0A=
#define OCON_FSUSE 5	/* fs_use */=0A=
#define OCON_NUM   6=0A=
=0A=
/* The policy database */=0A=
struct policydb {=0A=
	/* symbol tables */=0A=
	struct symtab symtab[SYM_NUM];=0A=
#define p_commons symtab[SYM_COMMONS]=0A=
#define p_classes symtab[SYM_CLASSES]=0A=
#define p_roles symtab[SYM_ROLES]=0A=
#define p_types symtab[SYM_TYPES]=0A=
#define p_users symtab[SYM_USERS]=0A=
#define p_bools symtab[SYM_BOOLS]=0A=
#define p_levels symtab[SYM_LEVELS]=0A=
#define p_cats symtab[SYM_CATS]=0A=
=0A=
	/* symbol names indexed by (value - 1) */=0A=
	char **sym_val_to_name[SYM_NUM];=0A=
#define p_common_val_to_name sym_val_to_name[SYM_COMMONS]=0A=
#define p_class_val_to_name sym_val_to_name[SYM_CLASSES]=0A=
#define p_role_val_to_name sym_val_to_name[SYM_ROLES]=0A=
#define p_type_val_to_name sym_val_to_name[SYM_TYPES]=0A=
#define p_user_val_to_name sym_val_to_name[SYM_USERS]=0A=
#define p_bool_val_to_name sym_val_to_name[SYM_BOOLS]=0A=
#define p_sens_val_to_name sym_val_to_name[SYM_LEVELS]=0A=
#define p_cat_val_to_name sym_val_to_name[SYM_CATS]=0A=
=0A=
	/* class, role, and user attributes indexed by (value - 1) */=0A=
	struct class_datum **class_val_to_struct;=0A=
	struct role_datum **role_val_to_struct;=0A=
	struct user_datum **user_val_to_struct;=0A=
=0A=
	/* type enforcement access vectors and transitions */=0A=
	struct avtab te_avtab;=0A=
=0A=
	/* role transitions */=0A=
	struct role_trans *role_tr;=0A=
=0A=
	/* bools indexed by (value - 1) */=0A=
	struct cond_bool_datum **bool_val_to_struct;=0A=
	/* type enforcement conditional access vectors and transitions */=0A=
	struct avtab te_cond_avtab;=0A=
	/* linked list indexing te_cond_avtab by conditional */=0A=
	struct cond_node* cond_list;=0A=
=0A=
	/* role allows */=0A=
	struct role_allow *role_allow;=0A=
=0A=
	/* security contexts of initial SIDs, unlabeled file systems,=0A=
	   TCP or UDP port numbers, network interfaces and nodes */=0A=
	struct ocontext *ocontexts[OCON_NUM];=0A=
=0A=
        /* security contexts for files in filesystems that cannot =
support=0A=
	   a persistent label mapping or use another=0A=
	   fixed labeling behavior. */=0A=
  	struct genfs *genfs;=0A=
=0A=
#ifdef CONFIG_SECURITY_SELINUX_MLS=0A=
	/* number of legitimate MLS levels */=0A=
	u32 nlevels;=0A=
=0A=
	struct ebitmap trustedreaders;=0A=
	struct ebitmap trustedwriters;=0A=
	struct ebitmap trustedobjects;=0A=
#endif=0A=
};=0A=
=0A=
extern int policydb_init(struct policydb *p);=0A=
extern int policydb_index_classes(struct policydb *p);=0A=
extern int policydb_index_others(struct policydb *p);=0A=
extern int constraint_expr_destroy(struct constraint_expr *expr);=0A=
extern void policydb_destroy(struct policydb *p);=0A=
extern int policydb_load_isids(struct policydb *p, struct sidtab =
*s);=0A=
extern int policydb_context_isvalid(struct policydb *p, struct context =
*c);=0A=
extern int policydb_read(struct policydb *p, void *fp);=0A=
=0A=
#define PERM_SYMTAB_SIZE 32=0A=
=0A=
#define POLICYDB_CONFIG_MLS    1=0A=
=0A=
#define OBJECT_R "object_r"=0A=
#define OBJECT_R_VAL 1=0A=
=0A=
#define POLICYDB_MAGIC SELINUX_MAGIC=0A=
#define POLICYDB_STRING "SE Linux"=0A=
=0A=
struct policy_file {=0A=
	char *data;=0A=
	size_t len;=0A=
};=0A=
=0A=
static inline void *next_entry(struct policy_file *fp, size_t bytes)=0A=
{=0A=
	void *buf;=0A=
=0A=
	if (bytes > fp->len)=0A=
		return NULL;=0A=
=0A=
	buf =3D fp->data;=0A=
	fp->data +=3D bytes;=0A=
	fp->len -=3D bytes;=0A=
	return buf;=0A=
}=0A=
=0A=
#endif	/* _SS_POLICYDB_H_ */=0A=
=0A=

------_=_NextPart_000_01C4008C.9F02D180
Content-Type: application/octet-stream;
	name="linux-2.6.3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.6.3.patch"

*** linux-2.6.3/security/selinux/ss/policydb.h	2004-02-25 =
14:33:47.000000000 -0600=0A=
--- linux-2.6.3/security/selinux/ss/policydb.h	2004-03-02 =
13:13:20.000000000 -0600=0A=
***************=0A=
*** 160,172 ****=0A=
  #define SYM_ROLES   2=0A=
  #define SYM_TYPES   3=0A=
  #define SYM_USERS   4=0A=
  #ifdef CONFIG_SECURITY_SELINUX_MLS=0A=
! #define SYM_LEVELS  5=0A=
! #define SYM_CATS    6=0A=
! #define SYM_BOOLS   7=0A=
  #define SYM_NUM     8=0A=
  #else=0A=
- #define SYM_BOOLS   5=0A=
  #define SYM_NUM     6=0A=
  #endif=0A=
  =0A=
--- 160,171 ----=0A=
  #define SYM_ROLES   2=0A=
  #define SYM_TYPES   3=0A=
  #define SYM_USERS   4=0A=
+ #define SYM_BOOLS   5=0A=
  #ifdef CONFIG_SECURITY_SELINUX_MLS=0A=
! #define SYM_LEVELS  6=0A=
! #define SYM_CATS    7=0A=
  #define SYM_NUM     8=0A=
  #else=0A=
  #define SYM_NUM     6=0A=
  #endif=0A=
  =0A=
***************=0A=
*** 188,196 ****=0A=
  #define p_roles symtab[SYM_ROLES]=0A=
  #define p_types symtab[SYM_TYPES]=0A=
  #define p_users symtab[SYM_USERS]=0A=
  #define p_levels symtab[SYM_LEVELS]=0A=
  #define p_cats symtab[SYM_CATS]=0A=
- #define p_bools symtab[SYM_BOOLS]=0A=
  =0A=
  	/* symbol names indexed by (value - 1) */=0A=
  	char **sym_val_to_name[SYM_NUM];=0A=
--- 187,195 ----=0A=
  #define p_roles symtab[SYM_ROLES]=0A=
  #define p_types symtab[SYM_TYPES]=0A=
  #define p_users symtab[SYM_USERS]=0A=
+ #define p_bools symtab[SYM_BOOLS]=0A=
  #define p_levels symtab[SYM_LEVELS]=0A=
  #define p_cats symtab[SYM_CATS]=0A=
  =0A=
  	/* symbol names indexed by (value - 1) */=0A=
  	char **sym_val_to_name[SYM_NUM];=0A=
***************=0A=
*** 199,207 ****=0A=
  #define p_role_val_to_name sym_val_to_name[SYM_ROLES]=0A=
  #define p_type_val_to_name sym_val_to_name[SYM_TYPES]=0A=
  #define p_user_val_to_name sym_val_to_name[SYM_USERS]=0A=
  #define p_sens_val_to_name sym_val_to_name[SYM_LEVELS]=0A=
  #define p_cat_val_to_name sym_val_to_name[SYM_CATS]=0A=
- #define p_bool_val_to_name sym_val_to_name[SYM_BOOLS]=0A=
  =0A=
  	/* class, role, and user attributes indexed by (value - 1) */=0A=
  	struct class_datum **class_val_to_struct;=0A=
--- 198,206 ----=0A=
  #define p_role_val_to_name sym_val_to_name[SYM_ROLES]=0A=
  #define p_type_val_to_name sym_val_to_name[SYM_TYPES]=0A=
  #define p_user_val_to_name sym_val_to_name[SYM_USERS]=0A=
+ #define p_bool_val_to_name sym_val_to_name[SYM_BOOLS]=0A=
  #define p_sens_val_to_name sym_val_to_name[SYM_LEVELS]=0A=
  #define p_cat_val_to_name sym_val_to_name[SYM_CATS]=0A=
  =0A=
  	/* class, role, and user attributes indexed by (value - 1) */=0A=
  	struct class_datum **class_val_to_struct;=0A=

------_=_NextPart_000_01C4008C.9F02D180--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
