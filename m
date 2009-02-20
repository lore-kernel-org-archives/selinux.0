Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1KLX67E002809
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 16:33:06 -0500
Received: from g4t0015.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1KLX4Ow010981
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 21:33:05 GMT
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0015.houston.hp.com (Postfix) with ESMTP id 915278307
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 21:33:04 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/2] selinux: Fix the NetLabel glue code for setsockopt()
To: selinux@tycho.nsa.gov
Date: Fri, 20 Feb 2009 16:33:02 -0500
Message-ID: <20090220213302.17416.60174.stgit@flek.lan>
In-Reply-To: <20090220212900.17416.14061.stgit@flek.lan>
References: <20090220212900.17416.14061.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At some point we (okay, I) managed to break the ability for users to use the
setsockopt() syscall to set IPv4 options when NetLabel was not active on the
socket in question.  The problem was noticed by someone trying to use the
"-R" (record route) option of ping:

 # ping -R 10.0.0.1
 ping: record route: No message of desired type

The solution is relatively simple, we catch the unlabeled socket case and
clear the error code, allowing the operation to succeed.  Please note that we
still deny users the ability to override IPv4 options on socket's which have
NetLabel labeling active; this is done to ensure the labeling remains intact.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/netlabel.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index f58701a..3f4b266 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -490,8 +490,10 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 		lock_sock(sk);
 		rc = netlbl_sock_getattr(sk, &secattr);
 		release_sock(sk);
-		if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
+		if (rc == 0)
 			rc = -EACCES;
+		else if (rc == -ENOMSG)
+			rc = 0;
 		netlbl_secattr_destroy(&secattr);
 	}
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
