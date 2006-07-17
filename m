Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6HKV5A8029346
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 16:31:05 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6HKV3XC013821
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 20:31:05 GMT
Subject: [PATCH 5/6] netfilter integration: add support to semodule_package
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 16:32:36 -0400
Message-Id: <1153168357.10090.50.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add netfilter_contexts support to semodule_package.

 policycoreutils/semodule_package/semodule_package.c |   28 ++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --exclude .svn -purN trunk/policycoreutils/semodule_package/semodule_package.c netfilter-integration/policycoreutils/semodule_package/semodule_package.c
--- trunk/policycoreutils/semodule_package/semodule_package.c	2006-07-03 10:42:01.031370000 -0400
+++ netfilter-integration/policycoreutils/semodule_package/semodule_package.c	2006-07-14 11:15:36.411653000 -0400
@@ -33,6 +33,7 @@ static void usage(char *prog)
 	printf("  -s --seuser		Seusers file (only valid in base)\n");
 	printf
 	    ("  -u --user_extra	user_extra file (only valid in base)\n");
+	printf("  -n --nc		Netfilter contexts file\n");
 	exit(1);
 }
 
@@ -94,7 +95,8 @@ int main(int argc, char **argv)
 	    NULL, *user_extra = NULL;
 	char *fcdata = NULL, *outfile = NULL, *seusersdata =
 	    NULL, *user_extradata = NULL;
-	size_t fclen = 0, seuserslen = 0, user_extralen = 0;
+	char *netfilter_contexts = NULL, *ncdata = NULL;
+	size_t fclen = 0, seuserslen = 0, user_extralen = 0, nclen = 0;
 	int i;
 
 	static struct option opts[] = {
@@ -102,12 +104,13 @@ int main(int argc, char **argv)
 		{"fc", required_argument, NULL, 'f'},
 		{"seuser", required_argument, NULL, 's'},
 		{"user_extra", required_argument, NULL, 'u'},
+		{"nc", required_argument, NULL, 'n'},
 		{"outfile", required_argument, NULL, 'o'},
 		{"help", 0, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((i = getopt_long(argc, argv, "m:f:s:u:o:h", opts, NULL)) != -1) {
+	while ((i = getopt_long(argc, argv, "m:f:s:u:o:n:h", opts, NULL)) != -1) {
 		switch (i) {
 		case 'h':
 			usage(argv[0]);
@@ -161,6 +164,17 @@ int main(int argc, char **argv)
 			user_extra = strdup(optarg);
 			if (!user_extra)
 				exit(1);
+			break;
+		case 'n':
+			if (netfilter_contexts) {
+				fprintf(stderr,
+					"May not specify more than one netfilter contexts file\n");
+				exit(1);
+			}
+			netfilter_contexts = strdup(optarg);
+			if (!netfilter_contexts)
+				exit(1);
+			break;
 		}
 	}
 
@@ -186,6 +200,11 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
+	if (netfilter_contexts) {
+		if (file_to_data(netfilter_contexts, &ncdata, &nclen))
+			exit(1);
+	}
+
 	if (file_to_policy_file(module, &mod, "r"))
 		exit(1);
 
@@ -211,6 +230,9 @@ int main(int argc, char **argv)
 		sepol_module_package_set_user_extra(pkg, user_extradata,
 						    user_extralen);
 
+	if (nclen)
+		sepol_module_package_set_netfilter_contexts(pkg, ncdata, nclen);
+
 	if (file_to_policy_file(outfile, &out, "w"))
 		exit(1);
 
@@ -223,6 +245,8 @@ int main(int argc, char **argv)
 
 	if (fclen)
 		munmap(fcdata, fclen);
+	if (nclen)
+		munmap(ncdata, nclen);
 	sepol_policy_file_free(mod);
 	sepol_policy_file_free(out);
 	sepol_module_package_free(pkg);


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
