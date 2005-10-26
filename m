Subject: [PATCH] Sort file contexts
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-w1Odb3ntbSsLzRRkhYxB"
Date: Wed, 26 Oct 2005 15:47:47 -0400
Message-Id: <1130356067.7724.6.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-w1Odb3ntbSsLzRRkhYxB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch changes matchpathcon to sort the file contexts according to a previous email from
Chris PeBenito:

---
To try to fix this we looked for regular expression sorting algorithms,
but pretty much came up empty.  So we wrote support/fc_sort.c to do a
stable sort (merge sort) with this comparison function:

1. does one have a meta chars and the other not
2. length of the spec up to the first meta char
3. length of the entire spec
4. does one have a specific file type (--, -d, etc.) and the other not
---




--=-w1Odb3ntbSsLzRRkhYxB
Content-Disposition: attachment; filename=1-fcsort-merge.diff
Content-Type: text/x-patch; name=1-fcsort-merge.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn libselinux/src/matchpathcon.c libselinux/src/matchpathcon.c
--- libselinux/src/matchpathcon.c	2005-10-11 13:50:00.000000000 -0400
+++ libselinux/src/matchpathcon.c	2005-10-26 14:26:49.000000000 -0400
@@ -110,7 +110,7 @@ typedef struct spec {
 	int hasMetaChars; 	/* indicates whether the RE has 
 				   any meta characters.  
 				   0 = no meta chars 
-				   1 = has one or more meta chars */
+				   Non 0 = has meta chars and is position of meta char */
 	int stem_id;		/* indicates which of the stem-compression
 				 * items it matches */
 } spec_t;
@@ -438,7 +438,7 @@ static void spec_hasMetaChars(struct spe
 			case '[':
 			case '(':
 			case '{':
-				spec->hasMetaChars = 1;
+				spec->hasMetaChars = c - spec->regex_str;
 				return;
 			case '\\':		/* skip the next character */
 				c++;
@@ -593,6 +593,115 @@ static int process_line( const char *pat
 	return 0;
 }
 
+/* Compares two spec regular expressions for specificity
+ * Returns -1 if a < b, 0 if a == b, or 1 if a > b */
+static int spec_compare(spec_t *a, spec_t *b)
+{
+	int a_len, b_len;
+
+	/* Check to see if either a or b have meta characters
+	 * and the other does not */
+	if(a->hasMetaChars && !b->hasMetaChars)
+		return -1;
+	if(b->hasMetaChars && !a->hasMetaChars)
+		return 1;
+
+	/* Check to see if either a or b have a shorter stem
+	 * length than the other, if they have meta characters */
+	if (a->hasMetaChars < b->hasMetaChars)
+		return -1;
+	if (b->hasMetaChars < a->hasMetaChars)
+		return 1;
+
+	/* Check to see if either a or b have a shorter string
+	 * length than the other */
+	a_len = strlen(a->regex_str);
+	b_len = strlen(b->regex_str);
+	if(a_len < b_len)
+		return -1;
+	if(b_len < a_len)
+		return 1;
+
+	/* Check to see if either a or b has a specified type
+	 * and the other does not */
+	if(!a->type_str && b->type_str)
+		return -1;
+	if(!b->type_str && a->type_str)
+		return 1;
+
+	/* If none of the above conditions were satisfied, 
+	 * then a and b are equally specific. */
+	return 0;
+}
+
+/* Uses the compare function and merge sort to sort the list of file contexts */
+static int spec_merge_sort(spec_t *start, spec_t *finish)
+{
+	spec_t *tmp;
+	spec_t *tmp_finish;
+	spec_t *center;
+	spec_t *cur_left;
+	spec_t *cur_right;
+	spec_t *cur;
+
+	if(finish - start > 0) {
+		/* Split the spec array into two pieces and merge sort them */
+		center = (finish - start)/2 + start;
+		if(spec_merge_sort(start, center) == -1 || 
+			spec_merge_sort(center + 1, finish) == -1) {
+			return -1;
+		}
+
+		/* Generate a temporary array for the first half of the array */
+		tmp = malloc((center - start + 1) * sizeof(spec_t));
+		if(!tmp) {
+			return -1;
+		}
+
+		tmp_finish = tmp + (center - start);
+		memcpy(tmp, start, (center - start + 1) * sizeof(spec_t));
+
+		/* cur will move along the original array */
+		cur = start;
+
+		/* cur_left will move along the temporary array (left side) */
+		cur_left = tmp;
+
+		/* cur_right will move along the right side of the original
+		 * array */
+		cur_right = center + 1;
+
+		/* Merge the temporary array and the right side of the
+		 * original array into the original array */
+		while(cur < cur_right && cur_right <= finish) {
+			/* If cur_left's data is less than or equal to
+			 * cur_right's then copy over the cur_left's data in the
+			 * temporary array to cur's data in the original array */
+			if(spec_compare(cur_left, cur_right) <= 0) {
+				memcpy(cur, cur_left, sizeof(spec_t));
+				cur_left++;
+			}
+			/* Otherwise, copy cur_right's data in the right side
+			 * of the original array to cur's data in the original
+			 * array */
+			else {
+				memcpy(cur, cur_right, sizeof(spec_t));
+				cur_right++;
+			}
+			cur++;
+		}
+
+		/* Copy over the leftovers in the temporary array */
+		if(tmp_finish >= cur_left) {
+			memcpy(cur, cur_left, (tmp_finish - cur_left + 1) * sizeof(spec_t));
+		}
+
+		free(tmp);
+	}
+
+	return 0;
+}
+
 int matchpathcon_init(const char *path)
 {
 	FILE *fp;
@@ -602,8 +711,7 @@ int matchpathcon_init(const char *path)
 	char homedir_path[PATH_MAX + 1];
 	char *line_buf = NULL;
 	size_t line_len = 0;
-	unsigned int lineno, pass, i, j, maxnspec;
-	spec_t *spec_copy=NULL;
+	unsigned int lineno, pass, maxnspec;
 	int status=-1;
 	int mls_enabled=is_selinux_mls_enabled();
 
@@ -673,28 +781,16 @@ int matchpathcon_init(const char *path)
 	}
 	free(line_buf);
 
-	/* Move exact pathname specifications to the end. */
-	spec_copy = malloc(sizeof(spec_t) * nspec);
-	if (!spec_copy)
-		goto finish;
-	j = 0;
-	for (i = 0; i < nspec; i++) {
-		if (spec_arr[i].hasMetaChars)
-			memcpy(&spec_copy[j++], &spec_arr[i], sizeof(spec_t));
+	/* Sort specifications */
+	if( spec_merge_sort(spec_arr, spec_arr + nspec - 1) == -1){
+		myprintf("%s:  out of memory during file context sort"); 
 	}
-	for (i = 0; i < nspec; i++) {
-		if (!spec_arr[i].hasMetaChars)
-			memcpy(&spec_copy[j++], &spec_arr[i], sizeof(spec_t));
-	}
-	free(spec_arr);
-	spec_arr = spec_copy;
-
+	
 	nodups_specs(path);
 
 	status = 0;
  finish:
 	fclose(fp);
-	if (spec_arr != spec_copy) free(spec_arr);
 	if (homedirfp) fclose(homedirfp);
 	if (localfp) fclose(localfp);
 	return status;

--=-w1Odb3ntbSsLzRRkhYxB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
