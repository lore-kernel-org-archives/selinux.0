Subject: [patch] libsepol: fix endianness problem in policy module write
	code
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 16:06:10 -0500
Message-Id: <1143234370.386.112.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

A FC5 PowerPC user reported that a policy module he built via
checkmodule was triggering a failure upon semodule_package's attempt to
read the module for packaging, and I tracked it down to a missing
cpu_to_le32 conversion in the policy module write code.  Patch is below
and included in libsepol 1.12.2 in the sourceforge CVS.  Note that you
need to rebuild checkpolicy/checkmodule after rebuilding the patched
libsepol, since checkpolicy/checkmodule use the static lib.

The bug report is at:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=186344

Index: libsepol/src/write.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/write.c,v
retrieving revision 1.22
diff -u -p -r1.22 write.c
--- libsepol/src/write.c	15 Nov 2005 13:05:58 -0000	1.22
+++ libsepol/src/write.c	24 Mar 2006 16:42:15 -0000
@@ -1340,7 +1340,7 @@ static int avrule_block_write(avrule_blo
                 for (decl = cur->branch_list; decl != NULL; decl = decl->next) {
                         num_decls++;
                 }
-                buf[0] = num_decls;
+                buf[0] = cpu_to_le32(num_decls);
                 if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1) {
                         return -1;
                 }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
