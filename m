Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB4J1qMP016305
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 14:01:52 -0500
Received: from cadmus.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB4J1mwr026340
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 19:01:50 GMT
Received: from cadmus.columbia.tresys.com (localhost.localdomain [127.0.0.1])
	by cadmus.columbia.tresys.com (8.14.1/8.14.1) with ESMTP id lB4J1kFM019365
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 14:01:47 -0500
Received: (from tmiller@localhost)
	by cadmus.columbia.tresys.com (8.14.1/8.14.1/Submit) id lB4J1jhU019364
	for selinux@tycho.nsa.gov; Tue, 4 Dec 2007 14:01:45 -0500
Date: Tue, 4 Dec 2007 14:01:45 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200712041901.lB4J1jhU019364@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: PATCH: audit format mismatch for inode number
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i_ino is unsigned.  We recently saw an audit message with a negative
inode number in procfs due to this.

 - todd

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

---

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index e4396a8..e233a3d 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -586,7 +586,7 @@ void avc_audit(u32 ssid, u32 tsid,
 				}
 			}
 			if (inode)
-				audit_log_format(ab, " dev=%s ino=%ld",
+				audit_log_format(ab, " dev=%s ino=%lu",
 						 inode->i_sb->s_id,
 						 inode->i_ino);
 			break;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
