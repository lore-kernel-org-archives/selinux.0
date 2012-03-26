Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QFVU9L006492
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 11:31:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 440331A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 17:31:29 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WeQdn-9Th5Q3 for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 17:31:27 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 6D6D41A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 17:31:27 +0200 (CEST)
Date: Mon, 26 Mar 2012 17:31:25 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/4] policycoreutils -- Fix infinite loop i watch code
Message-ID: <20120326173125.1d8bf203@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

This patch seems old, and I /think/ has already been proposed once.

From: Manoj Srivastava <srivasta@debian.org>
Date: Wed, 14 Oct 2009 02:03:28 -0500
Subject: Fix infinite loop i watch code

    [topic--utmp-watch-fix]: Fix infinite loop i watch code

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

    Patch by Martin Orr.

    Signed-off-by: Martin Orr <martin@martinorr.name>
    Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 restorecond/watch.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/policycoreutils/restorecond/watch.c b/policycoreutils/restorecond/watch.c
index 6a833c3..9a45cba 100644
--- a/policycoreutils/restorecond/watch.c
+++ b/policycoreutils/restorecond/watch.c
@@ -186,20 +186,22 @@ int watch(int fd, const char *watch_file)
 			printf("wd=%d mask=%u cookie=%u len=%u\n",
 			       event->wd, event->mask,
 			       event->cookie, event->len);
-		if (event->wd == master_wd)
-			read_config(fd, watch_file);
-		else {
-			switch (utmpwatcher_handle(fd, event->wd)) {
-			case -1:	/* Message was not for utmpwatcher */
-				if (event->len)
-					watch_list_find(event->wd, event->name);
-				break;
-			case 1:	/* utmp has changed need to reload */
+		if (event->mask & ~IN_IGNORED) {
+			if (event->wd == master_wd)
 				read_config(fd, watch_file);
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
+				case 1:	/* utmp has changed need to reload */
+					read_config(fd, watch_file);
+					break;
+
+				default:	/* No users logged in or out */
+					break;
+				}
 			}
 		}
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
