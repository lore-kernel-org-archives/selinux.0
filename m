Message-ID: <4032E49C.3070003@snu.edu>
Date: Tue, 17 Feb 2004 22:05:48 -0600
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: [Announce][Patch] PaX support in SELinux
Content-Type: multipart/mixed;
 boundary="------------090304030009070303010508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090304030009070303010508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I know that most of the selinux uses ExecShield but I'm hoping that I 
can convince people that PaX is a viable alternative. This isn't meant 
to start a flame war so I'll keep to things that have already been said.

For starters the primary argument against PaX is that "it breaks stuff". 
  While the author of ES already admitted that PaX can provide more 
protection ES is less intrusive and has therefore been the choice for 
many distributions.

PaX has recently introduced a way to hook into an ACL system in a 
generic way and I've done just this for SELinux. I realize that this 
will probably never be considered for upstream but hopefully we'll be 
able to support and maintain this within Hardened Gentoo for the 
forseeable future.

First apply the pax patch from 
http://pax.grsecurity.net/pax-linux-2.6.2-200402172205.patch
(don't let the domain name scare you, PaX is part of grsecurity, not 
vice versa)
Then apply the included patch to the kernel and apply the other patch in 
your policy/flask directory. Then make in the flask directory and copy 
*.h to /usr/src/linux/security/selinux/include.

You'll then be able to manage PaX restrictions within SELinux policy 
like this:

Since Java is one of the apps 'broken' by PaX I used it as a proof of 
concept.

--- policy
type java_bin_t, file_type;

can_exec(sysadm_t, java_bin_t);
allow java_bin_t self:pax { nomprotect nosegmexec };

--- policy
before adding the policy:

vmware-2 selinux # java
Killed

And after adding policy:

vmware-2 selinux # java
Usage: java [-options] class [args...]
            (to execute a class)
    or  java -jar [-options] jarfile [args...]
            (to execute a jar file)
....

The options available are

nomprotect 	turns off mprotect() protection
nosegmexec	turns off segmentation based non-executable pages
norandmmap	turns off randomized mmap base
pageexec	turns on paging based non-executable pages
emutramp	trampoline emulation
randexec	randomize ET_EXEC base

The defaults are MPROTECT, SEGMEXEC and RANDMMAP which is why the first 
three are options to turn them off.

To put this into prospective, the last 2 kernel exploits, which selinux 
was vulnerable too, would have been prevented from running on systems 
with SEGMEXEC protection enforced by the MAC system. I hope that this 
will generate some more interest in PaX for SELinux users. If you have 
any questions about PaX or the implementation please feel free to ask.

I'd like to give a huge thanks to Stephen Smalley for answering all the 
questions I had concerning SELinux in the kernel.

Joshua Brindle

--------------090304030009070303010508
Content-Type: text/plain;
 name="pax+selinux-2.6.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pax+selinux-2.6.2.patch"

diff -urN linux-2.6.2/security/selinux/hooks.c linux-2.6.2-pax/security/selinux/hooks.c
--- linux-2.6.2/security/selinux/hooks.c	2004-02-08 02:41:59.000000000 -0600
+++ linux-2.6.2-pax/security/selinux/hooks.c	2004-02-07 23:40:47.000000000 -0600
@@ -61,6 +61,10 @@
 #include "objsec.h"
 #include "netif.h"
 
+#ifdef CONFIG_PAX_HOOK_ACL_FLAGS
+static void avc_pax_set_flags(struct linux_binprm * bprm);
+#endif
+
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
@@ -3738,12 +3742,104 @@
 		goto next_sb;
 	}
 	spin_unlock(&sb_security_lock);
+
+        #ifdef CONFIG_PAX_HOOK_ACL_FLAGS
+        printk(KERN_DEBUG "SELinux:  Setting PaX callback function\n");
+        pax_set_flags_func = avc_pax_set_flags;
+        #endif
 }
 
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
 security_initcall(selinux_init);
 
+#ifdef CONFIG_PAX_HOOK_ACL_FLAGS
+
+static void avc_pax_set_flags(struct linux_binprm * bprm)
+{
+        struct inode_security_struct *isec;
+        struct av_decision avd;
+        /* these are good default flags for i386 */
+        unsigned long flags = (PF_PAX_SEGMEXEC | PF_PAX_MPROTECT | PF_PAX_RANDMMAP);
+        unsigned long oldflags = current->flags;
+        int rc;
+
+        char *scontext;
+        u32 scontext_len;
+
+        /*
+         * get the security struct from the inode of the file 
+         * since the bprm security struct will just point to 
+         * the user running the binary
+         */
+        struct inode *inode = bprm->file->f_dentry->d_inode;
+        isec = inode->i_security;
+
+        /* PAGEEXEC is disabled by default, we'll check if it should enabled */
+        rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__PAGEEXEC, &isec->avcr,NULL);
+        if (!rc) {
+                flags |= PF_PAX_PAGEEXEC;
+	}
+        /* EMUTRAMP is disabled by default, we'll check if it should enabled */
+        rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__EMUTRAMP, &isec->avcr, NULL);
+        if (!rc) {
+                flags |= PF_PAX_EMUTRAMP;
+	}
+        /* RANDEXEC is disabled by default, we'll check if it should enabled */
+        rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__RANDEXEC, &isec->avcr, NULL);
+        if (!rc) {
+                flags |= PF_PAX_RANDEXEC;
+	}
+	/* MPROTECT is enabled by default, nomprotect disables */
+        rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__NOMPROTECT, &isec->avcr, NULL);
+        if (!rc) {
+                flags &= ~PF_PAX_MPROTECT;
+	}
+	/* RANDMMAP is enabled by default, norandmmap disables */
+        rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__NORANDMMAP, &isec->avcr, NULL);
+        if (!rc) {
+                flags &= ~PF_PAX_RANDMMAP;
+	}
+	/* SEGMEXEC is enabled by default, nosegmexec disables */
+        rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__NOSEGMEXEC, &isec->avcr, NULL);
+        if (!rc) {
+                flags &= ~PF_PAX_SEGMEXEC;
+	}
+
+	if (selinux_enforcing) {
+
+		/* pull all the pax flags in current */
+	        current->flags &= ~(PF_PAX_PAGEEXEC | PF_PAX_EMUTRAMP | PF_PAX_MPROTECT | PF_PAX_RANDMMAP | PF_PAX_RANDEXEC | PF_PAX_SEGMEXEC);
+        	/* and add ours */
+	        current->flags |= flags;
+
+		printk( KERN_WARNING "avc: setting flags %lx\n", flags );
+
+        	if (pax_check_flags(&current->flags) < 0)
+                	printk(KERN_WARNING
+                        	"avc: pax flags were changed from %lx to %lx by pax_check_flags, please check your policy for incompatible or disabled options\n",
+        	                flags,
+                	        current->flags
+                        	);
+	
+	        security_sid_to_context(isec->sid, &scontext, &scontext_len);
+        	if (current->flags != oldflags)
+                	printk(KERN_INFO
+	                         "avc: pax changing flags for process %u (%s) %s to %lx from %lx \n",
+        	                 current->pid,
+                	         scontext,
+                        	 bprm->filename,
+	                         current->flags,
+        	                 oldflags
+                	        );
+	        kfree(scontext);
+	}
+
+        return;
+}
+
+#endif /* CONFIG_PAX_HOOK_ACL_FLAGS */
+
 #if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_NETFILTER)
 
 static struct nf_hook_ops selinux_ip_ops[] = {

--------------090304030009070303010508
Content-Type: text/plain;
 name="flask-pax.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="flask-pax.patch"

diff -urN flask.old/access_vectors flask/access_vectors
--- flask.old/access_vectors	2004-02-08 03:04:54.066802896 -0600
+++ flask/access_vectors	2004-01-29 13:20:13.000000000 -0600
@@ -353,3 +353,17 @@
 	chfn
 	chsh
 }
+
+#
+# Define the access vector interpretation for controlling
+# PaX flags
+#
+class pax
+{
+	pageexec	# Paging based non-executable pages
+	emutramp	# Emulate trampolines
+	nomprotect	# Restrict mprotect()
+	norandmmap	# Randomize mmap() base
+	randexec	# Randomize ET_EXEC base
+	nosegmexec	# Segmentation based non-executable pages
+}
diff -urN flask.old/security_classes flask/security_classes
--- flask.old/security_classes	2004-02-08 03:05:03.066434744 -0600
+++ flask/security_classes	2004-01-29 03:02:39.000000000 -0600
@@ -47,4 +47,7 @@
 # passwd/chfn/chsh
 class passwd
 
+# pax flags
+class pax
+
 # FLASK

--------------090304030009070303010508--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
