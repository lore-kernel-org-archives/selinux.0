Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h944KdsJ014413
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 00:20:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h944InZt007609
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 04:18:49 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h944ImM3007605
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 04:18:48 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B2C7592472
	for <selinux@tycho.nsa.gov>; Sat,  4 Oct 2003 14:20:30 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6EEAE7F004
	for <selinux@tycho.nsa.gov>; Sat,  4 Oct 2003 14:20:22 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: serial devices
Date: Sat, 4 Oct 2003 14:20:21 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310041420.21903.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently we have serial ports labeled at tty_device_t by default.

The problem is that serial ports are used for modems, printers, and many other 
things than terminals.  Currently the sample policy does not permit such 
access.  So cups and lpd are not granted access, and if you want to run 
minicom you have to change the context of the device (and add new policy) or 
run minicom as sysadm_t.

I have been thinking of creating a new type for non-login serial devices and 
granting pppd, cups and lpd full access to it, then the administrator would 
have the option of granting users access to it for running minicom without 
allowing them to spoof logins.

Another possibility is to have different types for the device as used by cups, 
pppd, and minicom.  Then change the contexts of serial devices to indicate 
which service they are for, but this could be painful to administer.

What do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
