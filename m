Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA17760
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 04:44:59 -0400 (EDT)
From: pasi.kivikangas@nokia.com
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA00564
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 08:43:11 GMT
Received: from mgw-x4.nokia.com (mgw-x4.nokia.com [131.228.20.27])
        by jazzband.ncsc.mil  with ESMTP id IAA00560 for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 08:43:10 GMT
Received: from esvir03nok.nokia.com (esvir03nokt.ntc.nokia.com [172.21.143.35])
	by mgw-x4.nokia.com (Switch-2.2.1/Switch-2.2.0) with ESMTP id g8U8jUF13515
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 11:45:30 +0300 (EET DST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SE Linux and UML compile problems... 
Date: Mon, 30 Sep 2002 11:44:09 +0300
Message-ID: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8440@esebe013.ntc.nokia.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: ext Jeff Dike [mailto:jdike@karaya.com] Sent: 27 September, 2002 19:14
> 
> pasi.kivikangas@nokia.com said:
> > 	unsigned int magic = regs.regs.args[1]; 
> >	unsigned int call = regs.regs.args[2];
> >	unsigned long *args = (unsigned long *)regs.regs.args[3];
> 
> Yeah, that would be better.
> 
> 		Jeff

Hi,

Just wanted to confirm that SELinux enhanced UML kernel now boots.


	- Pasi
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
