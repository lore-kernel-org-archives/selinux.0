Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2SECFx6029888
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 09:12:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2SECER1001217
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 14:12:14 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h2SECEj9001214 for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 14:12:14 GMT
Received: from moss-shockers.ncsc.mil (moss-shockers [144.51.25.21])
	by facesaver.epoch.ncsc.mil (8.12.8/8.12.8) with SMTP id h2SECDNL010353
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 09:12:13 -0500 (EST)
Message-Id: <200303281419.JAA04415@moss-shockers.ncsc.mil>
Date: Fri, 28 Mar 2003 09:19:54 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Using kernel SID (kernel_t domain) in reparent_to_init
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Cluster_of_Spiders_522_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Cluster_of_Spiders_522_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: G+rw0I+TIWvNSoWG1VyZjQ==


In recent discussions on this list
(http://marc.theaimsgroup.com/?l=selinux&m=104852427209286&w=2) and on
the linux-security-module list
(http://marc.theaimsgroup.com/?l=linux-security-module&m=104861921931879&w=2),
it has come up that SELinux should be assigning the kernel SID
(kernel_t domain) to kernel threads in reparent_to_init rather than the
init SID, and that in 2.5, the kmod logic was been reworked to use
keventd, which uses reparent_to_init, so the kmod SID (kmod_t domain)
will be obsolete in 2.5.  The attached patch for lsm-2.4 changes
SELinux to use the kernel SID for both reparent_to_init and kmod for
consistency.  This will require corresponding updates to the policy to
fold the kmod_t domain into kernel_t.  This change also means that
certain permissions currently granted to init_t can be moved into
kernel_t.

--
Stephen Smalley, NSA


--Cluster_of_Spiders_522_000
Content-Type: TEXT/plain; name="kthread.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: kthread.patch
Content-MD5: r4X86guDCf88kwlHD78PvQ==

Index: lsm-2.4/security/selinux/hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/security/selinux/hooks.c,v
retrieving revision 1.28
diff -u -r1.28 hooks.c
--- lsm-2.4/security/selinux/hooks.c	18 Mar 2003 16:08:45 -0000	1.28
+++ lsm-2.4/security/selinux/hooks.c	28 Mar 2003 14:00:59 -0000
@@ -2474,7 +2474,7 @@
 
 	tsec = current->security;
 	tsec->osid = tsec->sid;
-	tsec->sid = SECINITSID_KMOD;
+	tsec->sid = SECINITSID_KERNEL;
 	return;
 }
 
@@ -2486,7 +2486,7 @@
 
 	tsec = p->security;
 	tsec->osid = tsec->sid;
-	tsec->sid = SECINITSID_INIT; 
+	tsec->sid = SECINITSID_KERNEL; 
 	return;
 }
 

--Cluster_of_Spiders_522_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
