Subject: Re: restorecon and symbolic links
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Martin Orr <martin@martinorr.name>
Cc: Manoj Srivastava <srivasta@golden-gryphon.com>, selinux@tycho.nsa.gov,
        544215-forwarded@bugs.debian.org, Chad Sellers <csellers@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4A9BCE45.7060704@martinorr.name>
References: <4A996106.4060604@martinorr.name>
	 <87my5ijji4.fsf@anzu.internal.golden-gryphon.com>
	 <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9BCE45.7060704@martinorr.name>
Content-Type: text/plain
Date: Mon, 31 Aug 2009 16:27:51 -0400
Message-Id: <1251750471.27334.4.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-31 at 14:21 +0100, Martin Orr wrote:
> On 31/08/09 13:17, Stephen Smalley wrote:
> > On Sat, 2009-08-29 at 18:19 -0500, Manoj Srivastava wrote:
> >> On Sat, Aug 29 2009, Martin Orr wrote:
> >>
> >>> With policycoreutils 2.0.71, "restorecon /dev/stdin" fails if stdin is a pipe:
> >>> martin@caligula:~$ echo hi | sudo restorecon /dev/stdin
> >>> realpath(/dev/stdin) failed No such file or directory
> >>>
> >>> Why would you want to do this?
> >>> The Debian udev init script does
> >>> ln -s /proc/self/fd/0 /dev/stdin
> >>> restorecon /dev/stdin
> >>> I am not sure why stdin is a pipe here but it is some consequence of the
> >>> boot process.
> >>>
> >>> The intention here (and what happened with policycoreutils 2.0.69) is to
> >>> relabel the symbolic link.  But the recent realpath patch changed this, and
> >>> I don't think there is a way now to ask restorecon to relabel an individual
> >>> symlink.
> >>         There are consequences to this change not mentioned above: when
> >>  booting with policycoreutils 2.0.71 /dev/pts (and several other device
> >>  nodes) are not created which causes all sorts of trouble.
> >>
> >>  This is a consequence of the realpath changes in restorecon, because
> >>  when /lib/udev/create_static_nodes does
> >>          ln -s /proc/self/fd/0 /dev/stdin
> >>          restorecon /dev/stdin
> >>  it now fails with the error
> >>          realpath(/dev/stdin) failed No such file or directory
> >>  This causes create_static_nodes to exit (due to set -e) before creating
> >>  /dev/pts.
> >>
> >>         I am planning on reverting the removal of special treatment of
> >>  symlinks from the debian  unstable version until this is resolved.
> > 
> > The particular commit was:
> > 
> > commit 37c5c30998b73d9c6efe53fd0534256463991c5e
> > Author: Stephen Smalley <sds@tycho.nsa.gov>
> > Date:   Mon Aug 3 09:34:52 2009 -0400
> > 
> >     setfiles: only call realpath() on user-supplied pathnames
> >     
> >     Change setfiles/restorecon to only call realpath() on the user-supplied
> >     pathnames prior to invoking fts_open().  This ensures that commands such
> >     as restorecon -R /etc/init.d and (cd /etc && restorecon shadow gshadow)
> >     will work as expected while avoiding the overhead of calling realpath()
> >     on each file during a file tree walk.
> >     
> >     Since we are now only acting on user-supplied pathnames, drop the
> >     special case handling of symlinks (when a user invokes restorecon
> >     -R /etc/init.d he truly wants it to descend /etc/rc.d/init.d).  We can
> >     also defer allocation of the pathname buffer to libc by passing NULL
> >     (freeing on the out path) and we can drop the redundant exclude() check
> >     as it will now get handled on the normal path.
> >     
> >     Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > 
> > What behavior would you like instead?  I'd still like to have restorecon
> > -R /etc/init.d to do what the user expects, which isn't just relabel the
> > symlink.
> 
> True, but I would expect restorecon -R /etc/init.d to relabel the symlink as
> well as descend into the directory.  On the whole I would expect it not to
> relabel the target of the symlink itself but I don't have a strong opinion
> on that, as long as it doesn't fail if the symlink is broken.

How about this for a compromise?

Add a -h option to restorecon so that the user can explicitly ask to
relabel a symlink (as with chcon), but also fall back to proceeding with
the original path if realpath() fails, in which case we will relabel the
symlink if the path was a broken symlink.

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 4c47f21..7ea7262 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -73,6 +73,7 @@ static int iamrestorecon;
 
 /* Behavior flags determined based on setfiles vs. restorecon */
 static int expand_realpath;  /* Expand paths via realpath. */
+static int follow_symlink; /* follow symlinks */
 static int abort_on_error; /* Abort the file tree walk upon an error. */
 static int add_assoc; /* Track inode associations for conflict detection. */
 static int fts_flags; /* Flags to fts, e.g. follow links, follow mounts */
@@ -547,7 +548,7 @@ int canoncon(char **contextp)
 
 static int process_one(char *name)
 {
-	int rc = 0;
+	int rc = 0, free_name = 0;
 	const char *namelist[2];
 	dev_t dev_num = 0;
 	FTS *fts_handle;
@@ -555,16 +556,23 @@ static int process_one(char *name)
 
 	if (expand_realpath) {
 		char *p;
-		p = realpath(name, NULL);
-		if (!p) {
-			fprintf(stderr, "realpath(%s) failed %s\n", name,
-				strerror(errno));
+		struct stat sb;
+		
+		rc = lstat(name, &sb);
+		if (rc < 0) {
+			fprintf(stderr, "%s:  lstat(%s) failed:  %s\n",
+				progname, name,	strerror(errno));
 			return -1;
 		}
-		name = p;
+		if (!S_ISLNK(sb.st_mode) || follow_symlink) {
+			p = realpath(name, NULL);
+			if (p) {
+				name = p;
+				free_name = 1;
+			}
+		}
 	}
 
-
 	if (!strcmp(name, "/"))
 		mass_relabel = 1;
 
@@ -619,7 +627,7 @@ out:
 	}
 	if (fts_handle)
 		fts_close(fts_handle);
-	if (expand_realpath)
+	if (free_name)
 		free(name);
 	return rc;
 
@@ -777,6 +785,7 @@ int main(int argc, char **argv)
 		iamrestorecon = 1;
 		recurse = 0;
 		expand_realpath = 1;
+		follow_symlink = 1;
 		abort_on_error = 0;
 		add_assoc = 0;
 		fts_flags = FTS_PHYSICAL;
@@ -792,7 +801,7 @@ int main(int argc, char **argv)
 	exclude_non_seclabel_mounts();
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW0")) > 0) {
+	while ((opt = getopt(argc, argv, "c:de:f:hilnpqrsvo:FRW0")) > 0) {
 		switch (opt) {
 		case 'c':
 			{
@@ -843,6 +852,9 @@ int main(int argc, char **argv)
 		case 'd':
 			debug = 1;
 			break;
+		case 'h':
+			follow_symlink = 0;
+			break;
 		case 'i':
 			ignore_enoent = 1;
 			break;


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
