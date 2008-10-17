Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9HFu1Gu000590
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 11:56:01 -0400
Received: from flower.research.telcordia.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9HFsfpC009542
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 15:54:41 GMT
Received: from [127.0.0.1] (ar12-209.research.telcordia.com [192.4.12.209])
	by flower.research.telcordia.com (8.14.2/8.14.2) with ESMTP id m9HFuE94023168
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 11:56:14 -0400 (EDT)
Message-ID: <48F8B58C.9040609@research.telcordia.com>
Date: Fri, 17 Oct 2008 11:55:56 -0400
From: Sanjai Narain <narain@research.telcordia.com>
MIME-Version: 1.0
CC: selinux@tycho.nsa.gov
Subject: Protecting against inadvertent file copy
References: <48F798BB.6070602@rubix.com>	 <1224186793.9247.139.camel@moss-spartans.epoch.ncsc.mil>	 <1224186905.9247.141.camel@moss-spartans.epoch.ncsc.mil>	 <48F85ECC.108@rubix.com>	 <1224245613.18694.26.camel@moss-spartans.epoch.ncsc.mil>	 <48F89EBE.6020800@rubix.com>	 <1224253435.19562.23.camel@moss-spartans.epoch.ncsc.mil>	 <48F8ABBC.9060808@rubix.com> <1224256522.19562.54.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1224256522.19562.54.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello: I am just getting started with SELinux, and would very much 
appreciate an answer to the following question:

Suppose there is a directory ftp_dir. If one wants to allow ftp of one's 
file to the outside world, one places it in ftp_dir. Suppose there is 
also a directory private_dir. One wants to prevent copying of any file 
in that directory into ftp_dir. In particular, one wants to say "do not 
allow cp from private_dir to ftp_dir". How would one go about expressing 
this in SELinux?

Thanks. -- Sanjai




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
