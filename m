Message-ID: <52715E75.5000005@redhat.com>
Date: Wed, 30 Oct 2013 15:31:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Been looking at further shrinkage of the SELinux footprint on Linux.
Content-Type: multipart/mixed;
 boundary="------------010200080301060804080005"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010200080301060804080005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We are trying to shrink out cloud image as small as possible.  One idea was to
shrink SELinux Policy footprint by adding compression to it.

Here is a patch I have been fooling around with which would read a policy.29
file if it was compressed with xz.

xz compression does around a 90% compression on the policy file,  and does not
slow the load in any meaningfull way.

I also have done a patch to try out gzip.

gzip and xz are already used in systemd, which means we would not need to add
a new requirement to the minimal system.

xz seems quicker and smaller then gzip.

Have not started playing with libsemanage yet.

What do you think?  Is xz availabel on Android?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJxXnUACgkQrlYvE4MpobNR9QCgx4AMRM+0TR0mqwvPikvj6mGH
O1UAn0OIwFNTmQ2zIBwtB65IwfqfsEq2
=dBjb
-----END PGP SIGNATURE-----

--------------010200080301060804080005
Content-Type: text/x-patch;
 name="libselinux_lzma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux_lzma.patch"

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 02dd829..6dfdb46 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -114,7 +114,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) -shared -o $@ $^ -lpcre -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(CFLAGS) -shared -o $@ $^ -lpcre -llzma -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index e419f1a..275672d 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -16,6 +16,82 @@
 #include <dlfcn.h>
 #include "policy.h"
 #include <limits.h>
+#include <lzma.h>
+
+static char *lzmaread(int fd, size_t *rsize) {
+	int capacity = 64*1024;
+	char *buf = NULL;
+	int tmpsize = 8 * 1024;
+	unsigned char tmp[tmpsize];
+	unsigned char tmp_out[tmpsize];
+	size_t size = 0;
+	lzma_stream strm = LZMA_STREAM_INIT;
+	lzma_action action = LZMA_RUN;
+	lzma_ret ret;
+	
+	FILE *stream = fdopen (fd, "r");
+	if (!stream) {
+		return NULL;
+	}
+	ret = lzma_stream_decoder(&strm, UINT64_MAX,
+				  LZMA_CONCATENATED);
+	
+	strm.avail_in = 0;
+	strm.next_out = tmp_out;
+	strm.avail_out = tmpsize;
+	
+	buf = (char *) malloc (capacity);
+	if (!buf)
+		goto err;
+	
+	while (1) {
+		if (strm.avail_in == 0) {
+			strm.next_in = tmp;
+			strm.avail_in = fread(tmp, 1, tmpsize, stream);
+			
+			if (ferror(stream)) {
+				// POSIX says that fread() sets errno if
+				// an error occurred. ferror() doesn't
+				// touch errno.
+				goto err;
+			}
+			if (feof(stream)) action = LZMA_FINISH;
+		}
+		
+		ret = lzma_code(&strm, action);
+		
+		// Write and check write error before checking decoder error.
+		// This way as much data as possible gets written to output
+		// even if decoder detected an error.
+		if (strm.avail_out == 0 || ret != LZMA_OK) {
+			const size_t num =  tmpsize - strm.avail_out;
+			if (num > capacity) {
+				buf = (char*) realloc (buf, size*2);
+				capacity = size;
+			}
+			memcpy (buf+size, tmp_out, num);
+			capacity -= num;
+			size += num;
+			strm.next_out = tmp_out;
+			strm.avail_out = tmpsize;
+		}
+		if (ret != LZMA_OK) {
+			if (ret == LZMA_STREAM_END) {
+				break;
+			} else {
+				goto err;
+			}
+		}
+	}
+	*rsize = size;
+	
+	goto exit;
+err:
+	free(buf); buf = NULL;
+exit:
+	lzma_end(&strm);
+	return buf;
+}
 
 int security_load_policy(void *data, size_t len)
 {
@@ -55,7 +131,7 @@ int selinux_mkload_policy(int preservebools)
 	struct stat sb;
 	struct utsname uts;
 	size_t size;
-	void *map, *data;
+	void *map = NULL, *data=NULL;
 	int fd, rc = -1, prot;
 	sepol_policydb_t *policydb;
 	sepol_policy_file_t *pf;
@@ -181,24 +257,28 @@ checkbool:
 		goto dlclose;
 	}
 
-	if (fstat(fd, &sb) < 0) {
-		fprintf(stderr,
-			"SELinux:  Could not stat policy file %s:  %s\n",
-			path, strerror(errno));
-		goto close;
-	}
-
-	prot = PROT_READ;
-	if (setlocaldefs || preservebools)
-		prot |= PROT_WRITE;
+	data = lzmaread(fd,&size);
 
-	size = sb.st_size;
-	data = map = mmap(NULL, size, prot, MAP_PRIVATE, fd, 0);
-	if (map == MAP_FAILED) {
-		fprintf(stderr,
-			"SELinux:  Could not map policy file %s:  %s\n",
+	if (!data) {
+		if (fstat(fd, &sb) < 0) {
+			fprintf(stderr,
+				"SELinux:  Could not stat policy file %s:  %s\n",
 			path, strerror(errno));
-		goto close;
+			goto close;
+		}
+		
+		prot = PROT_READ;
+		if (setlocaldefs || preservebools)
+			prot |= PROT_WRITE;
+		
+		size = sb.st_size;
+		data = map = mmap(NULL, size, prot, MAP_PRIVATE, fd, 0);
+		if (map == MAP_FAILED) {
+			fprintf(stderr,
+				"SELinux:  Could not map policy file %s:  %s\n",
+				path, strerror(errno));
+			goto close;
+		}
 	}
 
 	if (vers > kernvers && usesepol) {
@@ -210,6 +290,8 @@ checkbool:
 			goto unmap;
 		}
 		policy_file_set_mem(pf, data, size);
+		if (!map)
+			free(data);
 		if (policydb_read(policydb, pf)) {
 			policy_file_free(pf);
 			policydb_free(policydb);
@@ -223,7 +305,8 @@ checkbool:
 				path);
 			policy_file_free(pf);
 			policydb_free(policydb);
-			munmap(map, sb.st_size);
+			if (map)
+				munmap(map, sb.st_size);
 			close(fd);
 			vers--;
 			goto search;
@@ -275,7 +358,7 @@ checkbool:
 #endif
 	}
 
-
+	
 	rc = security_load_policy(data, size);
 	
 	if (rc)
@@ -286,7 +369,8 @@ checkbool:
       unmap:
 	if (data != map)
 		free(data);
-	munmap(map, sb.st_size);
+	if (map)
+		munmap(map, sb.st_size);
       close:
 	close(fd);
       dlclose:

--------------010200080301060804080005
Content-Type: text/plain; charset=UTF-8;
 name="compare"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="compare"

Information gathered from Fedora 21/Rawhide.

Current Load_policy

real	0m0.848s
user	0m0.047s
sys	0m0.283s

real	0m0.846s
user	0m0.094s
sys	0m0.625s

real	0m0.850s
user	0m0.114s
sys	0m0.717s

xz Load_policy
real	0m0.885s
user	0m0.084s
sys	0m0.382s

real	0m0.878s
user	0m0.090s
sys	0m0.453s

real	0m0.886s
user	0m0.128s
sys	0m0.572s

du -s *
2584	policy.29
384	policy.29.xz

valgrind shows 
mmap load_policy
total heap usage: 443,521 allocs, 443,519 frees, 34,795,153 bytes allocated
Versus
xz load_policy
total heap usage: 443,509 allocs, 443,507 frees, 18,115,873 bytes allocated

--------------010200080301060804080005--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
