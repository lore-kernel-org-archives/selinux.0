Message-Id: <200509262347.j8QNl0Ys018820@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage-reorg 1/7 
Date: Mon, 26 Sep 2005 19:47:00 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0098_01C5C2D3.0FC31BA0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0098_01C5C2D3.0FC31BA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch removes semodule headers. Some of this functionality is moved to
semanage.h in the next patch set (mainly from semodule.h). Much of the rest
of this code is moved into private headers for libsemanage.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_0098_01C5C2D3.0FC31BA0
Content-Type: application/octet-stream;
	name="1-remove-semodule-headers.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="1-remove-semodule-headers.diff"

--- libsemanage/include/semanage/module_api.h	2005-09-19 =
09:03:15.000000000 -0400=0A=
+++ libsemanage/include/semanage/module_api.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
@@ -1,40 +0,0 @@=0A=
-/* Authors: Jason Tang <jtang@tresys.com>=0A=
- *=0A=
- * Copyright (C) 2004-2005 Tresys Technology, LLC=0A=
- *=0A=
- *  This library is free software; you can redistribute it and/or=0A=
- *  modify it under the terms of the GNU Lesser General Public=0A=
- *  License as published by the Free Software Foundation; either=0A=
- *  version 2.1 of the License, or (at your option) any later version.=0A=
- *=0A=
- *  This library is distributed in the hope that it will be useful,=0A=
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
- *  Lesser General Public License for more details.=0A=
- *=0A=
- *  You should have received a copy of the GNU Lesser General Public=0A=
- *  License along with this library; if not, write to the Free Software=0A=
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
- */=0A=
-=0A=
-/* This is a "simple" API for clients that have minimal error handling=0A=
- * requirements.  Be aware that NONE OF THESE FUNCTIONS ARE=0A=
- * THREAD-SAFE NOR ARE THEY SIGNAL-SAFE. */=0A=
-=0A=
-#ifndef SEMOD_MODULE_API_H=0A=
-#define SEMOD_MODULE_API_H=0A=
-=0A=
-#include <stdlib.h>=0A=
-=0A=
-int semod_install_module(char *module_data, size_t data_len,=0A=
-                         char *error_buf, size_t error_buf_size);=0A=
-int semod_upgrade_module(char *module_data,size_t data_len,=0A=
-                         char *error_buf, size_t error_buf_size);=0A=
-int semod_install_base_module(char *module_data, size_t data_len,=0A=
-                              char *error_buf, size_t error_buf_size);=0A=
-int semod_remove_module(char *module_name,=0A=
-                        char *error_buf, size_t error_buf_size);=0A=
-int semod_list_modules(char **module_info,=0A=
-                       char *error_buf, size_t error_buf_size);=0A=
-=0A=
-#endif=0A=
--- libsemanage/include/semanage/module_direct_api.h	2005-09-19 =
09:03:15.000000000 -0400=0A=
+++ libsemanage/include/semanage/module_direct_api.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
@@ -1,45 +0,0 @@=0A=
-/* Authors: Jason Tang <jtang@tresys.com>=0A=
- *=0A=
- * Copyright (C) 2004-2005 Tresys Technology, LLC=0A=
- *=0A=
- *  This library is free software; you can redistribute it and/or=0A=
- *  modify it under the terms of the GNU Lesser General Public=0A=
- *  License as published by the Free Software Foundation; either=0A=
- *  version 2.1 of the License, or (at your option) any later version.=0A=
- *=0A=
- *  This library is distributed in the hope that it will be useful,=0A=
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
- *  Lesser General Public License for more details.=0A=
- *=0A=
- *  You should have received a copy of the GNU Lesser General Public=0A=
- *  License along with this library; if not, write to the Free Software=0A=
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
- */=0A=
-=0A=
-#ifndef SEMOD_DIRECT_MODULE_API_H=0A=
-#define SEMOD_DIRECT_MODULE_API_H=0A=
-=0A=
-#include <stdlib.h>=0A=
-=0A=
-int semod_direct_install_module(char *sandbox, char *module_data,=0A=
-                                size_t data_len, char **modname,=0A=
-                                char *error_buf, size_t error_buf_size);=0A=
-int semod_direct_upgrade_module(char *sandbox, char *module_data,=0A=
-                                size_t data_len, char **modname,=0A=
-                                char *error_buf, size_t error_buf_size);=0A=
-int semod_direct_install_base_module(char *sandbox, char *module_data,=0A=
-                                     size_t data_len,=0A=
-                                     char *error_buf, size_t =
error_buf_size);=0A=
-int semod_direct_remove_module(char *sandbox, char *module_name,=0A=
-                                     char *error_buf, size_t =
error_buf_size);=0A=
-int semod_direct_list_modules(char **results);=0A=
-int semod_direct_list_sandbox(char *sandbox, char **results);=0A=
-int semod_direct_commit(char *sandbox, unsigned int policyvers,=0A=
-                        char *error_buf, size_t error_buf_size);=0A=
-=0A=
-char *semod_direct_connect(char *error_buf, size_t error_buf_size);=0A=
-int semod_direct_disconnect(char *sandbox, int commit,=0A=
-                            char *error_buf, size_t error_buf_size);=0A=
-=0A=
-#endif=0A=
--- libsemanage/include/semanage/module_ps_api.h	2005-09-19 =
09:03:15.000000000 -0400=0A=
+++ libsemanage/include/semanage/module_ps_api.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
@@ -1,46 +0,0 @@=0A=
-/* Authors: Jason Tang <jtang@tresys.com>=0A=
- *=0A=
- * Copyright (C) 2004-2005 Tresys Technology, LLC=0A=
- *=0A=
- *  This library is free software; you can redistribute it and/or=0A=
- *  modify it under the terms of the GNU Lesser General Public=0A=
- *  License as published by the Free Software Foundation; either=0A=
- *  version 2.1 of the License, or (at your option) any later version.=0A=
- *=0A=
- *  This library is distributed in the hope that it will be useful,=0A=
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
- *  Lesser General Public License for more details.=0A=
- *=0A=
- *  You should have received a copy of the GNU Lesser General Public=0A=
- *  License along with this library; if not, write to the Free Software=0A=
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
- */=0A=
-=0A=
-#ifndef SEMOD_PS_MODULE_API_H=0A=
-#define SEMOD_PS_MODULE_API_H=0A=
-=0A=
-#include "semanage/semod_conf.h"=0A=
-#include <stdlib.h>=0A=
-=0A=
-#define SEMOD_PS_PROTOCOL_VERSION_MAJOR 1=0A=
-#define SEMOD_PS_PROTOCOL_VERSION_MINOR 0=0A=
-=0A=
-int semod_ps_install_module (int fd, char *module_data, size_t data_len,=0A=
-                             char *results, size_t results_size);=0A=
-int semod_ps_upgrade_module (int fd, char *module_data, size_t data_len,=0A=
-                             char *results, size_t results_size);=0A=
-int semod_ps_install_base_module (int fd, char *base_data, size_t =
data_len,=0A=
-                             char *results, size_t results_size);=0A=
-int semod_ps_remove_module (int fd, char *module_name,=0A=
-                             char *results, size_t results_size);=0A=
-int semod_ps_list_modules (int fd, char *results, size_t results_size);=0A=
-int semod_ps_list_sandbox (int fd, char *results, size_t results_size);=0A=
-int semod_ps_commit (int fd, char *results, size_t results_size);=0A=
-=0A=
-int semod_ps_connect (semod_module_store_t *mod_store,=0A=
-                      char *results, size_t results_size);=0A=
-int semod_ps_disconnect (int fd, int commit,=0A=
-                         char *results, size_t results_size);=0A=
-=0A=
-#endif=0A=
--- libsemanage/include/semanage/module_store.h	2005-09-19 =
09:03:15.000000000 -0400=0A=
+++ libsemanage/include/semanage/module_store.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
@@ -1,63 +0,0 @@=0A=
-/* Authors: Karl MacMillan <kmacmillan@tresys.com>=0A=
- * 	    Joshua Brindle <jbrindle@tresys.com>=0A=
- *          Jason Tang <jtang@tresys.com>=0A=
- *=0A=
- * Copyright (C) 2004-2005 Tresys Technology, LLC=0A=
- *=0A=
- *  This library is free software; you can redistribute it and/or=0A=
- *  modify it under the terms of the GNU Lesser General Public=0A=
- *  License as published by the Free Software Foundation; either=0A=
- *  version 2.1 of the License, or (at your option) any later version.=0A=
- *=0A=
- *  This library is distributed in the hope that it will be useful,=0A=
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
- *  Lesser General Public License for more details.=0A=
- *=0A=
- *  You should have received a copy of the GNU Lesser General Public=0A=
- *  License along with this library; if not, write to the Free Software=0A=
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
- */=0A=
-=0A=
-#ifndef SEMOD_MODULE_STORE_H=0A=
-#define SEMOD_MODULE_STORE_H=0A=
-=0A=
-#include <stdlib.h>=0A=
-=0A=
-/* THIS MUST BE THE FIRST FUNCTION CALLED IN THIS LIBRARY. */=0A=
-int semod_init_module_store (char *module_store_path,=0A=
-                             char *error_buf, size_t error_buf_size);=0A=
-=0A=
-int semod_create_module_store (int create,=0A=
-                               char *error_buf, size_t error_buf_size);=0A=
-=0A=
-int semod_create_store_lock (int force_lock,=0A=
-                             char *error_buf, size_t error_buf_size);=0A=
-void semod_remove_store_lock (void);=0A=
-=0A=
-int semod_copy_file (const char *src, const char *dst);=0A=
-int semod_remove_directory (char *path);=0A=
-=0A=
-const char *semod_active_base_name (void);=0A=
-const char *semod_active_kernel_name (void);=0A=
-const char *semod_active_kernel_backup_name (void);=0A=
-const char *semod_active_fc_name (void);=0A=
-const char *semod_active_fc_backup_name (void);=0A=
-=0A=
-int semod_get_active_modules_list (char ***names, char ***versions, int =
*len);=0A=
-char *semod_get_active_module_filename (char *module_name);=0A=
-char *semod_get_active_filename (char *filename);=0A=
-=0A=
-/* sandbox filenames and paths */=0A=
-char *semod_make_sandbox (char *suffix, char *error_buf, size_t =
error_buf_size);=0A=
-int semod_commit_sandbox (char *sandbox);=0A=
-int semod_undo_commit_sandbox (char *sandbox);=0A=
-int semod_get_sandbox_modules_names (char *sandbox, char ***filenames, =
int *len);=0A=
-int semod_get_sandbox_modules_list (char *sandbox, char ***names, char =
***versions, int *len);=0A=
-char *semod_sandbox_modules_path (char *sandbox);=0A=
-char *semod_sandbox_kernel_name (char *sandbox);=0A=
-char *semod_sandbox_base_name (char *sandbox);=0A=
-char *semod_sandbox_linked_name (char *sandbox);=0A=
-char *semod_sandbox_fc_name (char *sandbox);=0A=
-=0A=
-#endif=0A=
--- libsemanage/include/semanage/semod_conf.h	2005-09-19 =
09:03:15.000000000 -0400=0A=
+++ libsemanage/include/semanage/semod_conf.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
@@ -1,58 +0,0 @@=0A=
-/* Authors: Jason Tang <jtang@tresys.com>=0A=
- *=0A=
- * Copyright (C) 2004-2005 Tresys Technology, LLC=0A=
- *=0A=
- *  This library is free software; you can redistribute it and/or=0A=
- *  modify it under the terms of the GNU Lesser General Public=0A=
- *  License as published by the Free Software Foundation; either=0A=
- *  version 2.1 of the License, or (at your option) any later version.=0A=
- *=0A=
- *  This library is distributed in the hope that it will be useful,=0A=
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
- *  Lesser General Public License for more details.=0A=
- *=0A=
- *  You should have received a copy of the GNU Lesser General Public=0A=
- *  License along with this library; if not, write to the Free Software=0A=
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
- */=0A=
-=0A=
-#ifndef SEMOD_CONF_H=0A=
-#define SEMOD_CONF_H=0A=
-=0A=
-/* libsemod has its own configuration file.  It has two main parts:=0A=
- *  - single options=0A=
- *  - external programs to execute whenever a policy is to be loaded=0A=
- */=0A=
-enum semod_store_type_e {=0A=
-        SEMOD_STORE_DIRECT, SEMOD_STORE_NAMED_SOCKET, =
SEMOD_STORE_REMOTE_SOCKET=0A=
-};=0A=
-=0A=
-typedef struct semod_module_store {=0A=
-        enum semod_store_type_e store_type;=0A=
-        char *server_path;=0A=
-        int server_port;=0A=
-} semod_module_store_t;=0A=
-=0A=
-typedef struct semod_conf {=0A=
-        semod_module_store_t module_store;=0A=
-        int policyvers;         /* version for server generated =
policies */=0A=
-        struct external_prog *load_policy;=0A=
-        struct external_prog *setfiles;=0A=
-        struct external_prog *mod_prog, *linked_prog, *kernel_prog;=0A=
-} semod_conf_t;=0A=
-=0A=
-/* A linked list of verification programs.  Each one is called in=0A=
- * order of appearance within the configuration file.=0A=
- */=0A=
-typedef struct external_prog {=0A=
-	char *path;=0A=
-	char *args;=0A=
-	struct external_prog *next;=0A=
-} external_prog_t;=0A=
-=0A=
-int semod_config_parse (char *config_filename);=0A=
-semod_conf_t *semod_get_current_conf (void);=0A=
-int semod_is_store_direct (void);=0A=
-=0A=
-#endif=0A=

------=_NextPart_000_0098_01C5C2D3.0FC31BA0--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
