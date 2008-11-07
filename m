Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA7EfRSi010312
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:41:27 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA7EfQYp016596
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 14:41:26 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EfQng004255
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:41:26 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mA7EfPJP032478
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:41:25 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EfPf9015518
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:41:25 -0500
Message-ID: <49145394.3050806@redhat.com>
Date: Fri, 07 Nov 2008 09:41:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: semodule patch to use new semanage interfaces
Content-Type: multipart/mixed;
 boundary="------------010607060304010406040905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010607060304010406040905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Allows semodule to read bzip compressed policy packages directly.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkUU5QACgkQrlYvE4MpobMHGQCdGwEl3h1ZwV92u1mfgrr3z7XT
NGYAoIwz76N7QFdEr8I0t3ncGhbo6heq
=raBi
-----END PGP SIGNATURE-----

--------------010607060304010406040905
Content-Type: text/plain;
 name="semodule.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semodule.patch"

--- nsapolicycoreutils/semodule/semodule.c	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.57/semodule/semodule.c	2008-10-10 16:04:46.000000000 -0400
@@ -60,24 +60,6 @@
 	free(commands);
 }
 
-/* mmap() a file to '*data', returning the total number of bytes in
- * the file.  Returns 0 if file could not be opened or mapped. */
-static size_t map_file(char *filename, char **data)
-{
-	int fd;
-	struct stat sb;
-	if ((fd = open(filename, O_RDONLY)) == -1) {
-		return 0;
-	}
-	if (fstat(fd, &sb) == -1 ||
-	    (*data = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0)) ==
-	    MAP_FAILED) {
-		sb.st_size = 0;
-	}
-	close(fd);
-	return sb.st_size;
-}
-
 /* Signal handlers. */
 static void handle_signal(int sig_num)
 {
@@ -339,16 +321,6 @@
 	for (i = 0; i < num_commands; i++) {
 		enum client_modes mode = commands[i].mode;
 		char *mode_arg = commands[i].arg;
-		char *data = NULL;
-		size_t data_len = 0;
-		if (mode == INSTALL_M || mode == UPGRADE_M || mode == BASE_M) {
-			if ((data_len = map_file(mode_arg, &data)) == 0) {
-				fprintf(stderr,
-					"%s:  Could not read file '%s': %s\n",
-					argv[0], mode_arg, errno ? strerror(errno) : "");
-				goto cleanup;
-			}
-		}
 		switch (mode) {
 		case INSTALL_M:{
 				if (verbose) {
@@ -357,7 +329,7 @@
 					     mode_arg);
 				}
 				result =
-				    semanage_module_install(sh, data, data_len);
+				    semanage_module_install_file(sh, mode_arg);
 				break;
 			}
 		case UPGRADE_M:{
@@ -367,7 +339,7 @@
 					     mode_arg);
 				}
 				result =
-				    semanage_module_upgrade(sh, data, data_len);
+				    semanage_module_upgrade_file(sh, mode_arg);
 				break;
 			}
 		case BASE_M:{
@@ -377,8 +349,7 @@
 					     mode_arg);
 				}
 				result =
-				    semanage_module_install_base(sh, data,
-								 data_len);
+				    semanage_module_install_base_file(sh, mode_arg);
 				break;
 			}
 		case REMOVE_M:{
@@ -429,9 +400,6 @@
 			}
 		}
 		commit += do_commit[mode];
-		if (mode == INSTALL_M || mode == UPGRADE_M || mode == BASE_M) {
-			munmap(data, data_len);
-		}
 		if (result < 0) {
 			fprintf(stderr, "%s:  Failed on %s!\n", argv[0],
 				mode_arg ? : "list");

--------------010607060304010406040905
Content-Type: application/octet-stream;
 name="semodule.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="semodule.patch.sig"

iEYEABECAAYFAkkUU5QACgkQrlYvE4MpobP2YACfebbp2A1fhGPC6EdXx7jYqsxmJKAAoLbf
VqpfWlwMfX3Ce+OpF0bhdV+8
--------------010607060304010406040905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
