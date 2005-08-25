Subject: Re: Problems with MCS/Targeted policy update.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1124981047.3873.64.camel@moss-spartans.epoch.ncsc.mil>
References: <430C776B.4060309@redhat.com>
	 <1124893226.11553.32.camel@moss-spartans.epoch.ncsc.mil>
	 <430C8EB8.80906@redhat.com>
	 <1124981047.3873.64.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 11:12:41 -0400
Message-Id: <1124982761.3873.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-25 at 10:44 -0400, Stephen Smalley wrote:
> Ok, Dan pointed out another issue with cleanly upgrading from targeted
> to MCS:  although the SELinux module now defaults the MLS level for
> inodes that lack one (based on the default file SID associated with the
> superblock, typically the 'file' initial SID unless one uses a
> defcontext= mount option), userspace still sees the real xattr value,
> and this leads to problems, e.g. userspace can take a context obtained
> via getfilecon and later try to pass it to an interface like setfilecon
> or setfscreatecon or security_compute_create, and the SELinux module
> will then reject the context as invalid (because the defaulting logic
> only applies when mapping inode contexts to incore inode SIDs, not for
> contexts supplied by userspace).  Options are:
> - Change the SELinux module to reset the on-disk xattr when it defaults
> the MLS level so that userspace will see the same context, or
> - Have the MCS libsetrans insert a default level (s0) into the context
> if it lacks one for trans_to_raw conversion.  However, the latter would
> also require libselinux to invoke the translation functions in some
> additional cases where it does not presently need to, e.g. rpm_execcon
> currently works entirely with raw contexts, but would need to go through
> libsetrans in order to gain the benefit of such corrections on the
> result of the getfilecon.

Here is the workaround patch for rpm_execcon until the kernel is fixed.

Index: libselinux/src/rpm.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/rpm.c,v
retrieving revision 1.5
diff -u -p -r1.5 rpm.c
--- libselinux/src/rpm.c	23 Aug 2005 16:46:41 -0000	1.5
+++ libselinux/src/rpm.c	25 Aug 2005 14:52:49 -0000
@@ -16,15 +16,15 @@ int rpm_execcon(unsigned int verified __
 	if (is_selinux_enabled() < 1)
 		return execve(filename, argv, envp);
 
-	rc = getcon_raw(&mycon);
+	rc = getcon(&mycon);
 	if (rc < 0)
 		goto out;
 
-	rc = getfilecon_raw(filename, &fcon);
+	rc = getfilecon(filename, &fcon);
 	if (rc < 0)
 		goto out;
 
-	rc = security_compute_create_raw(mycon, fcon, SECCLASS_PROCESS, &newcon);
+	rc = security_compute_create(mycon, fcon, SECCLASS_PROCESS, &newcon);
 	if (rc < 0)
 		goto out;
 
@@ -41,7 +41,7 @@ int rpm_execcon(unsigned int verified __
 			goto out;
 	}
 
-	rc = setexeccon_raw(newcon);
+	rc = setexeccon(newcon);
 	if (rc < 0) 
 		goto out;
 	rc = execve(filename, argv, envp);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
