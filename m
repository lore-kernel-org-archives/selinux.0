Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA20481
	for <selinux@tycho.nsa.gov>; Mon, 1 Jul 2002 17:19:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA11932
	for <selinux@tycho.nsa.gov>; Mon, 1 Jul 2002 21:18:10 GMT
Received: from mailgw3a.lmco.com (mailgw3a.lmco.com [192.35.35.7])
        by jazzband.ncsc.mil  with ESMTP id VAA11926 for <selinux@tycho.nsa.gov>; Mon, 1 Jul 2002 21:18:10 GMT
Received: from emss04g01.ems.lmco.com ([166.17.13.122])
	by mailgw3a.lmco.com (8.11.6/8.11.6) with ESMTP id g61LJZx00775
	for <selinux@tycho.nsa.gov>; Mon, 1 Jul 2002 17:19:35 -0400 (EDT)
Received: from CONVERSION-DAEMON.lmco.com by lmco.com (PMDF V6.1-1 #40649)
 id <0GYL00C019WN5H@lmco.com> for selinux@tycho.nsa.gov; Mon, 01 Jul 2002 17:19:35 -0400 (EDT)
Received: from emss04i00.ems.lmco.com ([166.17.13.135]) by lmco.com (PMDF V6.1-1 #40649)
 with ESMTP id <0GYL005FO9WM0S@lmco.com> for selinux@tycho.nsa.gov; Mon, 01 Jul 2002 17:19:34 -0400 (EDT)
Date: Mon, 01 Jul 2002 17:19:32 -0400
From: "Boyne, Patrick J" <patrick.j.boyne@lmco.com>
Subject: RE: problems with mount
To: selinux@tycho.nsa.gov
Message-id: <91A6D3929D6BD4119B8C0008C7E665640C7E05F1@emss04m03.ems.lmco.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I'm having problems with mount. Before I issue a mount command, /mnt/cdrom
is of type file_t. Immediately after 
> running mount, /mnt/cdrom is labeled as unlabeled_t. Is that supposed to
happen? That causes no end to problems
> in getting data from a CD in enforcing mode, if I'm correct...
>  
I believe it is supposed to happen. From what I've seen, labeling is only
supported on ext[2|3] filesystems. The standard filesystem of a CD-ROM is
ISO-9660 (and read-only) so I don't believe it can be anything other than
unlabeled_t. I noticed this happened when I would mount a floppy disk with a
FAT fs on it as well. Unfortunately, I can't tell you how to fix it :) 


Patrick Boyne
>  

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
