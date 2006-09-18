Subject: Re: Latest patch for policycoreutils, reworked from previous.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Steve G <linux_4ever@yahoo.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <450AA9BF.1080101@redhat.com>
References: <20060914210005.95111.qmail@web51511.mail.yahoo.com>
	 <450AA9BF.1080101@redhat.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 16:24:37 -0400
Message-Id: <1158611077.14194.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-15 at 09:25 -0400, Daniel J Walsh wrote:
> Reworked patch.
> 
> restorecon -v goes back to stdout
> 
> added "verify" to print out files with out the verbose mode.

Hmm...just noticed this:

diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.30.29/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2006-09-01 22:32:11.000000000 -0400
+++ policycoreutils-1.30.29/restorecon/restorecon.c	2006-09-15 09:19:49.000000000 -0400
@@ -249,7 +254,10 @@
 						freecon(scontext);
 						return 1;
 					}
-				}
+				} 
+				else
+					change_ctr++;
+


I don't think this is matching up with the right if statement; it
currently matches if (change), so it only executes if restorecon is
making no changes (-n option).  Looks like you meant it to match the if
(lsetfilecon(...) < 0).

<snip>
@@ -428,5 +445,7 @@
 	if (outfile)
 		fclose(outfile);
 
+	if (change) return change_ctr;
+
 	return errors;
 }

The problem here is that existing callers may assume that an exit status
of non-zero means failure.  Again, an interface change.  How did you
intend to use this?  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
