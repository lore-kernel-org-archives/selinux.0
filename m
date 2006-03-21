Message-Id: <200603212246.k2LMkRNq028071@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: "Selinux-Dev" <selinux-dev@tresys.com>
Subject: [RFC][PATCH] extending the libsepol API
Date: Tue, 21 Mar 2006 17:46:27 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0045_01C64D0F.617D2F00"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0045_01C64D0F.617D2F00
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello All,

Some of us at Tresys have been working on changing setools to use libsepol
as our underlying policy representation.  Our basic goals are the following:

1. Provide setools (and other analysis tools) with some of the added
features of libsepol such as modular policy, the new language features, etc 
2. Reduce the redundancy and maintenance required to maintain our own policy
representation 

To make our changes we have been working on some API additions for libsepol.
The attached diff adds some header files that represent how we plan to
export a new shared API for accessing types/attribs.  The patch is the first
of many aimed at fleshing out the shared API.  The diff contains just the
headers as we would like to get some feedback from the community at this
point.

The patch adds two files: "include/iterator.h" and "include/type_query.h".  

We are concerned about consistency in the API and so we intend that the
remaining component accessors will look very similar to the types API.
Ultimately we will need to add access to all other components in the policy
as well as rules and interfaces.  We feel that the iterator concept will
scale well to those functions.

As for the limited number of accessor functions that currently exist,
(users, booleans, etc.) we feel that the current design metaphors don't fit
well with our requirements and we are not sure what to do about them long
term as we are presenting something very different, and as I said we are
concerned about consistency.  There are several long-term options: 1.
Deprecate them in source and keep them for ABI stability, 2. Don't do number
1 ;)

We are looking for constructive feedback, so any comments will be helpful.
We have documented our headers with the doxygen format as we think this is
helpful, we are more than happy to continue or discontinue that format as
work continues, as well as make changes to fit our needs with the rest of
the community.

Again, our goal here is to build something that is more complete in scope
than the current functions, and ultimately found beneficial to the whole
SELinux community.

Kevin Carr
Tresys Technology
410.290.1411 x137


------=_NextPart_000_0045_01C64D0F.617D2F00
Content-Type: application/octet-stream;
	name="types-api.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="types-api.patch"

diff -purN --exclude=3D.svn trunk/libsepol/include/sepol/iterator.h =
branch/setools_export-types/libsepol/include/sepol/iterator.h=0A=
--- trunk/libsepol/include/sepol/iterator.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ branch/setools_export-types/libsepol/include/sepol/iterator.h	=
2006-03-12 04:31:26.000000000 -0500=0A=
@@ -0,0 +1,86 @@=0A=
+/**=0A=
+ * @file iterator.h=0A=
+ * Defines the public API for sepol_iterator; this structure=0A=
+ * is used when requesting lists of components from the policy=0A=
+ * database.=0A=
+ * =0A=
+ * @author Kevin Carr kcarr@tresys.com=0A=
+ * @author Jeremy A. Mowery jmowery@tresys.com=0A=
+ * @author Jason Tang jtang@tresys.com=0A=
+ *=0A=
+ * Copyright (C) 2006 Tresys Technology, LLC=0A=
+ *=0A=
+ *  This library is free software; you can redistribute it and/or=0A=
+ *  modify it under the terms of the GNU Lesser General Public=0A=
+ *  License as published by the Free Software Foundation; either=0A=
+ *  version 2.1 of the License, or (at your option) any later version.=0A=
+ *=0A=
+ *  This library is distributed in the hope that it will be useful,=0A=
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
+ *  Lesser General Public License for more details.=0A=
+ *=0A=
+ *  You should have received a copy of the GNU Lesser General Public=0A=
+ *  License along with this library; if not, write to the Free Software=0A=
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
+ */=0A=
+=0A=
+#ifndef SEPOL_ITERATOR_H=0A=
+#define SEPOL_ITERATOR_H=0A=
+=0A=
+#include <stddef.h>=0A=
+=0A=
+struct sepol_iterator;=0A=
+typedef struct sepol_iterator sepol_iterator_t;=0A=
+=0A=
+/**=0A=
+ *  Free memory used by the iterator.=0A=
+ *  @param iter Pointer to the iterator to be freed; frees all=0A=
+ *  memory used by the iterator and the iterator itself. On returning=0A=
+ *  *iter will be NULL.=0A=
+ */=0A=
+extern void sepol_iterator_destroy(sepol_iterator_t **iter);=0A=
+=0A=
+/**=0A=
+ *  Get the item at the current position of the iterator.=0A=
+ *  @param iter The iterator from which to get the item.=0A=
+ *  @param item Pointer in which to store the current item; the caller =
is =0A=
+ *  responsible for safely casting this pointer. Unless specifically=0A=
+ *  noted by the function creating the iterator, the item set =0A=
+ *  by this function should not be freed. If the iterator is at =0A=
+ *  the end (i.e. all items have been traversed) *item will be NULL.=0A=
+ *  @return Returns 0 on success and < 0 on failure; if the call fails,=0A=
+ *  errno will be set and *item will be NULL.=0A=
+ */=0A=
+extern int sepol_iterator_get_item(sepol_iterator_t *iter, void **item);=0A=
+=0A=
+/**=0A=
+ *  Advance the iterator to the next item.=0A=
+ *  @param iter The iterator to advance; internal state data will =
change.=0A=
+ *  @return Returns 0 on success and < 0 on failure; advancing an=0A=
+ *  iterator that is at the end fails (and returns < 0). If the call =
fails,=0A=
+ *  errno will be set.=0A=
+ */=0A=
+extern int sepol_iterator_next(sepol_iterator_t *iter);=0A=
+=0A=
+/**=0A=
+ *  Determine if an iterator is at the end.=0A=
+ *  @param iter The iterator to check.=0A=
+ *  @return Returns non-zero if the current position of the iterator=0A=
+ *  is at the end of the list (i.e. past the last valid item) and=0A=
+ *  zero in any other case. If there is an error determining if=0A=
+ *  the iterator is at the end then non-zero will be returned.=0A=
+ */=0A=
+extern int sepol_iterator_is_end(sepol_iterator_t *iter);=0A=
+=0A=
+/**=0A=
+ *  Get the total number of items in the list stored in the iterator.=0A=
+ *  @param iter The iterator from which to get the number of items.=0A=
+ *  @param size Pointer in which to store the number of items. =0A=
+ *  Must be non-NULL.=0A=
+ *  @return Returns 0 on success and < 0 on failure; if the call fails,=0A=
+ *  errno will be set and *size will be 0.=0A=
+ */=0A=
+extern int sepol_iterator_get_size(sepol_iterator_t *iter, size_t =
*size);=0A=
+=0A=
+#endif /* SEPOL_ITERATOR */=0A=
diff -purN --exclude=3D.svn trunk/libsepol/include/sepol/type_query.h =
branch/setools_export-types/libsepol/include/sepol/type_query.h=0A=
--- trunk/libsepol/include/sepol/type_query.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ branch/setools_export-types/libsepol/include/sepol/type_query.h	=
2006-03-12 04:31:39.000000000 -0500=0A=
@@ -0,0 +1,159 @@=0A=
+ /**=0A=
+ *  @file type_query.h=0A=
+ *  Defines the public interface for searching and iterating over =
types. =0A=
+ *=0A=
+ *  @author Kevin Carr kcarr@tresys.com=0A=
+ *  @author Jeremy A. Mowery jmowery@tresys.com=0A=
+ *  @author Jason Tang jtang@tresys.com=0A=
+ *=0A=
+ *  Copyright (C) 2006 Tresys Technology, LLC=0A=
+ *=0A=
+ *  This library is free software; you can redistribute it and/or=0A=
+ *  modify it under the terms of the GNU Lesser General Public=0A=
+ *  License as published by the Free Software Foundation; either=0A=
+ *  version 2.1 of the License, or (at your option) any later version.=0A=
+ *=0A=
+ *  This library is distributed in the hope that it will be useful,=0A=
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
+ *  Lesser General Public License for more details.=0A=
+ *=0A=
+ *  You should have received a copy of the GNU Lesser General Public=0A=
+ *  License along with this library; if not, write to the Free Software=0A=
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
+ */=0A=
+=0A=
+#ifndef SEPOL_TYPE_QUERY_H=0A=
+#define SEPOL_TYPE_QUERY_H=0A=
+=0A=
+#include <stddef.h>=0A=
+#include <stdint.h>=0A=
+#include <sepol/handle.h>=0A=
+#include <sepol/policydb.h>=0A=
+#include <sepol/iterator.h>=0A=
+=0A=
+typedef struct sepol_type_datum sepol_type_datum_t;=0A=
+=0A=
+/**=0A=
+ *  Get the datum for a type by name.=0A=
+ *  @param handle Error handler for the policy database.=0A=
+ *  @param policy The policy from which to get the type.=0A=
+ *  @param name The name of the type; searching is case sensitive.=0A=
+ *  @param datum Pointer in which to store the type datum; the caller=0A=
+ *  should not free this pointer.=0A=
+ *  @return Returns 0 on success and < 0 on failure; if the call fails,=0A=
+ *  errno will be set and *datum will be NULL.=0A=
+ */=0A=
+extern int sepol_policydb_get_type_by_name(sepol_handle_t *handle, =
sepol_policydb_t *policy, const char *name, sepol_type_datum_t **datum);=0A=
+=0A=
+/**=0A=
+ *  Get an iterator for types declared in the policy.=0A=
+ *  @param handle Error handler for the policy database.=0A=
+ *  @param policy The policy from which to create the iterator.=0A=
+ *  @param iter Iterator of type sepol_type_datum_t* returned; =0A=
+ *  the caller is responsible for calling sepol_iterator_destroy() to =0A=
+ *  free memory used; it is important to note that the iterator is =0A=
+ *  valid only as long as the policy is unchanged.=0A=
+ *  @return Returns 0 on success and < 0 on failure; if the call fails,=0A=
+ *  errno will be set and *iter will be NULL.=0A=
+ */=0A=
+extern int sepol_policydb_get_type_iter(sepol_handle_t *handle, =
sepol_policydb_t *policy, sepol_iterator_t **iter);=0A=
+=0A=
+/**=0A=
+ *  Get the integer value associated with a type. Values range from 1 =0A=
+ *  to the number of types declared in the policy.=0A=
+ *  @param handle Error handler for the policy database.=0A=
+ *  @param policy The policy associated with the type.=0A=
+ *  @param datum The type from which to get the value.=0A=
+ *  @param value Pointer to the integer in which to store value.=0A=
+ *  @return Returns 0 on success and < 0 on failure; if the call fails,=0A=
+ *  errno will be set and value will be 0.=0A=
+ */=0A=
+extern int sepol_type_datum_get_value(sepol_handle_t *handle, =
sepol_policydb_t *policy, sepol_type_datum_t *datum, uint32_t *value);=0A=
+=0A=
+/**=0A=
+ *  Determine whether a given type is an alias for another type.=0A=
+ *  @param handle Error handler for the policy database.=0A=
+ *  @param policy The policy associated with the type.=0A=
+ *  @param datum The type to check.=0A=
+ *  @param isalias Pointer to be set to 1 (true) if the type is an alias=0A=
+ *  and 0 (false) otherwise.=0A=
+ *  @return Returns 0 on success and < 0 on failure; if the call fails,=0A=
+ *  errno will be set and *isalias will be 0 (false).=0A=
+ */=0A=
+extern int sepol_type_datum_get_isalias(sepol_handle_t *handle, =
sepol_policydb_t *policy, sepol_type_datum_t *datum, unsigned char =
*isalias);=0A=
+=0A=
+/**=0A=
+ *  Determine whether a given type is an attribute.=0A=
+ *  @param handle Error handler for the policy database.=0A=
+ *  @param policy The policy associated with the type.=0A=
+ *  @param datum The type to check.=0A=
+ *  @param isattr Pointer to be set to 1 (true) if the type is an=0A=
+ *  attribute and 0 (false) otherwise.=0A=
+ *  @return Returns 0 on success and < 0 on failure; if the call fails,=0A=
+ *  errno will be set and *isattr will be 0 (false).=0A=
+ */=0A=
+extern int sepol_type_datum_get_isattr(sepol_handle_t *handle, =
sepol_policydb_t *policy, sepol_type_datum_t *datum, unsigned char =
*isattr);=0A=
+=0A=
+/**=0A=
+ *  Get an iterator for the list of types in an attribute.=0A=
+ *  @param handle Error handler for the policy database.=0A=
+ *  @param policy The policy associated with the attribute.=0A=
+ *  @param datum The attribute from which to get the types.=0A=
+ *  @param types Iterator of type sepol_type_datum_t* returned; =0A=
+ *  the caller is responsible for calling sepol_iterator_destroy() to =0A=
+ *  free memory used; it is important to note that the iterator is =0A=
+ *  valid only as long as the policy is unchanged.=0A=
+ *  @return Returns 0 on success, > 0 if the type is not an attribute=0A=
+ *  and < 0 on failure; if the call fails, errno will be set and=0A=
+ *  *types will be NULL. If the type is not an attribute *types will=0A=
+ *  be NUll.=0A=
+ */=0A=
+extern int sepol_type_datum_get_type_iter(sepol_handle_t *handle, =
sepol_policydb_t *policy, sepol_type_datum_t *datum, sepol_iterator_t =
**types);=0A=
+=0A=
+=0A=
+/**=0A=
+ *  Get an iterator for the list of attributes given to a type.=0A=
+ *  @param handle Error handler for the policy database.=0A=
+ *  @param policy The policy associated with the type.=0A=
+ *  @param datum The type for which to get the attributes.=0A=
+ *  @param attrs Iterator of type sepol_type_datum_t* returned; =0A=
+ *  the caller is responsible for calling sepol_iterator_destroy() to =0A=
+ *  free memory used; it is important to note that the iterator is =0A=
+ *  valid only as long as the policy is unchanged.=0A=
+ *  @return Returns 0 on success, > 0 if the type is an attribute=0A=
+ *  and < 0 on failure; if the call fails, errno will be set and=0A=
+ *  *types will be NULL. If the type is an attribute *types will=0A=
+ *  be NUll.=0A=
+ */=0A=
+extern int sepol_type_datum_get_attr_iter(sepol_handle_t *handle, =
sepol_policydb_t *policy, sepol_type_datum_t *datum, sepol_iterator_t =
**attrs);=0A=
+=0A=
+/**=0A=
+ *  Get the name by which a type is identified from its datum.=0A=
+ *  @param handle Error handler for the policy database.=0A=
+ *  @param policy The policy associated with the type.=0A=
+ *  @param datum The type for which to get the name.=0A=
+ *  @param name Pointer in which to store the name; the caller =0A=
+ *  should not free the string. If the type is an alias then the=0A=
+ *  primary name will be returned.=0A=
+ *  @return Returns 0 on success and < 0 on failure; if the call fails,=0A=
+ *  errno will be set and *name will be NULL.=0A=
+ */=0A=
+extern int sepol_type_datum_get_name(sepol_handle_t *handle, =
sepol_policydb_t *policy, sepol_type_datum_t *datum, char **name);=0A=
+=0A=
+/**=0A=
+ *  Get an iterator for the list of aliases for a type.=0A=
+ *  @param handle Error handler for the policy database.=0A=
+ *  @param policy The policy associated with the type.=0A=
+ *  @param datum The type for which to get aliases.=0A=
+ *  @param aliases Iterator of type char* returned; the caller is =0A=
+ *  responsible for calling sepol_iterator_destroy() to free=0A=
+ *  memory used; it is important to note that the iterator is valid=0A=
+ *  only as long as the policy is unchanged. If a type has no aliases,=0A=
+ *  the iterator will be at end and have size 0.=0A=
+ *  @return Returns 0 on success and < 0 on failure; if the call fails,=0A=
+ *  errno will be set and *aliases will be NULL.=0A=
+ */=0A=
+extern int sepol_type_datum_get_alias_iter(sepol_handle_t *handle, =
sepol_policydb_t *policy, sepol_type_datum_t *datum, sepol_iterator_t =
**aliases);=0A=
+=0A=
+#endif /* SEPOL_TYPE_QUERY_H */=0A=

------=_NextPart_000_0045_01C64D0F.617D2F00--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
