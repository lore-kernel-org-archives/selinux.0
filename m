Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13635
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 12:39:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA19531
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 16:37:38 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id QAA19527
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 16:37:38 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id MAA10189
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 12:38:39 -0400 (EDT)
Date: Tue, 4 Sep 2001 12:38:39 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Summary of posted bug fix and optional patches
Message-ID: <Pine.SOL.3.95.1010904122240.319Q-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Here is a summary of bug fix and optional patches posted
on the list since the April 23rd release.

1) Remove spurious bracket from lsm/net/ipv4/netfilter/ip_queue.c.  
See http://marc.theaimsgroup.com/?l=selinux&m=99862776813062&w=2

2) Fix error handling code in lsm/kernel/acct.c. 
See http://marc.theaimsgroup.com/?l=selinux&m=99867298719460&w=2

3) Fix selinux_sock_rcv_skb hook.
See hooks.patch in
http://marc.theaimsgroup.com/?l=selinux&m=99866990208334&w=2

4) (optional) Add security class for PF_KEY sockets.
See http://marc.theaimsgroup.com/?l=selinux&m=99891860017799&w=2

5) (optional) Add ipsec domain to policy.
See http://marc.theaimsgroup.com/?l=selinux&m=99894297513288&w=2

6) Fix performance bug in inode-to-PSID mapping.
See http://marc.theaimsgroup.com/?l=selinux&m=99926733231256&w=2

7) Fix selinux_ip_postroute hook.
See http://marc.theaimsgroup.com/?l=selinux&m=99962056431023&w=2

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
