Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p814BdFJ001714
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 00:11:39 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p814Bbjt003448
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 04:11:38 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7E01618022
	for <selinux@tycho.nsa.gov>; Thu,  1 Sep 2011 14:11:29 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: no new-line in setfiles/restorecon patch
Date: Thu, 1 Sep 2011 14:11:32 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0XwXOpZTkStPBVN"
Message-Id: <201109011411.32863.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_0XwXOpZTkStPBVN
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

New-lines just look ugly when the screen width isn't 80 columns.  Knowing 
exactly how much progress we have made in increments of 80,000 isn't that 
useful IMHO.

As an aside, I've been considering patching it to display "12345" instead of 
"*****" as the progress.  If you think this is a good idea then let me know 
and I'll submit a patch to do it.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--Boundary-00=_0XwXOpZTkStPBVN
Content-Type: text/x-patch;
  charset="UTF-8";
  name="nonl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nonl.diff"

--- policycoreutils-2.1.0.orig/setfiles/restore.c
+++ policycoreutils-2.1.0/setfiles/restore.c
@@ -114,10 +114,6 @@
 
 	if (r_opts->progress) {
 		r_opts->count++;
-		if (r_opts->count % (80 * STAR_COUNT) == 0) {
-			fprintf(stdout, "\n");
-			fflush(stdout);
-		}
 		if (r_opts->count % STAR_COUNT == 0) {
 			fprintf(stdout, "*");
 			fflush(stdout);

--Boundary-00=_0XwXOpZTkStPBVN--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
