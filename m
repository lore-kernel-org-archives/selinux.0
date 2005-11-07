Subject: Re: [PATCH] semanage - rename instead of copy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1131398734.21419.3.camel@twoface.columbia.tresys.com>
References: <1131398734.21419.3.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 16:35:05 -0500
Message-Id: <1131399305.20591.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-07 at 16:25 -0500, Joshua Brindle wrote:
> Attached patch makes libsemanage copy file to a temporary file and then
> rename() instead of copying directly to the target. This is necessary so
> that an install failure doesn't leave a corrupt binary policy on the
> system.

diff -purN -x .svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2005-11-07 11:52:28.000000000 -0500
+++ libsemanage/src/semanage_store.c	2005-11-07 16:06:04.000000000 -0500
@@ -305,12 +305,18 @@ static int semanage_filename_select(cons
  * overwrite it.  Returns 0 on success, -1 on error. */
 static int semanage_copy_file(const char *src, const char *dst) {
 	int in, out, retval = 0, amount_read;
+	char tmp[PATH_MAX] = {};
 	char buf[4192];
 
 	if ((in = open(src, O_RDONLY)) == -1) {
 		return -1;
 	}
-	if ((out = open(dst, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR)) == -1) {
+	
+	snprintf(tmp, PATH_MAX, "%s.tmp", dst);
+	if (!tmp)
+		return -1;
+

If you want to check for failure on the snprintf, you need something like:
	int n = snprintf(tmp, PATH_MAX, "%s.tmp", dst);
	if (n < 0 || n >= PATH_MAX)
		return -1;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
