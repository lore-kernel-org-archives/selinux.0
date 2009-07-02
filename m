Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n62LRXND014312
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 17:27:33 -0400
Received: from g5t0006.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n62LRGNx026638
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 21:27:16 GMT
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g5t0006.atlanta.hp.com (Postfix) with ESMTP id 22801C645
	for <selinux@tycho.nsa.gov>; Thu,  2 Jul 2009 21:27:33 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v2] selinux: Fix a problem with socket labels and the TUN
	driver
To: selinux@tycho.nsa.gov
Date: Thu, 02 Jul 2009 17:27:24 -0400
Message-ID: <20090702212724.7080.70214.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is a problem where packets being sent by the TUN driver are not
correctly handled by SELinux in the postrouting code.  The issue is that
the SELinux network access controls rely on a packet's associated sock, when
present, for it's security label.  The TUN driver does create a sock to send
network traffic but it only calls into the LSM/SELinux code once via the
security_sk_alloc() hook which never fully initializes the sock's label.  This
patch attempts to correct this problem by adding the normal LSM socket
creation hooks to the TUN driver.

NOTE: this is an RFC patch intended to demonstrate a possible solution
completely different from the v1 patch, but it is still crude, untested and
not fully hashed out just yet.  Please take a look and see if this approach
is even worth pursuing ... thanks.
---

 drivers/net/tun.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 11a0ba4..7db4b13 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -946,6 +946,10 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
+		err = security_socket_create(AF_UNSPEC, SOCK_RAW, 0, 0);
+		if (err < 0)
+			return err;
+
 		/* Set dev type */
 		if (ifr->ifr_flags & IFF_TUN) {
 			/* TUN device */
@@ -987,6 +991,12 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		tun->sk = sk;
 		container_of(sk, struct tun_sock, sk)->tun = tun;
 
+		/* XXX - correct placement? */
+		err = security_socket_post_create(tun->socket,
+						  AF_UNSPEC, SOCK_RAW, 0, 0);
+		if (err < 0)
+			goto err_free_sk;
+
 		tun_net_init(dev);
 
 		if (strchr(dev->name, '%')) {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
