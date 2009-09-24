Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8OEn6iZ024223
	for <selinux@tycho.nsa.gov>; Thu, 24 Sep 2009 10:49:06 -0400
Received: from smtp2.u-psud.fr (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8OEoYiO015627
	for <selinux@tycho.nsa.gov>; Thu, 24 Sep 2009 14:50:35 GMT
Received: from smtp2.u-psud.fr (localhost [127.0.0.1])
	by localhost (MTA) with SMTP id 8586A59E92E
	for <selinux@tycho.nsa.gov>; Thu, 24 Sep 2009 16:49:02 +0200 (CEST)
Received: from [129.175.216.134] (unknown [129.175.216.134])
	by smtp2.u-psud.fr (MTA) with ESMTP id BDD2F59E938
	for <selinux@tycho.nsa.gov>; Thu, 24 Sep 2009 16:49:01 +0200 (CEST)
Message-ID: <4ABB86EB.3050909@martinorr.name>
Date: Thu, 24 Sep 2009 15:49:15 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] restorecond: Ignore IN_IGNORED inotify events
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With kernel 2.6.31, restorecond uses 99% of my CPU.

This is because removing and readding the watch on utmp triggers inotify to
return an IN_IGNORED event for the old watch descriptor.  If the watch gets
allocated the same wd when it is readded, then restorecond thinks that utmp
has changed, so removes and readds the watch again, potentially looping.

With kernel <= 2.6.30, this never happened, because the kernel didn't reuse
watch descriptors.  So the IN_IGNORED event comes with a wd that is no
longer in use, and gets ignored.  But kernel 2.6.31 reuses the same watch
descriptor.

This patch fixes that by ignoring inotify events whose only bit set is
IN_IGNORED.

Note: it is not clear to me why it is necessary to remove and readd the
watch in the first place.

Note for testing: you need to log in (to cause a change in utmp) after
starting restorecond to trigger the bug.  In fact you need to log in twice
before the kernel reuses a watch descriptor.

---
 policycoreutils/restorecond/restorecond.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/policycoreutils/restorecond/restorecond.c
b/policycoreutils/restorecond/restorecond.c
index 58774e6..4952632 100644
--- a/policycoreutils/restorecond/restorecond.c
+++ b/policycoreutils/restorecond/restorecond.c
@@ -315,21 +315,24 @@ static int watch(int fd)
 			printf("wd=%d mask=%u cookie=%u len=%u\n",
 			       event->wd, event->mask,
 			       event->cookie, event->len);
-		if (event->wd == master_wd)
-			read_config(fd);
-		else {
-			switch (utmpwatcher_handle(fd, event->wd)) {
-			case -1:	/* Message was not for utmpwatcher */
-				if (event->len)
-					watch_list_find(event->wd, event->name);
-				break;

-			case 1:	/* utmp has changed need to reload */
+		if (event->mask & ~IN_IGNORED) {
+			if (event->wd == master_wd)
 				read_config(fd);
-				break;
-
-			default:	/* No users logged in or out */
-				break;
+			else {
+				switch (utmpwatcher_handle(fd, event->wd)) {
+				case -1:	/* Message was not for utmpwatcher */
+					if (event->len)
+						watch_list_find(event->wd, event->name);
+					break;
+
+				case 1:	/* utmp has changed need to reload */
+					read_config(fd);
+					break;
+
+				default:	/* No users logged in or out */
+					break;
+				}
 			}
 		}

-- 
Martin Orr


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
