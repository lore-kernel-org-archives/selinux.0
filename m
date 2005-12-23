Message-ID: <43AC883F.6000600@cornell.edu>
Date: Fri, 23 Dec 2005 18:29:03 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SETSEBOOL] Miscellaneous cleanups
Content-Type: multipart/mixed;
 boundary="------------090104050107010509030907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090104050107010509030907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remove unused ret variable causing confusion.
Simplify handling of strdup failure - the only reason strdup will fail 
is OMEM,
in which case there's no reason to go into detail regarding exactly 
which boolean failed.


--------------090104050107010509030907
Content-Type: text/x-patch;
 name="setsebool.misc_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setsebool.misc_cleanup.diff"

diff -Naurp --exclude-from excludes old/policycoreutils/setsebool/setsebool.c new/policycoreutils/setsebool/setsebool.c
--- old/policycoreutils/setsebool/setsebool.c	2005-11-09 08:49:41.000000000 -0500
+++ new/policycoreutils/setsebool/setsebool.c	2005-12-23 18:17:08.000000000 -0500
@@ -173,16 +173,14 @@ static int semanage_set_boolean_list(
 int setbool(char **list, size_t start, size_t end)
 {
 	char *name, *value_ptr;
-	int ret=0, j=0, value;
+	int j=0, value;
 	size_t i = start;
 	size_t boolcnt=end-start;
 	struct passwd *pwd;
 	SELboolean *vallist=calloc(boolcnt, sizeof(SELboolean));
-	if (!vallist) {
-		fprintf(stderr, 
-			"Error setting booleans: %s\n", strerror(errno));
-		return 1;
-	}
+	if (!vallist)
+		goto omem;
+
 	while (i < end) {
 		name = list[i];
 		value_ptr = strchr(list[i], '=');
@@ -190,7 +188,6 @@ int setbool(char **list, size_t start, s
 			fprintf(stderr, 
 			"setsebool: '=' not found in boolean expression %s\n",
 				list[i]);
-			ret=4;
 			goto err;
 		}
 		*value_ptr = 0;
@@ -202,21 +199,16 @@ int setbool(char **list, size_t start, s
 				strcasecmp(value_ptr, "false") == 0)
 			value = 0;
 		else {
-			fprintf(stderr, "setsebool: illegal boolean value %s\n",
-				value_ptr);
-			ret=1;
+			fprintf(stderr, "setsebool: illegal value "
+					"%s for boolean %s\n",
+					value_ptr, name);
 			goto err;
 		}
 
 		vallist[j].value = value;
 		vallist[j].name = strdup(name);
-		if (!vallist[j].name) {
-			fprintf(stderr, 
-				"Error setting boolean %s to value %d (%s)\n", 
-				name, value, strerror(errno));
-			ret= 2;
-			goto err;
-		}
+		if (!vallist[j].name)
+			goto omem;
 		i++;
 		j++;
 
@@ -257,7 +249,10 @@ int setbool(char **list, size_t start, s
 		free(vallist[i].name);
 	free(vallist);
 	return 0;
-				
+		
+	omem:
+	fprintf(stderr, "setsebool: out of memory");
+		
 	err:
 	for (i=0; i < boolcnt; i++) 
 		free(vallist[i].name);

--------------090104050107010509030907--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
