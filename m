Subject: Re: [PATCH] semanage - rename instead of copy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1131456888.20591.176.camel@moss-spartans.epoch.ncsc.mil>
References: <1131398734.21419.3.camel@twoface.columbia.tresys.com>
	 <1131399305.20591.151.camel@moss-spartans.epoch.ncsc.mil>
	 <436FCC19.6020700@tresys.com>
	 <1131456888.20591.176.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-I2W4DA8O3fq/d4hX3IN9"
Date: Tue, 08 Nov 2005 09:05:22 -0500
Message-Id: <1131458722.20591.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-I2W4DA8O3fq/d4hX3IN9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-11-08 at 08:34 -0500, Stephen Smalley wrote:
> On Mon, 2005-11-07 at 16:50 -0500, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > If you want to check for failure on the snprintf, you need something like:
> > > 	int n = snprintf(tmp, PATH_MAX, "%s.tmp", dst);
> > > 	if (n < 0 || n >= PATH_MAX)
> > > 		return -1;
> > > 
> > good point, also strlen(dst) can't be PATH_MAX or the filename will be 
> > truncated and you'll end up with rename(dst,dst).
> 
> That should be caught by the n >= PATH_MAX test above for the snprintf;
> from the man page: "If the output was truncated due to this limit then
> the return value is the number of characters (not including the trailing
> '\0') which would have been written to the final string if enough space
> had been available.  Thus, a return value of size or more means that the
> output was truncated.  If an output error is encountered, a negative
> value is returned."  
> 
> >  Do you want a new 
> > patch or are you going to fix this before commiting?
> 
> I'll make the adjustment above, and then commit it.

Interdiff below.  Four bug fixes: 1) corrected snprintf error checking,
2) moved snprintf prior to first open so that we don't leak a descriptor
on error path, 3) added error checking for close of output file (doesn't
matter for input, but could indicate truncation of output data), 4)
prevent rename if there was an earlier error, since error path falls
through presently for read/write errors.

-- 
Stephen Smalley
National Security Agency

--=-I2W4DA8O3fq/d4hX3IN9
Content-Disposition: attachment; filename=rename-files.interdiff
Content-Type: text/x-patch; name=rename-files.interdiff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -u libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2005-11-07 16:06:04.000000000 -0500
+++ libsemanage/src/semanage_store.c	8 Nov 2005 14:39:24 -0000
@@ -304,18 +304,18 @@
 /* Copies a file from src to dst.  If dst already exists then
  * overwrite it.  Returns 0 on success, -1 on error. */
 static int semanage_copy_file(const char *src, const char *dst) {
-	int in, out, retval = 0, amount_read;
-	char tmp[PATH_MAX] = {};
+	int in, out, retval = 0, amount_read, n;
+	char tmp[PATH_MAX];
 	char buf[4192];
 
+	n = snprintf(tmp, PATH_MAX, "%s.tmp", dst);
+	if (n < 0 || n >= PATH_MAX)
+		return -1;
+
 	if ((in = open(src, O_RDONLY)) == -1) {
 		return -1;
 	}
 	
-	snprintf(tmp, PATH_MAX, "%s.tmp", dst);
-	if (!tmp)
-		return -1;
-
 	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR)) == -1) {
 		close(in);
 		return -1;
@@ -329,9 +329,10 @@
 	if (amount_read < 0)
 		retval = -1;
 	close(in);
-	close(out);
+	if (close(out) < 0)
+		retval = -1;
 
-	if (rename(tmp, dst) == -1)
+	if (!retval && rename(tmp, dst) == -1)
 		return -1;
 
 	return retval;

--=-I2W4DA8O3fq/d4hX3IN9--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
