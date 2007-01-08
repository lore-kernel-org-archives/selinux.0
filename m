Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l08KYEMo005743
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 15:34:14 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l08KZ2c5029875
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 20:35:02 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l08KZ1lV004918
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 15:35:01 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l08KZ11W003947
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 15:35:01 -0500
Received: from [10.11.15.6] (vpn-15-6.rdu.redhat.com [10.11.15.6])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l08KZ0u2027844
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 15:35:00 -0500
Message-ID: <45A2AADC.1090907@mentalrootkit.com>
Date: Mon, 08 Jan 2007 15:34:36 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [RFC] Support for bzip compressed modules
Content-Type: multipart/mixed;
 boundary="------------060005080109040506080709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060005080109040506080709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There was some discussion about bzip compressing policy modules 
(actually policy packages). The attached patch implements this. The 
patch is not ready for merging - I'm trying to get feedback since there 
was opposition to this approach when proposed. This patch should 
probably wait until after a stable branch is created.

The patch implements this support by changing sepol_policy_file_t to 
support decompressing files or memory areas into a private memory copy. 
This support is optional - dlopen is used so that a hard dependency to 
libbz2 is not introduced. I took the approach of decompressing the 
entire file or memory area because:

* It is very simple
* The current code depends on the ability to seek within policy files - 
this is not really possible within compressed streams using the bzip2 
library.

The downsides are:

* Increased memory usage
* No transparent support for compressed writing with an fd based policy 
file.

I didn't want to add additional set functions - I would have preferred 
to allow sepol_policy_file_set_[mem,fd] to transparently open compressed 
streams with functions to set other behaviors as options stored in 
sepol_policy_file_t structs. This was not possible becuase the current 
set functions do not return errors.

Comments appreciated. Some very crude benchmarking below (note that I am 
using a patched semodule to allow the globbing syntax - patch for that 
to follow). The summary is that there is substantial space savings at 
the expense of some increase in time to complete common actions. An 
acceptable trade-off in my opinion.

Anyone have suggestions for something as simple as time but for max 
memory usage?

Karl

Uncompressed
------------

[root@localhost modules]# time semodule -b 
/usr/share/selinux/strict/base.pp

real    0m15.849s
user    0m14.791s
sys     0m0.930s

[root@localhost nobz-modules]# time semodule -i *.pp

real    0m15.447s
user    0m14.287s
sys     0m0.997s

[root@localhost modules]# time semodule -l

real    0m0.153s
user    0m0.133s
sys     0m0.017s

[root@localhost modules]# du -h
17M     ./active/modules
22M     ./active
22M     .


Compressed
----------

[root@localhost modules]# time semodule -b /root/base.pp.bz2

real    0m16.117s
user    0m14.729s
sys     0m1.022s

[root@localhost modules]# time semodule -i /root/modules/*.bz2

real    0m18.529s
user    0m17.110s
sys     0m1.314s

[root@localhost modules]# time semodule -l

real    0m0.851s
user    0m0.750s
sys     0m0.098s

[root@localhost modules]# du -h
2.0M    ./active/modules
4.9M    ./active
4.9M    .

--------------060005080109040506080709
Content-Type: text/x-patch;
 name="selinux-compressed-modules.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-compressed-modules.patch"

diff -r 67226637bf28 libsemanage/src/direct_api.c
--- a/libsemanage/src/direct_api.c	Mon Jan 08 11:08:13 2007 -0500
+++ b/libsemanage/src/direct_api.c	Mon Jan 08 15:00:13 2007 -0500
@@ -307,7 +307,15 @@ static int parse_module_headers(semanage
 		ERR(sh, "Out of memory!");
 		return -1;
 	}
-	sepol_policy_file_set_mem(pf, module_data, data_len);
+	/* We have to assume that this might be a compressed stream,
+	 * so first try to treat this as a bz2 stream. If that fails
+	 * assume that it is not compressed. The bad part of this is
+	 * that it will use at least twice the memory of the original
+	 * data. */
+	if (sepol_policy_file_set_mem_bz2(pf, module_data, data_len, 1) < 0) {
+		sepol_policy_file_set_mem(pf, module_data, data_len);
+	}
+
 	sepol_policy_file_set_handle(pf, sh->sepolh);
 	if (module_data == NULL ||
 	    data_len == 0 ||
@@ -352,7 +360,13 @@ static int parse_base_headers(semanage_h
 		ERR(sh, "Out of memory!");
 		return -1;
 	}
-	sepol_policy_file_set_mem(pf, module_data, data_len);
+	/* We have to assume that this might be a compressed stream,
+	 * so first try to treat this as a bz2 stream. If that fails
+	 * assume that it is not compressed. The bad part of this is
+	 * that it will use at least twice the memory of the original
+	 * data. */
+	if (sepol_policy_file_set_mem_bz2(pf, module_data, data_len, 1) < 0)
+		sepol_policy_file_set_mem(pf, module_data, data_len);
 	sepol_policy_file_set_handle(pf, sh->sepolh);
 	if (module_data == NULL ||
 	    data_len == 0 ||
@@ -915,16 +929,16 @@ static int semanage_direct_list(semanage
 		goto cleanup;
 	}
 
+	if ((*modinfo = calloc(num_mod_files, sizeof(**modinfo))) == NULL) {
+		ERR(sh, "Out of memory!");
+		goto cleanup;
+	}
+
 	if (sepol_policy_file_create(&pf)) {
 		ERR(sh, "Out of memory!");
 		goto cleanup;
 	}
 	sepol_policy_file_set_handle(pf, sh->sepolh);
-
-	if ((*modinfo = calloc(num_mod_files, sizeof(**modinfo))) == NULL) {
-		ERR(sh, "Out of memory!");
-		goto cleanup;
-	}
 
 	for (i = 0; i < num_mod_files; i++) {
 		FILE *fp;
@@ -936,7 +950,10 @@ static int semanage_direct_list(semanage
 			continue;
 		}
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
-		sepol_policy_file_set_fp(pf, fp);
+		if (sepol_policy_file_set_fp_bz2(pf, fp, 1) < 0) {
+			sepol_policy_file_set_fp(pf, fp);
+		}
+
 		if (sepol_module_package_info(pf, &type, &name, &version)) {
 			fclose(fp);
 			free(name);
diff -r 67226637bf28 libsemanage/src/semanage_store.c
--- a/libsemanage/src/semanage_store.c	Mon Jan 08 11:08:13 2007 -0500
+++ b/libsemanage/src/semanage_store.c	Mon Jan 08 15:00:13 2007 -0500
@@ -1490,7 +1490,13 @@ static int semanage_load_module(semanage
 		goto cleanup;
 	}
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-	sepol_policy_file_set_fp(pf, fp);
+	/* Try to set this as a bzip2 compressed file first. If this
+	 * fails it means that the file is not compressed, so fall back
+	 * to normal reading.
+	 */
+	if (sepol_policy_file_set_fp_bz2(pf, fp, 1) < 0) {
+		sepol_policy_file_set_fp(pf, fp);
+	}
 	sepol_policy_file_set_handle(pf, sh->sepolh);
 	if (sepol_module_package_read(*package, pf, 0) == -1) {
 		ERR(sh, "Error while reading from module file %s.", filename);
diff -r 67226637bf28 libsepol/include/sepol/policydb.h
--- a/libsepol/include/sepol/policydb.h	Mon Jan 08 11:08:13 2007 -0500
+++ b/libsepol/include/sepol/policydb.h	Mon Jan 08 15:00:13 2007 -0500
@@ -29,6 +29,9 @@ extern void sepol_policy_file_set_mem(se
 extern void sepol_policy_file_set_mem(sepol_policy_file_t * pf,
 				      char *data, size_t len);
 
+extern int sepol_policy_file_set_mem_bz2(sepol_policy_file_t * pf, char *data,
+					 size_t len, int check);
+
 /*
  * Get the size of the buffer needed to store a policydb write
  * previously done on this policy file.
@@ -41,6 +44,9 @@ extern int sepol_policy_file_get_len(sep
  * to the FILE.
  */
 extern void sepol_policy_file_set_fp(sepol_policy_file_t * pf, FILE * fp);
+
+extern int sepol_policy_file_set_fp_bz2(sepol_policy_file_t * pf, FILE * fp,
+	                             int check);
 
 /*
  * Associate a handle with a policy file, for use in
diff -r 67226637bf28 libsepol/include/sepol/policydb/policydb.h
--- a/libsepol/include/sepol/policydb/policydb.h	Mon Jan 08 11:08:13 2007 -0500
+++ b/libsepol/include/sepol/policydb/policydb.h	Mon Jan 08 15:00:13 2007 -0500
@@ -562,6 +562,7 @@ typedef struct policy_file {
 
 struct sepol_policy_file {
 	struct policy_file pf;
+	char *orig_data; /* if set, will be freed by sepol_policy_file_free */
 };
 
 extern int policydb_read(policydb_t * p, struct policy_file *fp,
diff -r 67226637bf28 libsepol/src/Makefile
--- a/libsepol/src/Makefile	Mon Jan 08 11:08:13 2007 -0500
+++ b/libsepol/src/Makefile	Mon Jan 08 15:00:13 2007 -0500
@@ -20,7 +20,7 @@ all: $(LIBA) $(LIBSO)
 	ranlib $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -Wl,-soname,$(LIBSO),--version-script=libsepol.map,-z,defs
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -Wl,-soname,$(LIBSO),--version-script=libsepol.map,-z,defs -ldl
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c 
diff -r 67226637bf28 libsepol/src/policydb_public.c
--- a/libsepol/src/policydb_public.c	Mon Jan 08 11:08:13 2007 -0500
+++ b/libsepol/src/policydb_public.c	Mon Jan 08 15:00:13 2007 -0500
@@ -1,9 +1,32 @@
+/*
+ * Author(s): Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
 #include <stdlib.h>
 
 #include "debug.h"
 #include <sepol/policydb/policydb.h>
 #include "policydb_internal.h"
 
+#include <bzlib.h>
+#include <dlfcn.h>
+
 /* Policy file interfaces. */
 
 int sepol_policy_file_create(sepol_policy_file_t ** pf)
@@ -14,10 +37,21 @@ int sepol_policy_file_create(sepol_polic
 	return 0;
 }
 
+static void sepol_policy_file_free_data(sepol_policy_file_t * pf)
+{
+	if (pf && pf->orig_data) {
+		free(pf->orig_data);
+		pf->orig_data = NULL;
+	}
+}
+
 void sepol_policy_file_set_mem(sepol_policy_file_t * spf,
 			       char *data, size_t len)
 {
 	struct policy_file *pf = &spf->pf;
+
+	sepol_policy_file_free_data(spf);
+
 	if (!len) {
 		pf->type = PF_LEN;
 		return;
@@ -32,9 +66,226 @@ void sepol_policy_file_set_fp(sepol_poli
 void sepol_policy_file_set_fp(sepol_policy_file_t * spf, FILE * fp)
 {
 	struct policy_file *pf = &spf->pf;
+
+	sepol_policy_file_free_data(spf);
+
 	pf->type = PF_USE_STDIO;
 	pf->fp = fp;
-	return;
+}
+
+/* BZIP suport */
+
+#define BZ_UNINIT  0
+#define BZ_INIT    1
+#define BZ_ERROR   2
+static int bz_status = 0;
+
+static BZFILE* (*bz2_read_open_fp)(int *berror, FILE * f, int verbosity, int small,
+			    void *unused, int nUnused) = NULL;
+static int (*bz2_read_fp)(int *berror, BZFILE *b, void *buf, int len) = NULL;
+static int (*bz2_decompress)(char *dest, unsigned int *dest_len, char *source,
+			     unsigned int source_len, int small, int verbosity) = NULL;
+
+static int bz2_init(void)
+{
+	void *handle;
+
+	/* Initialize the library */
+	if (bz_status == BZ_ERROR) {
+		return -1;
+	} else if (bz_status == BZ_UNINIT) {
+		handle = dlopen("libbz2.so", RTLD_LAZY | RTLD_LOCAL);
+		if (handle == NULL) {
+			bz_status = BZ_ERROR;
+			return -1;
+		}
+		bz2_read_open_fp = dlsym(handle, "BZ2_bzReadOpen");
+		if (bz2_read_open_fp == NULL) {
+			bz_status = BZ_ERROR;
+			return -1;
+		}
+		bz2_read_fp = dlsym(handle, "BZ2_bzRead");
+		if (bz2_read_fp == NULL) {
+			bz_status = BZ_ERROR;
+			return -1;
+		}
+		bz2_decompress = dlsym(handle, "BZ2_bzBuffToBuffDecompress");
+		if (bz2_decompress == NULL) {
+			bz_status = BZ_ERROR;
+			return -1;
+		}
+		bz_status = BZ_INIT;
+	}
+
+	return 0;
+}
+
+/* read a bzip file into a memory buffer */
+static int bz2_read_file(BZFILE *bzfp, char **buf, int *buf_len)
+{
+	int ret, error, prev_buf_len;
+
+	*buf = NULL;
+	*buf_len = 0;
+	while (1) {
+		prev_buf_len = *buf_len;
+		*buf_len += BUFSIZ;
+		*buf = realloc(*buf, *buf_len);
+		if (*buf == NULL)
+			goto error;
+		ret = bz2_read_fp(&error, bzfp, *buf + prev_buf_len, BUFSIZ);
+		if (error != BZ_OK) {
+			if (error == BZ_STREAM_END) {
+				/* trim the buffer if needed */
+				if (ret != BUFSIZ) {
+					*buf_len -= BUFSIZ - ret;
+					*buf = realloc(*buf, *buf_len);
+					if (*buf == NULL)
+						goto error;
+				}
+				break;
+			} else {
+				goto error;
+			}
+		} else if (ret != BUFSIZ) {
+			goto error;
+		}
+	}
+
+	return 0;
+
+error:
+	free(buf);
+	*buf = NULL;
+	return -1;
+}
+
+/* Determine if the buffer contains the BZ2 magic number. This is based on
+ * /usr/share/file/magic. The buffer must be at least BZ2_MAGIC_LEN long.
+ */ 
+#define BZ2_MAGIC_LEN 3
+static int is_bz2_magic(char *buf)
+{
+	if (strncmp(buf, "BZh", BZ2_MAGIC_LEN) == 0)
+		return 1;
+	else
+		return 0;
+}
+
+static int is_bz2_file(FILE *fp)
+{
+	int ret, ret2;
+	char buf[BZ2_MAGIC_LEN];
+	long pos;
+
+	pos = ftell(fp);
+	
+	ret = fread(buf, sizeof(char), BZ2_MAGIC_LEN, fp);
+	if (ret != BZ2_MAGIC_LEN) {
+		ret = -1;
+		goto out;
+	}
+	
+	ret = is_bz2_magic(buf);
+out:
+	ret2 = fseek(fp, pos, SEEK_SET);
+	if (ret2 < 0)
+		ret = ret2;
+	return ret;
+}
+
+int sepol_policy_file_set_fp_bz2(sepol_policy_file_t * pf, FILE * fp, int check)
+{
+	BZFILE *bzfp;
+	int ret, buf_len;
+	char *buf = NULL;
+
+	if (check) {
+		ret = is_bz2_file(fp);
+		if (ret <= 0) {
+			return -1;
+		}
+	}
+
+	if (bz2_init() != 0) {
+		return -1;
+	}
+	
+	bzfp = bz2_read_open_fp(&ret, fp, 0, 0, NULL, 0);
+	if (bzfp == NULL) {
+		return -1;
+	}
+	
+	if (bz2_read_file(bzfp, &buf, &buf_len) < 0) {
+		goto error;
+	}
+
+	sepol_policy_file_set_mem(pf, buf, buf_len);
+	sepol_policy_file_free_data(pf);
+	pf->orig_data = buf;
+
+	return 0;
+
+error:
+	free(buf);
+	return -1;
+}
+
+int sepol_policy_file_set_mem_bz2(sepol_policy_file_t * pf, char *data, size_t len, int check)
+{
+	int ret;
+	char *dest_data = NULL;
+	unsigned int dest_data_size;
+	unsigned int dest_len;
+
+	if (len < BZ2_MAGIC_LEN)
+		return -1;
+
+	if (check) {
+		ret = is_bz2_magic(data);
+		if (ret < 0)
+			return -1;
+	}
+
+	if (bz2_init() != 0)
+		return -1;
+	
+	/* We are going to decompress the data into a new buffer. The _awesome_ thing
+	 * about this is that the bzip library doesn't resize the destination buffer
+	 * for you or really provide any sort of reasonable interface for handling
+	 * this. The only solution is to try to guess the buffer size and keep
+	 * trying until we finally get the buffer size right. *yay*
+	 */
+	dest_data_size = len;
+	while (1) {
+		dest_data_size = dest_data_size * 2;
+		dest_len = dest_data_size;
+		dest_data = realloc(dest_data, dest_data_size);
+		if (!dest_data)
+			goto error;
+		ret = bz2_decompress(dest_data, &dest_len, data, len, 0, 0);
+
+		if (ret == BZ_OK)
+			break;
+		else if (ret == BZ_OUTBUFF_FULL)
+			continue;
+		else
+			goto error;
+	}
+
+	dest_data = realloc(dest_data, dest_len);
+	if (!dest_data)
+		goto error;
+
+	sepol_policy_file_set_mem(pf, dest_data, dest_len);
+	sepol_policy_file_free_data(pf);
+	pf->orig_data = dest_data;
+
+	return 0;
+
+error:
+	free(dest_data);
+	return -1;
 }
 
 int sepol_policy_file_get_len(sepol_policy_file_t * spf, size_t * len)
@@ -54,6 +305,7 @@ void sepol_policy_file_set_handle(sepol_
 
 void sepol_policy_file_free(sepol_policy_file_t * pf)
 {
+	sepol_policy_file_free_data(pf);
 	free(pf);
 }
 
diff -r 67226637bf28 policycoreutils/semodule_deps/Makefile
--- a/policycoreutils/semodule_deps/Makefile	Mon Jan 08 11:08:13 2007 -0500
+++ b/policycoreutils/semodule_deps/Makefile	Mon Jan 08 15:00:13 2007 -0500
@@ -7,7 +7,7 @@ MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
+LDLIBS = $(LIBDIR)/libsepol.a -ldl
 
 all: semodule_deps
 

--------------060005080109040506080709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
