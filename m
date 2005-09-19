Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8JASNNs016276
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 06:28:23 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8JAOP6H002472
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 10:24:26 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0015D61B01
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 20:24:30 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 00888-10 for <selinux@tycho.nsa.gov>;
	Mon, 19 Sep 2005 20:24:30 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 863AD61B00
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 20:24:30 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: procmail.te and targeted policy
Date: Mon, 19 Sep 2005 20:24:21 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dHpLDk0xhl4uOAX"
Message-Id: <200509192024.29027.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_dHpLDk0xhl4uOAX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Now that the targeted policy has the policy for mail servers it also needs 
procmail.te to allow delivery by procmail.

In addition the attached patch needs to be applied for procmail and 
Spamassassin to work together (for both targeted and strict).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_dHpLDk0xhl4uOAX
Content-Type: text/x-diff;
  charset="us-ascii";
  name="procmail.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="procmail.diff"

--- /tmp/procmail.te	2005-09-19 20:13:06.000000000 +1000
+++ domains/program/procmail.te	2005-09-19 20:22:49.000000000 +1000
@@ -59,6 +59,14 @@
 allow procmail_t usr_t:file { getattr ioctl read };
 ifdef(`spamassassin.te', `
 can_exec(procmail_t, spamassassin_exec_t)
+can_resolve(procmail_t)
+allow procmail_t port_t:udp_socket name_bind;
+allow procmail_t tmp_t:dir getattr;
+')
+ifdef(`targeted_policy', `
+can_resolve(procmail_t)
+allow procmail_t port_t:udp_socket name_bind;
+allow procmail_t tmp_t:dir getattr;
 ')
 
 # Search /var/run.

--Boundary-00=_dHpLDk0xhl4uOAX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
