Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9K228Wt017426
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 22:02:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9K227mR018622
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 02:02:07 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9K21ijp018578 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 02:01:45 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 15478924F3
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 01:48:18 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6C5477F06B
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 01:48:16 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: init patch for loading policy
Date: Mon, 20 Oct 2003 01:48:15 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/Irk/hm0CNLT0oG"
Message-Id: <200310200148.15852.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_/Irk/hm0CNLT0oG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a patch for /sbin/init to load the policy and set enforcing 
mode.  Here's a quick summary of the algorithm:

0)  Only reach our code if the PIPE code for detecting "telinit u" does not 
get a hit.  Therefore we know that we are executed on either a SEGV of the 
original init or the initial boot.
1)  Check for readability of /selinux/enforce, if it's readable then we have 
just exec'd ourselves so go to FINISH.
2)  Mount /selinux, if success then go to 5.
3)  Mount /proc, if error then go to FINISH (*).
4)  Check /proc/filesystems for selinuxfs entry, if it's not there then we 
aren't running an SE Linux kernel so go to FINISH.  If it's there then we 
have a serious error condition so go to ERR (I forgot to close a file handle, 
not that it matters much - I'll fix it later).
5)  load_policy - if error then go to ERR.
6)  Set enforcing mode, if error then go to ERR.
7)  Exec itself to get init_t, if can't exec then fall through to ERR.
ERR) Sleep for 60 seconds after displaying message then halt machine (*).
FINISH) Continue with regular init startup.

The (*)'s indicate issues that are open for discussion.  The exact actions may 
be contentious.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_/Irk/hm0CNLT0oG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="init.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="init.diff"

diff -ru orig/sysvinit-2.85/src/init.c sysvinit-2.85/src/init.c
--- orig/sysvinit-2.85/src/init.c	2003-10-19 20:25:32.000000000 +1000
+++ sysvinit-2.85/src/init.c	2003-10-20 01:00:47.000000000 +1000
@@ -2508,6 +2508,7 @@
 	char			*p;
 	int			f;
 	int			isinit;
+	FILE			*fp;
 
 	/* Get my own name */
 	if ((p = strrchr(argv[0], '/')) != NULL)
@@ -2551,6 +2552,55 @@
 		init_main();
 	}
 
+#ifdef WITH_SELINUX
+	if(!access("/selinux/enforce", R_OK))
+		goto finished;
+
+	if(system("mount -n none /selinux -t selinuxfs"))
+	{
+		char buf[64];
+		if(system("mount -n none /proc -t proc"))
+		{
+			fprintf(stderr, "Can't mount /selinux or /proc\n");
+			goto finished;
+		}
+		fp = fopen("/proc/filesystems", "r");
+		if(!fp)
+		{
+			fprintf(stderr, "Can't open /proc/filesystems");
+			goto err;
+		}
+		while(fgets(buf, sizeof(buf), fp))
+		{
+			if(strstr(buf, "selinuxfs"))
+			{
+				fprintf(stderr, "SE Linux is enabled but can't mount /selinux");
+				goto err;
+			}
+		}
+		fclose(fp); /* non-SE kernel */
+		goto finished;
+	}
+	if(system("/usr/sbin/load_policy /etc/security/selinux/policy.15"))
+	{
+		fprintf(stderr, "Can't load policy");
+		goto err;
+	}
+	fp = fopen("/selinux/enforce", "w");
+	if(!fp || 1 != fwrite("1", 1, 1, fp))
+	{
+		fprintf(stderr, "Can't set enforcing mode.\n");
+		goto err;
+	}
+	fclose(fp);
+	execv("/sbin/init", argv);
+	fprintf(stderr, "Can't re-exec init to get right context.\n");
+err:
+	sleep(60);
+	init_reboot(BMAGIC_HALT);
+finished:
+#endif
+
   	/* Check command line arguments */
 	maxproclen = strlen(argv[0]) + 1;
   	for(f = 1; f < argc; f++) {

--Boundary-00=_/Irk/hm0CNLT0oG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
