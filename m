Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00153
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 14:31:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA08270
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 19:28:15 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id TAA08266
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 19:28:14 GMT
Message-Id: <200301211938.OAA02406@moss-shockers.ncsc.mil>
Date: Tue, 21 Jan 2003 14:38:26 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Problems compiling selinux release (2003011510) for 2.4.20 kernel
To: selinux@tycho.nsa.gov, azeredo@qmc.ufsc.br
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Covey_of_Partridges_331_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Covey_of_Partridges_331_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: TQcCvhsz0qoiZA4aMC2NpA==


> Sorry, the attached patch (also committed to the sourceforge CVS tree) should
> fix this problem.  Save it to ~/acct.patch, cd lsm-2.4, patch -p1 < 
> ~/acct.patch, rebuild your kernel.  Make sure that you've enabled the
> new CONFIG_SECURITY option (Enable different security models) in your
> kernel configuration.

The same problem also exists for the fs/dquot.c file, if you have quota
support enabled.  The attached patch (also committed to the sourceforge CVS 
tree) should fix this problem.  Thanks to Russell Coker for reporting it.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--Covey_of_Partridges_331_000
Content-Type: TEXT/plain; name="dquot.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: dquot.patch
Content-MD5: EFCDbpTR947AeR2TJg+Nqw==

Index: lsm-2.4/fs/dquot.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/fs/dquot.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 dquot.c
--- lsm-2.4/fs/dquot.c	16 Jan 2003 13:37:12 -0000	1.1.1.3
+++ lsm-2.4/fs/dquot.c	21 Jan 2003 18:55:31 -0000
@@ -61,6 +61,7 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 

--Covey_of_Partridges_331_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
