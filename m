Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9OL9bWt017261
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 17:09:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9OL9OIS006351
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 21:09:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9OL9ODc006348
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 21:09:24 GMT
Subject: Re: [PATCH] libselinux-3
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031024190812.GA10572@wavehammer.waldi.eu.org>
References: <20031023215434.GA24235@wavehammer.waldi.eu.org>
	 <20031024190812.GA10572@wavehammer.waldi.eu.org>
Content-Type: text/plain
Message-Id: <1067029773.6209.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 24 Oct 2003 17:09:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-24 at 15:08, Bastian Blank wrote:
> updated patch.

@@ -366,13 +366,13 @@
 	if (!ptr)
 		return -1;
 	plen = strlen(ptr);
-	if (buf[plen-1] == '\n') 
+	if (plen > 1 && buf[plen-1] == '\n') 
 		buf[plen-1] = 0;

I believe that the original code is correct, and that the patch
introduces a minor bug.  If the file is empty, ptr will be NULL and the
!ptr test will catch it. Hence, plen should always be at least 1. 
Further, your test for plen > 0 means that you won't clear the newline
in the case where the file contains only a newline and nothing else,
i.e. plen == 1 and buf[0] == '\n'.  

@@ -23,11 +23,11 @@
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
-		size = fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
-		if (size < 0)
+		ret = fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
+		if (ret < 0)
 			goto out;
 
-		size++;
+		size = ret + 1;
 		newbuf = realloc(buf, size);
 		if (!newbuf)
 			goto out;

As with the earlier patch for the *getfilecon functions, this
one introduces a bug.  Look at the result of this patch when
the realloc fails; since ret is reset by your change, the
out path will not treat it as an error, and the caller will
be returned garbage without any indication that the call
actually failed.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
