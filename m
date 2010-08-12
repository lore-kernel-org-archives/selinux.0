Date: Thu, 12 Aug 2010 14:51:28 -0500
From: Chris Adams <cmadams@hiwaay.net>
To: SELinux@tycho.nsa.gov
Subject: Bug in restorecond for the first user logged in
Message-ID: <20100812195128.GC897947@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The first user that logs in will not be caught by restorecond.  The utmp
checking function only returns that there was a change when the previous
list of users was non-NULL.

Here's a patch that works for me (this is against the latest Red Hat
Enterprise Linux 5 policycoreutils release, but I checked the current
source tree and the same problem is present):

diff -urN policycoreutils-1.33.12-dist/restorecond/utmpwatcher.c policycoreutils-1.33.12/restorecond/utmpwatcher.c
--- policycoreutils-1.33.12-dist/restorecond/utmpwatcher.c	2007-01-11 13:01:39.000000000 -0600
+++ policycoreutils-1.33.12/restorecond/utmpwatcher.c	2010-08-12 14:13:24.000000000 -0500
@@ -69,10 +69,9 @@
 
 	utmp_wd =
 	    inotify_add_watch(inotify_fd, utmp_path, IN_MOVED_FROM | IN_MODIFY);
-	if (prev_utmp_ptr) {
-		changed = strings_list_diff(prev_utmp_ptr, utmp_ptr);
+	changed = strings_list_diff(prev_utmp_ptr, utmp_ptr);
+	if (prev_utmp_ptr)
 		strings_list_free(prev_utmp_ptr);
-	}
 	return changed;
 }
 

-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
