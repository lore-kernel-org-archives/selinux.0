Subject: [PATCH 4/4] features/fixes for rawhide and refpolicy
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-QTA9HD+SQs9Hhj3KSCVP"
Date: Mon, 24 Oct 2005 13:05:09 -0400
Message-Id: <1130173509.15661.36.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-QTA9HD+SQs9Hhj3KSCVP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

tool changes:

adds reload, noreload, store options to semodule
fixes invalid free bug in dismod

--=-QTA9HD+SQs9Hhj3KSCVP
Content-Disposition: attachment; filename=4-tools.diff
Content-Type: text/x-patch; name=4-tools.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn policycoreutils/semodule/semodule.c policycoreutils/semodule/semodule.c
--- policycoreutils/semodule/semodule.c	2005-10-20 14:28:24.000000000 -0400
+++ policycoreutils/semodule/semodule.c	2005-10-24 12:30:20.000000000 -0400
@@ -20,14 +20,14 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
-#include <semanage/semanage.h>
+#include <semanage/modules.h>
 
 enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, REMOVE_M,
-                    LIST_M };
+                    LIST_M, RELOAD };
 /* list of modes in which one ought to commit afterwards */
 static const int do_commit[] = {
         0, 1, 1, 1, 1,
-        0
+        0, 0
 };
 
 struct command {
@@ -39,8 +39,11 @@ static int num_commands = 0;
 
 /* options given on command line */
 static int quiet;
+static int reload;
+static int no_reload;
 
 static semanage_handle_t *sh = NULL;
+static char *store;
 
 extern char *optarg;
 extern int optind;
@@ -76,6 +79,22 @@ static void handle_signal(int sig_num) {
         }
 }
 
+static void set_store(char *storename) {
+	/* For now this only supports a store name, later on this 
+	 * should support an address for a remote connection */
+
+	if ((store = strdup(storename)) == NULL) {
+		fprintf(stderr, "Out of memory!\n");
+		goto bad;
+	}	
+
+	return;
+
+bad:
+	cleanup();
+	exit(1);
+}
+
 /* Establish signal handlers for the process. */
 static void create_signal_handlers(void) {
         if (signal(SIGINT, handle_signal) == SIG_ERR ||
@@ -91,12 +110,15 @@ static void usage(char *progname)
         printf("usage:  %s [options]... MODE [MODES]...\n", progname);
         printf("Manage SELinux policy modules.\n");
         printf("MODES:\n");
+	printf("  -R, --reload		    reload policy\n");
         printf("  -i,--install=MODULE_PKG   install a new module\n");
         printf("  -u,--upgrade=MODULE_PKG   upgrade existing module\n");
         printf("  -b,--base=MODULE_PKG      install new base module\n"); 
         printf("  -r,--remove=MODULE_NAME   remove existing module\n");
         printf("  -l,--list-modules         display list of installed modules\n");
         printf("Other options:\n");
+	printf("  -s,--store	   name of the store to operate on\n");
+	printf("  -n,--noreload	   do not reload policy after commit\n");
         printf("  -h,--help        print this message and quit\n");
         printf("  -q,--quiet       be quiet\n");
 }
@@ -128,6 +150,7 @@ static void set_mode(enum client_modes n
 /* Parse command line and set global options. */
 static void parse_command_line(int argc, char **argv) {
         static struct option opts [] = {
+		{"store", required_argument, NULL, 's'},
                 {"base", required_argument, NULL, 'b'},
                 {"help", 0, NULL, 'h'},
                 {"install", required_argument, NULL, 'i'},
@@ -135,11 +158,15 @@ static void parse_command_line(int argc,
                 {"quiet", 0, NULL, 'q'},
                 {"remove", required_argument, NULL, 'r'},
                 {"upgrade", required_argument, NULL, 'u'},
+		{"reload", 0, NULL, 'R'},
+		{"noreload", 0, NULL, 'n'},
                 {NULL, 0, NULL, 0}
         };
         int i;
         quiet = 0;
-        while ((i = getopt_long(argc, argv, "b:hi:lqr:u:", opts, NULL)) != -1) {
+	reload = 0;
+	no_reload = 0;
+        while ((i = getopt_long(argc, argv, "s:b:hi:lqr:u:Rn", opts, NULL)) != -1) {
                 switch (i) {
                 case 'b': set_mode(BASE_M, optarg); break;
                 case 'h': usage(argv[0]); exit(0);
@@ -148,6 +175,9 @@ static void parse_command_line(int argc,
                 case 'q': quiet = 1; break;
                 case 'r': set_mode(REMOVE_M, optarg); break;
                 case 'u': set_mode(UPGRADE_M,optarg); break;
+		case 's': set_store(optarg); break;
+		case 'R': reload = 1; break;
+		case 'n': no_reload = 1; break;
                 case '?':
                 default: {
                         usage(argv[0]);
@@ -164,7 +194,12 @@ static void parse_command_line(int argc,
                 cleanup();
 		exit (1);
 	}
-        if (num_commands == 0) {
+	if (reload && num_commands) {
+		fprintf(stderr, "reload should not be used with other commands\n");
+		usage(argv[0]);
+		exit(1);
+	}
+        if (num_commands == 0 && reload == 0) {
                 fprintf(stderr, "At least one mode must be specified.\n");
                 usage(argv[0]);
                 exit(1);
@@ -184,11 +219,27 @@ int main(int argc, char *argv[]) {
                 fprintf(stderr, "Could not create semanage handle\n");
                 goto cleanup;
 	}
+
+	if (store) {
+		/* Set the store we want to connect to, before connecting.
+		 * this will always set a direct connection now, an additional
+		 * option will need to be used later to specify a policy server 
+		 * location */
+		semanage_select_store(sh, store, SEMANAGE_CON_DIRECT);
+	}
+
         if ((result = semanage_connect(sh)) < 0) {
                 fprintf(stderr, "Could not connect to policy handler\n");
                 goto cleanup;
         }
 
+	if (reload) {
+		if ((result = semanage_reload_policy(sh)) < 0) {
+			fprintf(stderr, "Could not reload policy\n");
+			goto cleanup;
+		}
+	}
+
         for (i = 0; i < num_commands; i++) {
                 enum client_modes mode = commands[i].mode;
                 char *mode_arg = commands[i].arg;
@@ -273,6 +324,9 @@ int main(int argc, char *argv[]) {
                 if (!quiet) {
                         printf("Committing changes:\n");
                 }
+		if (no_reload) {
+			semanage_set_reload(sh, 0);
+		}
                 result = semanage_commit(sh);
         }
         
diff -purN -x .svn checkpolicy/test/dismod.c checkpolicy/test/dismod.c
--- checkpolicy/test/dismod.c	2005-10-18 11:01:40.000000000 -0400
+++ checkpolicy/test/dismod.c	2005-10-24 08:12:26.000000000 -0400
@@ -696,15 +696,15 @@ static int read_policy(char *filename, p
         }
         rewind(in_fp);
         if (le32_to_cpu(buf[0]) == SEPOL_MODULE_PACKAGE_MAGIC) {
-                sepol_module_package_t package;
-		if (sepol_module_package_init(&package)) {
+                sepol_module_package_t *package;
+		if (sepol_module_package_create(&package)) {
 			fprintf(stderr, "%s:  Out of memory!\n", __FUNCTION__);
 			exit(1);
 		}
-                package.policy = (sepol_policydb_t*)policy;
-                package.file_contexts = NULL;
-                retval = sepol_module_package_read(&package, (sepol_policy_file_t*)&f, 1);
-                free(package.file_contexts);
+                package->policy = (sepol_policydb_t*)policy;
+                package->file_contexts = NULL;
+                retval = sepol_module_package_read(package, (sepol_policy_file_t*)&f, 1);
+                free(package->file_contexts);
         }
         else {
 		if (policydb_init(policy)) {
@@ -791,6 +791,7 @@ int main(int argc, char **argv)
 
 	/* read the binary policy */
 	fprintf(out_fp, "Reading policy...\n");
+	policydb_init(&policydb);
         if (read_policy(argv[1], &policydb)) {
 		fprintf(stderr, "%s:  error(s) encountered while loading policy\n", argv[0]);
 		exit(1);

--=-QTA9HD+SQs9Hhj3KSCVP--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
