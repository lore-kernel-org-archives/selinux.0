Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1ODSDRb022863
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 08:28:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1ODSCQQ005973
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 13:28:12 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1ODSCP0005970 for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 13:28:12 GMT
Subject: Re: odd segfault in checkpolicy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1077577191.4374.9.camel@nexus.verbum.private>
References: <1077577191.4374.9.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1077629291.21221.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Feb 2004 08:28:11 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-02-23 at 17:59, Colin Walters wrote:
> I've been trying to track down an odd segfault when checkpolicy is
> compiled without optimization, but I've been looking at the code for
> like an hour and a half now and I just can't see the problem.  Here's
> some debugging information:
<snip>
> Does anyone have any ideas?  Can anyone else reproduce this?

Yes.  Patch below.  Since checkpolicy is rewriting the buffer in place
(to perform endian conversion), it needs to map the policy file
read-write and private, rather than read-only and shared.

Index: checkpolicy/checkpolicy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/checkpolicy.c,v
retrieving revision 1.16
diff -u -r1.16 checkpolicy.c
--- checkpolicy/checkpolicy.c	4 Feb 2004 19:31:17 -0000	1.16
+++ checkpolicy/checkpolicy.c	24 Feb 2004 13:24:45 -0000
@@ -502,7 +502,7 @@
 				file, strerror(errno));
 			exit(1);
 		}
-		map = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, fd, 0);
+		map = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 		if (map == MAP_FAILED) {
 			fprintf(stderr, "Can't map '%s':  %s\n",
 				file, strerror(errno));


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
