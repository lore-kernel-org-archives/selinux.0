Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBOHZSIi009023
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 12:35:28 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBOHXebn014261
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 17:33:41 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 27BC661AFD
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 04:35:30 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26719-03 for <selinux@tycho.nsa.gov>;
	Sat, 25 Dec 2004 04:35:29 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C324161AF9
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 04:35:29 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 0FDF9A4
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 04:35:29 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: iptables and assertions
Date: Sat, 25 Dec 2004 04:35:26 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200412250435.28809.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

allow iptables_t bin_t:file { execute execute_no_trans };

The above line has been in the iptables policy for ages (I think since it was 
ipchains_t).  Is it still needed?  My tests seem to indicate that it is not 
needed any more.

If we remove the above line we can add the following to assert.te:
ifdef(`iptables.te', `assert_execute(iptables)')

Also the following seems appropriate for assert.te:
ifdef(`ifconfig.te', `assert_execute(ifconfig)')

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
