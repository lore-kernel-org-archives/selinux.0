Message-Id: <200509262347.j8QNlUYs018826@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage-reorg 3/7 
Date: Mon, 26 Sep 2005 19:47:29 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_009E_01C5C2D3.214C8C80"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_009E_01C5C2D3.214C8C80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This removes the file module_api.c. This code is substantially changed and
moved into direct_api.c and semanage.c in the next patch set.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_009E_01C5C2D3.214C8C80
Content-Type: application/octet-stream;
	name="3-remove_module_api.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="3-remove_module_api.diff"

--- libsemanage/src/module_api.c	2005-09-19 09:03:15.000000000 -0400=0A=
+++ libsemanage/src/module_api.c	1969-12-31 19:00:00.000000000 -0500=0A=
@@ -1,153 +0,0 @@=0A=
-/* Author: Jason Tang     <jtang@tresys.com>=0A=
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
-#include "semanage/semod_conf.h"=0A=
-#include "semanage/module_direct_api.h"=0A=
-#include "semanage/module_ps_api.h"=0A=
-=0A=
-#include <stdlib.h>=0A=
-=0A=
-#define DIRECT_CONNECT \=0A=
-        char *sandbox;                                              \=0A=
-        int retval =3D 0, retval2 =3D 0;                                =
\=0A=
-        if ((sandbox =3D semod_direct_connect(error_buf,              \=0A=
-                                        error_buf_size)) =3D=3D NULL) { =
\=0A=
-                return 1;                                           \=0A=
-        }=0A=
-#define DIRECT_DISCONNECT(commit) \=0A=
-        retval2 =3D semod_direct_disconnect(sandbox, commit,          \=0A=
-                                        error_buf, error_buf_size); \=0A=
-        if (retval < 0 || retval2 < 0) {                            \=0A=
-                return -1;                                          \=0A=
-        }=0A=
-#define PS_CONNECT \=0A=
-        semod_conf_t *conf =3D semod_get_current_conf();              \=0A=
-        int retval, retval2;                                        \=0A=
-        int fd =3D semod_ps_connect(&(conf->module_store),            \=0A=
-                                  error_buf, error_buf_size);       \=0A=
-        if (fd < 0) {                                               \=0A=
-                return 1;                                           \=0A=
-        }=0A=
-#define PS_DISCONNECT(commit) \=0A=
-        retval2 =3D semod_ps_disconnect(fd, commit,                   \=0A=
-                                      error_buf, error_buf_size);   \=0A=
-        if (retval !=3D 0 || retval2 !=3D 0) {                          =
\=0A=
-                return -1;                                          \=0A=
-        }=0A=
-=0A=
-=0A=
-/* Install a module.  Returns 0 on success, non-zero on error. */=0A=
-int semod_install_module(char *module_data, size_t data_len,=0A=
-                         char *error_buf, size_t error_buf_size) {=0A=
-        if (semod_is_store_direct()) {=0A=
-                DIRECT_CONNECT;=0A=
-                retval =3D semod_direct_install_module(sandbox, =
module_data,=0A=
-                                                     data_len, NULL,=0A=
-                                                     error_buf, =
error_buf_size);=0A=
-                DIRECT_DISCONNECT(retval =3D=3D 0);=0A=
-        }=0A=
-        else {=0A=
-                PS_CONNECT;=0A=
-                retval =3D semod_ps_install_module(fd, module_data, =
data_len,=0A=
-                                                 error_buf, =
error_buf_size);=0A=
-                PS_DISCONNECT(retval =3D=3D 0);=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-=0A=
-/* Upgrade an existing module.  Returns 0 on success, -1 on error. */=0A=
-int semod_upgrade_module(char *module_data, size_t data_len,=0A=
-                         char *error_buf, size_t error_buf_size) {=0A=
-        if (semod_is_store_direct()) {=0A=
-                DIRECT_CONNECT;=0A=
-                retval =3D semod_direct_upgrade_module(sandbox, =
module_data,=0A=
-                                                     data_len, NULL,=0A=
-                                                     error_buf, =
error_buf_size);=0A=
-                DIRECT_DISCONNECT(retval =3D=3D 0);=0A=
-        }=0A=
-        else {=0A=
-                PS_CONNECT;=0A=
-                retval =3D semod_ps_upgrade_module(fd, module_data, =
data_len,=0A=
-                                                 error_buf, =
error_buf_size);=0A=
-                PS_DISCONNECT(retval =3D=3D 0);=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Install a new base module.  Returns 0 on success, -1 on error. */=0A=
-int semod_install_base_module(char *module_data, size_t data_len,=0A=
-                              char *error_buf, size_t error_buf_size) {=0A=
-        if (semod_is_store_direct()) {=0A=
-                DIRECT_CONNECT;=0A=
-                retval =3D semod_direct_install_base_module(sandbox, =
module_data,=0A=
-                                                          data_len,=0A=
-                                                          error_buf, =
error_buf_size);=0A=
-                DIRECT_DISCONNECT(retval =3D=3D 0);=0A=
-        }=0A=
-        else {=0A=
-                PS_CONNECT;=0A=
-                retval =3D semod_ps_install_base_module(fd, =
module_data, data_len,=0A=
-                                                      error_buf, =
error_buf_size);=0A=
-                PS_DISCONNECT(retval =3D=3D 0);=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Remove an existing module.  Returns 0 on success, -1 on error. */=0A=
-int semod_remove_module(char *module_name,=0A=
-                        char *error_buf, size_t error_buf_size) {=0A=
-        if (semod_is_store_direct()) {=0A=
-                DIRECT_CONNECT;=0A=
-                retval =3D semod_direct_remove_module(sandbox, =
module_name,=0A=
-                                                    error_buf, =
error_buf_size);=0A=
-                DIRECT_DISCONNECT(retval =3D=3D 0);=0A=
-        }=0A=
-        else {=0A=
-                PS_CONNECT;=0A=
-                retval =3D semod_ps_remove_module(fd, module_name,=0A=
-                                                error_buf, =
error_buf_size);=0A=
-                PS_DISCONNECT(retval =3D=3D 0);=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Obtain a list of existing active modules and write it to the=0A=
- * reference variable *module_info.  The caller is responsible for=0A=
- * free()ing it afterwards.  Returns 0 on success, -1 on error.  Note=0A=
- * that if there are no modules then *module_info will will point to a=0A=
- * newly allocated empty string. */=0A=
-int semod_list_modules(char **module_info,=0A=
-                       char *error_buf, size_t error_buf_size) {=0A=
-        if (semod_is_store_direct()) {=0A=
-                *module_info =3D NULL;=0A=
-                DIRECT_CONNECT;=0A=
-                retval =3D semod_direct_list_modules(module_info);=0A=
-                DIRECT_DISCONNECT(0);=0A=
-        }=0A=
-        else {=0A=
-                if ((*module_info =3D malloc (1024)) =3D=3D NULL) {=0A=
-                        return -1;=0A=
-                }=0A=
-                PS_CONNECT;=0A=
-                retval =3D semod_ps_list_modules(fd, *module_info, =
1024);=0A=
-                PS_DISCONNECT(0);=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=

------=_NextPart_000_009E_01C5C2D3.214C8C80--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
