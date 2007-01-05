Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l05KGBva001952
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 15:16:11 -0500
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l05KGuBd007688
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 20:16:57 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070105201637.494749925@hp.com>
References: <20070105200820.975960210@hp.com>
Date: Fri, 05 Jan 2007 15:08:21 -0500
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/2] NetLabel: correct locking in selinux_netlbl_socket_setsid()
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The spinlock protecting the update of the "sksec->nlbl_state" variable is not
currently softirq safe which can lead to problems.  This patch fixes this by
changing the spin_{un}lock() functions into spin_{un}lock_bh() functions.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/ss/services.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: net-2.6.20_bugfix_3/security/selinux/ss/services.c
===================================================================
--- net-2.6.20_bugfix_3.orig/security/selinux/ss/services.c
+++ net-2.6.20_bugfix_3/security/selinux/ss/services.c
@@ -2492,9 +2492,9 @@ static int selinux_netlbl_socket_setsid(
 
 	rc = netlbl_socket_setattr(sock, &secattr);
 	if (rc == 0) {
-		spin_lock(&sksec->nlbl_lock);
+		spin_lock_bh(&sksec->nlbl_lock);
 		sksec->nlbl_state = NLBL_LABELED;
-		spin_unlock(&sksec->nlbl_lock);
+		spin_unlock_bh(&sksec->nlbl_lock);
 	}
 
 netlbl_socket_setsid_return:

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
