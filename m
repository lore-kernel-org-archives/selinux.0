Subject: Re: Added is_context_configurable function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Colin Walters <walters@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41E544B6.1060606@redhat.com>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
	 <1105481440.24748.22.camel@nexus.verbum.private>
	 <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
	 <41E544B6.1060606@redhat.com>
Content-Type: multipart/mixed; boundary="=-1rthyRYrO7cHtXuPFE+Z"
Message-Id: <1106235143.26753.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 Jan 2005 10:32:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1rthyRYrO7cHtXuPFE+Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-01-12 at 10:39, Daniel J Walsh wrote:
> Patch to policycoreutils so restorecon/setfiles can handle 
> customizable_types.
> 
> Also fix a segfault in restorecon.

Thanks, merged into sourceforge CVS as of policycoreutils version
1.21.1, depends on libselinux 1.21.1, along with the modifications below
relative to your patch.  Note that setfiles and rpm still need to be
modified for file_contexts.local support.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

--=-1rthyRYrO7cHtXuPFE+Z
Content-Disposition: attachment; filename=policycoreutils-fixes.patch
Content-Type: text/x-patch; name=policycoreutils-fixes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/restorecon/restorecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/restorecon/restorecon.c,v
retrieving revision 1.19
diff -u -p -r1.19 restorecon.c
--- policycoreutils/restorecon/restorecon.c	19 Jan 2005 16:48:41 -0000	1.19
+++ policycoreutils/restorecon/restorecon.c	19 Jan 2005 17:23:20 -0000
@@ -135,7 +135,7 @@ int restore(char *filename) {
     int customizable=0;
     if (retcontext < 0 || 
 	(strcmp(prev_context,scontext) != 0 && 	
-	 (customizable=(force ? 0: is_context_customizable(prev_context))==0))) {
+	 !(customizable=(force ? 0: is_context_customizable(prev_context))))) {
       if (outfile) {
 	fprintf(outfile, "%s\n", filename);
       }

--=-1rthyRYrO7cHtXuPFE+Z--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
