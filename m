Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUlrH001830
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:47 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUjJc002894
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:46 GMT
Message-Id: <20070423213743.939428000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:19 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 24/33] libsemanage: networking support
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sending/receiving utilities in messages.[ch].  Additional exported defines to support message processing.
---
 libsemanage/include/semanage/messages.h |  126 +++++++++++
 libsemanage/include/semanage/semanage.h |    3 
 libsemanage/src/messages.c              |  355 ++++++++++++++++++++++++++++++++
 libsemanage/src/messages_internal.h     |   39 +++
 4 files changed, 523 insertions(+)

Index: selinux-pms-support/libsemanage/include/semanage/messages.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/include/semanage/messages.h
@@ -0,0 +1,126 @@
+/* Author:  Caleb Case                  <ccase@tresys.com>
+ *          Christopher Ashworth        <cashworth@tresys.com>
+ *
+ * Copyright (C) 2004-2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ *  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_MESSAGES_H_
+#define _SEMANAGE_MESSAGES_H_
+
+#ifndef SEMANAGE_PS_DEFAULT_TIMEOUT
+#define SEMANAGE_PS_DEFAULT_TIMEOUT 160
+#endif
+
+/* Message types in the client/server protocol.
+ */
+enum message_types {
+	PS_OK = 1,		/* policy server response */
+	PS_ERR,			/* policy server response */
+	PS_BUSY,		/* policy server response */
+	PS_INFO,		/* policy server response */
+	PS_CONNECT = 100,
+	PS_DISCONNECT,
+	PS_BEGIN_TRANSACTION,
+	PS_COMMIT,
+	PS_GET_COMMIT_NUMBER,
+	PS_INSTALL_MODULE,
+	PS_UPGRADE_MODULE,
+	PS_BASE_MODULE,
+	PS_REMOVE_MODULE,
+	PS_LIST_MODULES,
+	PS_GET_DATABASE,
+	PS_PUT_DATABASE
+};
+
+/* Database types in the client/server protocol.
+ */
+enum database_types {
+	DB_BOOLEAN_ACTIVE,
+	DB_BOOLEAN_LOCAL,
+	DB_BOOLEAN_POLICY,
+	DB_FCONTEXT_LOCAL,
+	DB_FCONTEXT_POLICY,
+	DB_INTERFACE_LOCAL,
+	DB_INTERFACE_POLICY,
+	DB_NODE_LOCAL,
+	DB_NODE_POLICY,
+	DB_PORT_LOCAL,
+	DB_PORT_POLICY,
+	DB_SEUSER_LOCAL,
+	DB_SEUSER_POLICY,
+	DB_USER_LOCAL,
+	DB_USER_POLICY,
+};
+
+/* Info and error message types and strings.
+ */
+#define PS_ERROR_MESSAGE_MAX_LENGTH 256
+
+#define PS_INFO_SERVER_CLOSING_NUM 100
+#define PS_INFO_SERVER_CLOSING_STR "Server is being shut down."
+#define PS_INFO_CHANGED_NUM 102
+#define PS_INFO_CHANGED_STR "Policy has been changed since session began."
+
+#define PS_BUSY_COMMIT_NUM 300
+#define PS_BUSY_COMMIT_STR "Another client is currently committing changes."
+#define PS_BUSY_WRITE_NUM 301
+#define PS_BUSY_WRITE_STR "Another client is currently writing."
+
+#define PS_ERROR_COULD_NOT_PARSE_NUM 400
+#define PS_ERROR_COULD_NOT_PARSE_STR "Could not parse request."
+#define PS_ERROR_NOTHING_TO_COMMIT_NUM 401
+#define PS_ERROR_NOTHING_TO_COMMIT_STR "There was nothing to commit."
+#define PS_ERROR_COULD_NOT_UPGRADE_NUM 402
+#define PS_ERROR_COULD_NOT_UPGRADE_STR "Module to be upgraded does not exist or is earlier than existing version."
+#define PS_ERROR_FORBIDDEN_NUM 403
+#define PS_ERROR_FORBIDDEN_STR "Could not access requested file or directory."
+#define PS_ERROR_NO_BASE_MODULE_NUM 404
+#define PS_ERROR_NO_BASE_MODULE_STR "Cannot execute command because no base module was found."
+#define PS_ERROR_METAVERIFY_FAILED_NUM 405
+#define PS_ERROR_METAVERIFY_FAILED_STR "The metapolicy did not accept a component."
+#define PS_ERROR_VERIFY_FAILED_NUM 406
+#define PS_ERROR_VERIFY_FAILED_STR "A verifier did not accept the new policy."
+#define PS_ERROR_COULD_NOT_EXPAND_NUM 409
+#define PS_ERROR_COULD_NOT_EXPAND_STR "Error while expanding policy."
+#define PS_ERROR_COULD_NOT_LINK_NUM 412
+#define PS_ERROR_COULD_NOT_LINK_STR "Error while linking modules."
+#define PS_ERROR_DATA_NOT_A_MODULE_NUM 415
+#define PS_ERROR_DATA_NOT_A_MODULE_STR "The supplied file was not a valid policy module."
+#define PS_ERROR_DATA_NOT_A_BASE_NUM 416
+#define PS_ERROR_DATA_NOT_A_BASE_STR "The supplied file was not a valid base policy module."
+#define PS_ERROR_COULD_NOT_LOAD_NUM 417
+#define PS_ERROR_COULD_NOT_LOAD_STR "Error while loading new policy."
+#define PS_ERROR_COULD_NOT_REMOVE_NUM 418
+#define PS_ERROR_COULD_NOT_REMOVE_STR "Error while removing policy."
+
+#define PS_ERROR_NOT_IMPLEMENTED_NUM 501
+#define PS_ERROR_NOT_IMPLEMENTED_STR "Function not implemented."
+#define PS_ERROR_BUSY_NUM 503
+#define PS_ERROR_BUSY_STR "Too many clients connected to server."
+#define PS_ERROR_UNSUPPORTED_VERSION_NUM 505
+#define PS_ERROR_UNSUPPORTED_VERSION_STR "That protocol version is not supported."
+#define PS_ERROR_MESSAGE_INVALID_NUM 506
+#define PS_ERROR_MESSAGE_INVALID_STR "The message was invalid."
+#define PS_ERROR_MESSAGE_TOO_BIG_NUM 507
+#define PS_ERROR_MESSAGE_TOO_BIG_STR "The message was longer than the supported maximum length."
+#define PS_ERROR_NO_SUCH_DATABASE_NUM 508
+#define PS_ERROR_NO_SUCH_DATABASE_STR "Database requested does not exist."
+
+
+#endif
Index: selinux-pms-support/libsemanage/include/semanage/semanage.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/semanage.h
+++ selinux-pms-support/libsemanage/include/semanage/semanage.h
@@ -52,4 +52,7 @@
 #include <semanage/nodes_local.h>
 #include <semanage/nodes_policy.h>
 
+/* Messaging */
+#include <semanage/messages.h>
+
 #endif
Index: selinux-pms-support/libsemanage/src/messages.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/messages.c
@@ -0,0 +1,355 @@
+/* Author:  Jason Tang                  <jtang@tresys.com>
+ *          Christopher Ashworth        <cashworth@tresys.com>
+ *          Caleb Case                  <ccase@tresys.com>
+ *
+ * Copyright (C) 2004-2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ *  02110-1301  USA
+ */
+
+/*
+ *  messages.c
+ *
+ *  Implements basic network io functions for communicating with a
+ *  policy server.
+ *
+ *  All messages to and from the server take the following form:
+ *
+ *    uint32_t message_type
+ *    uint64_t data_length    (may be zero)
+ *    char     *data          (may be omitted, if data_length == 0)
+ *
+ */
+
+#include <assert.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/un.h>
+
+#include <semanage/messages.h>
+
+#include "debug.h"
+#include "byteswap.h"
+#include "messages_internal.h"
+
+/* Reads a stream of bytes into the supplied buffer.
+ * Buffer must be large enough to hold the requested number of bytes.
+ * Returns 0 on success, if all the requested bytes have been read.
+ * Returns -1 on error.
+ */
+int read_n(semanage_handle_t *sh, int socket_fd, int timeout, char *buf, size_t n)
+{
+	size_t total_read = 0;
+	ssize_t amount_read = 0;
+	struct timeval timeout_spec;
+	time_t start_time;
+	time_t current_time;
+	fd_set read_fds;
+
+	if (n == 0) {
+		return 0;
+	}
+	if (buf == NULL) {
+		return -1;
+	}
+
+	if (time(&start_time) < 0) {
+		return -1;
+	}
+
+	while (total_read < n) {
+		if (timeout > 0) {
+			FD_ZERO(&read_fds);
+			FD_SET(socket_fd, &read_fds);
+			timeout_spec.tv_sec = timeout;
+			timeout_spec.tv_usec = 0;
+			switch (select
+				(socket_fd + 1, &read_fds, NULL, NULL,
+				 &timeout_spec)) {
+			case -1:
+				if (errno == EINTR) {
+					/* signal delivered */
+					continue;
+				} else {
+					return -1;
+				}
+			case 0:
+				/* timed out */
+				ERR(sh, "Server timout");
+				return -1;
+			}
+			if (!FD_ISSET(socket_fd, &read_fds))
+				return -1;
+		}
+		amount_read = read(socket_fd, buf + total_read, n - total_read);
+		if (amount_read == -1 && (errno == EINTR || errno == EAGAIN)) {
+			continue;
+		} else if (amount_read > 0) {
+			total_read += amount_read;
+		} else if (amount_read == 0) {
+			if (time(&current_time) < 0) {
+				return -1;
+			} else {
+				if (difftime(start_time, current_time) >
+				    timeout) {
+					/* timed out */
+					ERR(sh, "Server timout");
+					return -1;
+				}
+			}
+		} else {
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/* Similar to read_n in that it reads a bunch of bytes from a socket.
+ * However, instead of storing them this function discards the values.
+ * Returns 0 on success, if all the requested bytes have been flushed.
+ * Returns -1 on error.
+ */
+int flush_n(semanage_handle_t *sh, int socket_fd, int timeout, uint64_t n)
+{
+	ssize_t amount_read;
+	struct timeval timeout_spec;
+	time_t start_time;
+	time_t current_time;
+	fd_set read_fds;
+	char buf[1024];
+
+	if (time(&start_time) < 0) {
+		return -1;
+	}
+
+	while (n > 0) {
+		if (timeout > 0) {
+			FD_ZERO(&read_fds);
+			FD_SET(socket_fd, &read_fds);
+			timeout_spec.tv_sec = timeout;
+			timeout_spec.tv_usec = 0;
+			switch (select
+				(socket_fd + 1, &read_fds, NULL, NULL,
+				 &timeout_spec)) {
+			case -1:
+				if (errno == EINTR) {
+					/* signal delivered */
+					continue;
+				} else {
+					return -1;
+				}
+			case 0:
+				/* timed out */
+				ERR(sh, "Server timout");
+				return -1;
+			}
+			if (!FD_ISSET(socket_fd, &read_fds))
+				return -1;
+		}
+		amount_read = read(socket_fd, buf,
+				   (n > sizeof(buf) ? sizeof(buf) : n));
+		if (amount_read == -1 && (errno == EINTR || errno == EAGAIN)) {
+			continue;
+		} else if (amount_read > 0) {
+			n -= amount_read;
+		} else if (amount_read == 0) {
+			if (time(&current_time) < 0) {
+				return -1;
+			} else {
+				if (difftime(start_time, current_time) >
+				    timeout) {
+					/* time out */
+					return -1;
+				}
+			}
+		} else {
+			/* error; bail */
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/* Reads a single message from the given socket.
+ * message_type, data_length, and data are all set upon success.
+ * data_length may be 0, in which case data will be NULL.
+ * Caller is responsible for freeing a non-NULL data.
+ *
+ * Returns 0 on success.
+ * Returns -1 if we get an error when trying to read.
+ * Returns -2 if we cannot handle a message of the size received.
+ */
+int read_msg(semanage_handle_t *sh, int socket_fd, int timeout, uint32_t * message_type,
+	     uint64_t * data_length, char **data)
+{
+	char msg_header[sizeof(uint32_t) + sizeof(uint64_t)];
+
+	/* initially just read the message header.
+	 * this header contains the message type and data length. */
+	if (read_n(sh, socket_fd, timeout, msg_header, sizeof(msg_header)) == -1) {
+		return -1;
+	}
+
+	/* extract the message type */
+	memcpy(message_type, msg_header, sizeof(*message_type));
+	*message_type = le32_to_cpu(*message_type);
+
+	/* extract the length of the message data */
+	memcpy(data_length, msg_header + sizeof(*message_type),
+	       sizeof(*data_length));
+	*data_length = le64_to_cpu(*data_length);
+
+	/* check whether data_length will fit in a size_t
+	   (according to the description of <sys/types.h>
+	   size_t must be declared as an unsigned integer.) */
+	if (*data_length > UINT_MAX) {
+		/* flush message data */
+		flush_n(sh, socket_fd, timeout, *data_length);
+		return -2;
+	}
+
+	/* if data was sent with this message, read it */
+	if (*data_length > 0) {
+		*data = calloc(*data_length, sizeof(char));
+		if (read_n(sh, socket_fd, timeout, *data, *data_length) == -1) {
+			free(*data);
+			*data = NULL;
+			*data_length = 0;
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/* Write a single message to the given socket.
+ *
+ * Returns 0 on success.
+ * Returns -1 for write errors.
+ * Returns -2 if we cannot handle a message of the given size.
+ */
+int write_msg(semanage_handle_t *sh, int socket_fd, uint32_t message_type,
+	      uint64_t data_length, char *data)
+{
+	char msg_header[sizeof(uint32_t) + sizeof(uint64_t)];
+	size_t data_len = 0;
+	size_t amount_to_write = 0;
+	size_t amount_written = 0;
+	int rc = 0;
+
+	/* check whether data_length will fit in a size_t
+	   (according to the description of <sys/types.h>
+	   size_t must be declared as an unsigned integer.) */
+	if (data_length > UINT_MAX) {
+		return -2;
+	}
+	data_len = data_length;
+
+	/* prepare message header */
+	message_type = cpu_to_le32(message_type);
+	memcpy(msg_header, &message_type, sizeof(message_type));
+	data_length = cpu_to_le64(data_length);
+	memcpy(msg_header + sizeof(message_type), &data_length,
+	       sizeof(data_length));
+
+	/* write message header */
+	rc = write(socket_fd, msg_header, sizeof(msg_header));
+	if (rc != sizeof(msg_header))
+		return -1;
+
+	/* write message data */
+	while (data_len > 0) {
+		amount_to_write = (data_len > 1024) ? 1024 : data_len;
+		rc = write(socket_fd, data, amount_to_write);
+		amount_written = (rc > 0) ? rc : 0;
+		if (rc < 0) {
+			if (errno != EAGAIN) {
+				return -1;
+			}
+		} else {
+			data_len -= amount_written;
+			data += amount_written;
+		}
+	}
+	return 0;
+}
+
+/* Reads a response from the server.
+ *
+ * Note that read_server will keep reading responses from the server until
+ * a PS_OK or PS_ERR message is received.  It ignores all other messages.
+ * If a PS_ERR message is received, read_server extracts the error code
+ * and sets data to the error string received from the server.
+ *
+ * data is allocated to hold any data sent by the server, and may be NULL.
+ * data may also be set to an error message on failure.
+ * data_length is set to the size of the data, and may be zero.
+ * Caller is responsible for freeing data if it is not NULL when returned.
+ *
+ * Returns 0 if server said okay, otherwise returns the positive error number.
+ * Returns -1 for generic errors, or if the server gave no error number.
+ * Returns -2 if we cannot handle a message of the size received.
+ *
+ */
+int read_server(semanage_handle_t *sh, int socket_fd, uint32_t * message_type,
+		uint64_t * data_length, char **data)
+{
+	int err = 0;
+	uint32_t server_error = 0;
+
+	/* read message */
+	err =
+	    read_msg(sh, socket_fd, SEMANAGE_PS_DEFAULT_TIMEOUT, message_type,
+		     data_length, data);
+	if (err)
+		return err;
+
+	/* interpret message type */
+	if (*message_type == PS_OK) {
+		return 0;
+	}
+	if (*message_type == PS_ERR) {
+		/* an error message has data of the form:
+		 *     uint32_t error_code
+		 *     char *   error_string */
+		memcpy(&server_error, *data, sizeof(server_error));
+		server_error = le32_to_cpu(server_error);
+		memmove(*data, *data + sizeof(server_error),
+			*data_length - sizeof(server_error));
+		return server_error > 0 ? (int)server_error : -1;
+	}
+
+	/* we didn't get a PS_OK or a PS_ERR; try again */
+	*message_type = 0;
+	free(*data);
+	*data = NULL;
+	*data_length = 0;
+	return read_server(sh, socket_fd, message_type, data_length, data);
+}
Index: selinux-pms-support/libsemanage/src/messages_internal.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/messages_internal.h
@@ -0,0 +1,39 @@
+/* Author:  Caleb Case                  <ccase@tresys.com>
+ *          Christopher Ashworth        <cashworth@tresys.com>
+ *
+ * Copyright (C) 2004-2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ *  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_MESSAGES_INTERNAL_H_
+#define _SEMANAGE_MESSAGES_INTERNAL_H_
+
+#include <sys/types.h>
+
+#include <semanage/messages.h>
+
+int read_n(semanage_handle_t *sh, int socket_fd, int timeout, char *buf, size_t n);
+int flush_n(semanage_handle_t *sh, int socket_fd, int timeout, uint64_t n);
+int read_msg(semanage_handle_t *sh, int socket_fd, int timeout, uint32_t * message_type,
+	     uint64_t * data_length, char **data);
+int write_msg(semanage_handle_t *sh, int socket_fd, uint32_t message_type,
+	      uint64_t data_length, char *data);
+int read_server(semanage_handle_t *sh, int socket_fd, uint32_t * message_type,
+		uint64_t * data_length, char **data);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
