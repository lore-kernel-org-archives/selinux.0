Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA18397
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 17:40:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA20116
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 21:39:49 GMT
Received: from mailgw3a.lmco.com (mailgw3a.lmco.com [192.35.35.7])
	by jazzswing.ncsc.mil  with ESMTP id VAA20112
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 21:39:49 GMT
Received: from emss04g01.ems.lmco.com ([166.17.13.122])
	by mailgw3a.lmco.com (8.11.6/8.11.6) with ESMTP id g5ALe3W05010
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 17:40:03 -0400 (EDT)
Received: from CONVERSION-DAEMON by lmco.com (PMDF V5.2-33 #40649) id <0GXI00001ANW39@lmco.com> for selinux@tycho.nsa.gov;
 Mon, 10 Jun 2002 17:40:03 -0400 (EDT)
Received: from emss04i00.ems.lmco.com ([166.17.13.135]) by lmco.com (PMDF V5.2-33 #40649)
 with ESMTP id <0GXI00FAMEH4O8@lmco.com> for selinux@tycho.nsa.gov; Mon, 10 Jun 2002 17:31:53 -0400 (EDT)
Date: Mon, 10 Jun 2002 17:31:51 -0400
From: "Boyne, Patrick J" <patrick.j.boyne@lmco.com>
Subject: RE: auditing etc
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Message-id: <91A6D3929D6BD4119B8C0008C7E665640A4A3425@emss04m03.ems.lmco.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I have used the snare module for auditing extensively with SELinux
> and it works well . I have not look into the IBM module yet, but
> will check is out. Sound promising.

I was thinking of testing this out on a development machine I have right
now. I'm glad someone else has given it a shot. Is there more information on
the IBM module somewhere? If so could someone please contact me with it? 

Mostly I've been pondering the -types- of events a secure system might want
to record (beyond what syslog already deals with), such as users changing
their role, the audit limit being exceeded (partition fills, etc), and
perhaps attempts to read the audit information or alter its configuration.

My own thoughts on auditing are likely novice at best, and I'll ask you to
please excuse me if I'm off base, but I was thinking that the current
sysklogd would make a decent baseline for a more robust auditing facility.
Might it be possible to add a facility and or priorities to the existing
system to label something as 'audit' level, and then use syslog to direct it
where it needs to go, be it a separate file or another machine?

Patrick Boyne

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
