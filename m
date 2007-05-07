Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l47M6sxn014877
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 18:06:54 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l47M6q0g011598
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 22:06:52 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l47M6qmW031637
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 18:06:52 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l47M6pbO003880
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 18:06:51 -0400
Received: from localhost.localdomain (vpn-14-109.rdu.redhat.com [10.11.14.109])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l47M6nhX032380
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 18:06:49 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] Basic policy representation
Message-Id: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
Date: Mon, 07 May 2007 18:06:47 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support for the basic policy object model and the sepol_policy
and sepol_module objects to libsepol. This version has significant
changes from the last posted version:

1) sepol_handle is passed everywhere
2) public and private interfaces to the object system are correctly
   split (into policy.[c,h] and policy_internal.[c,h].
3) object ouput has been converted from writing to a FILE to returning
   allocated strings. This will help integrate better with scripting
   languages.
4) Basic documentation is included for the base objects.
5) Enums are used instead of defines - this is a change from the style
   for libsepol, but it makes documenting the enums much easier.

Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
---

7 files changed, 1667 insertions(+), 4 deletions(-)
libsepol/include/sepol/policy.h |  522 +++++++++++++++++++++++++++++++
libsepol/src/policy.c           |  638 +++++++++++++++++++++++++++++++++++++++
libsepol/src/policy_internal.c  |  102 ++++++
libsepol/src/policy_internal.h  |  269 ++++++++++++++++
libsepol/tests/libsepol-tests.c |   10 
libsepol/tests/test-policy.c    |  118 +++++++
libsepol/tests/test-policy.h    |   12 


diff -r cacdf4377ebf -r bd4ee6e00a63 libsepol/include/sepol/policy.h
--- a/libsepol/include/sepol/policy.h	Mon May 07 15:50:27 2007 -0400
+++ b/libsepol/include/sepol/policy.h	Mon May 07 18:03:03 2007 -0400
@@ -0,0 +1,522 @@
+/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __sepol_policy_h__
+#define __sepol_policy_h__
+
+#include <sepol/handle.h>
+
+#include <sepol/objpool.h>
+#include <sepol/objset.h>
+#include <sepol/list.h>
+
+#include <sys/types.h>
+#include <stdint.h>
+#include <stdio.h>
+
+/**
+ * \defgroup sepol_policy sepol_policy: policy representation
+ * Introduction to the policy object system
+ *
+ *
+ * The policy is represented as a tree of objects that loosely
+ * resemble an abstract syntax tree or intermediate representation
+ * commonly found in compilers. This tree representation is used as
+ * the output of the policy parser the format for selinux policy
+ * modules. The data structures are also intended to be flexible
+ * enough to represent an selinux policy for syntax/semantic checking,
+ * analysis, generation, and storage.
+ *
+ * The basic structure is that of a tree holding selinux policy
+ * language components (e.g., type declarations, rules, conditional
+ * blocks, etc.). To implement this tree structure in a form that can
+ * be processed easily, a basic object orientied structure is
+ * implemented in C.
+ *
+ * The object oriented system allows the use of polymorphic functions,
+ * making it possible to process objects in the tree with only limited
+ * informatio about the specific types (e.g., it is possible to
+ * traverse the tree and output all of the objects as strings without
+ * the traversal function knowing detailed type information about each
+ * object - it simple class sepol_object_strout on each object).
+ *
+ * See sepol_object and sepol_parent for more information on this object
+ * oriented type system.
+ *
+ */
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Every type in the policy object system is identified
+ * by a numberic typeid.
+ */
+enum sepol_typeid {
+	SEPOL_TYPEID_NONE, /** special typeid representing no type */
+	SEPOL_TYPEID_OBJECT, /** typeid for base class of all objects */
+	SEPOL_TYPEID_PARENT, /** typeid for base class of objects that contain other objects */
+	SEPOL_TYPEID_POLICY, /** typeid for policy object */
+	SEPOL_TYPEID_MODULE, /** typeid for the module object */
+	SEPOL_TYPEID_BLOCK, /** tyepid for the block object */
+	SEPOL_TYPEID_COND, /** typeid for the cond object */
+	SEPOL_TYPEID_OPTIONAL, /** typeid for the optional object */
+	SEPOL_TYPEID_TYPE, /** typed for the type object */
+	SEPOL_TYPEID_CLASS, /** typeid for the class object */
+	SEPOL_TYPEID_ATTRIBUTE, /** typeid for the attribute object */
+	SEPOL_TYPEID_TYPEALIAS, /** typeid for the typealias object */
+	SEPOL_TYPEID_BOOL, /** typeid for the bool object */
+	SEPOL_TYPEID_AVRULE, /** typeid for the avrule object */
+	SEPOL_TYPEID_TYPERULE, /** typeid for the typerule object */
+	SEPOL_TYPEID_SECURITY_CONTEXT, /** typeid for the securit context object */
+	SEPOL_TYPEID_ISID, /** typeid for the isid object */
+	SEPOL_TYPEID_TYPEATTRIBUTE, /** typeid for the typeattribute object */
+	SEPOL_TYPEID_COND_EXPR, /** typeid for the cond expr object */
+	SEPOL_TYPEID_SENS, /** typeid for the sends object */
+	SEPOL_TYPEID_DOMINANCE, /** typeid for the dominance object */
+	SEPOL_TYPEID_CATEGORY, /** typeid for the category object */
+	SEPOL_TYPEID_ROLE_DOMINANCE, /** typeid for the role dominance object */
+	SEPOL_TYPEID_ROLE /** typeid for the role object */
+};
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Convert a typeid to a string representation. The returned string
+ * is constant and should not be altered or freed.
+ *
+ * @param typeid typeid to convert to string
+ *
+ * \retval string string representing the typeid
+ */
+const char *sepol_typeid_tostring(int typeid);
+
+/**
+ * \ingroup sepol_policy
+ * \struct sepol_object
+ *
+ * sepol_object is the base class of all objects in this type system.
+ * There is no way to directly create an sepol_object - it is an
+ * abstract base class.
+ *
+ * The type system works by:
+ *   - mandating that sepol_object (or one of its subclasses) be the
+ *     first entry in every struct. This allows the structs to be
+ *     freely cast to an sepol_object or any of the other objects
+ *     in the hierarchy of that struct.
+ *   - Storing information about the types in the form of IDs. This
+ *     allows callers to determine type information at runtime.
+ *   - Storing function pointers to class specific function
+ *     implementations in each object instance. This allows functions
+ *     to have a limited form of polymorphism.
+ *
+ * sepol_object is also the parent class of all objects that are
+ * exclusively leaves in the tree (i.e., objects that cannot contain
+ * other objects).
+ *
+ * Properties that all sepol_objects share:
+ *   - string pool (strpool): [optional] an objpool for storing
+ *     strings stored in the objects. The object may be the owner of
+ *     the string pool (see sepol_object_is_strpool_owner), reference
+ *     the string pool of another object (usually the root of a policy
+ *     tree), or not have a string pool at all.
+ *   - type identifier (typeid): The sepol_typeid for this object.
+ */
+struct sepol_object;
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Convert an object to an sepol_object
+ *
+ * @param x object
+ */
+#define SEPOL_OBJECT(x) ((struct sepol_object *)x)
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Free an sepol_object. This can be called for any
+ * subclass of sepol_object.
+ *
+ * @param n object to free
+ *
+ * \retval SEPOL_OK success
+ * \retval <0 error
+ */
+extern int sepol_object_free(struct sepol_handle *h, struct sepol_object *o);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Make this object the owner of a string pool. See sepol_object for
+ * more information on string pools.
+ *
+ * @param o object to which to add string pool
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_object_create_strpool(struct sepol_handle *h, struct sepol_object *o);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Return the strpool for this object if any.
+ *
+ * @param o object from which to return string pool.
+ *
+ * \retval non-NULL string pool this object is using.
+ * \retval NULL object does not use string pool.
+ */
+extern struct sepol_objpool *sepol_object_get_strpool(struct sepol_object *o);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Determine whether the object is the owner of its string pool (if
+ * it has one).
+ *
+ * @param o object to check
+ *
+ * \retval 0 object does not own or does not have a string pool
+ * \retval 1 object owns its string pool
+ */
+extern char sepol_object_is_strpool_owner(struct sepol_object *o);
+
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Return the typeid for the object.
+ *
+ * @param o object from which to return the type id.
+ * 
+ * \retval >0 typeid for the object
+ */
+extern uint32_t sepol_object_get_typeid(struct sepol_object *o);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Determine whether the object is an instance of the object type
+ * represented by a typeid. This function checks both the specific
+ * object type (as returned by sepol_object_get_typeid) and the
+ * parent type for the object.
+ *
+ * @param o object to check
+ * @param typeid typeid
+ *
+ * \retval 0 object is not an instance of the type
+ * \retval 1 object is an instance of the type
+ */
+extern char sepol_object_isinstance(struct sepol_object *o, uint32_t typeid);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Return the parent of this object (if any).
+ *
+ * @param o object for which to return parent
+ *
+ * \retval non-NULL pointer to parent object
+ * \retval NULL object has no parent
+ */
+extern struct sepol_parent *sepol_object_get_parent(struct sepol_object *o);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Specify the output for various sepol_*_tostring functions.
+ */
+enum sepol_tostring_style {
+	SEPOL_TOSTRING_RAW, /** raw policy language */
+	SEPOL_TOSTRING_REFPOL, /** refpol style output */
+	SEPOL_TOSTRING_DEBUG /** debugging output */
+};
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Convert an sepol_object into a string representation. If the
+ * returned string is of 0 length (return is 0), str will be an
+ * allocated, 0 length string that should be freed by the caller.
+ *
+ * @param h sepol_handle (may be NULL)
+ * @param o object to convert to a string
+ * @param style style of the output - see sepol_tostring_style
+ * @param str output string - this string is allocated by the function
+ *  and should be freed by the caller using free()
+ *
+ * \retval >=0 Success - the size of the string is returned
+ * \retval <0 Failure - str will be undefined and does not need to be freed.
+ */
+extern int sepol_object_tostring(struct sepol_handle *h, struct sepol_object *o,
+				 int style, char **str);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Convert an sepol_object into a string representation for the
+ * closure of that object. Some objects - typically that contain
+ * other objects - need a string to represent the beginning _and_
+ * the end of that object. For example:
+ *
+ * \code
+ * if (foo) {
+ *   allow foo bar : file read;
+ * }
+ * \endcode
+ *
+ * In this example "if (foo) }" would be printed by
+ * sepol_object_tostring and "}} printed by
+ * sepol_object_tostring_close on the same conditional object. If the
+ * returned string is of 0 length (return is 0), str will be an
+ * allocated, 0 length string that should be freed by the caller.
+ *
+ * @param h sepol_handle (may be NULL)
+ * @param o object to convert to a string
+ * @param style style of the output - see sepol_tostring_style
+ * @param str output string - this string is allocated by the function
+ *  and should be freed by the caller using free()
+ *
+ * \retval >=0 Success - the size of the string is returned
+ * \retval <0 Failure - str will be undefined and does not need to be freed.
+ */
+extern int sepol_object_tostring_close(struct sepol_handle *h, struct sepol_object *o,
+				       int style, char **str);
+
+/**
+ * \ingroup sepol_policy
+ * \struct sepol_parent
+ *
+ * sepol_parent is the parent class of all objects that can contain
+ * other objects in the tree. Having a single base class for all parent
+ * objects allows writing functions that can traverse the tree without
+ * knowing the details about most of the objects in the tree.
+ */
+struct sepol_parent;
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Convert an object to an sepol_parent
+ *
+ * @param x object
+ */
+#define SEPOL_PARENT(x) ((struct sepol_parent *)x)
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Free a parent object and all of its children (if any). This
+ * function traverses a policy tree starting at the parent node passed
+ * in destroy each object it encounters (by (calling
+ * sepol_object_free).
+ *
+ * @param h sepol_handle (may be NULL)
+ * @param p sepol_parent object
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_parent_free_tree(struct sepol_handle *h, struct sepol_parent *p);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Append an object as a child of this parent. An object can only
+ * be the child of a single parent - to move an object from one
+ * part of the tree to another (and change the parent), remove the
+ * child from the current parent first before appending to the new
+ * parent.
+ *
+ * @param h sepol_handle (may be NULL)
+ * @param p sepol_parent to which to append child object
+ * @param o object to append (parent will be set)
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_EEXIST object is already a child of another parent
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_parent_append(struct sepol_handle *h, struct sepol_parent *p,
+			       struct sepol_object *o);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Extend the children of an sepol_parent with the objects returned by
+ * an iterator. Each object will be appended using
+ * sepol_parent_append. If there is an error from adding any of the
+ * children some of the objects may have been added. The iterator will
+ * be left in the position of the object that caused an error.
+ *
+ * @param h sepol_handle (may be NULL)
+ * @param p sepol_parent to which to add children
+ * @param iter iterator from which to add children
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_EEXIST object is already a child of another parent
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_parent_extend(struct sepol_handle *h, struct sepol_parent *p,
+			       struct sepol_iter *iter);
+
+/**
+ * \ingroup sepol_policy 
+ *
+ * Convenience function similar to sepol_parent_extend that takes a
+ * list instead of an interator.
+ *
+ * @param h sepol_handle (may be NULL)
+ * @param p sepol_parent to which to add objects
+ * @param list sepol_list from which to add objects
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_EEXIST object is already a child of another parent
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_parent_extend_list(struct sepol_handle *h, struct sepol_parent *p,
+				    struct sepol_list *list);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Delete a child object from the sepol_parent. Like sepol_list_del,
+ * the iterator will not be valid after a call to this function.
+ *
+ * @param h sepol_handle (may be NULL)
+ * @param p sepol_parent from which to delete child
+ * @param iter iterator pointing to a child object of p
+ *
+ * \retval SEPOL_OK success
+ */
+extern int sepol_parent_del(struct sepol_handle *h, struct sepol_parent *p,
+			    struct sepol_iter *iter);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Insert a child object into the list of children for the
+ * sepol_parent. See sepol_list_insert for more information on the
+ * semantics of this insert.
+ *
+ * @param h sepol_handle (may be NULL)
+ * @param p sepol_parent to which to insert child object
+ * @param iter iterator representing the position to insert the child object
+ * @param o child object to insert
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_EEXIST object is already a child of another parent
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_parent_insert(struct sepol_handle *h, struct sepol_parent *p,
+			       struct sepol_iter *iter, struct sepol_object *o);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Set an iterator to iterate over the children of an sepol_parent.
+ *
+ * @param h sepol_handle (may be NULL)
+ * @param p sepol_parent
+ * @param iter iterator to set to iterate over children
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_parent_children(struct sepol_handle *h, struct sepol_parent *p,
+				 struct sepol_iter *iter);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Return the list containing the children of the sepol_parent
+ * object. This is the actual list used to store children of the
+ * object, so changes will be reflected in the sepol_parent. It is
+ * important that deletions and insertions use sepol_parent_del and
+ * sepol_parent_insert or that the parent property of the objects
+ * is properly set.
+ *
+ * @param p sepol_parent
+ *
+ * \retval non-NULL pointer to the list of children
+ */
+struct sepol_list *sepol_parent_get_children(struct sepol_parent *parent);
+
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Traversal of a policy tree rooted at a sepol_parent can take many
+ * forms. This enumeration is used to set the traversal strategy. See
+ * http://en.wikipedia.org/wiki/Tree_traversal for more information.
+ *
+ * The hybrid strategy combines both preorder and postorder
+ * traversal. This means that each parent node will be visited twice:
+ * once before its children are traversed and once afterward. The
+ * second traversal can be detected by checking the flag indicating
+ * that the parent has been visited (see sepol_parent_isvisited).
+ */
+enum sepol_parent_traverse_strategy {
+	SEPOL_TRAVERSE_POSTORDER, /** traverse the tree in postorder */
+	SEPOL_TRAVERSE_PREORDER, /** traverse the tree in preorder */
+	SEPOL_TRAVERSE_HYBRID /** traverse the tree combining preorder and postorder */
+};
+	
+/**
+ * \ingroup sepol_policy
+ *
+ * Traverse a policy tree using parent as the root node of the tree. The traversal
+ * strategy is controlled by sepol_parent_traverse_strategy.
+ *
+ * @param h sepol_handle (may be null)
+ * @param parent sepol_parent
+ * @param iter iterator to represent traversal state
+ * @param strategy traversal strategy - see sepol_parent_traverse_strategy
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_parent_traverse(struct sepol_handle *h, struct sepol_parent *parent,
+				 struct sepol_iter *iter, int strategy);
+
+/**
+ * \ingroup sepol_policy
+ *
+ * Return whether an object has already been visited before during this tree
+ * traversal. See sepol_parent_traverse_strategy for more information.
+ *
+ * @param iter iterator
+ *
+ * \retval 0 object has not been previously visited
+ * \retval 1 object has been previously visited
+ */
+char sepol_parent_isvisited(struct sepol_iter *iter);
+
+struct sepol_policy;
+
+extern int sepol_policy_free(struct sepol_handle *h, struct sepol_policy *o);
+extern int sepol_policy_create(struct sepol_handle *h,
+			       struct sepol_policy **policy);
+
+extern char sepol_policy_get_mls(struct sepol_policy *o);
+extern int sepol_policy_set_mls(struct sepol_policy *o, char mls);
+
+struct sepol_module;
+
+extern int sepol_module_free(struct sepol_handle *h, struct sepol_module *o);
+extern int sepol_module_create(struct sepol_handle *h,
+			       struct sepol_module **module);
+extern int sepol_module_create_tree(struct sepol_handle *h,
+				    struct sepol_module **module,
+				    struct sepol_parent *root);
+
+int sepol_module_set_name(struct sepol_module *module, char *name);
+const char *sepol_module_get_name(struct sepol_module *module);
+
+int sepol_module_set_version(struct sepol_module *module, char *version);
+const char *sepol_module_get_version(struct sepol_module *module);
+
+int sepol_module_set_isbase(struct sepol_module *module, char isbase);
+char sepol_module_get_isbase(struct sepol_module *module);
+
+#endif
diff -r cacdf4377ebf -r bd4ee6e00a63 libsepol/src/policy.c
--- a/libsepol/src/policy.c	Mon May 07 15:50:27 2007 -0400
+++ b/libsepol/src/policy.c	Mon May 07 18:03:03 2007 -0400
@@ -0,0 +1,638 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "policy_internal.h"
+#include "debug.h"
+#include "dso.h"
+
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
+
+/*
+ * SEPOL_OBJECT
+ */
+
+static char *typeid_strings[] = {
+	"none",
+	"object",
+	"parent",
+	"policy",
+	"module",
+	"block",
+	"cond",
+	"optional",
+	"type",
+	"class",
+	"attribute",
+	"typealias",
+	"boolean",
+	"avrule",
+	"typerule",
+	"security context",
+	"initial sid",
+	"typeattribute",
+	"conditional expression",
+	"sensitivity",
+	"dominance",
+	"category",
+	"role dominance",
+	"role"
+};
+
+const char *sepol_typeid_tostring(int typeid)
+{
+	assert(typeid < sizeof(typeid_strings));
+	return typeid_strings[typeid];
+}
+hidden_def(sepol_typeid_tostring)
+
+int sepol_object_free(struct sepol_handle *h, struct sepol_object *o)
+{
+	assert(o->methods->free);
+
+	return o->methods->free(h, o);
+}
+hidden_def(sepol_object_free)
+
+#define SEPOL_STRPOOL_SIZE 64
+int sepol_object_create_strpool(struct sepol_handle *h, struct sepol_object *o)
+{
+	int ret;
+
+	ret = sepol_objpool_create(h, &o->strpool, (sepol_objpool_hash_t)sepol_symhash,
+				   (sepol_objpool_cmp_t)sepol_symcmp, free,
+				   SEPOL_STRPOOL_SIZE);
+	ret_check(ret);
+	o->flags |= SEPOL_OBJECT_STRPOOL_OWNER;
+	
+	return ret;
+}
+hidden_def(sepol_object_create_strpool)
+
+struct sepol_objpool *sepol_object_get_strpool(struct sepol_object *o)
+{
+	return o->strpool;
+}
+hidden_def(sepol_object_get_strpool)
+
+char sepol_object_is_strpool_owner(struct sepol_object *o)
+{
+	return (o->flags & SEPOL_OBJECT_STRPOOL_OWNER) != 0;
+}
+hidden_def(sepol_object_is_strpool_owner)
+
+uint32_t sepol_object_get_typeid(struct sepol_object *o)
+{
+	return o->typeid;
+}
+hidden_def(sepol_object_get_typeid)
+
+char sepol_object_isinstance(struct sepol_object *o, uint32_t typeid)
+{
+	if (o->typeid == typeid || o->sclass_typeid == typeid)
+		return 1;
+	else return 0;
+}
+hidden_def(sepol_object_isinstance)
+
+struct sepol_parent *sepol_object_get_parent(struct sepol_object *o)
+{
+	return o->parent;
+}
+hidden_def(sepol_object_get_parent)
+
+int sepol_object_tostring(struct sepol_handle *h, struct sepol_object *o,
+			  int style, char **str)
+{
+	if (o->methods->tostring) {
+		return o->methods->tostring(h, o, style, str);
+	} else {
+		if (style == SEPOL_TOSTRING_DEBUG) {
+			return asprintf(str, "[sepol_object(%s) at %p]",
+					sepol_typeid_tostring(o->typeid), o);
+		}
+		
+		/* Even though we are returning an empty string, we still
+		 * need to allocated an empty string to return. This
+		 * matches the behavior of asprintf.
+		 */
+		*str = strdup("");
+		if (*str == NULL)
+			return -1;
+		return 0;
+	}
+}
+hidden_def(sepol_object_tostring)
+
+int sepol_object_tostring_close(struct sepol_handle *h, struct sepol_object *o,
+				int style, char **str)
+{
+	if (o->methods->tostring_close) {
+		return o->methods->tostring_close(h, o, style, str);
+	} else {
+		if (style == SEPOL_TOSTRING_DEBUG) {
+			return asprintf(str, "[close: sepol_object(%s) at %p]",
+					sepol_typeid_tostring(o->typeid), o);
+		}
+
+		/* Even though we are returning an empty string, we still
+		 * need to allocated an empty string to return. This
+		 * matches the behavior of asprintf.
+		 */
+		*str = strdup("");
+		if (*str == NULL)
+			return -1;
+		return 0;
+	}	
+}
+hidden_def(sepol_object_tostring_close)
+
+/*
+ * SEPOL_PARENT
+ */
+
+int sepol_parent_free_tree(struct sepol_handle *h, struct sepol_parent *p)
+{
+	int ret;
+	struct sepol_iter *iter;
+	struct sepol_object *cur;
+
+	ret = sepol_iter_create(h, &iter);
+	if (ret < 0)
+		goto out;
+
+	ret = sepol_parent_traverse(h, p, iter, SEPOL_TRAVERSE_POSTORDER);
+	if (ret < 0)
+		goto out;
+
+	sepol_foreach(h, ret, cur, iter) {
+		int ret2;
+		char *str;
+		ret2 = sepol_object_tostring(h, cur, SEPOL_TOSTRING_DEBUG, &str);
+		assert(ret2 >= 0);
+		printf("freeing %s", str);
+		sepol_object_free(h, cur);
+		free(str);
+	}
+	if (ret != SEPOL_ITERSTOP)
+		goto out;
+
+	ret = SEPOL_OK;
+out:
+	sepol_iter_free(h, iter);
+	return ret;
+}
+hidden_def(sepol_parent_free_tree)
+
+int sepol_parent_append(struct sepol_handle *h, struct sepol_parent *p, struct sepol_object *o)
+{
+	if (o->parent)
+		return SEPOL_EEXIST;
+	o->parent = p;
+	return sepol_list_append(h, p->children, o);
+}
+hidden_def(sepol_parent_append)
+
+int sepol_parent_extend(struct sepol_handle *h, struct sepol_parent *p, struct sepol_iter *iter)
+{
+	int ret = SEPOL_OK;
+	struct sepol_object *cur;
+
+	sepol_foreach(h, ret, cur, iter) {
+		ret = sepol_parent_append(h, p, cur);
+		if (ret < 0) {
+			return ret;
+		}
+	}
+	if (ret != SEPOL_ITERSTOP) {
+		return ret;
+	}
+
+	return SEPOL_OK;
+}
+hidden_def(sepol_parent_extend)
+
+int sepol_parent_extend_list(struct sepol_handle *h, struct sepol_parent *p, struct sepol_list *list)
+{
+	int ret;
+	struct sepol_iter *iter;
+
+	ret = sepol_iter_create(h, &iter);
+	if (ret < 0)
+		return ret;
+	ret = sepol_list_begin(h, list, iter);
+	if (ret < 0) {
+		if (ret == SEPOL_ITERSTOP)
+			return SEPOL_OK;
+		else
+			return ret;
+	}
+	ret = sepol_parent_extend(h, p, iter);
+	sepol_iter_free(h, iter);
+
+	return ret;
+}
+hidden_def(sepol_parent_extend_list)
+
+int sepol_parent_del(struct sepol_handle *h, struct sepol_parent *p, struct sepol_iter *iter)
+{
+	struct sepol_object *o;
+	o = (struct sepol_object*)sepol_iter_get_data(h, iter);
+	if (!o) {
+		ERR(h, "error getting object from iterator");
+		return SEPOL_ERR;
+	}
+	o->parent = NULL;
+	return sepol_list_del(h, p->children, iter);
+}
+hidden_def(sepol_parent_del)
+
+int sepol_parent_insert(struct sepol_handle *h, struct sepol_parent *p,
+			struct sepol_iter *iter, struct sepol_object *o)
+{
+	if (o->parent)
+		return SEPOL_EEXIST;
+	o->parent = p;
+		
+	return sepol_list_insert(h, p->children, iter, o);
+}
+hidden_def(sepol_parent_insert)
+
+
+int sepol_parent_children(struct sepol_handle *h, struct sepol_parent *p, struct sepol_iter *iter)
+{
+	return sepol_list_begin(h, p->children, iter);
+}
+hidden_def(sepol_parent_children)
+
+struct sepol_list *sepol_parent_get_children(struct sepol_parent *parent)
+{
+	return parent->children;
+}
+hidden_def(sepol_parent_get_children)
+
+
+struct sepol_parent_traverse_state
+{
+	int strategy;
+	char cur_flags;
+	struct sepol_list *stack;
+	void *object;
+};
+
+static void *sepol_parent_iter_get_data(struct sepol_handle *h, struct sepol_iter *iter)
+{
+	struct sepol_parent_traverse_state *state;
+	
+	assert(iter);
+	state = (struct sepol_parent_traverse_state*)
+		sepol_iter_get_state(iter);
+	assert(state);
+
+	return state->object;
+}
+
+static int sepol_parent_iter_free(struct sepol_handle *h, void *data)
+{
+	struct sepol_parent_traverse_state *state = 
+		(struct sepol_parent_traverse_state*)data;
+
+	if (state == NULL)
+		return SEPOL_OK;
+
+	if (state->stack)
+		sepol_list_free(state->stack);
+	free(state);
+
+	return SEPOL_OK;
+}
+
+static int sepol_parent_traverse_preorder_next(struct sepol_handle *h, struct sepol_iter *iter)
+{
+	int ret;
+	struct sepol_parent_traverse_state *state;
+	struct sepol_object *object, *cur;
+	struct sepol_iter *child_iter;
+
+	state = sepol_iter_get_state(iter);
+
+	ret = sepol_list_pop_back(h, state->stack, (void**)&object);
+	
+	if (ret == SEPOL_ERANGE)
+		return SEPOL_ITERSTOP;
+	else if (ret < 0)
+		return ret;
+		
+	state->object = object;
+	state->cur_flags = object->flags;
+
+	if (sepol_object_isinstance(object, SEPOL_TYPEID_PARENT) &&
+	    !(object->flags & SEPOL_OBJECT_VISITED)) {
+		if (state->strategy == SEPOL_TRAVERSE_HYBRID) {
+			object->flags |= SEPOL_OBJECT_VISITED;
+			ret = sepol_list_append(h, state->stack, object);
+			ret_check(ret);
+		}
+		ret = sepol_iter_create(h, &child_iter);
+		ret_check(ret);
+		ret = sepol_list_end(h, sepol_parent_get_children(SEPOL_PARENT(object)),
+				     child_iter);
+		while (ret == SEPOL_OK) {
+			cur = sepol_iter_get_data(h, child_iter);
+			cur->flags &= ~SEPOL_OBJECT_VISITED;
+			ret = sepol_list_append(h, state->stack, cur);
+			if (ret < 0)
+				break;
+			ret = sepol_iter_prev(h, child_iter);
+		}
+		sepol_iter_free(h, child_iter);
+		if (ret < 0 && ret != SEPOL_ITERSTOP) {
+			return ret;
+		}
+
+	}
+	return SEPOL_OK;	
+}
+
+static int sepol_parent_traverse_postorder_next(struct sepol_handle *h, struct sepol_iter *iter)
+{
+	int ret;
+	struct sepol_parent_traverse_state *state;
+	struct sepol_object *object, *cur;
+	struct sepol_iter *child_iter;
+
+	state = sepol_iter_get_state(iter);
+
+	while (1) {
+		ret = sepol_list_pop_back(h, state->stack, (void**)&object);
+		
+		if (ret == SEPOL_ERANGE)
+			return SEPOL_ITERSTOP;
+		else if (ret < 0)
+			return ret;
+		
+		if (object->flags & SEPOL_OBJECT_VISITED ||
+		    !sepol_object_isinstance(object, SEPOL_TYPEID_PARENT)) {
+			state->object = object;
+			break;
+		} else {
+			object->flags |= SEPOL_OBJECT_VISITED;
+			ret = sepol_list_append(h, state->stack, object);
+			ret_check(ret);
+
+			ret = sepol_iter_create(h, &child_iter);
+			ret_check(ret);
+			ret = sepol_list_end(h, sepol_parent_get_children(SEPOL_PARENT(object)),
+								       child_iter);
+			while (ret == SEPOL_OK) {
+				cur = sepol_iter_get_data(h, child_iter);
+				cur->flags &= ~SEPOL_OBJECT_VISITED;
+				ret = sepol_list_append(h, state->stack, cur);
+				if (ret < 0)
+					break;
+				ret = sepol_iter_prev(h, child_iter);
+			}
+			sepol_iter_free(h, child_iter);
+			if (ret < 0 && ret != SEPOL_ITERSTOP) {
+				return ret;
+			}
+		}
+	}
+	return SEPOL_OK;
+}
+
+int sepol_parent_traverse(struct sepol_handle *h, struct sepol_parent *parent,
+			  struct sepol_iter *iter, int strategy)
+{
+	int ret;
+	struct sepol_parent_traverse_state *state = NULL;
+
+	state = calloc(1, sizeof(struct sepol_parent_traverse_state));
+	if (state == NULL)
+		return SEPOL_ENOMEM;
+
+	ret = sepol_list_create(h, &state->stack);
+	ret_goto(ret, err);
+
+	state->strategy = strategy;
+	sepol_iter_set_state(iter, state);
+
+	if (state->strategy == SEPOL_TRAVERSE_POSTORDER)
+		sepol_iter_set_next(iter, sepol_parent_traverse_postorder_next);
+	else if (state->strategy == SEPOL_TRAVERSE_PREORDER ||
+		state->strategy == SEPOL_TRAVERSE_HYBRID)
+		sepol_iter_set_next(iter, sepol_parent_traverse_preorder_next);
+	else
+		return SEPOL_ERR;
+	sepol_iter_set_free(iter, sepol_parent_iter_free);
+	sepol_iter_set_get_data(iter, sepol_parent_iter_get_data);
+
+
+	parent->sclass.flags &= ~SEPOL_OBJECT_VISITED;
+	ret = sepol_list_append(h, state->stack, parent);
+	ret_goto(ret, err);
+	ret = sepol_iter_next(h, iter);
+	ret_goto(ret, err);
+
+	return SEPOL_OK;
+err:
+	sepol_parent_iter_free(h, state);
+	return ret;
+}
+hidden_def(sepol_parent_traverse)
+
+char sepol_parent_isvisited(struct sepol_iter *iter)
+{
+	struct sepol_parent_traverse_state *state;
+
+	state = sepol_iter_get_state(iter);
+	if (state->cur_flags & SEPOL_OBJECT_VISITED)
+		return 1;
+	else
+		return 0;
+}
+hidden_def(sepol_parent_isvisited)
+
+/*
+ * SEPOL_POLICY
+ */
+
+struct sepol_policy
+{
+	struct sepol_parent sclass;
+	char mls;
+};
+
+int sepol_policy_free(struct sepol_handle *h, struct sepol_policy *o)
+{
+	intern_sepol_parent_free(SEPOL_PARENT(o));
+	free(o);
+
+	return SEPOL_OK;
+}
+
+static int sepol_policy_tostring(struct sepol_handle *h, 
+				 struct sepol_object * object __attribute__ ((unused)),
+				 int style, char **str)
+{
+	if (style == SEPOL_TOSTRING_DEBUG) {
+		return asprintf(str, "POLICY {");
+	} else {
+		*str = strdup("");
+		if (*str)
+			return 0;
+		else
+			return -1;
+	}
+}
+
+static int sepol_policy_tostring_close(struct sepol_handle *h __attribute__ ((unused)),
+				       struct sepol_object *object __attribute__ ((unused)),
+				       int style, char **str)
+{
+	if (style == SEPOL_TOSTRING_DEBUG) {
+		return asprintf(str, "POLICY {");
+	} else {
+		*str = strdup("");
+		if (*str)
+			return 0;
+		else
+			return -1;
+	}
+}
+
+static struct sepol_object_methods sepol_policy_methods = {
+	.free = (sepol_object_free_t)sepol_policy_free,
+	.tostring = sepol_policy_tostring,
+	.tostring_close = sepol_policy_tostring_close
+};
+
+int sepol_policy_create(struct sepol_handle *h, struct sepol_policy **policy)
+{
+	int ret;
+	struct sepol_policy *x;
+
+	*policy = NULL;
+	x = calloc(1, sizeof(struct sepol_policy));
+	if (x == NULL) {
+		return SEPOL_ENOMEM;
+	}
+
+	ret = intern_sepol_parent_init(h, SEPOL_PARENT(x), SEPOL_TYPEID_POLICY,
+				       &sepol_policy_methods, NULL);
+	ret_goto(ret, out);
+
+	/* policy always has a strpool for convenience */
+	ret = sepol_object_create_strpool(h, SEPOL_OBJECT(x));
+	ret_goto(ret, out);
+
+	*policy = x;
+	return SEPOL_OK;
+out:
+	intern_sepol_parent_free(SEPOL_PARENT(x));
+	return ret;
+}
+
+DEFINE_BOOL_PROP(policy, mls)
+
+/*
+ * SEPOL_MODULE
+ */
+
+struct sepol_module
+{
+	struct sepol_parent sclass;
+	char *name;
+	char *version;
+	char isbase;
+};
+
+int sepol_module_free(struct sepol_handle *h, struct sepol_module *o)
+{
+	int ret;
+
+	ret = intern_sepol_object_delstr(h, o, o->name);
+	ret_check(ret);
+
+	ret = intern_sepol_object_delstr(h, o, o->version);
+	ret_check(ret);
+
+	intern_sepol_parent_free(SEPOL_PARENT(o));
+
+	free(o);
+
+	return SEPOL_OK;
+}
+hidden_def(sepol_module_free)
+
+static int sepol_module_tostring(struct sepol_handle *h, struct sepol_object *object,
+				 int style, char **str)
+{
+	struct sepol_module *module = (struct sepol_module *)object;
+						
+	if (module->name == NULL || module->version == NULL)
+		return -1;
+
+	if (style == SEPOL_TOSTRING_REFPOL)
+		return asprintf(str, "policy_module(%s %s)", module->name,
+				module->version);
+	else
+		return asprintf(str, "module %s %s;", module->name, module->version);
+}
+
+static struct sepol_object_methods sepol_module_methods = {
+	.free = (sepol_object_free_t)sepol_module_free,
+	.tostring = sepol_module_tostring
+};
+
+int sepol_module_create(struct sepol_handle *h, struct sepol_module **module)
+{
+	return sepol_module_create_tree(h, module, NULL);
+}
+hidden_def(sepol_module_create)
+
+int sepol_module_create_tree(struct sepol_handle *h, struct sepol_module **module,
+			     struct sepol_parent *root)
+{
+	int ret;
+	struct sepol_module *x;
+
+	*module = NULL;
+	x = calloc(1, sizeof(struct sepol_module));
+	if (x == NULL) {
+		return SEPOL_ENOMEM;
+	}
+
+	ret = intern_sepol_parent_init(h, SEPOL_PARENT(x), SEPOL_TYPEID_MODULE,
+				       &sepol_module_methods, root);
+	ret_goto(ret, out);
+
+	*module = x;
+	return SEPOL_OK;
+out:
+	free(x);
+	return ret;
+}
+hidden_def(sepol_module_create_tree)
+
+DEFINE_STR_PROP(module, name)
+DEFINE_STR_PROP(module, version)
+DEFINE_BOOL_PROP(module, isbase)
diff -r cacdf4377ebf -r bd4ee6e00a63 libsepol/src/policy_internal.c
--- a/libsepol/src/policy_internal.c	Mon May 07 15:50:27 2007 -0400
+++ b/libsepol/src/policy_internal.c	Mon May 07 18:03:03 2007 -0400
@@ -0,0 +1,102 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "policy_internal.h"
+
+int intern_sepol_object_init(struct sepol_handle *h, struct sepol_object *o, uint32_t typeid,
+			     struct sepol_object_methods *methods, struct sepol_parent *root)
+{
+	memset(o, 0, sizeof(struct sepol_object));
+	o->sclass_typeid = SEPOL_TYPEID_OBJECT;
+	o->typeid = typeid;
+	o->methods = methods;
+	if (root && sepol_object_get_strpool(SEPOL_OBJECT(root)))
+		o->strpool = sepol_object_get_strpool(SEPOL_OBJECT(root));
+	
+	
+	return 0;
+}
+
+void intern_sepol_object_free(struct sepol_object *o)
+{
+	if (o == NULL)
+		return;
+
+	if (o->flags & SEPOL_OBJECT_STRPOOL_OWNER)
+		sepol_objpool_free(NULL, o->strpool);
+}
+
+int _intern_sepol_object_addstr(struct sepol_handle *h, struct sepol_object *o, char **str)
+{
+	char *tmp;
+
+	tmp = strdup(*str);
+	if (!tmp)
+		return SEPOL_ENOMEM;
+
+	*str = tmp;
+
+	if (o->strpool) {
+		*str = sepol_objpool_add(h, o->strpool, *str);
+		if (!*str)
+			return SEPOL_ENOMEM;
+	}
+
+	return SEPOL_OK;
+}
+
+int _intern_sepol_object_delstr(struct sepol_handle *h, struct sepol_object *o, char *str)
+{
+	int ret;
+
+	if (str == NULL)
+		return SEPOL_OK;
+
+	if (o->strpool) {
+		ret = sepol_objpool_del(h, o->strpool, str);
+		return ret;
+	} else {
+		free(str);
+		return SEPOL_OK;
+	}
+}
+
+int intern_sepol_parent_init(struct sepol_handle *h, struct sepol_parent *p, uint32_t typeid,
+			     struct sepol_object_methods *methods, struct sepol_parent *root)
+{
+	int ret;
+
+	ret = intern_sepol_object_init(h, SEPOL_OBJECT(p), typeid, methods, root);
+	ret_check(ret);
+	p->sclass.sclass_typeid = SEPOL_TYPEID_PARENT;
+
+	ret = sepol_list_create(h, &p->children);
+	if (ret < 0)
+		sepol_object_free(h, SEPOL_OBJECT(p));
+
+	return ret;
+}
+
+void intern_sepol_parent_free(struct sepol_parent *p)
+{
+	intern_sepol_object_free(SEPOL_OBJECT(p));
+
+	sepol_list_free(p->children);
+}
diff -r cacdf4377ebf -r bd4ee6e00a63 libsepol/src/policy_internal.h
--- a/libsepol/src/policy_internal.h	Mon May 07 15:50:27 2007 -0400
+++ b/libsepol/src/policy_internal.h	Mon May 07 18:03:03 2007 -0400
@@ -0,0 +1,269 @@
+#ifndef __policy_internal_h__
+#define __policy_internal_h__
+
+#include "dso.h"
+
+#include <sepol/policy.h>
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/conditional.h>
+
+#include <stdlib.h>
+#include <sys/types.h>
+
+/* Internal structs and functions for the policy object system. In
+ * general, policy objects cannot be created outside of the libsepol
+ * tree. It is possible, but not currently implemented, so there is
+ * quite a lot of internals in this header.
+ *
+ * One of the goals of this object system is to allow polymorphic
+ * methods. That will allow calling , for example, sepol_object_free
+ * on _any_ subclass of sepol_object and have the correct function
+ * called for the specific subclass. This polymorphism is implemented
+ * using an sepol_object_method struct for each class and a pointer to
+ * that struct held in each object instance.
+ *
+ * A subclass is expected to create an sepol_object_methods struct
+ * containing function pointers for the methods that it implements (it
+ * is valid for some of the function pointers to be NULL). Every
+ * instance of an sepol_object object holds a pointer to a single
+ * methods struct - i.e., there is only one struct per class and every
+ * instance holds a pointer to that struct.
+ *
+ * See sepol_object_init for how this pointer is set and sepol_object_free
+ * for how subclass methods are called.
+ */
+
+/* sepol_object_free_t is the type for the free method used in the policy
+ * object system. Implementations of this method should free all of the
+ * memory associated with the object including the struct.
+ */
+typedef int (*sepol_object_free_t)(struct sepol_handle *h, struct sepol_object *o);
+typedef int (*sepol_object_tostring_t)(struct sepol_handle *h, struct sepol_object *o,
+				       int style, char **str);
+
+struct sepol_object_methods
+{
+        sepol_object_free_t free;
+        sepol_object_tostring_t tostring;
+        sepol_object_tostring_t tostring_close;
+};
+
+#define SEPOL_OBJECT_STRPOOL_OWNER   1
+#define SEPOL_OBJECT_VISITED         2
+struct sepol_object
+{
+	struct sepol_object_methods *methods;
+	struct sepol_parent *parent;
+	struct sepol_objpool *strpool;
+	uint32_t sclass_typeid;
+	uint32_t typeid;
+	uint32_t lineno;
+	char flags;
+};
+
+/* Private initialization function for all objects. This function only
+ * initializes the generic object properties - the type specific creation
+ * function is responsible for initializing any type specific properties.
+ * If this function fails it will clean up any memory that it allocated. The
+ * calling function is responsible for any type specific memory and for freeing
+ * the object struct.
+ *
+ * params:
+ *  o - object to initialize
+ *  typeid - typeid of o
+ *  methods - pointer to sepol_object_methods struct for this type. Should
+ *   be a pointer to a single static struct for all instances of this type.
+ *  root - root of the policy tree of which o is a member (may be NULL). If
+ *    the root is non-NULL and has a string pool then that string pool is
+ *    used for this object.
+ */
+int intern_sepol_object_init(struct sepol_handle *h, struct sepol_object *o, uint32_t typeid,
+			     struct sepol_object_methods *methods, struct sepol_parent *root);
+
+/* Free any memory associated with the super class. This should be called
+ * from a type specific free function.
+ */
+void intern_sepol_object_free(struct sepol_object *o);
+
+/* Add a string to the string pool of the object. After a call to this
+ * function the str pointer will point to the correct (and possibly
+ * shared) version of the string to use.
+ */
+#define intern_sepol_object_addstr(h, o, str) _intern_sepol_object_addstr(h, SEPOL_OBJECT(o), str)
+int _intern_sepol_object_addstr(struct sepol_handle *h, struct sepol_object *o, char **str);
+
+/* Delete a string. If the object has a string pool the memory
+ * associated with the string may not be released
+ * immediately. Regardless, the caller should assume that the pointer
+ * is invalid after a call to this function.
+ */
+#define intern_sepol_object_delstr(h, o, str) _intern_sepol_object_delstr(h, SEPOL_OBJECT(o), str)
+int _intern_sepol_object_delstr(struct sepol_handle *h, struct sepol_object *o, char *str);
+
+hidden_proto(sepol_typeid_tostring)
+hidden_proto(sepol_object_free)
+hidden_proto(sepol_object_create_strpool)
+hidden_proto(sepol_object_get_strpool)
+hidden_proto(sepol_object_is_strpool_owner)
+hidden_proto(sepol_object_get_typeid)
+hidden_proto(sepol_object_isinstance)
+hidden_proto(sepol_object_get_parent)
+hidden_proto(sepol_object_tostring)
+hidden_proto(sepol_object_tostring_close)
+
+struct sepol_parent
+{
+	struct sepol_object sclass;
+	struct sepol_list *children;
+};
+
+/* Initialize an sepol_parent object. Same function and general
+ * properties as intern_sepol_object_init but for parent
+ * objects. Objects should only call the init function for their
+ * immediate parent - the parent is responsible for any further
+ * chaining up the type hierarchy.
+ */
+int intern_sepol_parent_init(struct sepol_handle *h, struct sepol_parent *p, uint32_t typeid,
+			     struct sepol_object_methods *methods, struct sepol_parent *root);
+
+/* Internal free function for sepol_paren objects. Like the init functions
+ * this chains up the type hierarchy by call inter_sepol_object_free.
+ */
+void intern_sepol_parent_free(struct sepol_parent *p);
+
+hidden_proto(sepol_parent_free_tree)
+hidden_proto(sepol_parent_append)
+hidden_proto(sepol_parent_extend)
+hidden_proto(sepol_parent_extend_list)
+hidden_proto(sepol_parent_del)
+hidden_proto(sepol_parent_insert)
+hidden_proto(sepol_parent_children)
+hidden_proto(sepol_parent_get_children)
+hidden_proto(sepol_parent_traverse)
+hidden_proto(sepol_parent_isvisited)
+
+/* sepol_policy */
+hidden_proto(sepol_policy_free)
+hidden_proto(sepol_policy_get_mls)
+hidden_proto(sepol_policy_set_mls)
+
+/* sepol_module */
+hidden_proto(sepol_module_free)
+hidden_proto(sepol_module_create)
+hidden_proto(sepol_module_create_tree)
+hidden_proto(sepol_module_set_name)
+hidden_proto(sepol_module_get_name)
+hidden_proto(sepol_module_set_version)
+hidden_proto(sepol_module_get_version)
+hidden_proto(sepol_module_set_isbase)
+hidden_proto(sepol_module_get_isbase)
+
+
+/* some convenience macros to check return values */
+#define ret_check(ret) { if (ret < 0) return ret; }
+#define ret_goto(ret, tag) { if (ret < 0) goto tag; }
+
+
+/*
+ * PROPERTY GENERATION MACROS
+ *
+ * Many of the objects are similar and will have almost identical
+ * functions for getting and setting properties. These macros generate
+ * those functions for brevity and correctness.
+ */
+
+/* Initialize an object set for holding strings. This should be used
+ * in an object creation function to initialize a string set. This
+ * handles object pooling.
+ */
+#define INIT_STRSET(obj, set, ret, target) {				\
+		if (SEPOL_OBJECT(obj)->strpool) {				\
+			ret = sepol_objset_create(&obj->set, sepol_policy_ptrcmp); \
+			ret_goto(ret, target);				\
+		} else {						\
+			ret = sepol_objset_create(&obj->set,		\
+						  (sepol_objset_cmp_t)sepol_policy_strcmp); \
+			ret_goto(ret, target);				\
+		} }
+
+#define DESTROY_STRSET(obj, set, iter, ret) {				\
+		if (obj->set != NULL) {					\
+			ret = sepol_iter_create(&iter);			\
+			ret_check(ret);					\
+			ret = sepol_objset_iter(obj->set, iter);	\
+			if (ret < 0 && ret != SEPOL_ITERSTOP) return ret; \
+			while (ret == SEPOL_OK) {			\
+				ret = intern_sepol_object_delstr(obj, sepol_iter_get_data(iter)); \
+				ret_check(ret);				\
+				ret = sepol_iter_next(iter);		\
+			}						\
+			sepol_iter_destroy(iter);			\
+			if (ret != SEPOL_ITERSTOP) return ret;		\
+		} \
+		sepol_objset_destroy(obj->set); }
+			
+
+#define DEFINE_STR_PROP(obj, prop)					\
+	int sepol_##obj##_set_##prop(struct sepol_##obj *x, char *prop) \
+        {								\
+		int ret;						\
+		if (x-> prop ) {					\
+			ret = intern_sepol_object_delstr(NULL, x, x-> prop ); \
+			ret_check(ret);					\
+		}							\
+		x-> prop = prop;					\
+		return intern_sepol_object_addstr(NULL, x, &x-> prop );	\
+	}								\
+	hidden_def(sepol_##obj##_set_##prop)				\
+	const char *sepol_##obj##_get_##prop(struct sepol_##obj *x)	\
+	{								\
+		return x-> prop ;					\
+	}								\
+	hidden_def(sepol_##obj##_get_##prop)			       
+
+#define DEFINE_BOOL_PROP(obj, prop)				       \
+	int sepol_##obj##_set_##prop(struct sepol_##obj *x, char prop) \
+        {							       \
+		x-> prop = prop;				       \
+		return SEPOL_OK;				       \
+	}							       \
+	hidden_def(sepol_##obj##_set_##prop)			       \
+	char sepol_##obj##_get_##prop(struct sepol_##obj *x)    \
+	{							       \
+		return x-> prop ;				       \
+	}							       \
+	hidden_def(sepol_##obj##_get_##prop)			       
+
+#define DEFINE_UINT_PROP(obj, prop)				       \
+	int sepol_##obj##_set_##prop(struct sepol_##obj *x, uint32_t prop) \
+        {							       \
+		x->prop = prop;				       \
+		return SEPOL_OK;				       \
+	}							       \
+	hidden_def(sepol_##obj##_set_##prop)			       \
+	uint32_t sepol_##obj##_get_##prop(struct sepol_##obj *x)	       \
+	{							       \
+		return x->prop ;				       \
+	}							       \
+	hidden_def(sepol_##obj##_get_##prop)			       
+
+#define DEFINE_STRSET_PROP(obj, prop, set)				\
+	int sepol_##obj##_add_##prop(struct sepol_##obj *x, char *prop) \
+	{								\
+		int ret;						\
+		char *tmp = strdup(prop);				\
+		ret = intern_sepol_object_addstr(x, &tmp);			\
+		ret_check(ret);						\
+		ret = sepol_objset_add(x->set, tmp);			\
+		ret_check(ret);						\
+		return SEPOL_OK;					\
+	}								\
+	hidden_def(sepol_##obj##_set_##prop)			       \
+	struct sepol_objset *sepol_##obj##_get_##set(struct sepol_##obj *x) \
+	{								\
+		return x->set;						\
+	}								\
+	hidden_def(sepol_##obj##_get_##prop)			       
+
+
+#endif
diff -r cacdf4377ebf -r bd4ee6e00a63 libsepol/tests/libsepol-tests.c
--- a/libsepol/tests/libsepol-tests.c	Mon May 07 15:50:27 2007 -0400
+++ b/libsepol/tests/libsepol-tests.c	Mon May 07 18:03:03 2007 -0400
@@ -26,6 +26,7 @@
 #include "test-hashtab.h"
 #include "test-objpool.h"
 #include "test-objset.h"
+#include "test-policy.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -61,14 +62,15 @@ static int do_tests(int interactive, int
 	if (CUE_SUCCESS != CU_initialize_registry())
 		return CU_get_error();
 
-	DECLARE_SUITE(cond);
-	DECLARE_SUITE(linker);
-	DECLARE_SUITE(expander);
-	DECLARE_SUITE(deps);
+	//DECLARE_SUITE(cond);
+	//DECLARE_SUITE(linker);
+	//DECLARE_SUITE(expander);
+	//DECLARE_SUITE(deps);
 	DECLARE_SUITE(list);
 	DECLARE_SUITE(hashtab);
 	DECLARE_SUITE(objpool);
 	DECLARE_SUITE(objset);
+	DECLARE_SUITE(policy);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff -r cacdf4377ebf -r bd4ee6e00a63 libsepol/tests/test-policy.c
--- a/libsepol/tests/test-policy.c	Mon May 07 15:50:27 2007 -0400
+++ b/libsepol/tests/test-policy.c	Mon May 07 18:03:03 2007 -0400
@@ -0,0 +1,118 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "test-policy.h"
+
+#include <sepol/policy.h>
+#include <sepol/iter.h>
+#include <sepol/errcodes.h>
+
+#include <stdlib.h>
+#include <stdio.h>
+
+int policy_test_init(void)
+{
+	return 0;
+}
+
+int policy_test_cleanup(void)
+{
+	return 0;
+}
+
+static void test_policy(void)
+{
+	int ret;
+	char *str;
+
+	struct sepol_handle *h;
+	struct sepol_iter *iter;
+	struct sepol_object *cur;
+
+	struct sepol_policy *policy;
+	struct sepol_module *module;
+
+	h = sepol_handle_create();
+	CU_ASSERT(h != NULL);
+
+	ret = sepol_policy_create(h, &policy);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_module_create_tree(h, &module, SEPOL_PARENT(policy));
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_module_set_isbase(module, 0);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_module_set_name(module, strdup("foo"));
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_module_set_version(module, strdup("1.0"));
+	CU_ASSERT(ret == SEPOL_OK);
+	
+	ret = sepol_parent_append(h, SEPOL_PARENT(policy), SEPOL_OBJECT(module));
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_module_create_tree(h, &module, SEPOL_PARENT(policy));
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_module_set_isbase(module, 1);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_module_set_name(module, strdup("bar"));
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_module_set_version(module, strdup("1.0"));
+	CU_ASSERT(ret == SEPOL_OK);
+	
+	ret = sepol_parent_append(h, SEPOL_PARENT(policy), SEPOL_OBJECT(module));
+	CU_ASSERT(ret == SEPOL_OK);
+
+
+	ret = sepol_iter_create(h, &iter);
+	CU_ASSERT(ret == SEPOL_OK);
+	ret = sepol_parent_traverse(h, SEPOL_PARENT(policy), iter, SEPOL_TRAVERSE_POSTORDER);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	sepol_foreach(h, ret, cur, iter) {
+		ret = sepol_object_tostring(h, cur, SEPOL_TOSTRING_DEBUG, &str);
+		CU_ASSERT(ret >= 0);
+		printf("%s\n", str);
+		free(str);
+	}
+	CU_ASSERT(ret == SEPOL_ITERSTOP);
+
+	//ret = sepol_parent_output_tree(SEPOL_PARENT(policy), stdout, SEPOL_DEBUG_OUTPUT);
+
+	ret = sepol_parent_free_tree(h, SEPOL_PARENT(policy));
+	CU_ASSERT(ret == SEPOL_OK);
+	sepol_iter_free(h, iter);
+	sepol_handle_destroy(h);
+}
+
+int policy_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "test_policy",
+				test_policy)) {
+		return -1;
+	}
+
+	return 0;
+}
diff -r cacdf4377ebf -r bd4ee6e00a63 libsepol/tests/test-policy.h
--- a/libsepol/tests/test-policy.h	Mon May 07 15:50:27 2007 -0400
+++ b/libsepol/tests/test-policy.h	Mon May 07 18:03:03 2007 -0400
@@ -0,0 +1,12 @@
+/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __test_policy_h__
+#define __test_policy_h__
+
+#include <CUnit/Basic.h>
+
+int policy_test_init(void);
+int policy_test_cleanup(void);
+int policy_add_tests(CU_pSuite suite);
+
+#endif

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
