Subject: Re: Patch setfiles to only warn if add_remove fails to lstat on
 user initiated excludes.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4A816043.9090905@redhat.com>
References: <4A803935.3040407@redhat.com>
	 <1249934593.2422.77.camel@moss-pluto.epoch.ncsc.mil>
	 <1249935130.2422.82.camel@moss-pluto.epoch.ncsc.mil>
	 <4A816043.9090905@redhat.com>
Content-Type: text/plain
Date: Tue, 11 Aug 2009 09:33:29 -0400
Message-Id: <1249997609.2422.121.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-08-11 at 08:12 -0400, Daniel J Walsh wrote:
> On 08/10/2009 04:12 PM, Stephen Smalley wrote:
> > On Mon, 2009-08-10 at 16:03 -0400, Stephen Smalley wrote:
> >> On Mon, 2009-08-10 at 11:13 -0400, Daniel J Walsh wrote:
> >>> Currently in F12 if you have file systems that root can not read
> >>>
> >>> # restorecon -R -v /var/lib/libvirt/
> >>> Can't stat directory "/home/dwalsh/.gvfs", Permission denied.
> >>> Can't stat directory "/home/dwalsh/redhat", Permission denied.
> >>>
> >>> After patch
> >>>
> >>> # ./restorecon -R -v /var/lib/libvirt/
> >>
> >> But if you were to run
> >> ./restorecon -R /home/dwalsh
> >> that would try to descend into .gvfs and redhat, right?
> >>
> >> I think you want instead to ignore the lstat error if the error was
> >> permission denied and add the entry to the exclude list so that
> >> restorecon will not try to descend into it.  It is ok to exclude a
> >> directory to which you lack permission.  Try this:
> > 
> > Also, why limit -e to only directories?  Why not let the user exclude
> > individual files if they choose to do so?  In which case we could drop
> > the mode test altogether, and possibly drop the lstat() call altogether?
> > Or if you truly want to warn the user about non-existent paths, then
> > take the lstat() and warning to the 'e' option processing in main()
> > instead of doing it inside of add_exclude().
> > 
> I agree lets remove the directory check and warn on non existing files.

Does this handle it correctly for you?

Remove the directory check for the -e option and only apply the
existence test to user-specified entries.  Also ignore permission denied
errors as it is ok to exclude a directory or file to which the caller
lacks permission.

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index d219225..4c47f21 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -236,25 +236,13 @@ void filespec_destroy(void)
 
 static int add_exclude(const char *directory)
 {
-	struct stat sb;
 	size_t len = 0;
+
 	if (directory == NULL || directory[0] != '/') {
 		fprintf(stderr, "Full path required for exclude: %s.\n",
 			directory);
 		return 1;
 	}
-	if (lstat(directory, &sb)) {
-		fprintf(stderr, "Can't stat directory \"%s\", %s.\n",
-			directory, strerror(errno));
-		return 0;
-	}
-	if ((sb.st_mode & S_IFDIR) == 0) {
-		fprintf(stderr,
-			"\"%s\" is not a Directory: mode %o, ignoring\n",
-			directory, sb.st_mode);
-		return 0;
-	}
-
 	if (excludeCtr == MAX_EXCLUDES) {
 		fprintf(stderr, "Maximum excludes %d exceeded.\n",
 			MAX_EXCLUDES);
@@ -840,6 +828,11 @@ int main(int argc, char **argv)
 			}
 		case 'e':
 			remove_exclude(optarg);
+			if (lstat(optarg, &sb) < 0 && errno != EACCES) {
+				fprintf(stderr, "Can't stat exclude path \"%s\", %s - ignoring.\n",
+					optarg, strerror(errno));
+				break;
+			}
 			if (add_exclude(optarg))
 				exit(1);
 			break;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
