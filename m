Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA19527
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 02:42:29 -0400 (EDT)
From: pasi.kivikangas@nokia.com
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id GAA00025
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 06:40:42 GMT
Received: from mgw-x4.nokia.com (mgw-x4.nokia.com [131.228.20.27])
        by jazzband.ncsc.mil  with ESMTP id GAA00021 for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 06:40:41 GMT
Received: from esvir03nok.nokia.com (esvir03nokt.ntc.nokia.com [172.21.143.35])
	by mgw-x4.nokia.com (Switch-2.2.1/Switch-2.2.0) with ESMTP id g8Q6guF02388
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 09:42:56 +0300 (EET DST)
Received: from esebh001.NOE.Nokia.com (unverified) by esvir03nok.nokia.com
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T5d91fd248aac158f230ad@esvir03nok.nokia.com> for <selinux@tycho.nsa.gov>;
 Thu, 26 Sep 2002 09:40:44 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SELinux on UML
Date: Thu, 26 Sep 2002 09:40:43 +0300
Message-ID: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE842A@esebe013.ntc.nokia.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: ext Russell Coker [mailto:russell@coker.com.au] Sent: 26 September, 2002 00:17
> 
> I've just had a quick look at it.  It seems that UML provides 
> a different ptrace interface internally.

That's correct, actually interface seems to be very different to what SE is using and it also seems that UML has had troubles with ptrace earlier.

> I've sent Jeff an email asking how to get the ptrace stuff 
> working on UML, but it might be better to get the SE kernel code to not do things 
> that way if possible...

Hopefully that can be done. It'd be so cool to just turn on and off virtual machines instead of real ones after doing some fatal experiments.


	- Pasi



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
