Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0DL0bRb021860
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 16:00:37 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0DKxSxr014571
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 20:59:28 GMT
Received: from thoron.boston.redhat.com (nat-pool-bos.redhat.com [66.187.230.200])
	by jazzswing.ncsc.mil  with ESMTP id i0DKxQYe014563
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 20:59:28 GMT
Date: Tue, 13 Jan 2004 16:00:32 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH][SELINUX] 2/2 Add SEND_MSG and RECV_MSG controls
In-Reply-To: <Xine.LNX.4.44.0401131326240.6829-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401131557590.7560-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Jan 2004, James Morris wrote:

> This patch implements two new access controls for SELinux: SEND_MSG and 
> RECV_MSG, providing mediation of network packets based on destination 
> port (IPv4 only at this stage).
> 

After some further discussion, Stephen and I decided that it would be more 
useful for security to invert the sense of the RECV_MSG permission so that 
the source port is checked during packet reception.

This patch is relative to the previous patch, please let me know if you 
want the entire patch redone.


diff -urN -X dontdiff linux-2.6.1-mm2.p/security/selinux/hooks.c linux-2.6.1-mm2.w/security/selinux/hooks.c
--- linux-2.6.1-mm2.p/security/selinux/hooks.c	2004-01-13 15:59:04.153184216 -0500
+++ linux-2.6.1-mm2.w/security/selinux/hooks.c	2004-01-13 14:32:06.000000000 -0500
@@ -2773,7 +2773,7 @@
 
 		/* Fixme: make this more efficient */
 		err = security_port_sid(sk->sk_family, sk->sk_type,
-		                        sk->sk_protocol, ntohs(ad.u.net.dport),
+		                        sk->sk_protocol, ntohs(ad.u.net.sport),
 		                        &port_sid);
 		if (err)
 			goto out;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
