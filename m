Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8KJd7sJ003630
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 15:39:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8KJYkdI018400
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 19:37:21 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8J2KlVY013328
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2003 02:22:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: privsep in ssh
Date: Fri, 19 Sep 2003 12:22:15 +1000
Cc: Colin Watson <cjwatson@debian.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Xhma/RRq3GCAQKg"
Message-Id: <200309191222.15919.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Xhma/RRq3GCAQKg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

#ifdef DISABLE_FD_PASSING
        if (1) {
#else
        if (authctxt->pw->pw_uid == 0 || options.use_login) {
#endif
                /* File descriptor passing is broken or root login */
                monitor_apply_keystate(pmonitor);
                use_privsep = 0;
                return;
        }

When browsing the ssh source I noticed the above in sshd.c.  It appears from a 
casual inspection that we should change this and remove the check for
pw_uid == 0.  Logging in as root in SE Linux does not mean that we have full 
administrative privs, so I think that we should have privsep enabled all the 
time.

I have compiled a sshd with privsep for root logins and it seems to work fine.

I have attached the patch against ssh 3.6.1p2, I expect that the same thing 
would be necessary in 3.7.1 and the same patch probably applies (but I 
haven't checked).

I believe that this patch is worthy of inclusion in the standard distribution 
of ssh.  The only drawback is that it uses a small amount of extra CPU power 
for root logins, and on systems such as SE Linux it provides security 
benefits.

Anyone who wants to use the SE Linux PAM module for sshd probably wants this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Xhma/RRq3GCAQKg
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- orig/openssh-3.6.1p2/sshd.c	2003-09-18 15:16:41.000000000 +1000
+++ openssh-3.6.1p2/sshd.c	2003-09-19 12:00:15.000000000 +1000
@@ -636,7 +636,7 @@
 #ifdef DISABLE_FD_PASSING
 	if (1) {
 #else
-	if (authctxt->pw->pw_uid == 0 || options.use_login) {
+	if (options.use_login) {
 #endif
 		/* File descriptor passing is broken or root login */
 		monitor_apply_keystate(pmonitor);

--Boundary-00=_Xhma/RRq3GCAQKg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
