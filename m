Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7C6WXHa017882
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2003 02:32:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7C6VEOD005632
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2003 06:31:14 GMT
Received: from smtp2.poczta.onet.pl (smtp2.poczta.onet.pl [213.180.130.30])
	by jazzswing.ncsc.mil  with ESMTP id h7C6VDKO005629
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2003 06:31:14 GMT
Message-ID: <00c601c3609b$645d9d80$260b0aac@MWPCNOWY>
Reply-To: "Marcin Wasilewski" <marcinwasilewski@poczta.onet.pl>
From: "Marcin Wasilewski" <marcinwasilewski@poczta.onet.pl>
To: <selinux@tycho.nsa.gov>
Subject: Building the policy
Date: Tue, 12 Aug 2003 08:31:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
I'm using debian woody (2.4.18 kernel) and try to install selinux. It is a
fresh woody system.
I've patched the kernel with lsm (it is compiled and redy to install) but
I've the problem with policy.
The packages are from:
deb http://microcomaustralia.com.au/debian  stable selinux
I'm installing packages using dselect so all packages needed for selinux are
already installed.
The final step before reboot is to install "selinux" package &
selinux-policy-default package: mine are:
selinux200307110601.bam.1_i386.deb
selinux-policy-default2003071106-1.bam.1_i386.deb

After installing selinux-policy-default it is asking me some questions about
policy files(as it should :) ), but then I get an error message. Here is
some output:
make -C /etc/selinux clean
make -C /etc/selinux load
some compilations....

/usr/bin/checkpolicy -o policy policy.conf
/usr/bin/checkpolicy: loading policy configuration from policy.conf
ERROR 'attribute file_type is not declared at token ';' on line 867:
type device_t; file_type;

What is wrong?
Best regards
Marcin


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
