Subject: RE: [PATCH] libsemanage: free policydb before fork
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd Miller <Tmiller@tresys.com>
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880181EED5@exchange.columbia.tresys.com>
References: <47A5311F.2020703@manicmethod.com>
	 <6FE441CD9F0C0C479F2D88F959B015880181EED5@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 04 Feb 2008 11:41:35 -0500
Message-Id: <1202143295.3070.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-04 at 10:14 -0500, Todd Miller wrote:
> Joshua Brindle wrote:
> > While testing the recent memory-related patches on a low memory
> > machine (512m total) I found that semodule still failed. It turns out
> > that fork() requires enough free ram for the amount of private dirty
> > memory in the parent process to succeed (even if it is never written
> > to in the child process).
> 
> I would suggest trying to use vfork() instead of fork() in
> semanage_exec_prog().
> This should result in less of the parent's memory being copied into the
> child.
> You would also have to change the exit() following execve() failure to
> _exit()
> but that should be it.

Ok, patch below makes this change.

Index: trunk/libsemanage/src/semanage_store.c
===================================================================
--- trunk/libsemanage/src/semanage_store.c	(revision 2783)
+++ trunk/libsemanage/src/semanage_store.c	(working copy)
@@ -911,14 +911,14 @@
 
 	/* no need to use pthread_atfork() -- child will not be using
 	 * any mutexes. */
-	if ((forkval = fork()) == -1) {
+	if ((forkval = vfork()) == -1) {
 		ERR(sh, "Error while forking process.");
 		return -1;
 	} else if (forkval == 0) {
 		/* child process.  file descriptors will be closed
 		 * because they were set as close-on-exec. */
 		execve(e->path, argv, NULL);
-		exit(EXIT_FAILURE);	/* if execve() failed */
+		_exit(EXIT_FAILURE);	/* if execve() failed */
 	} else {
 		/* parent process.  wait for child to finish */
 		int status = 0;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
