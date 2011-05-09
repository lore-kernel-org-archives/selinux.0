Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p49Jp7gB005658
	for <selinux@tycho.nsa.gov>; Mon, 9 May 2011 15:51:07 -0400
Received: from fepna04-svc.tim.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p49Jp5OZ023708
	for <selinux@tycho.nsa.gov>; Mon, 9 May 2011 19:51:06 GMT
Subject: [PATCH v2] policycoreutils: alternative configuration file support
 for sestatus
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Lawrence <slawrence@tresys.com>
Date: Mon, 09 May 2011 21:50:57 +0200
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1304970662.2521.54.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

RESUBMISSION (originally submitted on Sat, 19 Mar 2011 18:36:27 +0100)

Hello !

I have created a tiny patch so that sestatus would be able to accept
alternative configuration files. The patch also tries to improve the
manual page and adds an option for displaying the usage of the tool.

Christopher: I have created this so that sestatus can check processes
other than init without touching the default configuration file (the
primordial "make check" in refpolicy).

Regards,

Guido

diff -pruN selinux/policycoreutils/sestatus/sestatus.8 selinux-policycoreutils-sestatus-config-files/policycoreutils/sestatus/sestatus.8
--- selinux/policycoreutils/sestatus/sestatus.8	2011-05-09 01:04:17.079842517 +0200
+++ selinux-policycoreutils-sestatus-config-files/policycoreutils/sestatus/sestatus.8	2011-05-09 21:33:20.868842542 +0200
@@ -1,10 +1,10 @@
-.TH "sestatus" "8" "2005111103" "" ""
+.TH "sestatus" "8" "March 2011" "" ""
 .SH "NAME"
 sestatus \- SELinux status tool
 
 .SH "SYNOPSIS"
 .B sestatus
-.I [\-v] [\-b]  
+.I [\-v] [\-b] [\-c] [\-h]
 .P
 This tool is used to get the status of a system running SELinux.
 
@@ -13,7 +13,7 @@ This manual page describes the
 .BR sestatus
 program.
 .br
-This tool is used to get the status of a system running SELinux.  It displays data about whether SELinux is enabled, disabled, the loaded policy and whether it is in enforcing or permissive mode.  It can also be used to display the security context of files and processes listed in the /etc/sestatus.conf file.
+This tool is used to get the status of a system running SELinux.  It displays useful information about whether SELinux is enabled or disabled, about the policy currently loaded and whether the SELinux framework is in enforcing or permissive mode. This tool can also be used to display the security context of files and processes listed in the default \fI/etc/sestatus.conf\fP (or in an alternative) configuration file.
 
 > sestatus
 .br
@@ -29,21 +29,24 @@ Policy version:         16
 .TP 
 
 .B \-v
-.P
- Checks the contexts of a files , and a processes listed in the /etc/sestatus.conf file.  It also checks the context of the target, in cases of
-symlinks.
-
+Checks the contexts of files and processes listed in the \fI/etc/sestatus.conf\fP configuration file. In the case of symbolic links, it also checks the context of the target files.
+.TP
 .B \-b
-.P
-Display the current state of booleans.
-
+Displays the current state of the SELinux policy booleans.
+.TP
+.B \-c
+Determines the file that sestatus uses for configuration. The default is \fI/etc/sestatus.conf\fP.
+.TP
+.B \-h
+Displays usage.
 
 .SH "FILES"
-/etc/sestatus.conf
+\fI/etc/sestatus.conf\fP
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>.
 .br
 The program was written by Chris PeBenito <pebenito@gentoo.org>
 
-
+.SH "SEE ALSO"
+.BR booleans (8)
diff -pruN selinux/policycoreutils/sestatus/sestatus.c selinux-policycoreutils-sestatus-config-files/policycoreutils/sestatus/sestatus.c
--- selinux/policycoreutils/sestatus/sestatus.c	2011-05-09 01:04:17.079842517 +0200
+++ selinux-policycoreutils-sestatus-config-files/policycoreutils/sestatus/sestatus.c	2011-05-09 21:33:20.869842476 +0200
@@ -20,7 +20,7 @@
 
 #define PROC_BASE "/proc"
 #define MAX_CHECK 50
-#define CONF "/etc/sestatus.conf"
+#define DEFAULT_CONF "/etc/sestatus.conf"
 
 /* conf file sections */
 #define PROCS "[process]"
@@ -85,17 +85,17 @@ int pidof(const char *command)
 	return ret;
 }
 
-void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
+void load_checks(char *pc[], int *npc, char *fc[], int *nfc, char *config_file)
 {
 
-	FILE *fp = fopen(CONF, "r");
+	FILE *fp = fopen(config_file, "r");
 	char buf[255], *bufp;
 	int buf_len, section = -1;
 	int proclen = strlen(PROCS);
 	int filelen = strlen(FILES);
 
 	if (fp == NULL) {
-		printf("\nUnable to open %s.\n", CONF);
+		printf("\nUnable to open %s.\n", config_file);
 		return;
 	}
 
@@ -196,8 +196,11 @@ int main(int argc, char **argv)
 	const char *pol_name;
 	char *pol_path;
 
+	/* configuration file */
+	char *config_file = DEFAULT_CONF;
+
 	while (1) {
-		opt = getopt(argc, argv, "vb");
+		opt = getopt(argc, argv, "vbc:h");
 		if (opt == -1)
 			break;
 		switch (opt) {
@@ -207,15 +210,24 @@ int main(int argc, char **argv)
 		case 'b':
 			show_bools = 1;
 			break;
+		case 'c':
+			config_file = optarg;
+			break;
+		case 'h':
 		default:
 			/* invalid option */
 			printf("\nUsage: %s [OPTION]\n\n", basename(argv[0]));
 			printf
 			    ("  -v  Verbose check of process and file contexts.\n");
-			printf("\nWithout options, show SELinux status.\n");
+			printf
+			    ("  -b  Displays the current state of SELinux policy booleans.\n");
+			printf
+			    ("  -c config_file  Uses an alternate configuration file (the default is %s).\n", DEFAULT_CONF);
+			printf("\nWithout options, shows SELinux status.\n");
 			return -1;
 		}
 	}
+
 	printf_tab("SELinux status:");
 	rc = is_selinux_enabled();
 
@@ -341,7 +353,7 @@ int main(int argc, char **argv)
 	if (!verbose)
 		return 0;
 
-	load_checks(pc, &npc, fc, &nfc);
+	load_checks(pc, &npc, fc, &nfc, config_file);
 
 	printf("\nProcess contexts:\n");
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
