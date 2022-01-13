Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B976C433F5
	for <selinux@archiver.kernel.org>; Thu, 13 Jan 2022 14:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiAMOjw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jan 2022 09:39:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235679AbiAMOjv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jan 2022 09:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642084790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBlCWs2C7lpFrfIAgPR5unql6DEKerw+1S9Rd03H88s=;
        b=dVYneIvhT5CzeZcQ+1S03y12502RyCCzjP67Dl1Frsn9rkIzbqPgDftQCqvC6ZkB1NZ/lr
        UNpzEaqJDNdQ/i3+h/UdR2a0qhsHbnLElPv5g9ZHuYyZEg5TsTwB22JVxA5wMmyv7Mw61G
        +R3ue8p+GrozjB12O+ZqLr41MFRYYS4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-cZSzyoU2Op2JlcMdZ-wCAw-1; Thu, 13 Jan 2022 09:39:49 -0500
X-MC-Unique: cZSzyoU2Op2JlcMdZ-wCAw-1
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso5515500edd.14
        for <selinux@vger.kernel.org>; Thu, 13 Jan 2022 06:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBlCWs2C7lpFrfIAgPR5unql6DEKerw+1S9Rd03H88s=;
        b=D0yePiFWbReP0hBzL5KRf3jXUwhI1LLGXlXSDKLE7Kj/vWbyenWXxq5w31UNY2G0Tk
         Ua/O9nCqhZl9uB0iNqIIsGe6Kb/O5PqrawCDbbVLn/5ZcbUOiwq5uiu6ItTnnrxoE/1e
         g84v5riZHvTdybUV+/SMgfvtUUYM61idcjj/nA8voqPpt9hPv3xMMfgkZaTWLJAzFRrC
         nG2zVfQWIhdQBmpdCpR7SqbgwRfk4OBVXns7vVF8ZvrpvesxQdnu88XKscxIUZ9OtKcV
         xunTFe7EJrtQxmXMM19DmIgurM31iRKQmlksCUXQPzwE+uQ+NuG2xVjtMy/dXuGkekOo
         0XwQ==
X-Gm-Message-State: AOAM532k9kQap7pO1zPLu5v70tUbwlFUwUUy2L+gONoxTkzE6/76OJZV
        7ay6Wn7gknVJjYfZNfu4eqY4htdQqWtyZ67o4sf5BYucG+aLB4TIwNiJv4S9KWSScbjIeYXINzu
        GtdBV6MRxPTDuPw9+SOnF0ljbLMHs52CUDfxpmIyAJSnNLjf6ThcJWGfjiWzUJ8RxN7qyAA==
X-Received: by 2002:a05:6402:40cd:: with SMTP id z13mr4399557edb.257.1642084787306;
        Thu, 13 Jan 2022 06:39:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw50EePrBIf9HfNfMYKEEI1syl676jg4nQLQKfzEf3QOjHeTJp0bgtVXNtH2MNjOotnQwdc2w==
X-Received: by 2002:a05:6402:40cd:: with SMTP id z13mr4399502edb.257.1642084786521;
        Thu, 13 Jan 2022 06:39:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:d5c1:b1da:9874:b302])
        by smtp.gmail.com with ESMTPSA id sc7sm964242ejc.87.2022.01.13.06.39.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 06:39:46 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 3/5] libsemanage: move compressed file handling into a separate object
Date:   Thu, 13 Jan 2022 15:39:33 +0100
Message-Id: <20220113143935.195125-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113143935.195125-1-omosnace@redhat.com>
References: <20220113143935.195125-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In order to reduce exisiting and future code duplication and to avoid
some unnecessary allocations and copying, factor the compressed file
utility functions out into a separate C/header file and refactor their
interface.

Note that this change effectively removes the __fsetlocking(3) call from
semanage_load_files() - I haven't been able to figure out what purpose
it serves, but it seems pointless...

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/src/compressed_file.c | 224 +++++++++++++++++++++++++
 libsemanage/src/compressed_file.h |  78 +++++++++
 libsemanage/src/direct_api.c      | 263 +++++-------------------------
 libsemanage/src/direct_api.h      |   4 -
 libsemanage/src/semanage_store.c  |  52 ++----
 5 files changed, 354 insertions(+), 267 deletions(-)
 create mode 100644 libsemanage/src/compressed_file.c
 create mode 100644 libsemanage/src/compressed_file.h

diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
new file mode 100644
index 00000000..5546b830
--- /dev/null
+++ b/libsemanage/src/compressed_file.c
@@ -0,0 +1,224 @@
+/* Author: Jason Tang	  <jtang@tresys.com>
+ *         Christopher Ashworth <cashworth@tresys.com>
+ *         Ondrej Mosnacek <omosnacek@gmail.com>
+ *
+ * Copyright (C) 2004-2006 Tresys Technology, LLC
+ * Copyright (C) 2005-2021 Red Hat, Inc.
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
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+
+#include <unistd.h>
+#include <fcntl.h>
+
+#include <bzlib.h>
+
+#include "compressed_file.h"
+
+#include "debug.h"
+
+#define BZ2_MAGICSTR "BZh"
+#define BZ2_MAGICLEN (sizeof(BZ2_MAGICSTR)-1)
+
+/* bzip() a data to a file, returning the total number of compressed bytes
+ * in the file.  Returns -1 if file could not be compressed. */
+static int bzip(semanage_handle_t *sh, const char *filename, void *data,
+		size_t num_bytes)
+{
+	BZFILE* b;
+	size_t  size = 1<<16;
+	int     bzerror;
+	size_t  total = 0;
+	size_t len = 0;
+	FILE *f;
+
+	if ((f = fopen(filename, "wb")) == NULL) {
+		return -1;
+	}
+
+	if (!sh->conf->bzip_blocksize) {
+		if (fwrite(data, 1, num_bytes, f) < num_bytes) {
+			fclose(f);
+			return -1;
+		}
+		fclose(f);
+		return 0;
+	}
+
+	b = BZ2_bzWriteOpen( &bzerror, f, sh->conf->bzip_blocksize, 0, 0);
+	if (bzerror != BZ_OK) {
+		BZ2_bzWriteClose ( &bzerror, b, 1, 0, 0 );
+		fclose(f);
+		return -1;
+	}
+
+	while ( num_bytes > total ) {
+		if (num_bytes - total > size) {
+			len = size;
+		} else {
+			len = num_bytes - total;
+		}
+		BZ2_bzWrite ( &bzerror, b, (uint8_t *)data + total, len );
+		if (bzerror == BZ_IO_ERROR) {
+			BZ2_bzWriteClose ( &bzerror, b, 1, 0, 0 );
+			fclose(f);
+			return -1;
+		}
+		total += len;
+	}
+
+	BZ2_bzWriteClose ( &bzerror, b, 0, 0, 0 );
+	fclose(f);
+	if (bzerror == BZ_IO_ERROR) {
+		return -1;
+	}
+	return 0;
+}
+
+/* bunzip() a file to '*data', returning the total number of uncompressed bytes
+ * in the file.  Returns -1 if file could not be decompressed. */
+static ssize_t bunzip(semanage_handle_t *sh, FILE *f, void **data)
+{
+	BZFILE*  b = NULL;
+	size_t   nBuf;
+	uint8_t* buf = NULL;
+	size_t   size = 1<<18;
+	size_t   bufsize = size;
+	int      bzerror;
+	size_t   total = 0;
+	uint8_t* uncompress = NULL;
+	uint8_t* tmpalloc = NULL;
+	int      ret = -1;
+
+	buf = malloc(bufsize);
+	if (buf == NULL) {
+		ERR(sh, "Failure allocating memory.");
+		goto exit;
+	}
+
+	/* Check if the file is bzipped */
+	bzerror = fread(buf, 1, BZ2_MAGICLEN, f);
+	rewind(f);
+	if ((bzerror != BZ2_MAGICLEN) || memcmp(buf, BZ2_MAGICSTR, BZ2_MAGICLEN)) {
+		goto exit;
+	}
+
+	b = BZ2_bzReadOpen ( &bzerror, f, 0, sh->conf->bzip_small, NULL, 0 );
+	if ( bzerror != BZ_OK ) {
+		ERR(sh, "Failure opening bz2 archive.");
+		goto exit;
+	}
+
+	uncompress = malloc(size);
+	if (uncompress == NULL) {
+		ERR(sh, "Failure allocating memory.");
+		goto exit;
+	}
+
+	while ( bzerror == BZ_OK) {
+		nBuf = BZ2_bzRead ( &bzerror, b, buf, bufsize);
+		if (( bzerror == BZ_OK ) || ( bzerror == BZ_STREAM_END )) {
+			if (total + nBuf > size) {
+				size *= 2;
+				tmpalloc = realloc(uncompress, size);
+				if (tmpalloc == NULL) {
+					ERR(sh, "Failure allocating memory.");
+					goto exit;
+				}
+				uncompress = tmpalloc;
+			}
+			memcpy(&uncompress[total], buf, nBuf);
+			total += nBuf;
+		}
+	}
+	if ( bzerror != BZ_STREAM_END ) {
+		ERR(sh, "Failure reading bz2 archive.");
+		goto exit;
+	}
+
+	ret = total;
+	*data = uncompress;
+
+exit:
+	BZ2_bzReadClose ( &bzerror, b );
+	free(buf);
+	if ( ret < 0 ) {
+		free(uncompress);
+	}
+	return ret;
+}
+
+int map_compressed_file(semanage_handle_t *sh, const char *path,
+			struct file_contents *contents)
+{
+	ssize_t size = -1;
+	void *uncompress;
+	int ret = 0, fd = -1;
+	FILE *file = NULL;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1) {
+		ERR(sh, "Unable to open %s\n", path);
+		return -1;
+	}
+
+	file = fdopen(fd, "r");
+	if (file == NULL) {
+		ERR(sh, "Unable to open %s\n", path);
+		close(fd);
+		return -1;
+	}
+
+	if ((size = bunzip(sh, file, &uncompress)) >= 0) {
+		contents->data = uncompress;
+		contents->len = size;
+		contents->compressed = 1;
+	} else {
+		struct stat sb;
+		if (fstat(fd, &sb) == -1 ||
+		    (uncompress = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0)) ==
+		    MAP_FAILED) {
+			ret = -1;
+		} else {
+			contents->data = uncompress;
+			contents->len = sb.st_size;
+			contents->compressed = 0;
+		}
+	}
+	fclose(file);
+	return ret;
+}
+
+void unmap_compressed_file(struct file_contents *contents)
+{
+	if (!contents->data)
+		return;
+
+	if (contents->compressed) {
+		free(contents->data);
+	} else {
+		munmap(contents->data, contents->len);
+	}
+}
+
+int write_compressed_file(semanage_handle_t *sh, const char *path,
+			  void *data, size_t len)
+{
+	return bzip(sh, path, data, len);
+}
diff --git a/libsemanage/src/compressed_file.h b/libsemanage/src/compressed_file.h
new file mode 100644
index 00000000..96cfb4b6
--- /dev/null
+++ b/libsemanage/src/compressed_file.h
@@ -0,0 +1,78 @@
+/* Author: Jason Tang	  <jtang@tresys.com>
+ *         Christopher Ashworth <cashworth@tresys.com>
+ *         Ondrej Mosnacek <omosnacek@gmail.com>
+ *
+ * Copyright (C) 2004-2006 Tresys Technology, LLC
+ * Copyright (C) 2005-2021 Red Hat, Inc.
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
+#ifndef _SEMANAGE_CIL_FILE_H_
+#define _SEMANAGE_CIL_FILE_H_
+
+#include <sys/mman.h>
+#include <sys/types.h>
+
+#include "handle.h"
+
+struct file_contents {
+	void *data; /** file contents (uncompressed) */
+	size_t len; /** length of contents */
+	int compressed; /** whether file was compressed */
+};
+
+/**
+ * Map/read a possibly-compressed file into memory.
+ *
+ * If the file is bzip compressed map_file will uncompress the file into
+ * @p contents. The caller is responsible for calling
+ * @ref unmap_compressed_file on @p contents on success.
+ *
+ * @param sh        semanage handle
+ * @param path      path to the file
+ * @param contents  pointer to struct file_contents, which will be
+ *   populated with data pointer, size, and an indication whether
+ *   the file was compressed or not
+ *
+ * @return 0 on success, -1 otherwise.
+ */
+int map_compressed_file(semanage_handle_t *sh, const char *path,
+			struct file_contents *contents);
+
+/**
+ * Destroy a previously mapped possibly-compressed file.
+ *
+ * If all fields of @p contents are zero/NULL, the function is
+ * guaranteed to do nothing.
+ *
+ * @param contents  pointer to struct file_contents to destroy
+ */
+void unmap_compressed_file(struct file_contents *contents);
+
+/**
+ * Write bytes into a file, using compression if configured.
+ *
+ * @param sh    semanage handle
+ * @param path  path to the file
+ * @param data  pointer to the data
+ * @param len   length of the data
+ *
+ * @return 0 on success, -1 otherwise.
+ */
+int write_compressed_file(semanage_handle_t *sh, const char *path,
+			  void *data, size_t len);
+
+#endif
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index f0e2300a..7eb6938b 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -50,6 +50,7 @@
 
 #include "debug.h"
 #include "handle.h"
+#include "compressed_file.h"
 #include "modules.h"
 #include "direct_api.h"
 #include "semanage_store.h"
@@ -446,194 +447,6 @@ static int parse_module_headers(semanage_handle_t * sh, char *module_data,
        return 0;
 }
 
-#include <stdlib.h>
-#include <bzlib.h>
-#include <string.h>
-#include <sys/sendfile.h>
-
-/* bzip() a data to a file, returning the total number of compressed bytes
- * in the file.  Returns -1 if file could not be compressed. */
-static ssize_t bzip(semanage_handle_t *sh, const char *filename, char *data,
-			size_t num_bytes)
-{
-	BZFILE* b;
-	size_t  size = 1<<16;
-	int     bzerror;
-	size_t  total = 0;
-	size_t len = 0;
-	FILE *f;
-
-	if ((f = fopen(filename, "wb")) == NULL) {
-		return -1;
-	}
-
-	if (!sh->conf->bzip_blocksize) {
-		if (fwrite(data, 1, num_bytes, f) < num_bytes) {
-			fclose(f);
-			return -1;
-		}
-		fclose(f);
-		return num_bytes;
-	}
-
-	b = BZ2_bzWriteOpen( &bzerror, f, sh->conf->bzip_blocksize, 0, 0);
-	if (bzerror != BZ_OK) {
-		BZ2_bzWriteClose ( &bzerror, b, 1, 0, 0 );
-		return -1;
-	}
-	
-	while ( num_bytes > total ) {
-		if (num_bytes - total > size) {
-			len = size;
-		} else {
-			len = num_bytes - total;
-		}
-		BZ2_bzWrite ( &bzerror, b, &data[total], len );
-		if (bzerror == BZ_IO_ERROR) { 
-			BZ2_bzWriteClose ( &bzerror, b, 1, 0, 0 );
-			return -1;
-		}
-		total += len;
-	}
-
-	BZ2_bzWriteClose ( &bzerror, b, 0, 0, 0 );
-	fclose(f);
-	if (bzerror == BZ_IO_ERROR) {
-		return -1;
-	}
-	return total;
-}
-
-#define BZ2_MAGICSTR "BZh"
-#define BZ2_MAGICLEN (sizeof(BZ2_MAGICSTR)-1)
-
-/* bunzip() a file to '*data', returning the total number of uncompressed bytes
- * in the file.  Returns -1 if file could not be decompressed. */
-ssize_t bunzip(semanage_handle_t *sh, FILE *f, char **data)
-{
-	BZFILE* b = NULL;
-	size_t  nBuf;
-	char*   buf = NULL;
-	size_t  size = 1<<18;
-	size_t  bufsize = size;
-	int     bzerror;
-	size_t  total = 0;
-	char*   uncompress = NULL;
-	char*   tmpalloc = NULL;
-	int     ret = -1;
-
-	buf = malloc(bufsize);
-	if (buf == NULL) {
-		ERR(sh, "Failure allocating memory.");
-		goto exit;
-	}
-
-	/* Check if the file is bzipped */
-	bzerror = fread(buf, 1, BZ2_MAGICLEN, f);
-	rewind(f);
-	if ((bzerror != BZ2_MAGICLEN) || memcmp(buf, BZ2_MAGICSTR, BZ2_MAGICLEN)) {
-		goto exit;
-	}
-
-	b = BZ2_bzReadOpen ( &bzerror, f, 0, sh->conf->bzip_small, NULL, 0 );
-	if ( bzerror != BZ_OK ) {
-		ERR(sh, "Failure opening bz2 archive.");
-		goto exit;
-	}
-
-	uncompress = malloc(size);
-	if (uncompress == NULL) {
-		ERR(sh, "Failure allocating memory.");
-		goto exit;
-	}
-
-	while ( bzerror == BZ_OK) {
-		nBuf = BZ2_bzRead ( &bzerror, b, buf, bufsize);
-		if (( bzerror == BZ_OK ) || ( bzerror == BZ_STREAM_END )) {
-			if (total + nBuf > size) {
-				size *= 2;
-				tmpalloc = realloc(uncompress, size);
-				if (tmpalloc == NULL) {
-					ERR(sh, "Failure allocating memory.");
-					goto exit;
-				}
-				uncompress = tmpalloc;
-			}
-			memcpy(&uncompress[total], buf, nBuf);
-			total += nBuf;
-		}
-	}
-	if ( bzerror != BZ_STREAM_END ) {
-		ERR(sh, "Failure reading bz2 archive.");
-		goto exit;
-	}
-
-	ret = total;
-	*data = uncompress;
-
-exit:
-	BZ2_bzReadClose ( &bzerror, b );
-	free(buf);
-	if ( ret < 0 ) {
-		free(uncompress);
-	}
-	return ret;
-}
-
-/* mmap() a file to '*data',
- *  If the file is bzip compressed map_file will uncompress 
- * the file into '*data'.
- * Returns the total number of bytes in memory .
- * Returns -1 if file could not be opened or mapped. */
-static ssize_t map_file(semanage_handle_t *sh, const char *path, char **data,
-			int *compressed)
-{
-	ssize_t size = -1;
-	char *uncompress;
-	int fd = -1;
-	FILE *file = NULL;
-
-	fd = open(path, O_RDONLY);
-	if (fd == -1) {
-		ERR(sh, "Unable to open %s\n", path);
-		return -1;
-	}
-
-	file = fdopen(fd, "r");
-	if (file == NULL) {
-		ERR(sh, "Unable to open %s\n", path);
-		close(fd);
-		return -1;
-	}
-
-	if ((size = bunzip(sh, file, &uncompress)) > 0) {
-		*data = mmap(0, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
-		if (*data == MAP_FAILED) {
-			free(uncompress);
-			fclose(file);
-			return -1;
-		} else {
-			memcpy(*data, uncompress, size);
-		}
-		free(uncompress);
-		*compressed = 1;
-	} else {
-		struct stat sb;
-		if (fstat(fd, &sb) == -1 ||
-		    (*data = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0)) ==
-		    MAP_FAILED) {
-			size = -1;
-		} else {
-			size = sb.st_size;
-		}
-		*compressed = 0;
-	} 
-
-	fclose(file);
-
-	return size;
-}
-
 /* Writes a block of data to a file.  Returns 0 on success, -1 on
  * error. */
 static int write_file(semanage_handle_t * sh,
@@ -1045,15 +858,12 @@ static int semanage_compile_module(semanage_handle_t *sh,
 	char *compiler_path = NULL;
 	char *cil_data = NULL;
 	char *err_data = NULL;
-	char *hll_data = NULL;
 	char *start = NULL;
 	char *end = NULL;
-	ssize_t hll_data_len = 0;
-	ssize_t bzip_status;
 	int status = 0;
-	int compressed;
 	size_t cil_data_len = 0;
 	size_t err_data_len = 0;
+	struct file_contents hll_contents = {};
 
 	if (!strcasecmp(modinfo->lang_ext, "cil")) {
 		goto cleanup;
@@ -1084,13 +894,15 @@ static int semanage_compile_module(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	if ((hll_data_len = map_file(sh, hll_path, &hll_data, &compressed)) <= 0) {
+	status = map_compressed_file(sh, hll_path, &hll_contents);
+	if (status < 0) {
 		ERR(sh, "Unable to read file %s\n", hll_path);
-		status = -1;
 		goto cleanup;
 	}
 
-	status = semanage_pipe_data(sh, compiler_path, hll_data, (size_t)hll_data_len, &cil_data, &cil_data_len, &err_data, &err_data_len);
+	status = semanage_pipe_data(sh, compiler_path, hll_contents.data,
+				    hll_contents.len, &cil_data, &cil_data_len,
+				    &err_data, &err_data_len);
 	if (err_data_len > 0) {
 		for (start = end = err_data; end < err_data + err_data_len; end++) {
 			if (*end == '\n') {
@@ -1110,10 +922,9 @@ static int semanage_compile_module(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	bzip_status = bzip(sh, cil_path, cil_data, cil_data_len);
-	if (bzip_status == -1) {
-		ERR(sh, "Failed to bzip %s\n", cil_path);
-		status = -1;
+	status = write_compressed_file(sh, cil_path, cil_data, cil_data_len);
+	if (status == -1) {
+		ERR(sh, "Failed to write %s\n", cil_path);
 		goto cleanup;
 	}
 
@@ -1131,9 +942,7 @@ static int semanage_compile_module(semanage_handle_t *sh,
 	}
 
 cleanup:
-	if (hll_data_len > 0) {
-		munmap(hll_data, hll_data_len);
-	}
+	unmap_compressed_file(&hll_contents);
 	free(cil_data);
 	free(err_data);
 	free(compiler_path);
@@ -1756,19 +1565,17 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 {
 
 	int retval = -1;
-	char *data = NULL;
-	ssize_t data_len = 0;
-	int compressed = 0;
 	char *path = NULL;
 	char *filename;
 	char *lang_ext = NULL;
 	char *module_name = NULL;
 	char *separator;
 	char *version = NULL;
+	struct file_contents contents = {};
 
-	if ((data_len = map_file(sh, install_filename, &data, &compressed)) <= 0) {
+	retval = map_compressed_file(sh, install_filename, &contents);
+	if (retval < 0) {
 		ERR(sh, "Unable to read file %s\n", install_filename);
-		retval = -1;
 		goto cleanup;
 	}
 
@@ -1781,7 +1588,7 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 
 	filename = basename(path);
 
-	if (compressed) {
+	if (contents.compressed) {
 		separator = strrchr(filename, '.');
 		if (separator == NULL) {
 			ERR(sh, "Compressed module does not have a valid extension.");
@@ -1805,7 +1612,8 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 	}
 
 	if (strcmp(lang_ext, "pp") == 0) {
-		retval = parse_module_headers(sh, data, data_len, &module_name, &version);
+		retval = parse_module_headers(sh, contents.data, contents.len,
+					      &module_name, &version);
 		free(version);
 		if (retval != 0)
 			goto cleanup;
@@ -1822,10 +1630,11 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 		fprintf(stderr, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", install_filename, module_name, filename);
 	}
 
-	retval = semanage_direct_install(sh, data, data_len, module_name, lang_ext);
+	retval = semanage_direct_install(sh, contents.data, contents.len,
+					 module_name, lang_ext);
 
 cleanup:
-	if (data_len > 0) munmap(data, data_len);
+	unmap_compressed_file(&contents);
 	free(module_name);
 	free(path);
 
@@ -1844,10 +1653,8 @@ static int semanage_direct_extract(semanage_handle_t * sh,
 	enum semanage_module_path_type file_type;
 	int rc = -1;
 	semanage_module_info_t *_modinfo = NULL;
-	ssize_t _data_len;
-	char *_data;
-	int compressed;
 	struct stat sb;
+	struct file_contents contents = {};
 
 	/* get path of module */
 	rc = semanage_module_get_path(
@@ -1903,19 +1710,33 @@ static int semanage_direct_extract(semanage_handle_t * sh,
 		}
 	}
 
-	_data_len = map_file(sh, input_file, &_data, &compressed);
-	if (_data_len <= 0) {
+	rc = map_compressed_file(sh, input_file, &contents);
+	if (rc < 0) {
 		ERR(sh, "Error mapping file: %s", input_file);
-		rc = -1;
 		goto cleanup;
 	}
 
+	/* The API promises an mmap'ed pointer */
+	if (contents.compressed) {
+		*mapped_data = mmap(NULL, contents.len, PROT_READ|PROT_WRITE,
+				    MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+		if (*mapped_data == MAP_FAILED) {
+			ERR(sh, "Unable to map memory");
+			rc = -1;
+			goto cleanup;
+		}
+		memcpy(*mapped_data, contents.data, contents.len);
+		free(contents.data);
+	} else {
+		*mapped_data = contents.data;
+	}
+
 	*modinfo = _modinfo;
-	*data_len = (size_t)_data_len;
-	*mapped_data = _data;
+	*data_len = contents.len;
 
 cleanup:
 	if (rc != 0) {
+		unmap_compressed_file(&contents);
 		semanage_module_info_destroy(sh, _modinfo);
 		free(_modinfo);
 	}
@@ -2869,8 +2690,8 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	ret = bzip(sh, path, data, data_len);
-	if (ret <= 0) {
+	ret = write_compressed_file(sh, path, data, data_len);
+	if (ret < 0) {
 		ERR(sh, "Error while writing to %s.", path);
 		status = -3;
 		goto cleanup;
diff --git a/libsemanage/src/direct_api.h b/libsemanage/src/direct_api.h
index e56107b2..ffd428eb 100644
--- a/libsemanage/src/direct_api.h
+++ b/libsemanage/src/direct_api.h
@@ -39,8 +39,4 @@ int semanage_direct_access_check(struct semanage_handle *sh);
 
 int semanage_direct_mls_enabled(struct semanage_handle *sh);
 
-#include <stdio.h>
-#include <unistd.h>
-ssize_t bunzip(struct semanage_handle *sh, FILE *f, char **data);
-
 #endif
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index c6a736fe..633ee731 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -59,6 +59,7 @@ typedef struct dbase_policydb dbase_t;
 
 #include "debug.h"
 #include "utilities.h"
+#include "compressed_file.h"
 
 #define SEMANAGE_CONF_FILE "semanage.conf"
 /* relative path names to enum semanage_paths to special files and
@@ -2054,60 +2055,27 @@ int semanage_direct_get_serial(semanage_handle_t * sh)
 
 int semanage_load_files(semanage_handle_t * sh, cil_db_t *cildb, char **filenames, int numfiles)
 {
-	int retval = 0;
-	FILE *fp;
-	ssize_t size;
-	char *data = NULL;
+	int i, retval = 0;
 	char *filename;
-	int i;
+	struct file_contents contents = {};
 
 	for (i = 0; i < numfiles; i++) {
 		filename = filenames[i];
 
-		if ((fp = fopen(filename, "rb")) == NULL) {
-			ERR(sh, "Could not open module file %s for reading.", filename);
-			goto cleanup;
-		}
-
-		if ((size = bunzip(sh, fp, &data)) <= 0) {
-			rewind(fp);
-			__fsetlocking(fp, FSETLOCKING_BYCALLER);
-
-			if (fseek(fp, 0, SEEK_END) != 0) {
-				ERR(sh, "Failed to determine size of file %s.", filename);
-				goto cleanup;
-			}
-			size = ftell(fp);
-			rewind(fp);
-
-			data = malloc(size);
-			if (fread(data, size, 1, fp) != 1) {
-				ERR(sh, "Failed to read file %s.", filename);
-				goto cleanup;
-			}
-		}
+		retval = map_compressed_file(sh, filename, &contents);
+		if (retval < 0)
+			return -1;
 
-		fclose(fp);
-		fp = NULL;
+		retval = cil_add_file(cildb, filename, contents.data, contents.len);
+		unmap_compressed_file(&contents);
 
-		retval = cil_add_file(cildb, filename, data, size);
 		if (retval != SEPOL_OK) {
 			ERR(sh, "Error while reading from file %s.", filename);
-			goto cleanup;
+			return -1;
 		}
-	
-		free(data);
-		data = NULL;
 	}
 
-	return retval;
-
-      cleanup:
-	if (fp != NULL) {
-		fclose(fp);
-	}
-	free(data);
-	return -1;
+	return 0;
 }
 
 /* 
-- 
2.34.1

