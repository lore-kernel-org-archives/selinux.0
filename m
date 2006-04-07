Subject: [RFC] [PATCH] Extend vixie-cron to allow cron jobs at multiple
	security contexts
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: jvdias@redhat.com, stevegr@master.debian.org, ciaranm@gentoo.org,
        dwalsh@redhat.com, sgrubb@redhat.com, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1144422989.7681.6.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
Date: Fri, 07 Apr 2006 11:16:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch, to Fedora Core 5 version of vixie cron, extends the cron
subsystem to allow a user to submit cron jobs from different
security contexts, and have the cron daemon execute them in the
context from which they were submitted.

Currently, a user's crontab file is stored in the /var/spool/cron
directory as the user's name. With this patch a user can execute
crontab with a new option '-c' to append the current security
context to the crontab file name. The cron daemon, as part of
processing cron jobs, will attempt to set the security context
of the job to the context appended to the user name (if -c was
used with crontab). If the crontab file does not contain a
security context in its name (crontab without -c), the cron daemon
will continue to operate as it does now (use get_default_context_*
to obtain cron job's security context) for that perticular job.

System jobs in {hourly, daily, mothly} directories will continue
to work in the derived domains as specified by the policy.

The cron "allow/deny" logic will honor users with explicit
security context or all contexts for a user. That is, if only
the user name, without an appended security context, is present
in the allow/deny file, the all contexts for that user will be
allowed/denied the use of the cron subsystem. However, if a
username along with a security context is present in the allow/deny
file, then only that user with that perticular security context
will be allowed/denied the use of the cron subsystem.

I haven't made changes to man pages, but will do so once I get
feedback on the patch itself.

Changes since the last version of the patch, posted on redhat-lspp:
	- Ported to FC5
	- Fixed memory leaks
	- Extended allow/deny logic to handle security contexts
	- Changed getcon() to getprevcon() to ensure correct behavior
	  with targeted as well as strict policy

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 crontab.c  |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 database.c |   18 ++++++++++++-
 macros.h   |    4 ++
 misc.c     |   19 +++++++++++++
 security.c |   12 ++++++++
 user.c     |    2 -
 6 files changed, 134 insertions(+), 4 deletions(-)

diff -Naurp vixie-cron-4.1/crontab.c vixie-cron-4.1-patch/crontab.c
--- vixie-cron-4.1/crontab.c	2006-04-05 01:30:42.000000000 +0000
+++ vixie-cron-4.1-patch/crontab.c	2006-04-05 01:45:04.000000000 +0000
@@ -39,6 +39,21 @@ static char rcsid[] = "$Id: crontab.c,v 
 
 #define NHEADER_LINES 0
 
+#ifdef WITH_SELINUX
+
+enum opt_t	{ opt_unknown, opt_list, opt_delete, opt_edit, opt_replace,
+		  opt_context };
+
+#if DEBUGGING
+static char	*Options[] = { "???", "list", "delete", "edit", "replace",
+			       "context" };
+static char	*getoptargs = "u:lericx:";
+#else
+static char	*getoptargs = "u:leric";
+#endif
+
+#else /* !WITH_SELINUX */
+
 enum opt_t	{ opt_unknown, opt_list, opt_delete, opt_edit, opt_replace };
 
 #if DEBUGGING
@@ -48,6 +63,8 @@ static char	*getoptargs = "u:lerix:";
 static char	*getoptargs = "u:leri";
 #endif
 
+#endif /* WITH_SELINUX */
+
 static	PID_T		Pid;
 static	char		User[MAX_UNAME], RealUser[MAX_UNAME];
 static	char		Filename[MAX_FNAME], TempFilename[MAX_FNAME];
@@ -64,6 +81,14 @@ static	void		list_cmd(void),
 			parse_args(int c, char *v[]),
 			die(int);
 static	int		replace_cmd(void);
+#ifdef WITH_SELINUX
+static	int		ctxt_specified = 0;
+#endif
+
+
+#ifdef WITH_SELINUX
+static  security_context_t context=NULL;
+#endif
 
 static void
 usage(const char *msg) {
@@ -71,6 +96,9 @@ usage(const char *msg) {
 	fprintf(stderr, "usage:\t%s [-u user] file\n", ProgramName);
 	fprintf(stderr, "\t%s [-u user] [ -e | -l | -r ]\n", ProgramName);
 	fprintf(stderr, "\t\t(default operation is replace, per 1003.2)\n");
+#ifdef WITH_SELINUX
+        fprintf(stderr, "\t[-c]\t(User security context)\n");
+#endif
 	fprintf(stderr, "\t-e\t(edit user's crontab)\n");
 	fprintf(stderr, "\t-l\t(list user's crontab)\n");
 	fprintf(stderr, "\t-r\t(delete user's crontab)\n");
@@ -133,6 +161,9 @@ main(int argc, char *argv[]) {
 static void
 parse_args(int argc, char *argv[]) {
 	int argch;
+#ifdef WITH_SELINUX
+	static char unam[MAX_UNAME], *cptr;
+#endif
 
 	if (!(pw = getpwuid(getuid()))) {
 		fprintf(stderr, "%s: your UID isn't in the passwd file.\n",
@@ -157,6 +188,31 @@ parse_args(int argc, char *argv[]) {
 				usage("bad debug option");
 			break;
 #endif
+#ifdef WITH_SELINUX
+		case 'c':
+			if (is_selinux_enabled() > 0) {
+				if (getprevcon(&context)) {
+					fprintf(stderr,
+					   "Cannot obtain process context\n");
+					exit(ERROR_EXIT);
+				}
+
+				if ((strlen(pw->pw_name) +
+				     strlen((char *)context)) >= sizeof User) {
+					fprintf(stderr,
+					   "username+context too long\n");
+					exit(ERROR_EXIT);
+				}
+
+				snprintf(User, MAX_UNAME, "%s:%s", pw->pw_name,
+					 context);
+				strcpy(RealUser, User);
+
+				ctxt_specified = 1;
+			}
+			break;
+
+#endif /* WITH_SELINUX */
 		case 'u':
 			if (MY_UID(pw) != ROOT_UID) {
 				fprintf(stderr,
@@ -171,6 +227,22 @@ parse_args(int argc, char *argv[]) {
 			        exit(ERROR_EXIT);
 			}
 
+#ifdef WITH_SELINUX
+			if (strlen(optarg) >= sizeof User)
+				usage("username too long");
+			(void) strcpy(User, optarg);
+			(void) strcpy(unam, optarg);
+			if ((cptr = strchr(unam, ':')) != NULL)
+                                *cptr = '\0';
+
+			if (!(pw = getpwnam(unam))) {
+				fprintf(stderr, "%s:  user `%s' unknown\n",
+					ProgramName, unam);
+				exit(ERROR_EXIT);
+			}
+
+#else /* !WITH_SELINUX */
+
 			if (!(pw = getpwnam(optarg))) {
 				fprintf(stderr, "%s:  user `%s' unknown\n",
 					ProgramName, optarg);
@@ -179,6 +251,9 @@ parse_args(int argc, char *argv[]) {
 			if (strlen(optarg) >= sizeof User)
 				usage("username too long");
 			(void) strcpy(User, optarg);
+
+#endif /* WITH_SELINUX */
+
 			break;
 		case 'l':
 			if (Option != opt_unknown)
@@ -209,7 +284,13 @@ parse_args(int argc, char *argv[]) {
 		if (argv[optind] != NULL)
 			usage("no arguments permitted after this option");
 	} else {
-		if (argv[optind] != NULL) {
+#ifdef WITH_SELINUX
+		if ((ctxt_specified) && (argv[optind] == NULL)) {
+			Option = opt_replace;
+			(void) strcpy (Filename, "-");
+		}
+#endif /* WITH_SELINUX */
+		else if (argv[optind] != NULL) {
 			Option = opt_replace;
 			if (strlen(argv[optind]) >= sizeof Filename)
 				usage("filename too long");
diff -Naurp vixie-cron-4.1/database.c vixie-cron-4.1-patch/database.c
--- vixie-cron-4.1/database.c	2006-04-05 01:30:42.000000000 +0000
+++ vixie-cron-4.1-patch/database.c	2006-04-05 01:45:03.000000000 +0000
@@ -149,6 +149,9 @@ load_database(cron_db *old_db) {
 
 	while (NULL != (dp = readdir(dir))) {
 		char fname[MAXNAMLEN+1], tabname[MAXNAMLEN+1];
+#ifdef WITH_SELINUX
+		char unam[MAXNAMLEN+1], *cptr;
+#endif
 
 		/* avoid file names beginning with ".".  this is good
 		 * because we would otherwise waste two guaranteed calls
@@ -165,9 +168,22 @@ load_database(cron_db *old_db) {
 		if (!glue_strings(tabname, sizeof tabname, SPOOL_DIR,
 				  fname, '/'))
 			continue;	/* XXX log? */
+#ifdef WITH_SELINUX
+		/*
+		 * filename may have context in it
+		 */
+		(void) strcpy(unam, fname);
+
+		if ((cptr = strchr(unam, ':')) != NULL)
+			*cptr = '\0';
+
+		process_crontab(unam, fname, tabname,
+				&statbuf, &new_db, old_db);
 
+#else /* !WITH_SELINUX */
 		process_crontab(fname, fname, tabname,
 				&statbuf, &new_db, old_db);
+#endif /* WITH_SELINUX */
 	}
 	closedir(dir);
 
@@ -285,7 +301,7 @@ process_crontab(const char *uname, const
 
 	Debug(DLOAD, ("\t%s:", fname))
 
-	u = find_user(old_db, fname, crond_crontab ? tabname : NULL );
+	u = find_user(old_db, uname, crond_crontab ? tabname : NULL );
 
 	if (u != NULL) {
 		/* if crontab has not changed since we last read it
diff -Naurp vixie-cron-4.1/macros.h vixie-cron-4.1-patch/macros.h
--- vixie-cron-4.1/macros.h	2006-04-05 01:30:42.000000000 +0000
+++ vixie-cron-4.1-patch/macros.h	2006-04-05 01:45:02.000000000 +0000
@@ -48,7 +48,11 @@
 #define	MAX_COMMAND	131072	/* max length of internally generated cmd (max sh cmd line length) */
 #define	MAX_ENVSTR	131072	/* max length of envvar=value\0 strings */
 #define	MAX_TEMPSTR	131072	/* obvious */
+#ifdef WITH_SELINUX
+#define	MAX_UNAME	PATH_MAX/* username and context are part of filename  */
+#else /* !WITH_SELINUX */
 #define	MAX_UNAME	256	/* max length of username  */
+#endif /* WITH_SELINUX */
 #define	ROOT_UID	0	/* don't change this, it really must be root */
 #define	ROOT_USER	"root"	/* ditto */
 
diff -Naurp vixie-cron-4.1/misc.c vixie-cron-4.1-patch/misc.c
--- vixie-cron-4.1/misc.c	2006-04-05 01:30:42.000000000 +0000
+++ vixie-cron-4.1-patch/misc.c	2006-04-05 01:45:08.000000000 +0000
@@ -439,15 +439,34 @@ in_file(const char *string, FILE *file, 
 {
 	char line[MAX_TEMPSTR];
 	char *endp;
+#ifdef WITH_SELINUX
+	char usr[MAX_TEMPSTR];
+	char *colonptr;
+#endif
 
 	if (fseek(file, 0L, SEEK_SET))
 		return (error);
+
+#ifdef WITH_SELINUX
+	strcpy(usr, string);
+	colonptr = strchr(usr, ':');
+	if (colonptr)
+		*colonptr = '\0';
+#endif
+
 	while (fgets(line, MAX_TEMPSTR, file)) {
 		if (line[0] != '\0') {
 			endp = &line[strlen(line) - 1];
 			if (*endp != '\n')
 				return (error);
 			*endp = '\0';
+#ifdef WITH_SELINUX
+			colonptr = strchr(line, ':');
+			if (!colonptr) {
+				if (0 == strcmp(line, usr))
+					return (TRUE);
+			} else
+#endif
 			if (0 == strcmp(line, string))
 				return (TRUE);
 		}
diff -Naurp vixie-cron-4.1/security.c vixie-cron-4.1-patch/security.c
--- vixie-cron-4.1/security.c	2006-04-05 01:30:42.000000000 +0000
+++ vixie-cron-4.1-patch/security.c	2006-04-05 01:45:07.000000000 +0000
@@ -197,13 +197,23 @@ int get_security_context( const char *na
 	int retval=0;
 	char *seuser=NULL;
 	char *level=NULL;
+	char *tptr;
 
 	*rcontext = NULL;
 
 	if (is_selinux_enabled() <= 0) 
 	    return 0;
 
-	if (getseuserbyname(name, &seuser, &level) == 0) {
+	tptr = strchr(tabname, ':');
+	if (tptr) {
+		tptr++;
+		scontext = (security_context_t) strdup(tptr);
+		if (!scontext) {
+			log_it(name, getpid(), "get_security_context:strdup FAILED", name);
+			return -1;
+		}
+		log_it(name, getpid(), "job security context",scontext);
+	} else if (getseuserbyname(name, &seuser, &level) == 0) {
 		retval=get_default_context_with_level(seuser, level, NULL, &scontext);
 		free(seuser);
 		free(level);
diff -Naurp vixie-cron-4.1/user.c vixie-cron-4.1-patch/user.c
--- vixie-cron-4.1/user.c	2006-04-05 01:30:42.000000000 +0000
+++ vixie-cron-4.1-patch/user.c	2006-04-05 01:45:06.000000000 +0000
@@ -63,7 +63,7 @@ load_user(int crontab_fd, struct passwd	
 	if ((u = (user *) malloc(sizeof(user))) == NULL)
 		return (NULL);
 
-	if ( ((u->name = strdup(fname)) == NULL) 
+	if ( ((u->name = strdup(uname)) == NULL)
            ||((u->tabname = strdup(tabname)) == NULL)
            ){
 		save_errno = errno;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
