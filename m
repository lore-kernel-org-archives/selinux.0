Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7OFM1GU021091
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 11:22:01 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7OFNBsa007623
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 15:23:12 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7OFLxOR005454
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 11:21:59 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7OFLw5I006308
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 11:21:59 -0400
Message-ID: <4A92B016.1080804@redhat.com>
Date: Mon, 24 Aug 2009 11:21:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: This is a patch to both libsemanage and policycoreutils to change
 the behaviour of --upgrade
Content-Type: multipart/mixed;
 boundary="------------020909060102020802070205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020909060102020802070205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Currently -u will fail if a package does not exists,  This patch will install if a module does not exist

semodule -u ABC.pp XYZ.pp

Currently fails if ABC.pp exists and XYZ.pp does not

After this patch. it will succeed, if the version of ABC.pp is newer the XYZ.pp

Copying the behaviour of rpm.

Do you want these as two separate patches (libsemanage and policycoreutils) or just as the git diff?

--------------020909060102020802070205
Content-Type: text/plain;
 name="semodule-upgrade.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="semodule-upgrade.patch"

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index d563841..e5ca59b 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1087,7 +1087,7 @@ static int get_direct_upgrade_filename(semanage_handle_t * sh,
 	if (semanage_direct_list(sh, &modinfo, &num_modules) < 0) {
 		goto cleanup;
 	}
-	retval = -4;
+	retval = -5;
 	for (i = 0; i < num_modules; i++) {
 		semanage_module_info_t *m =
 		    semanage_module_list_nth(modinfo, i);
@@ -1104,10 +1104,6 @@ static int get_direct_upgrade_filename(semanage_handle_t * sh,
 			}
 		}
 	}
-	if (retval == -4) {
-		ERR(sh, "There does not already exist a module named %s.",
-		    module_name);
-	}
       cleanup:
 	free(version);
 	free(module_name);
@@ -1130,8 +1126,8 @@ static int get_direct_upgrade_filename(semanage_handle_t * sh,
  * module is an older version then the one in 'data'.  Returns 0 on
  * success, -1 if out of memory, -2 if the data does not represent a
  * valid module file, -3 if error while writing file or reading
- * modules directory, -4 if there does not exist an older module or if
- * the previous module is same or newer than 'data'.
+ * modules directory, -4 if the previous module is same or newer than 'data', 
+ * -5 if there does not exist an older module.
  */
 static int semanage_direct_upgrade(semanage_handle_t * sh,
 				   char *data, size_t data_len)
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index d5975c8..d99ee5b 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -87,7 +87,11 @@ int semanage_module_upgrade(semanage_handle_t * sh,
 		}
 	}
 	sh->modules_modified = 1;
-	return sh->funcs->upgrade(sh, module_data, data_len);
+	int rc = sh->funcs->upgrade(sh, module_data, data_len);
+	if (rc == -5) /* module did not exist */
+		rc = sh->funcs->install(sh, module_data, data_len);
+	return rc;
+	
 }
 
 int semanage_module_upgrade_file(semanage_handle_t * sh,
@@ -106,7 +110,10 @@ int semanage_module_upgrade_file(semanage_handle_t * sh,
 		}
 	}
 	sh->modules_modified = 1;
-	return sh->funcs->upgrade_file(sh, module_name);
+	int rc = sh->funcs->upgrade_file(sh, module_name);
+	if (rc == -5) /* module did not exist */
+		rc = sh->funcs->install_file(sh, module_name);
+	return rc;
 }
 
 int semanage_module_install_base(semanage_handle_t * sh,
diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 4d3d288..1c1d206 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -30,7 +30,7 @@ Temporarily remove dontaudits from policy.  Reverts whenever policy is rebuilt
 install/replace a module package
 .TP
 .B  \-u,\-\-upgrade=MODULE_PKG
-upgrade an existing module package
+upgrade an existing module package, or install if the module does not exist
 .TP
 .B  \-b,\-\-base=MODULE_PKG   
 install/replace base module package
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index f74a04a..ad6adca 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -104,7 +104,7 @@ static void usage(char *progname)
 	printf("  -R, --reload		    reload policy\n");
 	printf("  -B, --build		    build and reload policy\n");
 	printf("  -i,--install=MODULE_PKG   install a new module\n");
-	printf("  -u,--upgrade=MODULE_PKG   upgrade existing module\n");
+	printf("  -u,--upgrade=MODULE_PKG   upgrades or install module to a newer version\n");
 	printf("  -b,--base=MODULE_PKG      install new base module\n");
 	printf("  -r,--remove=MODULE_NAME   remove existing module\n");
 	printf

--------------020909060102020802070205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
