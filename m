Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9K932Wt018536
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 05:03:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9K92o0p012282
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 09:02:51 GMT
Received: from kaos (c210-49-228-68.sunsh1.vic.optusnet.com.au [210.49.228.68])
	by jazzswing.ncsc.mil  with ESMTP id h9K92gr7012268
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 09:02:50 GMT
Received: from kaos (kaos [127.0.0.1])
	by kaos (Postfix) with ESMTP id 5E2F247298
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 19:00:28 +1000 (EST)
From: Faye Coker <faye@lurking-grue.org>
Reply-To: faye@lurking-grue.org
To: selinux@tycho.nsa.gov
Subject: Number of roles reported by checkpolicy
Date: Mon, 20 Oct 2003 19:00:27 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310201900.27621.faye@lurking-grue.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Running checkpolicy shows I have 4 users and 5 roles:

faye@kaos:/etc/selinux$ checkpolicy
checkpolicy:  loading policy configuration from policy.conf
security:  4 users, 5 roles, 683 types
security:  29 classes, 71806 rules

however, I can only see four roles:

faye@kaos:/etc/selinux$ grep ^role policy.conf|cut -f2 "-d "|sort -u
staff_r
sysadm_r
system_r
user_r

Any ideas as to why checkpolicy is reporting five roles, when I can only see 
four?

faye
--
Faye Coker
faye@lurking-grue.org



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
