Subject: [patch 2/3] selinux: remove unused enumeration constant from
	selinuxfs
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 16:18:43 -0400
Message-Id: <1175717923.14463.71.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove the unused enumeration constant, SEL_AVC, from the sel_inos
enumeration in selinuxfs.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

---

 security/selinux/selinuxfs.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e0b6cfe..62cd248 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -96,7 +96,6 @@ enum sel_inos {
 	SEL_COMMIT_BOOLS, /* commit new boolean values */
 	SEL_MLS,	/* return if MLS policy is enabled */
 	SEL_DISABLE,	/* disable SELinux until next reboot */
-	SEL_AVC,	/* AVC management directory */
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
 	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
