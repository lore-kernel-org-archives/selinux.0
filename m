Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h927XgsJ001126
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 03:33:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h927VqZt006369
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 07:31:52 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h927VlM3006366
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 07:31:48 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B38CC924F2
	for <selinux@tycho.nsa.gov>; Thu,  2 Oct 2003 17:33:24 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 3EBC47F004
	for <selinux@tycho.nsa.gov>; Thu,  2 Oct 2003 17:33:22 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles performance
Date: Thu, 2 Oct 2003 17:33:21 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BT9e/mnfSn0yG5Z"
Message-Id: <200310021733.21601.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_BT9e/mnfSn0yG5Z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have gone through all the file contexts entries and put in types wherever 
possible.  I have also made a modified version of setfiles that checks the 
type before doing a regex check.

Here's a matrix of times:
                  old file contexts  |  new file contexts
setfiles-stem          83.2s         |      78.7s
setfiles-latest        83.5s         |      72.2s

The results are for the user time on a 2075MHz Athlon (XP 2600) with a root 
file system of 122461 Inodes.

Here's a matrix for a P2-400 with 168477 Inodes:
                  old file contexts  |  new file contexts
setfiles-stem         202.6s         |      201.8s
setfiles-latest       199.7s         |      181.7s


setfiles-stem is setfiles with the stem compression patch, setfiles-latest is 
with stem compression and the type check.

When adding type specifiers to most entries in the file_contexts I changed the 
labeling of some nodes.  For consistent testing I did not want any relabeling 
so I added some matching entries to the old file contexts file, so what I 
describe as "old file contexts" is something like 5% of the way towards 
having all the types specified (as it specifies some of the most important 
entries).  Therefore the performance difference between the old and new file 
contexts is not as great as it might be.  I believe that this is why the 
-latest version is slightly faster than the -stem version for the "old file 
contexts" on the P2-400.  I can only guess that the relative cost of a regex 
on an Athlon is not as great as on a P2-400.

I can't understand why the new file contexts would give marginally better 
performance than the old file contexts with setfiles-stem.  However I have 
them both providing the same results (setfiles -v indicates that when I run 
one and then the other nothing changes), so the results are OK.  I have 
tested this on both Debian and Red Hat machines (very important, some file 
names are different).

The new setfiles is between 8% and 14% faster with the new file contexts 
depending on how you are counting.  This combined with the fact that the file 
contexts conversion resulted in finding some minor bugs in file specs (and 
makes it less likely that such bugs will appear in future) makes me 
reasonably happy with the result.  Also my work in changing the file contexts 
is not complete as I don't know the types of some of the files in question, I 
expect that with some more changes to the file_contexts we could make it 
another few percent faster.

NB The Athlon runs the old SE Linux, but I don't think that affects the 
results.

I have attached a patch for the setfiles in new SE Linux named setfiles.diff, 
and a patch for the setfiles in the old SE Linux named setfiles-old.diff.  
Both patches expect that my stem compression patch will already be applied.

I have also attached my latest file_contexts tree as it's easier to attach an 
archive than a huge diff file.  It does reference some a few types that 
aren't defined in the policy yet, so a few minor tweaks will be needed if you 
want to just replace your file contexts.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_BT9e/mnfSn0yG5Z
Content-Type: text/x-diff;
  charset="us-ascii";
  name="setfiles.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="setfiles.diff"

diff -ru ../setfiles.new/setfiles.c ./setfiles.c
--- ../setfiles.new/setfiles.c	2003-09-23 14:53:22.000000000 +1000
+++ ./setfiles.c	2003-10-02 15:28:57.000000000 +1000
@@ -383,26 +383,28 @@
 	 */
 	for (i = nspec - 1; i >= 0; i--)
 	{
-		if(spec[i].stem_id == -1 || spec[i].stem_id == file_stem)
+		/* if the spec in question matches no stem or has the same
+		 * stem as the file AND if the spec in question has no mode
+		 * specified or if the mode matches the file mode then we do
+		 * a regex check	*/
+		if( (spec[i].stem_id == -1 || spec[i].stem_id == file_stem)
+		  && (!spec[i].mode || ( (sb->st_mode & S_IFMT) == spec[i].mode ) ) )
 		{
 			if(spec[i].stem_id == -1)
 				ret = regexec(&spec[i].regex, name, 0, NULL, 0);
 			else
 				ret = regexec(&spec[i].regex, buf, 0, NULL, 0);
-			if (ret == 0 &&
-		    	(!spec[i].mode
-		     	|| (sb->st_mode & S_IFMT) == spec[i].mode)) break;
-			if (ret) {
-				if (ret == REG_NOMATCH)
-					continue;
-				regerror(ret, &spec[i].regex, errbuf,
-				 	sizeof errbuf);
-				fprintf(stderr,
-					"%s:  unable to match %s against %s:  %s\n",
-					progname, name, spec[i].regex_str,
-					errbuf);
-				return -1;
-			}
+			if (ret == 0)
+				break;
+
+			if (ret == REG_NOMATCH)
+				continue;
+			/* else it's an error */
+			regerror(ret, &spec[i].regex, errbuf, sizeof errbuf);
+			fprintf(stderr,
+				"%s:  unable to match %s against %s:  %s\n",
+				progname, name, spec[i].regex_str, errbuf);
+			return -1;
 		}
 	}
 

--Boundary-00=_BT9e/mnfSn0yG5Z
Content-Type: text/x-diff;
  charset="us-ascii";
  name="setfiles-old.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="setfiles-old.diff"

diff -ru /home/rjc/selinux/selinux-small-2003081307/setfiles/setfiles.c ./setfiles.c
--- /home/rjc/selinux/selinux-small-2003081307/setfiles/setfiles.c	2003-09-23 15:28:53.000000000 +1000
+++ ./setfiles.c	2003-10-02 12:43:08.000000000 +1000
@@ -419,26 +419,27 @@
 	 */
 	for (i = nspec - 1; i >= 0; i--)
 	{
-		if(spec[i].stem_id == -1 || spec[i].stem_id == file_stem)
+		/* if the spec in question matches no stem or has the same
+		 * stem as the file AND if the spec in question has no mode
+		 * specified or if the mode matches the file mode then we do
+		 * a regex check        */
+		if( (spec[i].stem_id == -1 || spec[i].stem_id == file_stem)
+		  && (!spec[i].mode || ( (sb->st_mode & S_IFMT) == spec[i].mode ) ) )
+
 		{
 			if(spec[i].stem_id == -1)
 				ret = regexec(&spec[i].regex, name, 0, NULL, 0);
 			else
 				ret = regexec(&spec[i].regex, buf, 0, NULL, 0);
-			if (ret == 0 &&
-		    	(!spec[i].mode
-		     	|| (sb->st_mode & S_IFMT) == spec[i].mode)) break;
-			if (ret) {
-				if (ret == REG_NOMATCH)
-					continue;
-				regerror(ret, &spec[i].regex, errbuf,
-				 	sizeof errbuf);
-				fprintf(stderr,
-					"%s:  unable to match %s against %s:  %s\n",
-					progname, name, spec[i].regex_str,
-					errbuf);
-				return -1;
-			}
+			if (ret == 0)
+				break;
+			if (ret == REG_NOMATCH)
+				continue;
+			regerror(ret, &spec[i].regex, errbuf, sizeof errbuf);
+			fprintf(stderr,
+				"%s:  unable to match %s against %s:  %s\n",
+				progname, name, spec[i].regex_str, errbuf);
+			return -1;
 		}
 	}
 

--Boundary-00=_BT9e/mnfSn0yG5Z
Content-Type: application/x-tgz;
  name="file_contexts.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="file_contexts.tgz"

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
r/8HNnDE1gDQAgA=

--Boundary-00=_BT9e/mnfSn0yG5Z--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
