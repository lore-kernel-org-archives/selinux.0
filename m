Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8N5McsJ011103
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 01:22:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8N5Ksd0028225
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 05:20:54 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8N5KpVY028220
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 05:20:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles performance patch
Date: Tue, 23 Sep 2003 15:22:25 +1000
Cc: "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ri9b/H7Vg7P0IdR"
Message-Id: <200309231522.25749.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Ri9b/H7Vg7P0IdR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have attached a patch for setfiles (from the new SE Linux) to improve the 
performance.  It implements the idea I described on this list about a year 
ago.

When reading through the list of specifications for every spec that has no 
regex characters before the second '/' it will implement stem compression 
(that is the majority of entries).  The stem compression method is to create 
an array of stems (the part of the spec before the second '/' and store with 
each regex which of the stems applies.

Then when comparing a file it checks it's stem against the array.  The 
regexec() library function will only be called when the spec has no stem (IE 
it has a regex starting before the second '/' or it's in the root directory) 
or when the stem index of the file and the spec both match (EG they both 
start with "/var/").

The result of this is that the number of regexec() function calls is hugely 
decreased, and for each regexec() call only the part after the stem is 
checked.  So if we want to check whether the file "/var/lib/foo" matches spec 
"/var/log/atsar(/.*)?" the regexec() function will compare "/lib/foo" with
"/log/atsar(/.*)?", I imagine that this may also reduce the time taken for 
regexec but have not tested it.

I did a quick test on a machine with a 4G ext3 root file system that has 
168552 inodes.  As it's a root file system a good balance of the different 
specs is used, also this made a good test as I had previously run the NSA 
setfiles so when my setfiles program gave the same results I concluded that 
it was bug free.

The test machine has a P2-400 CPU and 192M of RAM.  Most of the test ran out 
of cache so a test on a cold machine would probably have more disk access 
delays.  Also the tests were done on a system that already had the correct 
contexts for all files so nothing was written.  Again if there was a need to 
write something (the usual case) then it would be slower.

The NSA version had the following results:
real    14m8.375s
user    12m53.800s
sys     1m6.310s

My version gives this:
real    4m14.511s
user    3m16.810s
sys     0m48.470s

So I have reduced the CPU use by a factor of 4, which (in this instance) 
increases the overall speed by a factor of 3.

I did some tests with the "-s" option and labeling a single file.  I expected 
that my version would be slower than the NSA version for this due to the 
overhead of finding the stems.  However according to "time" my version took 
0.18 seconds while the NSA version took 0.20 (and this was repeated over a 
dozen runs).  So I conclude that there is no situation in which my version is 
slower than the NSA version.

One thing I am now considering is the possibility of having two levels of 
stems, separating the /var/log, /var/run, and /var/lib entries may offer some 
more performance.  I won't bother at this stage, I am reasonably happy with 
making it 3 times faster (although I had been hoping to make it 4 times 
faster) and I don't want to make the code too ugly.

The next thing I am thinking of is the possibility of having it fork off 
another two processes for disk IO.  Then one process could do all disk reads 
while another could do all disk writes.  This would mean that in situations 
where the data is not all in cache (real-world use) the process that 
determines labels could use 100% CPU time instead of the 50% CPU time I 
expect to see when I try out my setfiles on more real-world tests.  Stephen 
Tweedie, do you have any comments on this?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Ri9b/H7Vg7P0IdR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="setfiles.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="setfiles.diff"

Binary files setfiles.orig/setfiles and setfiles/setfiles differ
diff -ru setfiles.orig/setfiles.c setfiles/setfiles.c
--- setfiles.orig/setfiles.c	2003-08-27 20:26:38.000000000 +1000
+++ setfiles/setfiles.c	2003-09-23 14:53:22.000000000 +1000
@@ -99,8 +99,107 @@
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
@@ -266,7 +365,8 @@
 
 int match(const char *name, struct stat *sb)
 {
-	int i, ret;
+	int i, ret, file_stem;
+	const char *buf = name;
 
 	ret = lstat(name, sb);
 	if (ret) {
@@ -275,25 +375,34 @@
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
 
@@ -631,10 +740,12 @@
 
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
@@ -642,7 +753,7 @@
 						argv[0], lineno);
 					exit(1);
 				}
-				sprintf(anchored_regex, "^%s$", regex);
+				sprintf(anchored_regex, "^%s$", buf);
 
 				/* Compile the regular expression. */
 				regerr =
Binary files setfiles.orig/setfiles.o and setfiles/setfiles.o differ

--Boundary-00=_Ri9b/H7Vg7P0IdR--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
