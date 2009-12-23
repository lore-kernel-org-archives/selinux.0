Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o04DIeoj027303
	for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2010 08:18:46 -0500
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o04DLK9q010941
	for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2010 13:21:20 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id o04DIAlN005280
	for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2010 08:18:10 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id o04DIAQC005278
	for selinux@tycho.nsa.gov; Mon, 4 Jan 2010 08:18:10 -0500
From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 11/13] libsemanage: new private api for unstable functions
Date: Wed, 23 Dec 2009 18:25:58 -0500
Message-Id: <1261610760-4724-12-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-11-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
 <1261610760-4724-2-git-send-email-ccase@tresys.com>
 <1261610760-4724-3-git-send-email-ccase@tresys.com>
 <1261610760-4724-4-git-send-email-ccase@tresys.com>
 <1261610760-4724-5-git-send-email-ccase@tresys.com>
 <1261610760-4724-6-git-send-email-ccase@tresys.com>
 <1261610760-4724-7-git-send-email-ccase@tresys.com>
 <1261610760-4724-8-git-send-email-ccase@tresys.com>
 <1261610760-4724-9-git-send-email-ccase@tresys.com>
 <1261610760-4724-10-git-send-email-ccase@tresys.com>
 <1261610760-4724-11-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rather than export the new functions as part of the stable API we
chose to create a private API. The private API is unstable, may change
in the future, and is mainly intended to be used by upstream tools like
semodule. Keeping these new APIs private for a time will allow them to
both get tested through upstream tools and be changed as necessary
without causing the same change burdens as they would if they were in
the public API.

The private API is found in the includes:

include/semanage/private/handle.h

* Exports the handle get/set default priority functions.

include/semanage/private/module.h

* Exports the module info management functions.
* Exports the get/set enabled status functions.
* Exports the module key management functions.
* Exports the module install, upgrade, remove info/key functions.

include/semanage/private/semanage.h

* Includes the other private headers.

This patch includes the modifications to the map file for exporting the
necessary functions.

Internal prototypes were moved to the private API and the private
headers included as necessary.

Examples:

/* changing the default priority for a distro install */
semanage_set_default_priority(sh, 100);

/* creating module meta data */
semanage_module_info_t *modinfo = NULL;
semanage_module_info_create(sh, &modinfo);

/* filling in that data */
semanage_module_info_set_priority(
	sh,
	modinfo,
	semanage_get_default_priority(sh));

semanage_module_info_set_name(
	sh,
	modinfo,
	"mymodule");

semanage_module_info_set_version(
	sh,
	modinfo,
	"0.1.2");

semanage_module_info_set_lang_ext(
	sh,
	modinfo,
	"pp");

semanage_module_info_set_enabled(
	sh,
	modinfo,
	-1); 	/* Sets enabled to default:
		 * If the module was already enabled/disabled
		 * then it will remain so after install.
		 * If it wasn't, then it will be enabled.
		 */

/* install the module */
semanage_module_install_info(sh, modinfo, data, data_len);

/* cleanup modinfo */
semanage_module_info_destroy(sh, modinfo);

/* create a key for retrieving a module's meta data */
semanage_module_key_t *modkey = NULL;
semanage_module_key_create(sh, &modkey);

/* Only set the module name, this will find the highest
 * priority module of that name.
 */
semanage_module_key_set_name(sh, modkey, "mymodule");

/* get the newly installed module */
semanage_module_get_module_info(sh, modkey, &modinfo);

/* get the priority of the module found */
uint16_t priority = 0;
semanage_module_info_get_priority(sh, modinfo, &priority);

/* set the priority in the key to the one found */
semanage_module_key_set_priority(sh, modkey, priority);

/* remove the highest priority module with the name "mymodule" */
semanage_module_remove_key(sh, modkey);

/* print all the modules installed */
semanage_module_info_t *modinfos = NULL;
int modinfos_len = 0;
semanage_module_list_all(sh, &modinfos, &modinfos_len);

char *name = NULL;
int i = 0;
for (i = 0; i < modinfos_len; i++) {
	semanage_module_info_get_priority(
		sh,
		semanage_module_list_nth(modinfos, i),
		&priority);
	semanage_module_info_get_name(
		sh,
		semanage_module_list_nth(modinfos, i),
		&name);
	printf("%d\t%s\n", priority, name);
}
---
 libsemanage/include/Makefile                    |    3 +
 libsemanage/include/semanage/private/handle.h   |   31 +++
 libsemanage/include/semanage/private/modules.h  |  281 +++++++++++++++++++++++
 libsemanage/include/semanage/private/semanage.h |   26 ++
 libsemanage/src/handle_internal.h               |    1 +
 libsemanage/src/libsemanage.map                 |   26 ++
 libsemanage/src/module_internal.h               |   21 ++
 libsemanage/src/modules.c                       |   40 ++++
 libsemanage/src/modules.h                       |  253 +--------------------
 9 files changed, 431 insertions(+), 251 deletions(-)
 create mode 100644 libsemanage/include/semanage/private/handle.h
 create mode 100644 libsemanage/include/semanage/private/modules.h
 create mode 100644 libsemanage/include/semanage/private/semanage.h

diff --git a/libsemanage/include/Makefile b/libsemanage/include/Makefile
index 391f950..f42824d 100644
--- a/libsemanage/include/Makefile
+++ b/libsemanage/include/Makefile
@@ -5,6 +5,9 @@ INCDIR ?= $(PREFIX)/include/semanage
 install:
 	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
 	install -m 644 $(wildcard semanage/*.h) $(INCDIR)
+	test -d $(INCDIR)/private || install -m 755 -d $(INCDIR)/private
+	install -m 644 $(wildcard semanage/private/*.h) $(INCDIR)/private
 
 indent:
 	../../scripts/Lindent $(wildcard semanage/*.h)
+	../../scripts/Lindent $(wildcard semanage/private/*.h)
diff --git a/libsemanage/include/semanage/private/handle.h b/libsemanage/include/semanage/private/handle.h
new file mode 100644
index 0000000..6efd664
--- /dev/null
+++ b/libsemanage/include/semanage/private/handle.h
@@ -0,0 +1,31 @@
+/* Authors:	Caleb Case	<ccase@tresys.com>
+ *
+ * Copyright (C) 2009 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_PRIVATE_HANDLE_H_
+#define _SEMANAGE_PRIVATE_HANDLE_H_
+
+#include <stdint.h>
+
+/* Get the default priority. */
+uint16_t semanage_get_default_priority(semanage_handle_t *sh);
+
+/* Set the default priority. */
+int semanage_set_default_priority(semanage_handle_t *sh, uint16_t priority);
+
+#endif
diff --git a/libsemanage/include/semanage/private/modules.h b/libsemanage/include/semanage/private/modules.h
new file mode 100644
index 0000000..2ffaa5b
--- /dev/null
+++ b/libsemanage/include/semanage/private/modules.h
@@ -0,0 +1,281 @@
+/* Authors:	Caleb Case	<ccase@tresys.com>
+ *
+ * Copyright (C) 2009 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_PRIVATE_MODULES_H_
+#define _SEMANAGE_PRIVATE_MODULES_H_
+
+#include <stdio.h>
+#include <stdint.h>
+
+typedef struct semanage_module_key semanage_module_key_t;
+
+/* Module Info */
+
+/* Creates a module info struct.
+ *
+ * Returns 0 on success and -1 on failure.
+ *
+ * The @modinfo should be destroyed with semanage_module_info_destroy.
+ * The caller should call free() on the struct.
+ */
+int semanage_module_info_create(semanage_handle_t *sh,
+				semanage_module_info_t **modinfo);
+
+/* Frees the members of the module info struct.
+ *
+ * Returns 0 on success and -1 on failure.
+ *
+ * The caller should call free() on the struct.
+ */
+int semanage_module_info_destroy(semanage_handle_t *handle,
+				 semanage_module_info_t *modinfo);
+
+/* Module Info Getters */
+
+/* Get @priority from @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_get_priority(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      uint16_t *priority);
+
+/* Get @name from @modinfo. Caller should not free @name.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_get_name(semanage_handle_t *sh,
+				  semanage_module_info_t *modinfo,
+				  const char **name);
+
+/* Get @version from @modinfo. Caller should not free @version.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_get_version(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     const char **version);
+
+/* Get @lang_ext from @modinfo. Caller should not free @lang_ext.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_get_lang_ext(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      const char **lang_ext);
+
+/* Get @enabled from @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_get_enabled(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     int *enabled);
+
+/* Module Info Setters */
+
+/* Set @priority in @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_set_priority(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      uint16_t priority);
+
+/* Set @name in @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_set_name(semanage_handle_t *sh,
+				  semanage_module_info_t *modinfo,
+				  const char *name);
+
+/* Set @version in @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_set_version(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     const char *version);
+
+/* Set @lang_ext in @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_set_lang_ext(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      const char *lang_ext);
+
+/* Set @enabled in @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_set_enabled(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     int enabled);
+
+/* Module Key */
+
+/* Creates a module key struct.
+ *
+ * Return 0 on success, and -1 on error.
+ *
+ * The @modkey should be destroyed with semanage_module_key_destroy.
+ * The caller should call free() on the struct.
+ */
+int semanage_module_key_create(semanage_handle_t *sh,
+			       semanage_module_key_t **modkey);
+
+/* Frees members of the @modkey, but not the struct. The caller should
+ * call free() on struct.
+ *
+ * Returns 0 on success, and -1 on error.
+ */
+int semanage_module_key_destroy(semanage_handle_t *sh,
+				semanage_module_key_t *modkey);
+
+/* Module Key Getters */
+
+/* Get @name from @modkey. Caller should not free @name.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_key_get_name(semanage_handle_t *sh,
+				 semanage_module_key_t *modkey,
+				 const char **name);
+
+/* Get @name from @modkey.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_key_get_priority(semanage_handle_t *sh,
+				     semanage_module_key_t *modkey,
+				     uint16_t *priority);
+
+/* Module Key Setters */
+
+/* Set @name in @modkey.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_key_set_name(semanage_handle_t *sh,
+				 semanage_module_key_t *modkey,
+				 const char *name);
+
+/* Set @priority in @modkey.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_key_set_priority(semanage_handle_t *sh,
+				     semanage_module_key_t *modkey,
+				     uint16_t priority);
+
+/* Module Enabled */
+
+/* Get module @enabled status from @modkey. Modules are enabled on a per
+ * module name basis (across all priorities). @modkey only needs to have
+ * name set (priority is ignored).
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_get_enabled(semanage_handle_t *sh,
+				const semanage_module_key_t *modkey,
+				int *enabled);
+
+/* Set module @enabled status from @modkey. Modules are enabled on a per
+ * module name basis (across all priorities). @modkey only needs to have
+ * name set (priority is ignored).
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_set_enabled(semanage_handle_t *sh,
+				const semanage_module_key_t *modkey,
+				int enabled);
+
+/* Lookup @modinfo by @modkey. Caller should use
+ * semanage_module_info_destroy and free on @modinfo.
+ * 
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_get_module_info(semanage_handle_t *sh,
+				    const semanage_module_key_t *modkey,
+				    semanage_module_info_t **modinfo);
+
+/* Create a list of all modules in @modinfos of length @modinfos_len.
+ * The list will be sorted from high priority to low and alphabetically
+ * by module name within a priority.
+ *
+ * Caller should use semanage_module_info_destroy on each modinfo in
+ * @modinfos and free on @modinfos.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_list_all(semanage_handle_t *sh,
+			     semanage_module_info_t **modinfos,
+			     int *modinfos_len);
+
+/* Install the module indicated by @modinfo with input data from 
+ * @module_data with length @data_len.
+ *
+ * @modinfo must have all values filled in.
+ * @module_data may be bzip compressed.
+ *
+ * Returns:
+ *	 0	success
+ *	-1	failure, out of memory
+ *	-2	failure, invalid @modinfo
+ *	-3	failure, error writing file
+ */
+int semanage_module_install_info(semanage_handle_t *sh,
+				 const semanage_module_info_t *modinfo,
+				 char *data,
+				 size_t data_len);
+
+/* Upgrade the module indicated by @modinfo with input data from
+ * @module_data with length @data_len.
+ *
+ * If the module is not already installed, then this will install it.
+ *
+ * @modinfo must have all values filled in.
+ * @module_data may be bzip compressed.
+ *
+ * Returns:
+ *	 0	success
+ *	-1	failure, out of memory
+ *	-2	failure, invalid @modinfo
+ *	-3	failure, error writing file
+ *	-4	failure, same or newer version module exists
+ */
+int semanage_module_upgrade_info(semanage_handle_t *sh,
+				 const semanage_module_info_t *modinfo,
+				 char *data,
+				 size_t data_len);
+
+/* Remove the module indicated by @modkey.
+ * @modkey must have key values filled in.
+ *
+ * Returns:
+ * 	 0	success
+ *	-1	failure, out of memeory
+ *	-2	failure, @module not found or couldn't be removed
+ */
+int semanage_module_remove_key(semanage_handle_t *sh,
+			       const semanage_module_key_t *modkey);
+
+#endif
diff --git a/libsemanage/include/semanage/private/semanage.h b/libsemanage/include/semanage/private/semanage.h
new file mode 100644
index 0000000..f083c60
--- /dev/null
+++ b/libsemanage/include/semanage/private/semanage.h
@@ -0,0 +1,26 @@
+/* Authors:	Caleb Case	<ccase@tresys.com>
+ *
+ * Copyright (C) 2009 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_PRIVATE_SEMANAGE_H_
+#define _SEMANAGE_PRIVATE_SEMANAGE_H_
+
+#include <semanage/private/handle.h>
+#include <semanage/private/modules.h>
+
+#endif
diff --git a/libsemanage/src/handle_internal.h b/libsemanage/src/handle_internal.h
index 8493a39..f009195 100644
--- a/libsemanage/src/handle_internal.h
+++ b/libsemanage/src/handle_internal.h
@@ -2,6 +2,7 @@
 #define _SEMANAGE_HANDLE_INTERNAL_H_
 
 #include <semanage/handle.h>
+#include <semanage/private/handle.h>
 #include "dso.h"
 
 hidden_proto(semanage_begin_transaction)
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index d15f69d..3526256 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -18,5 +18,31 @@ LIBSEMANAGE_1.0 {
 	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
 	  semanage_mls_enabled;
 	  semanage_set_check_contexts;
+	  semanage_get_default_priority; semanage_set_default_priority;
+	  semanage_module_info_create;
+	  semanage_module_info_destroy;
+	  semanage_module_info_get_priority;
+	  semanage_module_info_get_name;
+	  semanage_module_info_get_version;
+	  semanage_module_info_get_lang_ext;
+	  semanage_module_info_get_enabled;
+	  semanage_module_info_set_priority;
+	  semanage_module_info_set_name;
+	  semanage_module_info_set_version;
+	  semanage_module_info_set_lang_ext;
+	  semanage_module_info_set_enabled;
+	  semanage_module_key_create;
+	  semanage_module_key_destroy;
+	  semanage_module_key_get_priority;
+	  semanage_module_key_get_name;
+	  semanage_module_key_set_priority;
+	  semanage_module_key_set_name;
+	  semanage_module_get_module;
+	  semanage_module_list_all;
+	  semanage_module_get_enabled;
+	  semanage_module_set_enabled;
+	  semanage_module_install_info;
+	  semanage_module_upgrade_info;
+	  semanage_module_remove_key;
   local: *;
 };
diff --git a/libsemanage/src/module_internal.h b/libsemanage/src/module_internal.h
index f074a3a..7fe20be 100644
--- a/libsemanage/src/module_internal.h
+++ b/libsemanage/src/module_internal.h
@@ -2,10 +2,31 @@
 #define _SEMANAGE_MODULE_INTERNAL_H_
 
 #include <semanage/modules.h>
+#include <semanage/private/modules.h>
 #include "dso.h"
 
 hidden_proto(semanage_module_get_name)
     hidden_proto(semanage_module_get_version)
     hidden_proto(semanage_module_info_datum_destroy)
     hidden_proto(semanage_module_list_nth)
+    hidden_proto(semanage_module_info_create)
+    hidden_proto(semanage_module_info_destroy)
+    hidden_proto(semanage_module_info_get_priority)
+    hidden_proto(semanage_module_info_get_name)
+    hidden_proto(semanage_module_info_get_version)
+    hidden_proto(semanage_module_info_get_lang_ext)
+    hidden_proto(semanage_module_info_get_enabled)
+    hidden_proto(semanage_module_info_set_priority)
+    hidden_proto(semanage_module_info_set_name)
+    hidden_proto(semanage_module_info_set_version)
+    hidden_proto(semanage_module_info_set_lang_ext)
+    hidden_proto(semanage_module_info_set_enabled)
+    hidden_proto(semanage_module_key_create)
+    hidden_proto(semanage_module_key_destroy)
+    hidden_proto(semanage_module_key_get_priority)
+    hidden_proto(semanage_module_key_get_name)
+    hidden_proto(semanage_module_key_set_priority)
+    hidden_proto(semanage_module_key_set_name)
+    hidden_proto(semanage_module_get_enabled)
+    hidden_proto(semanage_module_set_enabled)
 #endif
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 817da80..6f6f8b1 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -246,6 +246,8 @@ int semanage_module_info_create(semanage_handle_t *sh,
 	return semanage_module_info_init(sh, *modinfo);
 }
 
+hidden_def(semanage_module_info_create)
+
 int semanage_module_info_destroy(semanage_handle_t *sh,
 				 semanage_module_info_t *modinfo)
 {
@@ -262,6 +264,8 @@ int semanage_module_info_destroy(semanage_handle_t *sh,
 	return semanage_module_info_init(sh, modinfo);
 }
 
+hidden_def(semanage_module_info_destroy)
+
 int semanage_module_info_init(semanage_handle_t *sh,
 			      semanage_module_info_t *modinfo)
 {
@@ -342,6 +346,8 @@ int semanage_module_info_get_priority(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_info_get_priority)
+
 int semanage_module_info_get_name(semanage_handle_t *sh,
 				  semanage_module_info_t *modinfo,
 				  const char **name)
@@ -355,6 +361,8 @@ int semanage_module_info_get_name(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_info_get_name)
+
 int semanage_module_info_get_version(semanage_handle_t *sh,
 				     semanage_module_info_t *modinfo,
 				     const char **version)
@@ -368,6 +376,8 @@ int semanage_module_info_get_version(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_info_get_version)
+
 int semanage_module_info_get_lang_ext(semanage_handle_t *sh,
 				      semanage_module_info_t *modinfo,
 				      const char **lang_ext)
@@ -381,6 +391,8 @@ int semanage_module_info_get_lang_ext(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_info_get_lang_ext)
+
 int semanage_module_info_get_enabled(semanage_handle_t *sh,
 				     semanage_module_info_t *modinfo,
 				     int *enabled)
@@ -394,6 +406,8 @@ int semanage_module_info_get_enabled(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_info_get_enabled)
+
 int semanage_module_info_set_priority(semanage_handle_t *sh,
 				      semanage_module_info_t *modinfo,
 				      uint16_t priority)
@@ -413,6 +427,8 @@ int semanage_module_info_set_priority(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_info_set_priority)
+
 int semanage_module_info_set_name(semanage_handle_t *sh,
 				  semanage_module_info_t *modinfo,
 				  const char *name)
@@ -441,6 +457,8 @@ int semanage_module_info_set_name(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_info_set_name)
+
 int semanage_module_info_set_version(semanage_handle_t *sh,
 				     semanage_module_info_t *modinfo,
 				     const char *version)
@@ -469,6 +487,8 @@ int semanage_module_info_set_version(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_info_set_version)
+
 int semanage_module_info_set_lang_ext(semanage_handle_t *sh,
 				      semanage_module_info_t *modinfo,
 				      const char *lang_ext)
@@ -497,6 +517,8 @@ int semanage_module_info_set_lang_ext(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_info_set_lang_ext)
+
 int semanage_module_info_set_enabled(semanage_handle_t *sh,
 				     semanage_module_info_t *modinfo,
 				     int enabled)
@@ -516,6 +538,8 @@ int semanage_module_info_set_enabled(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_info_set_enabled)
+
 int semanage_module_get_path(semanage_handle_t *sh,
 			     const semanage_module_info_t *modinfo,
 			     enum semanage_module_path_type type,
@@ -721,6 +745,8 @@ int semanage_module_key_create(semanage_handle_t *sh,
 	return semanage_module_key_init(sh, *modkey);
 }
 
+hidden_def(semanage_module_key_create)
+
 int semanage_module_key_destroy(semanage_handle_t *sh,
 				semanage_module_key_t *modkey)
 {
@@ -733,6 +759,8 @@ int semanage_module_key_destroy(semanage_handle_t *sh,
 	return semanage_module_key_init(sh, modkey);
 }
 
+hidden_def(semanage_module_key_destroy)
+
 int semanage_module_key_init(semanage_handle_t *sh,
 			     semanage_module_key_t *modkey)
 {
@@ -758,6 +786,8 @@ int semanage_module_key_get_name(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_key_get_name)
+
 int semanage_module_key_get_priority(semanage_handle_t *sh,
 				     semanage_module_key_t *modkey,
 				     uint16_t *priority)
@@ -771,6 +801,8 @@ int semanage_module_key_get_priority(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_key_get_priority)
+
 int semanage_module_key_set_name(semanage_handle_t *sh,
 				 semanage_module_key_t *modkey,
 				 const char *name)
@@ -801,6 +833,8 @@ cleanup:
 	return status;
 }
 
+hidden_def(semanage_module_key_set_name)
+
 int semanage_module_key_set_priority(semanage_handle_t *sh,
 				     semanage_module_key_t *modkey,
 				     uint16_t priority)
@@ -819,6 +853,8 @@ int semanage_module_key_set_priority(semanage_handle_t *sh,
 	return 0;
 }
 
+hidden_def(semanage_module_key_set_priority)
+
 int semanage_module_get_enabled(semanage_handle_t *sh,
 				const semanage_module_key_t *modkey,
 				int *enabled)
@@ -839,6 +875,8 @@ int semanage_module_get_enabled(semanage_handle_t *sh,
 	return sh->funcs->get_enabled(sh, modkey, enabled);
 }
 
+hidden_def(semanage_module_get_enabled)
+
 int semanage_module_set_enabled(semanage_handle_t *sh,
 				const semanage_module_key_t *modkey,
 				int enabled)
@@ -863,6 +901,8 @@ int semanage_module_set_enabled(semanage_handle_t *sh,
 	return sh->funcs->set_enabled(sh, modkey, enabled);
 }
 
+hidden_def(semanage_module_set_enabled)
+
 /* Converts a string to a priority
  *
  * returns -1 if str is not a valid priority.
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index 7faead4..38e1e0c 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -35,25 +35,6 @@ struct semanage_module_info {
 	int enabled;		/* module enabled/disabled status */
 };
 
-/* Creates a module info struct.
- *
- * Returns 0 on success and -1 on failure.
- *
- * The @modinfo should be destroyed with semanage_module_info_destroy.
- * The caller should call free() on the struct.
- */
-int semanage_module_info_create(semanage_handle_t *sh,
-				semanage_module_info_t **modinfo);
-
-/* Frees the members of the module info struct.
- *
- * Returns 0 on success and -1 on failure.
- *
- * The caller should call free() on the struct.
- */
-int semanage_module_info_destroy(semanage_handle_t *handle,
-				 semanage_module_info_t *modinfo);
-
 /* Initializes a pre-allocated module info struct.
  *
  * Returns 0 on success and -1 on error.
@@ -69,90 +50,6 @@ int semanage_module_info_clone(semanage_handle_t *sh,
 			       const semanage_module_info_t *source,
 			       semanage_module_info_t *target);
 
-/* Module Info Getters */
-
-/* Get @priority from @modinfo.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_info_get_priority(semanage_handle_t *sh,
-				      semanage_module_info_t *modinfo,
-				      uint16_t *priority);
-
-/* Get @name from @modinfo. Caller should not free @name.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_info_get_name(semanage_handle_t *sh,
-				  semanage_module_info_t *modinfo,
-				  const char **name);
-
-/* Get @version from @modinfo. Caller should not free @version.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_info_get_version(semanage_handle_t *sh,
-				     semanage_module_info_t *modinfo,
-				     const char **version);
-
-/* Get @lang_ext from @modinfo. Caller should not free @lang_ext.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_info_get_lang_ext(semanage_handle_t *sh,
-				      semanage_module_info_t *modinfo,
-				      const char **lang_ext);
-
-/* Get @enabled from @modinfo.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_info_get_enabled(semanage_handle_t *sh,
-				     semanage_module_info_t *modinfo,
-				     int *enabled);
-
-/* Module Info Setters */
-
-/* Set @priority in @modinfo.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_info_set_priority(semanage_handle_t *sh,
-				      semanage_module_info_t *modinfo,
-				      uint16_t priority);
-
-/* Set @name in @modinfo.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_info_set_name(semanage_handle_t *sh,
-				  semanage_module_info_t *modinfo,
-				  const char *name);
-
-/* Set @version in @modinfo.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_info_set_version(semanage_handle_t *sh,
-				     semanage_module_info_t *modinfo,
-				     const char *version);
-
-/* Set @lang_ext in @modinfo.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_info_set_lang_ext(semanage_handle_t *sh,
-				      semanage_module_info_t *modinfo,
-				      const char *lang_ext);
-
-/* Set @enabled in @modinfo.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_info_set_enabled(semanage_handle_t *sh,
-				     semanage_module_info_t *modinfo,
-				     int enabled);
-
 /* Convert a cstring to a priority.
  *
  * Returns 0 on success and -1 on error.
@@ -167,28 +64,10 @@ int semanage_module_validate_lang_ext(const char *ext);
 int semanage_module_validate_version(const char *version);
 
 /* Module Key */
-typedef struct semanage_module_key {
+struct semanage_module_key {
 	uint16_t priority;	/* module priority */
 	char *name;		/* module name */
-} semanage_module_key_t;
-
-/* Creates a module key struct.
- *
- * Return 0 on success, and -1 on error.
- *
- * The @modkey should be destroyed with semanage_module_key_destroy.
- * The caller should call free() on the struct.
- */
-int semanage_module_key_create(semanage_handle_t *sh,
-			       semanage_module_key_t **modkey);
-
-/* Frees members of the @modkey, but not the struct. The caller should
- * call free() on struct.
- *
- * Returns 0 on success, and -1 on error.
- */
-int semanage_module_key_destroy(semanage_handle_t *sh,
-				semanage_module_key_t *modkey);
+};
 
 /* Initializes a pre-allocated module key struct.
  *
@@ -197,42 +76,6 @@ int semanage_module_key_destroy(semanage_handle_t *sh,
 int semanage_module_key_init(semanage_handle_t *sh,
 			     semanage_module_key_t *modkey);
 
-/* Module Key Getters */
-
-/* Get @name from @modkey. Caller should not free @name.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_key_get_name(semanage_handle_t *sh,
-				 semanage_module_key_t *modkey,
-				 const char **name);
-
-/* Get @name from @modkey.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_key_get_priority(semanage_handle_t *sh,
-				     semanage_module_key_t *modkey,
-				     uint16_t *priority);
-
-/* Module Key Setters */
-
-/* Set @name in @modkey.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_key_set_name(semanage_handle_t *sh,
-				 semanage_module_key_t *modkey,
-				 const char *name);
-
-/* Set @priority in @modkey.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_key_set_priority(semanage_handle_t *sh,
-				     semanage_module_key_t *modkey,
-				     uint16_t priority);
-
 /* Module Paths */
 
 enum semanage_module_path_type {
@@ -255,96 +98,4 @@ int semanage_module_get_path(semanage_handle_t *sh,
 			     char *path,
 			     size_t len);
 
-/* Module Enabled */
-
-/* Get module @enabled status from @modkey. Modules are enabled on a per
- * module name basis (across all priorities). @modkey only needs to have
- * name set (priority is ignored).
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_get_enabled(semanage_handle_t *sh,
-				const semanage_module_key_t *modkey,
-				int *enabled);
-
-/* Set module @enabled status from @modkey. Modules are enabled on a per
- * module name basis (across all priorities). @modkey only needs to have
- * name set (priority is ignored).
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_set_enabled(semanage_handle_t *sh,
-				const semanage_module_key_t *modkey,
-				int enabled);
-
-/* Lookup @modinfo by @modkey. Caller should use
- * semanage_module_info_destroy and free on @modinfo.
- * 
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_get_module_info(semanage_handle_t *sh,
-				    const semanage_module_key_t *modkey,
-				    semanage_module_info_t **modinfo);
-
-/* Create a list of all modules in @modinfos of length @modinfos_len.
- * The list will be sorted from high priority to low and alphabetically
- * by module name within a priority.
- *
- * Caller should use semanage_module_info_destroy on each modinfo in
- * @modinfos and free on @modinfos.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_module_list_all(semanage_handle_t *sh,
-			     semanage_module_info_t **modinfos,
-			     int *modinfos_len);
-
-/* Install the module indicated by @modinfo with input data from 
- * @module_data with length @data_len.
- *
- * @modinfo must have all values filled in.
- * @module_data may be bzip compressed.
- *
- * Returns:
- *	 0	success
- *	-1	failure, out of memory
- *	-2	failure, invalid @modinfo
- *	-3	failure, error writing file
- */
-int semanage_module_install_info(semanage_handle_t *sh,
-				 const semanage_module_info_t *modinfo,
-				 char *data,
-				 size_t data_len);
-
-/* Upgrade the module indicated by @modinfo with input data from
- * @module_data with length @data_len.
- *
- * If the module is not already installed, then this will install it.
- *
- * @modinfo must have all values filled in.
- * @module_data may be bzip compressed.
- *
- * Returns:
- *	 0	success
- *	-1	failure, out of memory
- *	-2	failure, invalid @modinfo
- *	-3	failure, error writing file
- *	-4	failure, same or newer version module exists
- */
-int semanage_module_upgrade_info(semanage_handle_t *sh,
-				 const semanage_module_info_t *modinfo,
-				 char *data,
-				 size_t data_len);
-
-/* Remove the module indicated by @modkey.
- * @modkey must have key values filled in.
- *
- * Returns:
- * 	 0	success
- *	-1	failure, out of memeory
- *	-2	failure, @module not found or couldn't be removed
- */
-int semanage_module_remove_key(semanage_handle_t *sh,
-			       const semanage_module_key_t *modkey);
-
 #endif
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
