Subject: Re: Proposed change to install
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1104158005.15615.84.camel@moss-spartans.epoch.ncsc.mil>
References: <41D00FE7.2070203@redhat.com>
	 <1104158005.15615.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1104260348.21391.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Dec 2004 13:59:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-12-27 at 09:33, Stephen Smalley wrote:
> On a different note, should matchpathcon() be doing something different
> in the <<none>> case rather than returning it to the caller, so that the
> caller doesn't have to hardcode a check for it?  Possibly return -1 with
> errno ENOENT as in the case where there is no matching entry in
> file_contexts?

This patch for libselinux changes matchpathcon() to return -1 with errno
ENOENT when the path matches <<none>>.  It also fixes the handling for
an empty file_contexts configuration.

Index: libselinux/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/ChangeLog,v
retrieving revision 1.97
diff -u -p -r1.97 ChangeLog
--- libselinux/ChangeLog	2 Dec 2004 17:58:59 -0000	1.97
+++ libselinux/ChangeLog	28 Dec 2004 18:51:19 -0000
@@ -1,4 +1,6 @@
-1.19 2004-12-02	
+1.19 2004-12-28
+	* Changed matchpathcon to return -1 with errno ENOENT for 
+	  <<none>> entries, and also for an empty file_contexts configuration.
 	* Removed some trivial utils that were not useful or redundant.
 	* Changed BINDIR default to /usr/sbin to match change in Fedora.
 	* Added security_compute_member.
Index: libselinux/src/matchpathcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/matchpathcon.c,v
retrieving revision 1.11
diff -u -p -r1.11 matchpathcon.c
--- libselinux/src/matchpathcon.c	4 Nov 2004 19:08:13 -0000	1.11
+++ libselinux/src/matchpathcon.c	28 Dec 2004 18:46:55 -0000
@@ -354,7 +354,7 @@ static int matchpathcon_init(void)
 
 		if (pass == 0) {
 			if (nspec == 0)
-				return -1;
+				return 0;
 			if ((spec_arr = malloc(sizeof(spec_t) * nspec)) ==
 			    NULL)
 				return -1;
@@ -438,6 +438,11 @@ int matchpathcon(const char *name, 
 
 	spec_arr[i].matches++;
 
+	if (strcmp(spec_arr[i].context, "<<none>>") == 0) {
+		errno = ENOENT;
+		return -1;
+	}
+
 	*con = strdup(spec_arr[i].context);
 	if (!(*con))
 		return -1;

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
