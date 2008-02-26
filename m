Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QGXgHe013987
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 11:33:42 -0500
Received: from ns1.a61.nl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1QGXeQG001958
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 16:33:40 GMT
Received: from localhost ([127.0.0.1] helo=www.a61.nl)
	by ns1.a61.nl with esmtp (Exim 4.54)
	id 1JU2K6-0006gi-Lu
	for selinux@tycho.nsa.gov; Tue, 26 Feb 2008 17:06:30 +0100
Message-ID: <33491.80.95.164.250.1204041990.squirrel@www.a61.nl>
Date: Tue, 26 Feb 2008 17:06:30 +0100 (CET)
Subject: Global requirements were not met
From: selinux@a61.nl
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

Still having problems setting up modules dor JBoss + Java:

I believe our JBoss module has a fine start now. We decided to write a
complete new java-module (jbossjava) so we will be able to get java to
work is strict-mode.

See the following files:
myjboss.if: http://pastebin.com/f4df202a2
myjboss.te: http://pastebin.com/d7318637b
myjboss.fc: http://pastebin.com/f2f66ff68

jbossjava.if: http://pastebin.com/f179749e8
jbossjava.te: http://pastebin.com/f1731b45d
jbossjava.fc: http://pastebin.com/f52227f13

(Probably our code isn't optimized or even corect yet, we know. We first
just want to have everyting up and running)

We are able to build an rpm with the modules included, but when installing
the newly build rpm's we see:

Preparing...                ###########################################
[100%]
   1:selinux-policy-strict  ########################################### [
33%]
libsepol.print_missing_requirements: jbossjava's global requirements were
not met: type/attribute jboss_rx_t
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed!
   2:selinux-policy         ########################################### [
67%]
   3:selinux-policy-devel   ###########################################
[100%]

Apparently, jbossjava doesn't have any access to the interfaces in
myjboss.pp. why?

Cheers!

Bart + Ronald


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
