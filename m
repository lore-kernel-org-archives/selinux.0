Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8N6NrsJ011283
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 02:23:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8N6MAd0000701
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 06:22:10 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8N6M7VY000698
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 06:22:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 743C3C16B
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 16:23:48 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12278-04 for <selinux@tycho.nsa.gov>;
 Tue, 23 Sep 2003 16:23:45 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 85CDAC167
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 16:23:45 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 00A1E924D6
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 16:23:44 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 3FFE47F004
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 16:23:42 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setfiles performance patch
Date: Tue, 23 Sep 2003 16:23:41 +1000
References: <200309231522.25749.russell@coker.com.au>
In-Reply-To: <200309231522.25749.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tb+b/5vZjal4lPa"
Message-Id: <200309231623.41712.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_tb+b/5vZjal4lPa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 23 Sep 2003 15:22, Russell Coker wrote:
> I have attached a patch for setfiles (from the new SE Linux) to improve the
> performance.  It implements the idea I described on this list about a year
> ago.

Attached is a patch for the setfiles from the old SE Linux.

Here's the time for running the NSA version on a root file system with 157273 
files on a machine with a P3-650 CPU:
real    17m55.623s
user    15m45.300s
sys     0m14.750s

Here's the time for running my version on the same system.
real    4m58.447s
user    4m42.320s
sys     0m10.240s

Note that the cache was not hot when I ran the NSA version, and it did have to 
relabel about 30 files.

Now here's the results for a P-166 with 102592 files in the root fs:
My version:
real    2m33.416s
user    1m46.180s
sys     0m13.710s

NSA version:
real    4m42.297s
user    4m2.620s
sys     0m9.360s

NB  The difference between the real time and user+sys is that the machine in 
question is a live server.  So not all the resources of the machine go 
towards setfiles.  Also when I ran my version the cache was not hot and it 
had to relabel about 1000 files.

Now my version takes 15:45 CPU to check 157K files and 1:46 to check 102K 
files.  That is a rate of 166 files per second on a P3-650 and 962 on a 
P-166.  Either the operations that setfiles performs are seriously optimised 
for the original Pentium, the GCC 2.9.5 I used to compile for the P1 is 
better than the gcc 3.3.2 used for for the P2, or we have some performance 
issues whereby setfiles does not scale linearly to the number of files in the 
file system.  I will investigate this next and post again soon.


PS  We probably should modify setfiles to report the number of files it 
relabeled before it exits.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_tb+b/5vZjal4lPa
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="old-setfiles.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="old-setfiles.diff"

--- /tmp/selinux/setfiles/setfiles.c	2003-05-30 06:21:42.000000000 +1000
+++ setfiles.c	2003-09-23 15:28:53.000000000 +1000
@@ -116,8 +116,107 @@
 				   any meta characters.  
 				   0 = no meta chars 
 				   1 = has one or more meta chars */
+	int stem_id;		/* indicates which of the stem-compression
+				 * items it matches */
 } spec_t;
 
+typedef struct stem {
+	char *buf;
+	int len;
+} stem_t;
+
+stem_t *stem_arr = NULL;
+int num_stems = 0;
+int alloc_stems = 0;
+
+const char * const regex_chars = ".^$?*+|[({";
+
+/* Return the length of the text that can be considered the stem, returns 0
+ * if there is no identifiable stem */
+int get_stem_from_spec(const char * const buf)
+{
+	const char *tmp = strchr(buf + 1, '/');
+	const char *ind;
+
+	if(!tmp)
+		return 0;
+
+	for(ind = buf + 1; ind < tmp; ind++)
+	{
+		if(strchr(regex_chars, (int)*ind))
+			return 0;
+	}
+	return tmp - buf;
+}
+
+/* return the length of the text that is the stem of a file name */
+int get_stem_from_file_name(const char * const buf)
+{
+	const char *tmp = strchr(buf + 1, '/');
+
+	if(!tmp)
+		return 0;
+	return tmp - buf;
+}
+
+/* find the stem of a file spec, returns the index into stem_arr for a new
+ * or existing stem, (or -1 if there is no possible stem - IE for a file in
+ * the root directory or a regex that is too complex for us).  Makes buf
+ * point to the text AFTER the stem. */
+int find_stem_from_spec(const char **buf)
+{
+	int i;
+	int stem_len = get_stem_from_spec(*buf);
+
+	if(!stem_len)
+		return -1;
+	for(i = 0; i < num_stems; i++)
+	{
+		if(stem_len == stem_arr[i].len && !strncmp(*buf, stem_arr[i].buf, stem_len))
+		{
+			*buf += stem_len;
+			return i;
+		}
+	}
+	if(num_stems == alloc_stems)
+	{
+		alloc_stems = alloc_stems * 2 + 16;
+		stem_arr = realloc(stem_arr, sizeof(stem_t) * alloc_stems);
+		if(!stem_arr)
+			exit(1);
+	}
+	stem_arr[num_stems].len = stem_len;
+	stem_arr[num_stems].buf = malloc(stem_len + 1);
+	if(!stem_arr[num_stems].buf)
+		exit(1);
+	memcpy(stem_arr[num_stems].buf, *buf, stem_len);
+	stem_arr[num_stems].buf[stem_len] = '\0';
+	num_stems++;
+	*buf += stem_len;
+	return num_stems - 1;
+}
+
+/* find the stem of a file name, returns the index into stem_arr (or -1 if
+ * there is no match - IE for a file in the root directory or a regex that is
+ * too complex for us).  Makes buf point to the text AFTER the stem. */
+int find_stem_from_file(const char **buf)
+{
+	int i;
+	int stem_len = get_stem_from_file_name(*buf);
+
+	if(!stem_len)
+		return -1;
+	for(i = 0; i < num_stems; i++)
+	{
+		if(stem_len == stem_arr[i].len && !strncmp(*buf, stem_arr[i].buf, stem_len))
+		{
+			*buf += stem_len;
+			return i;
+		}
+	}
+	return -1;
+}
+
 /*
  * The array of specifications, initially in the
  * same order as in the specification file.
@@ -286,8 +385,9 @@
 
 int match(const char *name, struct stat *sb, security_id_t *out_sid) 
 {
-	int i, ret;
+	int i, ret, file_stem;
 	const char *fullname = name;
+	const char *buf = name;
 
 	/* fullname will be the real file that gets labeled
 	 * name will be what is matched in the policy */
@@ -311,25 +411,34 @@
 		return -1;
 	}
 
+	file_stem = find_stem_from_file(&buf);
+
 	/* 
 	 * Check for matching specifications in reverse order, so that
 	 * the last matching specification is used.
 	 */
-	for (i = nspec - 1; i >= 0; i--) {
-		ret = regexec(&spec[i].regex, name, 0, NULL, 0);
-		if (ret == 0 &&
-		    (!spec[i].mode
-		     || (sb->st_mode & S_IFMT) == spec[i].mode)) break;
-		if (ret) {
-			if (ret == REG_NOMATCH)
-				continue;
-			regerror(ret, &spec[i].regex, errbuf,
-				 sizeof errbuf);
-			fprintf(stderr,
-				"%s:  unable to match %s against %s:  %s\n",
-				progname, name, spec[i].regex_str,
-				errbuf);
-			return -1;
+	for (i = nspec - 1; i >= 0; i--)
+	{
+		if(spec[i].stem_id == -1 || spec[i].stem_id == file_stem)
+		{
+			if(spec[i].stem_id == -1)
+				ret = regexec(&spec[i].regex, name, 0, NULL, 0);
+			else
+				ret = regexec(&spec[i].regex, buf, 0, NULL, 0);
+			if (ret == 0 &&
+		    	(!spec[i].mode
+		     	|| (sb->st_mode & S_IFMT) == spec[i].mode)) break;
+			if (ret) {
+				if (ret == REG_NOMATCH)
+					continue;
+				regerror(ret, &spec[i].regex, errbuf,
+				 	sizeof errbuf);
+				fprintf(stderr,
+					"%s:  unable to match %s against %s:  %s\n",
+					progname, name, spec[i].regex_str,
+					errbuf);
+				return -1;
+			}
 		}
 	}
 
@@ -796,10 +905,12 @@
 
 			if (pass == 1) {
 				/* On the second pass, compile and store the specification in spec. */
+				const char *buf = regex;
+				spec[nspec].stem_id = find_stem_from_spec(&buf);
 				spec[nspec].regex_str = regex;
 
 				/* Anchor the regular expression. */
-				len = strlen(regex);
+				len = strlen(buf);
 				anchored_regex = malloc(len + 3);
 				if (!anchored_regex) {
 					fprintf(stderr,
@@ -807,7 +918,7 @@
 						argv[0], lineno);
 					exit(1);
 				}
-				sprintf(anchored_regex, "^%s$", regex);
+				sprintf(anchored_regex, "^%s$", buf);
 
 				/* Compile the regular expression. */
 				regerr =

--Boundary-00=_tb+b/5vZjal4lPa--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
