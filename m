Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4I9pLRb000038
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 05:51:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4I9muB2029955
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:48:56 GMT
Received: from zinc.btinternet.com (zinc.btinternet.com [194.73.73.148])
	by jazzswing.ncsc.mil  with ESMTP id i4I9muwi029952
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:48:56 GMT
Received: from [81.130.181.235] (helo=lkcl.net)
	by zinc.btinternet.com with esmtp (Exim 3.22 #25)
	id 1BQ1Fl-0007Wy-00
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 10:51:17 +0100
Received: from highfield ([192.168.0.223]:34026 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQ1IX-0007YG-OC
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:54:09 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQ1DB-0006La-Nf
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 09:48:37 +0000
Date: Tue, 18 May 2004 09:48:37 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [latest cvs]: build error on printer_device_t not recognised
Message-ID: <20040518094837.GA24333@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, i just took dan walsh's deb .diff, copied over the debian/
files from the patch, then added serviceusers to debian/rules
in the cp -r stuff.

this enables me to create a .deb to copy over to the target machine.

i removed all previous /etc/selinux stuff and /usr/share/selinux
stuff.

on install, i get:

	tv:/etc/selinux# make
	mkdir -p /etc/security/selinux
	/usr/bin/checkpolicy -o /etc/security/selinux/policy.17 policy.conf
	/usr/bin/checkpolicy:  loading policy configuration from policy.conf
	domains/program/cups.te:29:ERROR 'unknown type printer_device_t' at
	token ';' on line 44054:

	allow cupsd_t printer_device_t:chr_file { ioctl read getattr lock write
	append };
	/usr/bin/checkpolicy:  error(s) encountered while parsing configuration

i find the printer_device_t definition to be in
domains/program/unused/lpd.te

is this error something to do with me having cups installed but not
lpd?

i believe i am correct in thinking that you don't need lpd installed in
order for cups to work _as a client_.

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
