Subject: Re: Change of restorecon and setfiles to not modify context if
	only_user_section changed
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41F148B8.5090504@redhat.com>
References: <41F148B8.5090504@redhat.com>
Content-Type: text/plain
Message-Id: <1106336874.28551.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 21 Jan 2005 14:47:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-01-21 at 13:23, Daniel J Walsh wrote:
> Specifying force (-F) will override.

Thanks, merged into sourceforge CVS as of policycoreutils 1.21.3.
Also includes the fix below for restorecon to avoid handling errors from
is_customizable_context() incorrectly as per Tom London's bug report.

Index: policycoreutils/restorecon/restorecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/restorecon/restorecon.c,v
retrieving revision 1.21
retrieving revision 1.22
diff -u -p -r1.21 -r1.22
--- policycoreutils/restorecon/restorecon.c	21 Jan 2005 19:14:20 -0000	1.21
+++ policycoreutils/restorecon/restorecon.c	21 Jan 2005 19:39:23 -0000	1.22
@@ -133,7 +133,7 @@ int restore(char *filename) {
     int customizable=0;
     if (retcontext < 0 || 
 	(strcmp(prev_context,scontext) != 0 && 	
-	 !(customizable=(force ? 0: is_context_customizable(prev_context))))) {
+	 !(customizable=(force ? 0: (is_context_customizable(prev_context) > 0))))) {
       if (outfile) {
 	fprintf(outfile, "%s\n", filename);
       }

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
