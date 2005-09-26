Message-Id: <200509262347.j8QNluYs018829@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage-reorg 4/7 
Date: Mon, 26 Sep 2005 19:47:56 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00A1_01C5C2D3.30D06960"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00A1_01C5C2D3.30D06960
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch removes module_ps_api.c. This code will be reworked and submitted
for inclusion at a later date. It is not present in the next patch set.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_00A1_01C5C2D3.30D06960
Content-Type: application/octet-stream;
	name="4-remove-modules_ps_api.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="4-remove-modules_ps_api.diff"

--- libsemanage/src/module_ps_api.c	2005-09-19 09:03:15.000000000 -0400=0A=
+++ libsemanage/src/module_ps_api.c	1969-12-31 19:00:00.000000000 -0500=0A=
@@ -1,560 +0,0 @@=0A=
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
-#include "semanage/module_ps_api.h"=0A=
-#include "semanage/semod_conf.h"=0A=
-=0A=
-#include <ctype.h>=0A=
-#include <errno.h>=0A=
-#include <fcntl.h>=0A=
-#include <stdarg.h>=0A=
-#include <stdio.h>=0A=
-#include <stdlib.h>=0A=
-#include <string.h>=0A=
-#include <unistd.h>=0A=
-#include <arpa/inet.h>=0A=
-#include <netinet/in.h>=0A=
-#include <sys/socket.h>=0A=
-#include <sys/stat.h>=0A=
-#include <sys/types.h>=0A=
-#include <sys/un.h>=0A=
-=0A=
-static int read_server (int fd, char *results, size_t results_size, int =
block);=0A=
-static int read_bytestream (int fd, char *num_bytes_string,=0A=
-                            char *results, size_t results_size);=0A=
-static int copy_optional_string (char *buffer, size_t buffer_size,=0A=
-                                 char *read_buf);=0A=
-static int write_msg (int fd, char *fmt, ...);=0A=
-static int write_msg_data (int fd, char *data, size_t data_len, char =
*fmt, ...);=0A=
-=0A=
-/* Command the policy server to install a module.  If results is not=0A=
- * NULL then write the message received from the server to it, up to=0A=
- * results_size - 1 bytes.  The string is guaranteed to be nul=0A=
- * terminated.  Returns 0 on success, -1 if it could not send the=0A=
- * command, or the [positive] error code received from the server.=0A=
- */=0A=
-int semod_ps_install_module (int fd, char *module_data, size_t data_len,=0A=
-                             char *results, size_t results_size) {=0A=
-        int retval;=0A=
-        char buf [256];=0A=
-        if (results !=3D NULL && results_size > 0) {=0A=
-                *results =3D '\0';=0A=
-        }=0A=
-        if (write_msg_data (fd, module_data, data_len, =
"INSTALL_MODULE") =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((retval =3D read_server (fd, buf, sizeof (buf), 1)) !=3D 0) =
{=0A=
-                if (results !=3D NULL && results_size > 0) {=0A=
-                        (void) strncpy (results, buf, results_size);=0A=
-                        results [results_size - 1] =3D '\0';=0A=
-                }=0A=
-                return retval;=0A=
-        }=0A=
-        else {=0A=
-                return read_bytestream (fd, buf, results, results_size);=0A=
-                return 0;=0A=
-        }=0A=
-}=0A=
-=0A=
-/* Command the policy server to upgrade a module.  If results is not=0A=
- * NULL then write the message received from the server to it, up to=0A=
- * results_size - 1 bytes.  The string is guaranteed to be nul=0A=
- * terminated.  Returns 0 on success, -1 if it could not send the=0A=
- * command, or the [positive] error code received from the server.=0A=
- */=0A=
-int semod_ps_upgrade_module (int fd, char *module_data, size_t data_len,=0A=
-                             char *results, size_t results_size) {=0A=
-        int retval;=0A=
-        char buf [256];=0A=
-        if (results !=3D NULL && results_size > 0) {=0A=
-                *results =3D '\0';=0A=
-        }=0A=
-        if (write_msg_data (fd, module_data, data_len, =
"UPGRADE_MODULE") =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((retval =3D read_server (fd, buf, sizeof (buf), 1)) !=3D 0) =
{=0A=
-                if (results !=3D NULL && results_size > 0) {=0A=
-                        (void) strncpy (results, buf, results_size);=0A=
-                        results [results_size - 1] =3D '\0';=0A=
-                }=0A=
-                return retval;=0A=
-        }=0A=
-        else {=0A=
-                return read_bytestream (fd, buf, results, results_size);=0A=
-        }=0A=
-}=0A=
-=0A=
-/* Command the policy server to install a new base module.  If results=0A=
- * is not NULL then write the message received from the server to it,=0A=
- * up to results_size - 1 bytes.  The string is guaranteed to be nul=0A=
- * terminated.  Returns 0 on success, -1 if it could not send the=0A=
- * command, or the [positive] error code received from the server.=0A=
- */=0A=
-int semod_ps_install_base_module (int fd, char *base_data, size_t =
data_len,=0A=
-                                  char *results, size_t results_size) {=0A=
-        int retval;=0A=
-        char buf [256];=0A=
-        if (results !=3D NULL && results_size > 0) {=0A=
-                *results =3D '\0';=0A=
-        }=0A=
-        if (write_msg_data (fd, base_data, data_len, "BASE_MODULE") =
=3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((retval =3D read_server (fd, buf, sizeof (buf), 1)) !=3D 0) =
{=0A=
-                if (results !=3D NULL && results_size > 0) {=0A=
-                        (void) strncpy (results, buf, results_size);=0A=
-                        results [results_size - 1] =3D '\0';=0A=
-                }=0A=
-                return retval;=0A=
-        }=0A=
-        else {=0A=
-                return read_bytestream (fd, buf, results, results_size);=0A=
-        }=0A=
-}=0A=
-=0A=
-/* Command the policy server to remove a module.  If results is not=0A=
- * NULL then write the message received from the server to it, up to=0A=
- * results_size - 1 bytes.  The string is guaranteed to be nul=0A=
- * terminated.  Returns 0 on success, -1 if it could not send the=0A=
- * command, or the [positive] error code received from the server.=0A=
- */=0A=
-int semod_ps_remove_module (int fd, char *module_name,=0A=
-                            char *results, size_t results_size) {=0A=
-        int retval;=0A=
-        char buf [256];=0A=
-        if (results !=3D NULL && results_size > 0) {=0A=
-                *results =3D '\0';=0A=
-        }=0A=
-        if (write_msg (fd, "REMOVE_MODULE %s\n", module_name) =3D=3D =
-1) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((retval =3D read_server (fd, buf, sizeof (buf), 1)) !=3D 0) =
{=0A=
-                if (results !=3D NULL && results_size > 0) {=0A=
-                        (void) strncpy (results, buf, results_size);=0A=
-                        results [results_size - 1] =3D '\0';=0A=
-                }=0A=
-                return retval;=0A=
-        }=0A=
-        else {=0A=
-                return read_bytestream (fd, buf, results, results_size);=0A=
-        }=0A=
-}=0A=
-=0A=
-/* Obtain from the policy server a list of active modules.  If results=0A=
- * is not NULL then write the list or any error messages to it, up to=0A=
- * results_size - 1 bytes.  The string is guaranteed to be nul=0A=
- * terminated.  A tab character separates the module name from its=0A=
- * version; newlines separate modules.  Returns 0 on success, -1 if it=0A=
- * could not send the command, or the [positive] error code received=0A=
- * from the server.=0A=
- */=0A=
-int semod_ps_list_modules (int fd, char *results, size_t results_size) {=0A=
-        int retval;=0A=
-        char buf [256];=0A=
-        if (results !=3D NULL && results_size > 0) {=0A=
-                *results =3D '\0';=0A=
-        }=0A=
-        if (write_msg (fd, "LIST_MODULES\n") =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((retval =3D read_server (fd, buf, sizeof (buf), 1)) !=3D 0) =
{=0A=
-                if (results !=3D NULL && results_size > 0) {=0A=
-                        (void) strncpy (results, buf, results_size);=0A=
-                        results [results_size - 1] =3D '\0';=0A=
-                }=0A=
-                return retval;=0A=
-        }=0A=
-        else {=0A=
-                return read_bytestream (fd, buf, results, results_size);=0A=
-        }=0A=
-}=0A=
-=0A=
-/* Obtain from the policy server a list of modules within the sandbox.=0A=
- * If results is not NULL then write the list or any error messages to=0A=
- * it, up to results_size - 1 bytes.  The string is guaranteed to be=0A=
- * nul terminated.  A tab character separates the module name from its=0A=
- * version; newlines separate modules.  Returns 0 on success, -1 if it=0A=
- * could not send the command, or the [positive] error code received=0A=
- * from the server.=0A=
- */=0A=
-int semod_ps_list_sandbox (int fd, char *results, size_t results_size) {=0A=
-        int retval;=0A=
-        char buf [256];=0A=
-        if (results !=3D NULL && results_size > 0) {=0A=
-                *results =3D '\0';=0A=
-        }=0A=
-        if (write_msg (fd, "LIST_UNCOMMITTED_MODULES\n") =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((retval =3D read_server (fd, buf, sizeof (buf), 1)) !=3D 0) =
{=0A=
-                if (results !=3D NULL && results_size > 0) {=0A=
-                        (void) strncpy (results, buf, results_size);=0A=
-                        results [results_size - 1] =3D '\0';=0A=
-                }=0A=
-                return retval;=0A=
-        }=0A=
-        else {=0A=
-                return read_bytestream (fd, buf, results, results_size);=0A=
-        }=0A=
-}=0A=
-=0A=
-/* Command the policy server to commit all changes.  If results is not=0A=
- * NULL then write the message received from the server to it, up to=0A=
- * results_size - 1 bytes.  The string is guaranteed to be nul=0A=
- * terminated.  Returns 0 on success, negative value on error, or the=0A=
- * [positive] error code received from the server.=0A=
- */=0A=
-int semod_ps_commit (int fd, char *results, size_t results_size) {=0A=
-        int retval;=0A=
-        char buf [256];=0A=
-        if (results !=3D NULL && results_size > 0) {=0A=
-                *results =3D '\0';=0A=
-        }=0A=
-        if (write_msg (fd, "COMMIT\n") =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((retval =3D read_server (fd, buf, sizeof (buf), 1)) !=3D 0) =
{=0A=
-                if (results !=3D NULL && results_size > 0) {=0A=
-                        (void) strncpy (results, buf, results_size);=0A=
-                        results [results_size - 1] =3D '\0';=0A=
-                }=0A=
-                return retval;=0A=
-        }=0A=
-        else {=0A=
-                return read_bytestream (fd, buf, results, results_size);=0A=
-        }=0A=
-}=0A=
-=0A=
-/* Attempt to make a connection to the policy server specified within=0A=
- * the given semod_module_store struct.  If results is not NULL then=0A=
- * write the message received from the server to it, up to=0A=
- * results_size - 1 bytes.  The string is guaranteed to be nul=0A=
- * terminated.  The file descriptor will be set to non-blocking mode.=0A=
- * Return the file descriptor used, -1 if the server could not be=0A=
- * found, -2 if the server rejected this connection, or -3 for all=0A=
- * other errors.=0A=
- */=0A=
-int semod_ps_connect (semod_module_store_t *mod_store,=0A=
-                      char *results, size_t results_size) {=0A=
-        int fd;=0A=
-        char handshake [256];=0A=
-        if (results !=3D NULL && results_size > 0) {=0A=
-                *results =3D '\0';=0A=
-        }=0A=
-        if (mod_store->store_type =3D=3D SEMOD_STORE_REMOTE_SOCKET) {=0A=
-                struct sockaddr_in sock;=0A=
-                char *server_addr =3D mod_store->server_path;=0A=
-                int server_port =3D mod_store->server_port;=0A=
-                if ((fd =3D socket (AF_INET, SOCK_STREAM, 0)) =3D=3D =
-1) {=0A=
-                        return -3;=0A=
-                }=0A=
-                (void) memset (&sock, 0, sizeof (sock));=0A=
-                sock.sin_family =3D AF_INET;=0A=
-                if (inet_aton (server_addr, &sock.sin_addr) =3D=3D 0) {=0A=
-                        (void) close (fd);=0A=
-                        return -1;=0A=
-                }=0A=
-                sock.sin_port =3D htons (server_port);=0A=
-                if (connect (fd, (struct sockaddr *) &sock, sizeof =
(sock)) =3D=3D -1) {=0A=
-                        (void) close (fd);=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        else if (mod_store->store_type =3D=3D SEMOD_STORE_NAMED_SOCKET) =
{=0A=
-                struct sockaddr_un sock;=0A=
-                char *server_path =3D mod_store->server_path;=0A=
-                if ((fd =3D socket (AF_UNIX, SOCK_STREAM, 0)) =3D=3D =
-1) {=0A=
-                        return -3;=0A=
-                }=0A=
-                sock.sun_family =3D AF_UNIX;=0A=
-                (void) strncpy (sock.sun_path, server_path, sizeof =
(sock.sun_path));=0A=
-                sock.sun_path [sizeof (sock.sun_path) - 1] =3D '\0';=0A=
-                if (connect (fd, (struct sockaddr *) &sock, sizeof =
(sock)) =3D=3D -1) {=0A=
-                        (void) close (fd);=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        else {=0A=
-                /* unknown module store type */=0A=
-                return -2;=0A=
-        }=0A=
-        if (fcntl (fd, F_SETFL, O_NONBLOCK) =3D=3D -1) {=0A=
-                (void) close (fd);=0A=
-                return -3;=0A=
-        }=0A=
-        (void) snprintf (handshake, sizeof (handshake),=0A=
-                         "CONNECT %d.%d\n",=0A=
-                         SEMOD_PS_PROTOCOL_VERSION_MAJOR,=0A=
-                         SEMOD_PS_PROTOCOL_VERSION_MINOR);=0A=
-        if (write (fd, handshake, strlen (handshake)) !=3D =
(ssize_t)strlen (handshake)) {=0A=
-                (void) close (fd);=0A=
-                return -1;=0A=
-        }=0A=
-        if (read_server (fd, handshake, sizeof (handshake), 1) !=3D 0) {=0A=
-                (void) close (fd);=0A=
-                if (results !=3D NULL && results_size > 0) {=0A=
-                        (void) strncpy (results, handshake, =
results_size);=0A=
-                        results [results_size - 1] =3D '\0';=0A=
-                }=0A=
-                return -2;=0A=
-        }=0A=
-        if (read_bytestream (fd, handshake, results, results_size) =
=3D=3D -1) {=0A=
-                (void) close (fd);=0A=
-                return -1;=0A=
-        }=0A=
-        return fd;=0A=
-}=0A=
-=0A=
-/* If 'commit' is non-zero, command the policy server to commit the=0A=
- * changes.  Regardless if there was a commit or not disconnect from=0A=
- * the server.  Returns 0 on success, negative value on error, or the=0A=
- * [positive] error code received from the server.=0A=
- */=0A=
-int semod_ps_disconnect (int fd, int commit,=0A=
-                         char *results, size_t results_size) {=0A=
-        int retval =3D 0;=0A=
-        if (commit) {=0A=
-                retval =3D semod_ps_commit (fd, results, results_size);=0A=
-        }=0A=
-        (void) close (fd);=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-=0A=
-/*************************/=0A=
-/* Low-end I/O functions */=0A=
-=0A=
-/* Reads a [properly] formatted response from the server.  Returns 0=0A=
- * if server said okay, otherwise the error number.  If server gave no=0A=
- * error number then return -1.  If 'block' is non-zero, return -2 if=0A=
- * nothing was available.  Return -3 for all other errors. If message=0A=
- * is "OK", *results is set to the string representation of number of=0A=
- * bytes following OK.  Else if message is an error than *results is=0A=
- * set to the error string.  For a busy or info message, print the=0A=
- * string and wait for another message.  For both cases *results will=0A=
- * be nul terminated and no more than 'results_size' bytes will be=0A=
- * written.=0A=
- */=0A=
-static int read_server (int fd, char *results, size_t results_size, int =
block) {=0A=
-        char buf [256], *bp;=0A=
-        fd_set read_fds;=0A=
-        struct timeval timeout =3D {0, 0};=0A=
-        int code;=0A=
-=0A=
-        if (results !=3D NULL && results_size > 0) {=0A=
-                *results =3D '\0';=0A=
-        }=0A=
-        FD_ZERO (&read_fds);=0A=
-        FD_SET (fd, &read_fds);=0A=
-        if (block) {=0A=
-                if (select (fd + 1, &read_fds, NULL, NULL, NULL) =3D=3D =
-1) {=0A=
-                        return -3;=0A=
-                }=0A=
-        }=0A=
-        else {=0A=
-                switch (select (fd + 1, &read_fds, NULL, NULL, =
&timeout)) {=0A=
-                case 0: {=0A=
-                        return -2;=0A=
-                }=0A=
-                case -1: {=0A=
-                        return -3;=0A=
-                }=0A=
-                }=0A=
-        }=0A=
-        /* read up to the next newline */=0A=
-        bp =3D buf;=0A=
-        do {=0A=
-                switch (read (fd, bp, 1)) {=0A=
-                case 0: {=0A=
-                        *bp =3D '\n';=0A=
-                        break;=0A=
-                }=0A=
-                case -1: {=0A=
-                        return -3;=0A=
-                }=0A=
-                }=0A=
-                bp++;=0A=
-        } while (bp + 1 < buf + sizeof(buf) && *(bp - 1) !=3D '\n');=0A=
-        /* chomp() the buffer; also ensure that it is nul terminated */=0A=
-        if (*(bp - 1) =3D=3D '\n') {=0A=
-                *(bp - 1) =3D '\0';=0A=
-        }=0A=
-        else {=0A=
-                *bp =3D '\0';=0A=
-        }=0A=
-        if (buf [0] =3D=3D 'O' && buf [1] =3D=3D 'K') {=0A=
-                for (bp =3D buf + 2; *bp !=3D '\0' && isspace (*bp); =
bp++)=0A=
-                        ;=0A=
-                if (results !=3D NULL && results_size > 0) {=0A=
-                        (void) strncpy (results, bp, results_size - 1);=0A=
-                        results [results_size - 1] =3D '\0';=0A=
-                }=0A=
-                return 0;=0A=
-        }=0A=
-        else if (buf [0] =3D=3D 'E' && buf [1] =3D=3D 'R' && buf [2] =
=3D=3D 'R') {=0A=
-                code =3D copy_optional_string (results, results_size, =
buf + 4);=0A=
-                if (code > 0) {=0A=
-                        return code;=0A=
-                }=0A=
-                else {=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        else if (buf [0] =3D=3D 'B' && buf [1] =3D=3D 'U' &&=0A=
-                 buf [2] =3D=3D 'S' && buf [3] =3D=3D 'Y') {=0A=
-                code =3D copy_optional_string (results, results_size, =
buf + 4);=0A=
-                /* server is busy; wait for the next line */=0A=
-                return read_server (fd, results, results_size, block);=0A=
-        }=0A=
-        else if (buf [0] =3D=3D 'I' && buf [1] =3D=3D 'N' &&=0A=
-                 buf [2] =3D=3D 'F' && buf [3] =3D=3D 'O') {=0A=
-                code =3D copy_optional_string (results, results_size, =
buf + 4);=0A=
-                /* server sent some informational message; wait for=0A=
-                 * the next line */=0A=
-                return read_server (fd, results, results_size, block);=0A=
-        }=0A=
-        else {=0A=
-                /* received some unknown message */=0A=
-                return -3;=0A=
-        }=0A=
-}=0A=
-=0A=
-/* Parse the integer at the start of 'read_buf', ignoring any initial=0A=
- * whitespace.  If there was no number, return 0 and leave 'buffer'=0A=
- * unchanged.  Otherwise fill 'buffer' up to 'buffer_size' bytes by=0A=
- * the remaining contents of 'read_buf'.  Finally return the initial=0A=
- * number found in 'read_buf'.=0A=
- */=0A=
-static int copy_optional_string (char *buffer, size_t buffer_size,=0A=
-                                 char *read_buf) {=0A=
-        int code;=0A=
-        char c, *remainder;=0A=
-=0A=
-        while ((c =3D *read_buf) !=3D '\0' && isspace (c)) {=0A=
-                read_buf++;=0A=
-        }=0A=
-        code =3D (int) strtol (read_buf, &remainder, 10);=0A=
-        while ((c =3D *remainder) !=3D '\0' && isspace (c)) {=0A=
-                remainder++;=0A=
-        }=0A=
-        if (buffer !=3D NULL && buffer_size > 0) {=0A=
-                (void) strncpy (buffer, remainder, buffer_size - 1);=0A=
-                buffer [buffer_size - 1] =3D '\0';=0A=
-        }=0A=
-        return code;=0A=
-}=0A=
-=0A=
-/* Reads a stream of bytes from the server and writes it to results up=0A=
- * to results_size - 1 bytes.  The results string will always be nul=0A=
- * terminated.  Number of bytes to read is given by a character string=0A=
- * (which is conveniently returned by net_read_server()).  If results=0A=
- * is NULL then don't write to it at all (but still read from the=0A=
- * server).  On success return 0, or -1 if error while reading.=0A=
- */=0A=
-static int read_bytestream (int fd, char *num_bytes_string,=0A=
-                            char *results, size_t results_size) {=0A=
-        size_t num_bytes =3D (size_t) atol (num_bytes_string);=0A=
-        size_t amount_to_read, amount_read, amount_to_write;=0A=
-        char buf [256];=0A=
-	int rc;=0A=
-        if (num_bytes =3D=3D 0) {=0A=
-                return 0;=0A=
-        }=0A=
-        while (num_bytes > 0) {=0A=
-                amount_to_read =3D num_bytes > 256 ? 256 : num_bytes;=0A=
-                rc =3D read (fd, buf, amount_to_read);=0A=
-		amount_read =3D (rc > 0) ? rc : 0;=0A=
-                if (rc < 0) {=0A=
-                        if (errno =3D=3D EIO) {=0A=
-                                if (results !=3D NULL && results_size > =
0) {=0A=
-                                        *results =3D '\0';=0A=
-                                }=0A=
-                                return -1;=0A=
-                        }=0A=
-                }=0A=
-                if (results !=3D NULL) {=0A=
-                        amount_to_write =3D results_size - 1 < =
amount_read ?=0A=
-                                results_size - 1 : amount_read;=0A=
-                        (void) memcpy (results, buf, amount_to_write);=0A=
-                        results +=3D amount_to_write;=0A=
-                        results_size -=3D amount_to_write;=0A=
-                }=0A=
-                num_bytes -=3D amount_read;=0A=
-        }=0A=
-        if (results !=3D NULL && results_size > 0) {=0A=
-                *results =3D '\0';=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Sends a single message to the server.  Returns 0 if message was=0A=
- * sent, -1 if not.=0A=
- */=0A=
-#ifdef __GNUC__=0A=
-__attribute__ ((format (printf, 2, 3)))=0A=
-#endif=0A=
-static int write_msg (int fd, char *fmt, ...) {=0A=
-        char buf [256];=0A=
-        va_list ap;=0A=
-        va_start (ap, fmt);=0A=
-        (void) vsnprintf (buf, sizeof (buf), fmt, ap);=0A=
-        va_end (ap);=0A=
-        while (write (fd, buf, strlen (buf)) =3D=3D -1) {=0A=
-                if (errno !=3D EAGAIN) {=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Send a message followed by the contents of a file to the server.=0A=
- * Returns 0 if message was sent or -1 if message could not be=0A=
- * delivered;=0A=
- */=0A=
-#ifdef __GNUC__=0A=
-__attribute__ ((format (printf, 4, 5)))=0A=
-#endif=0A=
-static int write_msg_data (int fd, char *data, size_t data_len, char =
*fmt, ...) {=0A=
-        char buf [256], buf2 [256];=0A=
-        va_list ap;=0A=
-        va_start (ap, fmt);=0A=
-        (void) vsnprintf (buf, sizeof (buf), fmt, ap);=0A=
-        va_end (ap);=0A=
-        (void) snprintf (buf2, sizeof (buf2), "%s %u\n", buf, data_len);=0A=
-        if (write (fd, buf2, strlen (buf2)) =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        while (data_len > 0) {=0A=
-                /* because client fd was opened as O_NONBLOCK, make=0A=
-                 * sure not to overflow the write buffer */=0A=
-                size_t amount_to_write =3D data_len > 1024 ? 1024 : =
data_len;=0A=
-                int rc =3D write (fd, data, amount_to_write);=0A=
-                size_t amount_written =3D (rc > 0) ? rc : 0;=0A=
-                if (rc < 0) {=0A=
-                        if (errno !=3D EAGAIN) {=0A=
-                                return -1;=0A=
-                        }=0A=
-                }=0A=
-                else {=0A=
-                        data_len -=3D amount_written;=0A=
-                        data +=3D amount_written;=0A=
-                }=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=

------=_NextPart_000_00A1_01C5C2D3.30D06960--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
