Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCumNs021826
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:56:50 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCpTcJ006595
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:51:29 GMT
Message-Id: <200509271251.j8RCpWYs026122@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 16/17
Date: Tue, 27 Sep 2005 08:51:31 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003D_01C5C340.A864F8C0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_003D_01C5C340.A864F8C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch updates semodule to the new semanage api and improves the
commandline arguments.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_003D_01C5C340.A864F8C0
Content-Type: application/octet-stream;
	name="policycoreutils_semodule_semodule.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policycoreutils_semodule_semodule.c.diff"

diff -purN -x .svn policycoreutils/semodule/semodule.c =
policycoreutils/semodule/semodule.c=0A=
--- policycoreutils/semodule/semodule.c	2005-09-26 14:02:41.000000000 =
-0400=0A=
+++ policycoreutils/semodule/semodule.c	2005-09-22 15:29:15.000000000 =
-0400=0A=
@@ -10,78 +10,147 @@=0A=
 =0A=
 #include <fcntl.h>=0A=
 #include <getopt.h>=0A=
+#include <signal.h>=0A=
 #include <stdio.h>=0A=
+#include <stdlib.h>=0A=
+#include <string.h>=0A=
 #include <unistd.h>=0A=
 #include <sys/mman.h>=0A=
 #include <sys/stat.h>=0A=
 #include <sys/types.h>=0A=
 =0A=
-#include <semanage/module_store.h>=0A=
-#include <semanage/module_api.h>=0A=
+#include <semanage/semanage.h>=0A=
 =0A=
 enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, REMOVE_M,=0A=
-                    LIST_M, CREATE_MODSTORE_M };=0A=
-=0A=
-static size_t map_file (char *filename, char **data);=0A=
-static char *parse_command_line (int argc, char **argv);=0A=
-static void usage(char *progname);=0A=
-static void set_mode (enum client_modes new_mode, char *argv0);=0A=
+                    LIST_M };=0A=
+/* list of modes in which one ought to commit afterwards */=0A=
+static const int do_commit[] =3D {=0A=
+        0, 1, 1, 1, 1,=0A=
+        0=0A=
+};=0A=
+=0A=
+struct command {=0A=
+        enum client_modes mode;=0A=
+        char *arg;=0A=
+};=0A=
+static struct command *commands =3D NULL;=0A=
+static int num_commands =3D 0;=0A=
 =0A=
 /* options given on command line */=0A=
-static enum client_modes mode;=0A=
-static int verbose;=0A=
+static int quiet;=0A=
+=0A=
+static semanage_handle_t *sh =3D NULL;=0A=
 =0A=
 extern char *optarg;=0A=
 extern int optind;=0A=
 =0A=
+static void cleanup(void) {=0A=
+        while(--num_commands >=3D 0) {=0A=
+                free(commands[num_commands].arg);=0A=
+        }=0A=
+        free(commands);=0A=
+}=0A=
+=0A=
 /* mmap() a file to '*data', returning the total number of bytes in=0A=
  * the file.  Returns 0 if file could not be opened or mapped. */=0A=
-static size_t map_file (char *filename, char **data) {=0A=
+static size_t map_file(char *filename, char **data) {=0A=
         int fd;=0A=
         struct stat sb;=0A=
-        if ((fd =3D open (filename, O_RDONLY)) =3D=3D -1) {=0A=
+        if ((fd =3D open(filename, O_RDONLY)) =3D=3D -1) {=0A=
                 return 0;=0A=
         }=0A=
-        if (fstat (fd, &sb) =3D=3D -1 ||=0A=
-            (*data =3D mmap (NULL, sb.st_size, PROT_READ, MAP_PRIVATE, =
fd, 0)) =3D=3D=0A=
+        if (fstat(fd, &sb) =3D=3D -1 ||=0A=
+            (*data =3D mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, =
fd, 0)) =3D=3D=0A=
 MAP_FAILED) {=0A=
                 sb.st_size =3D 0;=0A=
         }=0A=
-        (void) close (fd);=0A=
+        close(fd);=0A=
         return sb.st_size;=0A=
 }=0A=
 =0A=
+/* Signal handlers. */=0A=
+static void handle_signal(int sig_num) {=0A=
+        if (sig_num =3D=3D SIGINT || sig_num =3D=3D SIGQUIT || sig_num =
=3D=3D SIGTERM) {=0A=
+                /* catch these signals, and then drop them */=0A=
+        }=0A=
+}=0A=
+=0A=
+/* Establish signal handlers for the process. */=0A=
+static void create_signal_handlers(void) {=0A=
+        if (signal(SIGINT, handle_signal) =3D=3D SIG_ERR ||=0A=
+            signal(SIGQUIT, handle_signal) =3D=3D SIG_ERR ||=0A=
+            signal(SIGTERM, handle_signal) =3D=3D SIG_ERR) {=0A=
+                fprintf(stderr, "Could not set up signal handler.\n");=0A=
+                exit(255);=0A=
+        }=0A=
+}=0A=
+=0A=
+static void usage(char *progname)=0A=
+{=0A=
+        printf("usage:  %s [options]... MODE [MODES]...\n", progname);=0A=
+        printf("Manage SELinux policy modules.\n");=0A=
+        printf("MODES:\n");=0A=
+        printf("  -i,--install=3DMODULE_PKG   install a new module\n");=0A=
+        printf("  -u,--upgrade=3DMODULE_PKG   upgrade existing =
module\n");=0A=
+        printf("  -b,--base=3DMODULE_PKG      install new base =
module\n"); =0A=
+        printf("  -r,--remove=3DMODULE        remove existing =
module\n");=0A=
+        printf("  -l,--list-modules         display list of installed =
modules\n");=0A=
+        printf("Other options:\n");=0A=
+        printf("  -h,--help        print this message and quit\n");=0A=
+        printf("  -q,--quiet       be quiet\n");=0A=
+}=0A=
+=0A=
+/* Sets the global mode variable to new_mode, but only if no other=0A=
+ * mode has been given. */=0A=
+static void set_mode(enum client_modes new_mode, char *arg) {=0A=
+        struct command *c;=0A=
+        char *s;=0A=
+        if ((c =3D realloc(commands, sizeof(*c) * (num_commands + 1))) =
=3D=3D NULL) {=0A=
+                fprintf(stderr, "Out of memory!\n");=0A=
+                cleanup();=0A=
+                exit(1);=0A=
+        }=0A=
+        commands =3D c;=0A=
+        commands[num_commands].mode =3D new_mode;=0A=
+        commands[num_commands].arg =3D NULL;        =0A=
+        num_commands++;=0A=
+        if (arg !=3D NULL) {=0A=
+                if ((s =3D strdup(arg)) =3D=3D NULL) {=0A=
+                        fprintf(stderr, "Out of memory!\n");=0A=
+                        cleanup();=0A=
+                        exit(1);=0A=
+                }=0A=
+                commands[num_commands - 1].arg =3D s;=0A=
+        }=0A=
+}=0A=
+=0A=
 /* Parse command line and set global options. */=0A=
-static char *parse_command_line (int argc, char **argv) {=0A=
+static void parse_command_line(int argc, char **argv) {=0A=
         static struct option opts [] =3D {=0A=
                 {"base", required_argument, NULL, 'b'},=0A=
                 {"help", 0, NULL, 'h'},=0A=
                 {"install", required_argument, NULL, 'i'},=0A=
                 {"list-modules", 0, NULL, 'l'},=0A=
-                {"create-module-store", optional_argument, NULL, 'm'},=0A=
+                {"quiet", 0, NULL, 'q'},=0A=
                 {"remove", required_argument, NULL, 'r'},=0A=
                 {"upgrade", required_argument, NULL, 'u'},=0A=
-                {"verbose", 0, NULL, 'v'},=0A=
                 {NULL, 0, NULL, 0}=0A=
         };=0A=
-        char *mode_arg =3D NULL;=0A=
         int i;=0A=
-        mode =3D NO_MODE;=0A=
-        verbose =3D 0;=0A=
-        while ((i =3D getopt_long (argc, argv, "b:hi:lm::r:u:v", opts, =
NULL)) !=3D -1) {=0A=
+        quiet =3D 0;=0A=
+        while ((i =3D getopt_long(argc, argv, "b:hi:lqr:u:", opts, =
NULL)) !=3D -1) {=0A=
                 switch (i) {=0A=
-                case 'b': set_mode (BASE_M, argv [0]); mode_arg =3D =
optarg; break;=0A=
-                case 'h': usage (argv [0]); exit (0);=0A=
-                case 'i': set_mode (INSTALL_M, argv [0]); mode_arg =3D =
optarg; break;=0A=
-                case 'l': set_mode (LIST_M, argv [0]); break;=0A=
-                case 'm': set_mode (CREATE_MODSTORE_M, argv [0]); =
mode_arg =3D optarg; break;=0A=
-                case 'r': set_mode (REMOVE_M, argv [0]); mode_arg =3D =
optarg; break;=0A=
-                case 'u': set_mode (UPGRADE_M, argv [0]); mode_arg =3D =
optarg; break;=0A=
-                case 'v': verbose =3D 1; break;=0A=
+                case 'b': set_mode(BASE_M, optarg); break;=0A=
+                case 'h': usage(argv[0]); exit(0);=0A=
+                case 'i': set_mode(INSTALL_M, optarg); break;=0A=
+                case 'l': set_mode(LIST_M, NULL); break;=0A=
+                case 'q': quiet =3D 1; break;=0A=
+                case 'r': set_mode(REMOVE_M, optarg); break;=0A=
+                case 'u': set_mode(UPGRADE_M,optarg); break;=0A=
                 case '?':=0A=
                 default: {=0A=
-                        usage (argv [0]);=0A=
-                        exit (1);=0A=
+                        usage(argv[0]);=0A=
+                        exit(1);=0A=
                 }=0A=
             }=0A=
         }=0A=
@@ -91,134 +160,135 @@ static char *parse_command_line (int arg=0A=
 			fprintf (stderr, "%s", argv[optind++]);=0A=
 		fprintf(stderr, "\n");=0A=
 		usage (argv [0]);=0A=
+                cleanup();=0A=
 		exit (1);=0A=
 	}=0A=
-        if (mode =3D=3D NO_MODE) {=0A=
-                (void) fprintf (stderr, "At least one mode must be =
specified.\n");=0A=
-                usage (argv [0]);=0A=
-                exit (1);=0A=
+        if (num_commands =3D=3D 0) {=0A=
+                fprintf(stderr, "At least one mode must be =
specified.\n");=0A=
+                usage(argv[0]);=0A=
+                exit(1);=0A=
         }=0A=
-        return mode_arg;=0A=
 }=0A=
     =0A=
-/* Sets the global mode variable to new_mode, but only if no other=0A=
- * mode has been given. */=0A=
-static void set_mode (enum client_modes new_mode, char *argv0) {=0A=
-        if (mode =3D=3D NO_MODE) {=0A=
-                mode =3D new_mode;=0A=
-        }=0A=
-        else {=0A=
-                (void) fprintf (stderr, "Only one mode may be =
specified.\n");=0A=
-                usage (argv0);=0A=
-                exit (1);=0A=
-        }=0A=
-}=0A=
-=0A=
-static void usage(char *progname)=0A=
-{=0A=
-        (void) printf ("usage:  %s [options]... MODE\n", progname);=0A=
-        (void) printf ("Manage SELinux policy modules.\n");=0A=
-        (void) printf ("NORMAL MODES (specify exactly one):\n");=0A=
-        (void) printf ("  -i,--install=3DMODULE_PKG install a new =
module package\n");=0A=
-        (void) printf ("  -u,--upgrade=3DMODULE_PKG upgrade existing =
module package\n");=0A=
-        (void) printf ("  -b,--base=3DMODULE_PKG    install new base =
module package\n"); =0A=
-        (void) printf ("  -r,--remove=3DMODULE      remove existing =
module\n");=0A=
-        (void) printf ("  -l,--list-modules       display list of =
installed modules\n");=0A=
-        (void) printf ("BOOTSTRAPPING MODE:\n");=0A=
-        (void) printf ("  -m[PATH],--create-module-store[=3DPATH]  =
create module store at PATH\n");=0A=
-        (void) printf ("                                   (if no path =
given then use default location)\n");=0A=
-        (void) printf ("Other options:\n");=0A=
-        (void) printf ("  -h,--help        print this message and =
quit\n");=0A=
-        (void) printf ("  -v,--verbose     be verbose\n");=0A=
-}=0A=
-=0A=
-int main (int argc, char *argv[]) {=0A=
+int main(int argc, char *argv[]) {=0A=
+        int i, commit =3D 0;=0A=
         int result;=0A=
-        char *data, *mode_arg =3D parse_command_line (argc, argv);=0A=
-        char error_buf [256] =3D {'\0'};=0A=
-        size_t data_len;=0A=
-=0A=
-        if (mode =3D=3D CREATE_MODSTORE_M) {=0A=
-                if (semod_init_module_store (mode_arg, error_buf, =
sizeof (error_buf)) =3D=3D -1 ||=0A=
-                    semod_create_module_store (1, error_buf, sizeof =
(error_buf)) !=3D 0) {=0A=
-                        (void) fprintf (stderr, "Could not create =
module store at %s: %s\n", mode_arg, error_buf);=0A=
-                        exit (2);=0A=
-                }=0A=
-                if (verbose) {=0A=
-                        (void) printf ("Module store created.\n");=0A=
-                }=0A=
-                exit (0);=0A=
-        }=0A=
-        if ((result =3D semod_init_module_store (NULL, error_buf, =
sizeof (error_buf))) < 0) {=0A=
-		(void) fprintf (stderr, "Module store initialization failed: error =
%d.\n%s\n", result, error_buf);=0A=
-                exit (2);=0A=
-        }=0A=
+        int status =3D EXIT_FAILURE;=0A=
+=0A=
+        create_signal_handlers();=0A=
+        parse_command_line(argc, argv);=0A=
         =0A=
-        if (mode =3D=3D INSTALL_M || mode =3D=3D UPGRADE_M || mode =
=3D=3D BASE_M) {=0A=
-                if ((data_len =3D map_file (mode_arg, &data)) =3D=3D 0) =
{=0A=
-                        (void) fprintf (stderr, "Could not read file =
'%s':\n", mode_arg);=0A=
-                        exit (3);=0A=
-                }=0A=
+        if ((result =3D semanage_connect(&sh)) < 0) {=0A=
+                fprintf(stderr, "Could not connect to policy handler: =
%s", semanage_strerror(sh));=0A=
+                goto cleanup;=0A=
         }=0A=
-        =0A=
-        switch (mode) {=0A=
-        case INSTALL_M: {=0A=
-                if (verbose) {=0A=
-                        (void) printf ("Attempting to install module =
'%s':\n", mode_arg);=0A=
+=0A=
+        for (i =3D 0; i < num_commands; i++) {=0A=
+                enum client_modes mode =3D commands[i].mode;=0A=
+                char *mode_arg =3D commands[i].arg;=0A=
+                char *data;=0A=
+                size_t data_len;=0A=
+                if (mode =3D=3D INSTALL_M || mode =3D=3D UPGRADE_M || =
mode =3D=3D BASE_M) {=0A=
+                        if ((data_len =3D map_file(mode_arg, &data)) =
=3D=3D 0) {=0A=
+                                fprintf(stderr, "Could not read file =
'%s':\n", mode_arg);=0A=
+                                goto cleanup;=0A=
+                        }=0A=
                 }=0A=
-                result =3D semod_install_module (data, data_len, =
error_buf, sizeof (error_buf));=0A=
-                break;=0A=
-        }=0A=
-        case UPGRADE_M: {=0A=
-                if (verbose) {=0A=
-                        (void) printf ("Attempting to upgrade module =
'%s':\n", mode_arg);=0A=
+                switch (mode) {=0A=
+                case INSTALL_M: {=0A=
+                        if (!quiet) {=0A=
+                                printf("Attempting to install module =
'%s':\n", mode_arg);=0A=
+                        }=0A=
+                        result =3D semanage_module_install(sh, data, =
data_len);=0A=
+                        break;=0A=
                 }=0A=
-                result =3D semod_upgrade_module (data, data_len, =
error_buf, sizeof (error_buf));=0A=
-                break;=0A=
-        }=0A=
-        case BASE_M: {=0A=
-                if (verbose) {=0A=
-                        (void) printf ("Attempting to install base =
module '%s':\n", mode_arg);=0A=
+                case UPGRADE_M: {=0A=
+                        if (!quiet) {=0A=
+                                printf("Attempting to upgrade module =
'%s':\n", mode_arg);=0A=
+                        }=0A=
+                        result =3D semanage_module_upgrade(sh, data, =
data_len);=0A=
+                        break;=0A=
                 }=0A=
-                result =3D semod_install_base_module (data, data_len, =
error_buf, sizeof (error_buf));=0A=
-                break;=0A=
-        }=0A=
-        case REMOVE_M: {=0A=
-                if (verbose) {=0A=
-                        (void) printf ("Attempting to remove module =
'%s':\n", mode_arg);=0A=
+                case BASE_M: {=0A=
+                        if (!quiet) {=0A=
+                                printf("Attempting to install base =
module '%s':\n", mode_arg);=0A=
+                        }=0A=
+                        result =3D semanage_module_install_base(sh, =
data, data_len);=0A=
+                        break;=0A=
                 }=0A=
-                result =3D semod_remove_module (mode_arg, error_buf, =
sizeof (error_buf));=0A=
-                break;=0A=
-        }=0A=
-        case LIST_M: {=0A=
-                if (verbose) {=0A=
-                        (void) printf ("Attempting to list active =
modules:\n");=0A=
+                case REMOVE_M: {=0A=
+                        if (!quiet) {=0A=
+                                printf("Attempting to remove module =
'%s':\n", mode_arg);=0A=
+                        }=0A=
+                        result =3D semanage_module_remove(sh, mode_arg);=0A=
+                        break;=0A=
                 }=0A=
-                if ((result =3D semod_list_modules (&data, error_buf, =
sizeof (error_buf))) =3D=3D 0) {=0A=
-                        if (data =3D=3D NULL || *data =3D=3D '\0') {=0A=
-                                (void) printf ("No modules.\n");=0A=
+                case LIST_M: {=0A=
+                        semanage_module_info_t *modinfo;=0A=
+                        int num_modules;=0A=
+                        if (!quiet) {=0A=
+                                printf("Attempting to list active =
modules:\n");=0A=
                         }=0A=
-                        else {=0A=
-                                (void) printf ("%s", data);=0A=
+                        if ((result =3D semanage_module_list(sh, =
&modinfo, &num_modules)) >=3D 0) {=0A=
+                                int j;=0A=
+                                if (num_modules =3D=3D 0) {=0A=
+                                        printf("No modules.\n");=0A=
+                                }=0A=
+                                for (j =3D 0; j < num_modules; j++) {=0A=
+                                        semanage_module_info_t *m =3D =
semanage_module_list_nth(modinfo, j);=0A=
+                                        printf("%s\t%s\n",=0A=
+                                               =
semanage_module_get_name(m),=0A=
+                                               =
semanage_module_get_version(m));=0A=
+                                        =
semanage_module_info_datum_destroy(m);=0A=
+                                }=0A=
+                                free(modinfo);=0A=
                         }=0A=
+                        break;=0A=
+                }=0A=
+                default: {=0A=
+                        fprintf(stderr, "Unknown mode specified.\n");=0A=
+                        goto cleanup;=0A=
+                }=0A=
+                }=0A=
+                commit +=3D do_commit[mode];=0A=
+                if (mode =3D=3D INSTALL_M || mode =3D=3D UPGRADE_M || =
mode =3D=3D BASE_M) {=0A=
+                        munmap(data, data_len);=0A=
+                }=0A=
+                if (result < 0) {=0A=
+                        fprintf(stderr, "Failed: %s\n", =
semanage_strerror(sh));=0A=
+                        goto cleanup;=0A=
+                }=0A=
+                else if (!quiet) {=0A=
+                        printf("Ok: return value of %d.\n", result);=0A=
                 }=0A=
-                free (data);=0A=
-                break;=0A=
-        }=0A=
-        default: {=0A=
-                (void) fprintf (stderr, "Unknown mode specified.\n");=0A=
-                exit (1);=0A=
-        }=0A=
         }=0A=
         =0A=
-        if (mode =3D=3D INSTALL_M || mode =3D=3D UPGRADE_M || mode =
=3D=3D BASE_M) {=0A=
-                (void) munmap (data, data_len);=0A=
+        if (commit) {=0A=
+                if (!quiet) {=0A=
+                        printf("Committing changes:\n");=0A=
+                }=0A=
+                result =3D semanage_commit(sh);=0A=
         }=0A=
         =0A=
-	if (result =3D=3D 0) {=0A=
-		if (verbose)=0A=
-                        (void) printf ("Ok.\n");=0A=
-	} else=0A=
-		(void) printf ("Failed: %d.\n%s\n", result, error_buf);=0A=
-        exit (result);=0A=
+        if (result < 0) {=0A=
+                fprintf(stderr, "Failed: %s\n", semanage_strerror(sh));=0A=
+                goto cleanup;=0A=
+        }=0A=
+        else if (commit && !quiet) {=0A=
+                printf("Ok: transaction number %d.\n", result);=0A=
+        }=0A=
+=0A=
+        if (semanage_disconnect(sh) < 0) {=0A=
+                fprintf(stderr, "Error disconnecting: %s\n", =
semanage_strerror(sh));=0A=
+                goto cleanup;=0A=
+        }=0A=
+        status =3D EXIT_SUCCESS;=0A=
+=0A=
+ cleanup:=0A=
+        if (semanage_disconnect(sh) < 0) {=0A=
+                fprintf(stderr, "Error disconnecting: %s\n", =
semanage_strerror(sh));=0A=
+        }=0A=
+        semanage_handle_destroy(sh);=0A=
+        cleanup();=0A=
+        exit(status);=0A=
 }=0A=

------=_NextPart_000_003D_01C5C340.A864F8C0--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
