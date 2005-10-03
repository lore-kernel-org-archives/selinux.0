Subject: Re: getseuserbyname patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1128354729.26285.137.camel@moss-spartans.epoch.ncsc.mil>
References: <43398EB2.1050100@redhat.com>
	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>
	 <433BEB18.7000703@redhat.com>
	 <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil>
	 <433C06F0.3020804@redhat.com>  <433C3C5A.4000104@redhat.com>
	 <1128028887.27495.184.camel@moss-spartans.epoch.ncsc.mil>
	 <1128354729.26285.137.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-/ox7gRXrvChOtPtRS0A1"
Date: Mon, 03 Oct 2005 12:29:27 -0400
Message-Id: <1128356967.26285.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/ox7gRXrvChOtPtRS0A1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-10-03 at 11:52 -0400, Stephen Smalley wrote:
> I merged a revised implementation of this interface into libselinux
> 1.27.2, as you know.  However, it occurred to me that if you are going
> to rework pam_selinux and the SELinux patches for sshd, crond, etc to
> use this interface along with either get_ordered_context_list_with_level
> or get_default_context_with_level, then we need to make sure this also
> works when using a non-MLS policy.  The simplest approach would be to
> have getseuserbyname not require (but allow) a MLS field in the config
> file if MLS is disabled (!is_selinux_mls_enabled()), and just set *level
> to NULL in that case.  get_ordered_context_list_with_level and
> get_default_context_with_level will handle that correctly already.  The
> caller can still unconditionally free the level afterward as free (NULL)
> is perfectly valid and harmless.
> 
> This will ensure that the same code will work regardless of whether MLS
> is enabled or not, and that people can still use seusers.conf to map
> Linux users to SELinux users (and thus to role sets) even in the non-MLS
> case.

Patch below makes this change.  Next question is error handling in
either getseuserbyname() itself or in the caller, given that you are
converting pam_selinux and the SELinux patches to always call this
function.  If seusers.conf doesn't exist, getseuserbyname() could simply
set the *seuser to the linuxuser, set the *level to NULL and return
success to the caller, so that the caller would then call
get*_with_level with the Linux user and a NULL level, and that function
in turn would devolve to the normal get* call with the Linux user.  That
would provide equivalence to the current behavior if seusers.conf
doesn't exist on the system.  Downside is that if seusers.conf were
accidentally "lost", user might end up gaining greater access than
desired because user_u might be authorized for all categories in the
kernel policy.  Similar issue exists if seusers.conf exists but contains
no default entry and no matching entry for the Linux user, as you
mentioned earlier.  Possibly /etc/selinux/config should specify whether
user mapping is enabled or disabled explicitly?  Then getseuserbyname
could use that to determine whether it should just fall back to the
Linux user and NULL level always, or try accessing seusers.conf.
Thoughts?

-- 
Stephen Smalley
National Security Agency

--=-/ox7gRXrvChOtPtRS0A1
Content-Disposition: attachment; filename=libselinux-seuser-nomls.patch
Content-Type: text/x-patch; name=libselinux-seuser-nomls.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/seusers.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/seusers.c,v
retrieving revision 1.2
diff -u -p -r1.2 seusers.c
--- libselinux/src/seusers.c	30 Sep 2005 18:37:54 -0000	1.2
+++ libselinux/src/seusers.c	3 Oct 2005 15:53:54 -0000
@@ -13,7 +13,8 @@
 static int process_seusers(const char *buffer, 
 			   char **luserp, 
 			   char **seuserp, 
-			   char **levelp)
+			   char **levelp,
+			   int mls_enabled)
 {
 	char *newbuf = strdup(buffer);
 	char *luser = NULL, *seuser = NULL, *level = NULL;
@@ -40,14 +41,23 @@ static int process_seusers(const char *b
 
 	start = end+1;
 	end = strchr(start, ':');
-	if (!end)
-		goto err;
+	if (!end) {
+		if (mls_enabled)
+			goto err; /* no MLS level and MLS is enabled */
+		/* MLS is disabled, so :level suffix not required. */
+		end = start;
+		while (*end && !isspace(*end))
+			end++;
+	}
 	*end = 0;
 	
 	seuser = strdup(start);
 	if (!seuser)
 		goto err;
 
+	if (!mls_enabled)
+		goto out; /* skip any MLS level */
+
 	start = ++end;
 	while (*end && !isspace(*end))
 		end++;
@@ -57,6 +67,7 @@ static int process_seusers(const char *b
 	if (!level)
 		goto err;
 
+out:
 	free(newbuf);
 	*luserp = luser;
 	*seuserp = seuser;
@@ -76,6 +87,7 @@ int getseuserbyname(const char *name, ch
 	char *buffer=NULL;
 	int rc;
 	unsigned long lineno = 0;
+	int mls_enabled = is_selinux_mls_enabled();
 
 	char *username=NULL;
         char *seuser=NULL;
@@ -89,7 +101,7 @@ int getseuserbyname(const char *name, ch
 
 	while (getline(&buffer, &size, cfg) > 0) {
 		++lineno;
-		rc = process_seusers(buffer, &username, &seuser, &level);
+		rc = process_seusers(buffer, &username, &seuser, &level, mls_enabled);
 		if (rc == -1)
 			continue; /* comment, skip */
 		if (rc == -2) {

--=-/ox7gRXrvChOtPtRS0A1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
