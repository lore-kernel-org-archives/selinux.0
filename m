Subject: Re: Latest patch for policycoreutils, reworked from previous.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45094B5D.3070606@redhat.com>
References: <45094B5D.3070606@redhat.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 15:53:43 -0400
Message-Id: <1158263623.25629.216.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-14 at 08:30 -0400, Daniel J Walsh wrote:
> Reworked patch to restorecon
> 
> Added -i qualified to ignore missing files.  (-f) flag is already used 
> for filename.  If you want to pick another qualifier, pick it, I am not 
> wed to -i.
> 
> Added ability to use stdout for -o qualifier, so -o - will now output to 
> stdout.
> 
> Changed verbose mode to print to stderr, so you can use -v and -o - at 
> the same time.
> 
> 
> Add a change_ctr to allow restorecon to exit with the number of 
> "changed" files.  Similar to what grep returns.
> 
> Also changes fixfiles to send only stdout to logfile so we can grab "-o 
> -" separately.
> 
> There is a bug in fixfiles which causes it not to handle multiple rpm 
> files which is also fixed.

diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.30.29/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2006-09-01 22:32:11.000000000 -0400
+++ policycoreutils-1.30.29/restorecon/restorecon.c	2006-09-14 08:17:23.000000000 -0400
@@ -129,7 +132,7 @@
 void usage(const char *const name)
 {
 	fprintf(stderr,
-		"usage:  %s [-FnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
+		"usage:  %s [-iFonrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",

Doesn't reflect the new usage in the reworked patch (no -o by itself, but -o - | -o filename).

@@ -160,7 +163,9 @@
 	}
 
 	if (lstat(filename, &st) != 0) {
-		fprintf(stderr, "lstat(%s) failed: %s\n", filename,
+		if (!file_exist && errno == ENOENT)
+			return 0;
+		fprintf(outfile, "lstat(%s) failed: %s\n", filename,
 			strerror(errno));

This is an actual error message, so I don't know why you want it in
outfile, and outfile can be NULL here.

 		return 1;
 	}
@@ -249,9 +251,12 @@
 						freecon(scontext);
 						return 1;
 					}
-				}
+				} 
+				else
+					change_ctr++;
+
 				if (verbose)
-					printf("%s reset %s context %s->%s\n",
+					fprintf(stderr, "%s reset %s context %s->%s\n",
 					       progname, filename,
 					       (retcontext >=
 						0 ? prev_context : ""),
@@ -259,7 +264,7 @@
 			}
 		}
 		if (verbose > 1 && !force && customizable > 0) {
-			printf("%s: %s not reset customized by admin to %s\n",
+			fprintf(stderr, "%s: %s not reset customized by admin to %s\n",
 			       progname, filename, prev_context);
 		}
 

The -v output seems to be a superset of the -o output.  So why do you
need them to be run simultaneously and fed to two separate streams?


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
