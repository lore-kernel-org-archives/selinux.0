Subject: Re: [ SEPOL ] Detach old debug system from new
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4328745F.9060702@cornell.edu>
References: <4328745F.9060702@cornell.edu>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 15:03:57 -0400
Message-Id: <1126724637.12299.187.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 15:05 -0400, Ivan Gyurdiev wrote:
> Fixes DEBUG.

Thanks, applied.

Also applied this one:

Index: libsepol/src/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/policydb.c,v
retrieving revision 1.29
retrieving revision 1.30
diff -u -p -r1.29 -r1.30
--- libsepol/src/policydb.c	14 Sep 2005 15:18:56 -0000	1.29
+++ libsepol/src/policydb.c	14 Sep 2005 19:01:36 -0000	1.30
@@ -51,6 +51,7 @@
 #include <sepol/avrule_block.h>
 
 #include "private.h"
+#include "debug.h"
 
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static struct policydb_compat_info policydb_compat[] = {

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
