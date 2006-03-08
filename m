Subject: Re: libsemanage/src/semanage_store.c:semanage_split_fc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <440CE9FF.2090201@cornell.edu>
References: <20060306221519.GA25033@sergelap.austin.ibm.com>
	 <440CE9FF.2090201@cornell.edu>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 10:05:01 -0500
Message-Id: <1141830301.6157.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-03-06 at 21:03 -0500, Ivan Gyurdiev wrote:
> Serge E. Hallyn wrote:
> > In semanage_split_fc(), linex 887 and 893, the file_con fd is not closed
> > on error.  Trivial patch follows.
> >
> >   
> There's already a cleanup: goto target, I think that should be used instead
> (after initializing the file descriptors, and making the close 
> statements conditional).
> 
> It'd be nice if close(-1) and fclose(NULL) were no-ops.

Like this?

Index: libsemanage/src/semanage_store.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/semanage_store.c,v
retrieving revision 1.43
diff -u -p -r1.43 semanage_store.c
--- libsemanage/src/semanage_store.c	15 Feb 2006 16:23:45 -0000	1.43
+++ libsemanage/src/semanage_store.c	8 Mar 2006 14:46:51 -0000
@@ -871,27 +871,26 @@ hidden_def(semanage_reload_policy)
 
 /* This expands the file_context.tmpl file to file_context and homedirs.template */
 int semanage_split_fc(semanage_handle_t *sh) {
-	FILE *file_con;
-	int fc, hd, retval = 0;
+	FILE *file_con = NULL;
+	int fc = -1, hd = -1, retval = -1;
 	char buf[PATH_MAX] = {0};
 
 	/* I use fopen here instead of open so that I can use fgets which only reads a single line */
 	file_con = fopen(semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL), "r");
 	if (!file_con) {
 		ERR(sh, "Could not open %s for reading.", semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL));
-		return -1;
+		goto cleanup;
 	}
 
 	fc = open(semanage_path(SEMANAGE_TMP, SEMANAGE_FC), O_WRONLY | O_CREAT | O_TRUNC,  S_IRUSR | S_IWUSR);
 	if (!fc) {
 		ERR(sh, "Could not open %s for writing.", semanage_path(SEMANAGE_TMP, SEMANAGE_FC));
-		return -1;
+		goto cleanup;
 	}
 	hd = open(semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL), O_WRONLY | O_CREAT | O_TRUNC,  S_IRUSR | S_IWUSR);
 	if (!hd) {
 		ERR(sh, "Could not open %s for writing.", semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
-		close(fc);
-		return -1;
+		goto cleanup;
 	}
 
 	while (fgets_unlocked(buf, PATH_MAX, file_con)) {
@@ -901,22 +900,24 @@ int semanage_split_fc(semanage_handle_t 
 			/* This contains one of the template variables, write it to homedir.template */
 			if (write(hd, buf, strnlen(buf, PATH_MAX)) == 0) {
 				ERR(sh, "Write to %s failed.", semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
-				retval = -1;
 				goto cleanup;
 			}
 		} else {
 			if (write(fc, buf, strnlen(buf, PATH_MAX)) == 0) {
 				ERR(sh, "Write to %s failed.", semanage_path(SEMANAGE_TMP, SEMANAGE_FC));
-				retval = -1;	
 				goto cleanup;
 			}
 		}
 	}
-	
+
+	retval = 0;
 cleanup:
-	fclose(file_con);
-	close(fc);
-	close(hd);	
+	if (file_con)
+		fclose(file_con);
+	if (fc >= 0)
+		close(fc);
+	if (hd >= 0)
+		close(hd);
 
 	return retval;
 		

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
