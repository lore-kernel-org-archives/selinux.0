Subject: [PATCH 2/2] SELinux: do not spam dmesg about unix domain sockets
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Wed, 29 Oct 2008 10:37:44 -0400
Message-Id: <1225291064.23736.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

unix sockets were able to get down the open code path.  This simply matches
exactly that request and does nothing with it.  Should shut up the dmesg
spam.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)


diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 188284f..562844a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1697,7 +1697,9 @@ static inline u32 open_file_mask_to_av(int mode, int mask)
 
 	if (selinux_policycap_openperm) {
 		/*
-		 * lnk files and socks do not really have an 'open'
+		 * lnk files do not really have an 'open'
+		 * unix domain sockets from unix_find_other can get here, so
+		 * do nothing with those requests...
 		 */
 		if (S_ISREG(mode))
 			av |= FILE__OPEN;
@@ -1710,6 +1712,8 @@ static inline u32 open_file_mask_to_av(int mode, int mask)
 		else if (S_ISDIR(mode)) {
 			if (mask != MAY_EXEC)
 				av |= DIR__OPEN;
+		} else if (S_ISSOCK(mode) && (mask == MAY_WRITE)) {
+			/* do nothing for stupid unix domain sockets */
 		} else
 			printk(KERN_ERR "SELinux: WARNING: inside %s with "
 				"unknown mode:%o mask:%x\n", __func__, mode, mask);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
