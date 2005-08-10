Date: Wed, 10 Aug 2005 16:45:49 -0500
From: serue@us.ibm.com
To: SELinux@tycho.nsa.gov
Subject: [PATCH] Free alloc'ed memory on error path in matchpathcon_filespec_add
Message-ID: <20050810214549.GG7826@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a trivial bug found in matchpathcon.c by Coverity:

	When matchpathcon_filespec_add() fails to allocate fl->file
	and jumps to oom:, it fails to free fl which was malloced
	immedately above.  Jump to oom_freefl: instead and free it.

Index: src/matchpathcon.c
===================================================================
--- src.orig/matchpathcon.c
+++ src/matchpathcon.c
@@ -274,11 +274,13 @@ int matchpathcon_filespec_add(ino_t ino,
 	fl->specind = specind;
 	fl->file = malloc(strlen(file) + 1);
 	if (!fl->file)
-		goto oom;
+		goto oom_freefl;
 	strcpy(fl->file, file);
 	fl->next = prevfl->next;
 	prevfl->next = fl;
 	return fl->specind;
+oom_freefl:
+	free(fl);
 oom:
 	myprintf("%s:  insufficient memory for file label entry for %s\n",
 		 __FUNCTION__, file);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
