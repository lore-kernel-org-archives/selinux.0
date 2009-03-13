Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2DCPKsj001278
	for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2009 08:25:20 -0400
Received: from merlin.cdltd.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2DCLZsi018822
	for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2009 12:21:35 GMT
Received: from exch.cdltd.co.uk (fw.cdltd.co.uk [193.132.127.247])
	by merlin.cdltd.co.uk (Postfix) with ESMTP id 82B9C1F8009E
	for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2009 12:25:34 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Unable to disable SELinux
Date: Fri, 13 Mar 2009 12:25:51 -0000
Message-ID: <DAE2574A7F44F44ABE07381C36213DFA069F7833@exch.cdltd.co.uk>
From: "Paul Cocker" <paul.cocker@tntpost.co.uk>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Running SELinux on a CentOS 5.2 box, Im trying to temporarily disable
SELinux via one of the following methods:
 
1. sudo echo 0 > /selinux/enforce
 
2. sudo vim /selinux/enforce
 
The first comes back with
 
-bash: /selinux/enforce: Permission denied
 
The second comes back with
 
Could not set security context for /home/paulc/enforcz~
 
Could not set security context for /home/paulc/enforcz~
"enforce" E667: Fsync failed
Press ENTER or type command to continue
 
 
I believe the first method has worked for me before, but it's possible I
have made changes since then. It was some time ago. What's the cause of
this issue?
 

Paul Cocker



TNT Post is the trading name for TNT Post UK Ltd (company number: 04417047), TNT Post (Doordrop Media) Ltd (00613278), TNT Post Scotland Ltd (05695897), TNT Post North Ltd (05701709), TNT Post South West Ltd (05983401), TNT Post Midlands Limited (6458167)and TNT Post London Limited (6493826). Emma's Diary and Lifecycle are trading names for Lifecycle Marketing (Mother and Baby) Ltd (02556692). All companies are registered in England and Wales; registered address: 1 Globeside Business Park, Fieldhouse Lane, Marlow, Buckinghamshire, SL7 1HY.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
