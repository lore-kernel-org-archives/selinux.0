Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAA3KF0g021527
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2012 22:20:20 -0500
Date: Sat, 10 Nov 2012 04:19:32 +0100
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Cc: selinux-devel@lists.alioth.debian.org, debian-dpkg@lists.debian.org
Subject: Re: Possible issues with dpkg SELinux support
Message-ID: <20121110031932.GA6217@gaara.hadrons.org>
References: <20121108082623.GA5059@gaara.hadrons.org>
 <CAB9W1A3cVVSj-PbM73c+vePHt7fVGf8117OXmTrDPf0K0vyYGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
In-Reply-To: <CAB9W1A3cVVSj-PbM73c+vePHt7fVGf8117OXmTrDPf0K0vyYGg@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: Quoted-Printable

On Thu, 2012-11-08 at 10:49:59 -0500, Stephen Smalley wrote:
> Agree that lsetfilecon failure other than EOPNOTSUPP should abort
> package installation if SELinux is enabled.  Note that matchpathcon
> and friends are deprecated interfaces; consider converting to
> selabel_open and friends instead, as has already been done in rpm.

Great, done now in the attached patch. Would be nice if the currently
obsolete/deprecated functions could be marked as such on the man pages
and possibly on the header files with compiler attributes, as this was
not obvious until you pointed it out. I still have some questions and
doubts though, if you don't mind:


Is the "<<none>>" check needed at all? This has bothered me for a
while, and it's not clear if calling lsetfilecon_raw() with that would
DTRT, or if selabel_lookup_raw() would never return that to start with.

Should the code be handling selinux_status_updated(), and reopening
the selabel_handle in such case? If so, how often, per extracted file,
per package processed (probably this usually happens only after
upgrading the refpolicy package?), some other time(s)?

Should the code be ignoring some other SELinux errors or considering
them warnings when running in non-enforcing mode, or is that already
handled internally by the SELinux interfaces?

Is ignoring errors from lsetfilecon_raw() enough of a grave issue as
to warrant a stable dpkg update (can it create security issues, or just
wrongful or too restrictive unpacks)? (I'd be preparing updates for the
current Debian stable and the just-being-prepared-stable releases in
such case.)


> Some mechanism to allow package scriptlets to run in a different
> context than the package manager would be helpful, but rpm_execcon()
> may not be a very good example.  The Tizen folks have been working on
> a more general architecture for rpm security plugins that may be
> relevant/helpful as a guide, see prior discussions on selinux list and
> rpm-maint.

If you mean the discussion started by Elena, I agree that for dpkg too,
it would be nice to have a more generic =E2=80=9Cplugin=E2=80=9D interfac=
e, but for now,
given that there's no one requesting it, I'd rather just make SELinux
behave correctly, and modularize this later on, as the code would need
quite some cleanup/reorganization first in any case.

Also Elena's proposed plugin system did not seem to be directly related
to SELinux, so I've ended adapting rpm_execcon() almost verbatim to the
dpkg case. But something that came to mind is if you think it would make
sense to refactor that function (I've read it's supposed to disappear
anyway) into something slightly more generic so that it could be used by
at least both rpm and dpkg (and possibly other package managers or even
programs invoking helper programs). Something ressembling the adaptation
that I've made in the attached patch, but in addition passing to it (at
least) the fallback context type, it could perhaps have a signature
similar to something like:

  int setexecfilecon(const char *filename, const char *fallback_type);

and be called like:

  rc =3D setexecfilecon(path, "dpkg_script_t");
  ...
  rc =3D execve(path, argv, envp);

?


If the attached patch looks fine in principle, I'd ask the Debian
SELinux folks for some testing (as I've only build tested it), and if
they need to somehow adapt the Debian SELinux refpolicy.

thanks,
guillem

--mP3DRpeJDSE+ciuQ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="dpkg-selinux-rework.patch"
Content-Transfer-Encoding: 7Bit

diff --git a/src/archives.c b/src/archives.c
index 4e36347..90a528a 100644
--- a/src/archives.c
+++ b/src/archives.c
@@ -59,6 +59,7 @@
 
 #ifdef WITH_SELINUX
 #include <selinux/selinux.h>
+#include <selinux/label.h>
 #endif
 
 #include "filesdb.h"
@@ -476,11 +477,38 @@ tarobject_set_perms(struct tar_entry *te, const char *path, struct file_stat *st
   }
 }
 
+#ifdef WITH_SELINUX
+static struct selabel_handle *
+dpkg_get_selabel_handle(void)
+{
+  static int selinux_enabled = -1;
+  static struct selabel_handle *sehandle;
+
+  if (selinux_enabled >= 0)
+    return sehandle;
+
+  /* Set selinux_enabled if it is not already set (singleton). */
+  selinux_enabled = (is_selinux_enabled() > 0);
+
+  if (!selinux_enabled)
+    return NULL;
+
+  sehandle = selabel_open(SELABEL_CTX_FILE, NULL, 0);
+  if (sehandle == NULL)
+    ohshite(_("cannot get security labeling handle"));
+
+  /* XXX: We could use selinux_set_callback() to redirect the errors from
+   * the other SELinux calls, but that does not seem worth it right now. */
+
+  return sehandle;
+}
+#endif
+
 static void
 tarobject_set_se_context(const char *matchpath, const char *path, mode_t mode)
 {
 #ifdef WITH_SELINUX
-  static int selinux_enabled = -1;
+  struct selabel_handle *sehandle;
   security_context_t scontext = NULL;
   int ret;
 
@@ -488,33 +516,28 @@ tarobject_set_se_context(const char *matchpath, const char *path, mode_t mode)
   if ((mode & S_IFMT) == 0)
     return;
 
-  /* Set selinux_enabled if it is not already set (singleton). */
-  if (selinux_enabled < 0) {
-    selinux_enabled = (is_selinux_enabled() > 0);
-
-    /* Do not translate from computer to human readable forms, to avoid
-     * issues when mcstransd has disappeared during the unpack process. */
-    if (selinux_enabled)
-      set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
-  }
-
-  /* If SE Linux is not enabled just do nothing. */
-  if (!selinux_enabled)
+  /* If SELinux is not enabled just do nothing. */
+  sehandle = dpkg_get_selabel_handle();
+  if (sehandle == NULL)
     return;
 
-  /* XXX: Well, we could use set_matchpathcon_printf() to redirect the
-   * errors from the following bit, but that seems too much effort. */
+  /*
+   * We use the _raw function variants here so that no translation happens
+   * from computer to human readable forms, to avoid issues when mcstransd
+   * has disappeared during the unpack process.
+   *
+   * And we do nothing if we can't figure out what the context is, or if it
+   * has no context; in which case the default context shall be applied.
+   */
 
-  /* Do nothing if we can't figure out what the context is, or if it has
-   * no context; in which case the default context shall be applied. */
-  ret = matchpathcon(matchpath, mode & S_IFMT, &scontext);
+  ret = selabel_lookup_raw(sehandle, &scontext, matchpath, mode & S_IFMT);
   if (ret == -1 || (ret == 0 && scontext == NULL))
     return;
 
   if (strcmp(scontext, "<<none>>") != 0) {
-    if (lsetfilecon_raw(path, scontext) < 0)
-      /* XXX: This might need to be fatal instead!? */
-      perror("Error setting security context for next file object:");
+    ret = lsetfilecon_raw(path, scontext);
+    if (ret < 0 && ret != ENOTSUP)
+      ohshite(_("cannot set security context for file object '%s'"), path);
   }
 
   freecon(scontext);
diff --git a/src/script.c b/src/script.c
index c03441b..2aeaf40 100644
--- a/src/script.c
+++ b/src/script.c
@@ -31,6 +31,12 @@
 #include <unistd.h>
 #include <stdlib.h>
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/flask.h>
+#include <selinux/context.h>
+#endif
+
 #include <dpkg/i18n.h>
 #include <dpkg/dpkg.h>
 #include <dpkg/dpkg-db.h>
@@ -137,6 +143,59 @@ preexecscript(struct command *cmd)
 }
 
 static int
+maintscript_set_exec_context(struct command *cmd)
+{
+	int rc = 0;
+#ifdef WITH_SELINUX
+	security_context_t curcon = NULL, newcon = NULL, filecon = NULL;
+	context_t tmpcon = NULL;
+
+	if (is_selinux_enabled() < 1)
+		return 0;
+
+	rc = getcon(&curcon);
+	if (rc < 0)
+		goto out;
+
+	rc = getfilecon(cmd->filename, &filecon);
+	if (rc < 0)
+		goto out;
+
+	rc = security_compute_create(curcon, filecon, SECCLASS_PROCESS, &newcon);
+	if (rc < 0)
+		goto out;
+
+	if (strcmp(curcon, newcon) == 0) {
+		/* No default transition, use dpkg_script_t for now. */
+		rc = -1;
+		tmpcon = context_new(curcon);
+		if (tmpcon == NULL)
+			goto out;
+		if (context_type_set(tmpcon, "dpkg_script_t"))
+			goto out;
+		freecon(newcon);
+		newcon = strdup(context_str(tmpcon));
+		if (newcon == NULL)
+			goto out;
+		rc = 0;
+	}
+
+	rc = setexeccon(newcon);
+
+out:
+	if (rc < 0 && security_getenforce() == 0)
+		rc = 0;
+
+	context_free(tmpcon);
+	freecon(newcon);
+	freecon(curcon);
+	freecon(filecon);
+#endif
+
+	return rc < 0 ? rc : 0;
+}
+
+static int
 do_script(struct pkginfo *pkg, struct pkgbin *pkgbin,
           struct command *cmd, struct stat *stab, int warn)
 {
@@ -156,6 +215,11 @@ do_script(struct pkginfo *pkg, struct pkgbin *pkgbin,
 			ohshite(_("unable to setenv for maintainer script"));
 
 		cmd->filename = cmd->argv[0] = preexecscript(cmd);
+
+		if (maintscript_set_exec_context(cmd) < 0)
+			ohshite(_("cannot set security execution context for "
+			          "maintainer script"));
+
 		command_exec(cmd);
 	}
 	subproc_signals_setup(cmd->name); /* This does a push_cleanup(). */

--mP3DRpeJDSE+ciuQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
