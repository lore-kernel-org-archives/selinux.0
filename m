Subject: Re: [PATCH 1/4] make newrole suid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4526D531.1090409@us.ibm.com>
References: <4526D531.1090409@us.ibm.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 16:27:28 -0400
Message-Id: <1160512048.3322.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 17:14 -0500, Michael C Thompson wrote:
> This is the 1st of 4 patches.
> This patch applies against policycoreutils-1.30.30-1.
> 
> Changes:
>   * This patch breaks up the operations performed by newrole
>     into functions. They are called in patch 2/4.
>   * The following functions do not new functionality:
>     - extract_pw_data
>     - relabel_tty
>     - restore_tty_label
>     - parse_command_line_arguments
>   * The following functions do add new functionality:
>     - xsetenv
>     - sanitize_environment
>     - transition_to_caller_uid
>     - set_signal_handles
> 
> The new (and existing) functionality should be adequately documented in 
> the code. If it is not clear, I consider that to be a failure of the 
> code, and please let me know.
> 
> Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>

diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-09-29 10:50:27.000000000 -0500
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-10-06 16:58:06.000000000 -0500
@@ -101,6 +101,25 @@
 	return s2;
 }
 
+/**
+ * Returns zero on success, non-zero otherwise
+ */
+static int xsetenv(char const *name, char const *val)
+{
+	size_t namelen = strlen(name);
+	size_t vallen = strlen(val);
+	char *string = malloc(namelen + 1 + vallen + 1);
+
+	if (!string)
+		return -1;
+	strcpy(string, name);
+	string[namelen] = '=';
+	strcpy(string + namelen + 1, val);
+	if (putenv (string) != 0)
+		return -1;

Why not just use setenv(name, val, 1)?  Then you also don't have to
worry about integer overflow in your string allocation.

@@ -332,6 +351,115 @@
 	return found;
 }
 
+/**
+ * Determine the Linux user identity to re-authenticate.
+ * If supported and set, use the login uid, as this should be more stable.
+ * Otherwise, use the real uid.
+ *
+ * This function assigns malloc'd memory into the pw_copy struct.
+ * Returns zero on success, non-zero otherwise
+ */
+int extract_pw_data(struct passwd *pw_copy)
+{
+	uid_t uid;
+	struct passwd *pw;
+
+#ifdef USE_AUDIT
+	uid = audit_getloginuid();
+	if (uid == (uid_t) - 1)
+		uid = getuid();
+#else
+	uid = getuid();
+#endif
+
+	setpwent();
+	pw = getpwuid(uid);
+	endpwent();
+	if (!(pw && pw->pw_name && pw->pw_name[0] && pw->pw_shell
+	      && pw->pw_shell[0] && pw->pw_dir && pw->pw_dir[0])) {

This seems unnecessary, unless the interface can actually return NULL
pointers for the individual fields (vs. empty strings, which are
possible) and unless later code cannot correctly handle the legal cases
that might be returned by the interface.  Otherwise, we end up
cluttering the code with lots of tests that might hide a real bug.

+		fprintf(stderr,
+			_("cannot find valid entry in the passwd file.\n"));
+		return -1;
+	}
+
+	*pw_copy = *pw;
+	pw = pw_copy;
+	pw->pw_name = xstrdup(pw->pw_name);
+	pw->pw_dir = xstrdup(pw->pw_dir);
+	pw->pw_shell = xstrdup(pw->pw_shell);
+
+	if (! (pw->pw_name && pw->pw_dir && pw->pw_shell))
+		goto out_free;

xstrdup by definition exits on OOM errors, so you don't have to re-test
here, or alternatively you don't need to use xstrdup in the first place
(vs. just plain strdup).

+static int sanitize_environment(const struct passwd *pw)
+{
+	char const *term_env = getenv("TERM");
+	char const *display_env = getenv("DISPLAY");
+	char const *xauthority_env = getenv("XAUTHORITY");
+	char *term = NULL;		/* temporary container */
+	char *display = NULL;		/* temporary container */
+	char *xauthority = NULL;	/* temporary container */
+	int rc;
+
+	/* Save the variable values we want */
+	if (term_env)
+		term = xstrdup(term_env);
+	if (display_env)
+		display = xstrdup(display_env);
+	if (xauthority_env)
+		xauthority = xstrdup(xauthority_env);
+	if ((term_env && !term) || (display_env && !display) ||
+	     (xauthority_env && !xauthority)) {
+		rc = -1;
+		goto out;
+	}

Same point here - you either use xstrdup and don't re-test afterward, or
you use strdup and test.  Ditto for all other uses of xstrdup.

@@ -396,6 +524,23 @@
 }
 #endif
 
+#ifdef NAMESPACE_PRIV
+/**
+ * This function will set the uid values to be that of caller's uid, and
+ * will drop any privilages which maybe have been raised.
+ */
+static int transition_to_caller_uid()
+{
+	uid_t uid = getuid();
+
+	if (setresuid(uid, uid, uid)) {
+		fprintf(stderr, _("Error changing uid, aborting.\n"));
+		return -1;
+	}

Note that this will not drop privileges if KEEPCAPS has been set to 1.
So you might want to explicitly call prctl in this function just prior
to calling setresuid to make it clear that you are dropping capabilities
as well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
