Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0QJM4Rb026292
	for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2004 14:22:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0QJKmxr017233
	for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2004 19:20:49 GMT
Received: from smtp-1.llnl.gov (smtp-1.llnl.gov [128.115.250.81])
	by jazzswing.ncsc.mil  with ESMTP id i0QJKmYc017230
	for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2004 19:20:48 GMT
Received: from popcorn.llnl.gov (localhost [127.0.0.1])
	by smtp-1.llnl.gov (8.12.3p2-20030917/8.12.3/LLNL evision: 1.13 $) with ESMTP id i0QJM1ev027001
	for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2004 11:22:02 -0800 (PST)
Received: from [128.115.96.64] (account shakespeare2 [128.115.96.64] verified)
  by popcorn.llnl.gov (CommuniGate Pro SMTP 4.0.6)
  with ESMTP id 32140750 for selinux@tycho.nsa.gov; Mon, 26 Jan 2004 11:22:01 -0800
Mime-Version: 1.0
Message-Id: <p06020419bc3b1448ee02@[128.115.96.64]>
Date: Mon, 26 Jan 2004 11:22:00 -0800
To: selinux@tycho.nsa.gov
From: Mark Shakespeare <mshakes@llnl.gov>
Subject: Has something changed on Dan Walsh's site?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I tried a fresh install of SeLinux on top of a new Fedora build.
Using Dan Walsh's selUpgrade script.....used to work a week ago.

Now I get many errors....

error: Failed dependencies:

	glibc-headers = 2.3.3 is needed by glibc-devel-2.3.3-1
	db4 = 4.2.52 is needed by pam-0.77-24
	libproc.so.2.0.17 is needed by rusers-server-0.17-34.sel
	libtcl8.4.so is needed by setools-gui-1.1.1-1
	libtk8.4.so is needed by setools-gui-1.1.1-1
	glibc = 2.3.2 is needed by ( installed ) glibc-headers-2.3.2-101

it then down loads the newest 2.6.1-1.141 kernel......

starts to build the kernel...

then fails......

./selUpgrade: line 55: cd: /etc/security/selinux/src/policy/domains: 
no such file or directory

cp: cannot stat `program/unused/*': no such file or directory
rm: cannot remove `program/dpkg*': no such file or directory
rm: cannot remove `program/qmail*': no such file or directory
rm: cannot remove `program/gatekeeper*': no such file or directory
cp: cannot stat `misc/unused/*': no such file or directory

./selUpgrade: line 65: cd: /etc/security/selinux/src/policy: no such 
file or directory

make: *** no targets specified and no makefile found.  Stop.



Any help would be greatly appreciated.

I had this working fine a week ago....

Now it is broke. Looks like the SeLinux directory is not being created.




								Mark






-- 
******************************************
* Mark Shakespeare			 *
* Engineering Computer Operations Team   *
* Lawrence Livermore National Laboratory *
* 7000 East Ave		L-130            *
* Livermore,Ca 94550			 *
* 925-423-9922	      mshakes@llnl.gov   *
******************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
