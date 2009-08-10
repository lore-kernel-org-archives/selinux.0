Subject: Re: Patch setfiles to only warn if add_remove fails to lstat on
 user initiated excludes.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4A803935.3040407@redhat.com>
References: <4A803935.3040407@redhat.com>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 16:03:13 -0400
Message-Id: <1249934593.2422.77.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-10 at 11:13 -0400, Daniel J Walsh wrote:
> Currently in F12 if you have file systems that root can not read
> 
> # restorecon -R -v /var/lib/libvirt/
> Can't stat directory "/home/dwalsh/.gvfs", Permission denied.
> Can't stat directory "/home/dwalsh/redhat", Permission denied.
> 
> After patch
> 
> # ./restorecon -R -v /var/lib/libvirt/

But if you were to run
./restorecon -R /home/dwalsh
that would try to descend into .gvfs and redhat, right?

I think you want instead to ignore the lstat error if the error was
permission denied and add the entry to the exclude list so that
restorecon will not try to descend into it.  It is ok to exclude a
directory to which you lack permission.  Try this:

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index d219225..4190ded 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -243,17 +243,18 @@ static int add_exclude(const char *directory)
 			directory);
 		return 1;
 	}
-	if (lstat(directory, &sb)) {
+	if (lstat(directory, &sb) == 0) {
+		if ((sb.st_mode & S_IFDIR) == 0) {
+			fprintf(stderr,
+				"\"%s\" is not a Directory: mode %o, ignoring\n",
+				directory, sb.st_mode);
+			return 0;
+		}
+	} else if (errno != EACCES) {
 		fprintf(stderr, "Can't stat directory \"%s\", %s.\n",
 			directory, strerror(errno));
 		return 0;
 	}
-	if ((sb.st_mode & S_IFDIR) == 0) {
-		fprintf(stderr,
-			"\"%s\" is not a Directory: mode %o, ignoring\n",
-			directory, sb.st_mode);
-		return 0;
-	}
 
 	if (excludeCtr == MAX_EXCLUDES) {
 		fprintf(stderr, "Maximum excludes %d exceeded.\n",



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
