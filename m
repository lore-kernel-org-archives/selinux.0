Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA29673
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 08:56:11 -0400 (EDT)
From: pasi.kivikangas@nokia.com
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA12105
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 12:54:40 GMT
Received: from mgw-x1.nokia.com (mgw-x1.nokia.com [131.228.20.21])
	by jazzswing.ncsc.mil  with ESMTP id MAA12095
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 12:54:39 GMT
Received: from esvir01nok.ntc.nokia.com (esvir01nokt.ntc.nokia.com [172.21.143.33])
	by mgw-x1.nokia.com (Switch-2.2.1/Switch-2.2.0) with ESMTP id g8RCtw507326
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 15:55:58 +0300 (EET DST)
Received: from esebh001.NOE.Nokia.com (unverified) by esvir01nok.ntc.nokia.com
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T5d987b29a7ac158f210a1@esvir01nok.ntc.nokia.com> for <selinux@tycho.nsa.gov>;
 Fri, 27 Sep 2002 15:56:06 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SE Linux and UML compile problems...
Date: Fri, 27 Sep 2002 15:56:00 +0300
Message-ID: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE843B@esebe013.ntc.nokia.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: ext Russell Coker [mailto:russell@coker.com.au] Sent: 26 September, 2002 17:27
> 
> I haven't had time to try this yet...
> 
> ----------  Forwarded Message  ----------
> Subject: Re: pt_regs
> Date: Wed, 25 Sep 2002 20:32:30 -0500
> From: Jeff Dike <jdike@karaya.com>
> To: Russell Coker <russell@coker.com.au>
> 
> russell@coker.com.au said:
> >        unsigned int magic = regs.ebx;
> >        unsigned int call = regs.ecx;
> 
> unsigned int magic = regs.args[1];
> unsigned int call = regs.args[2];
> 
> 				Jeff

Maybe this way?

	unsigned int magic = regs.regs.args[1];
	unsigned int call = regs.regs.args[2];
	unsigned long *args = (unsigned long *)regs.regs.args[3];


	- Pasi

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
