Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA13701
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 17:14:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA20127
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 21:13:32 GMT
Received: from mailgw3a.lmco.com (mailgw3a.lmco.com [192.35.35.7])
        by jazzband.ncsc.mil  with ESMTP id VAA20123 for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 21:13:32 GMT
Received: from emss04g01.ems.lmco.com ([166.17.13.122])
	by mailgw3a.lmco.com (8.11.6/8.11.6) with ESMTP id g5PLEuk06092
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 17:14:57 -0400 (EDT)
Received: from CONVERSION-DAEMON.lmco.com by lmco.com (PMDF V6.1-1 #40649)
 id <0GYA00L015OV7T@lmco.com> for selinux@tycho.nsa.gov; Tue, 25 Jun 2002 17:14:56 -0400 (EDT)
Received: from emss04i00.ems.lmco.com ([166.17.13.135]) by lmco.com (PMDF V6.1-1 #40649)
 with ESMTP id <0GYA00NLN5ORF1@lmco.com> for selinux@tycho.nsa.gov; Tue, 25 Jun 2002 17:14:54 -0400 (EDT)
Date: Tue, 25 Jun 2002 17:14:42 -0400
From: "Boyne, Patrick J" <patrick.j.boyne@lmco.com>
Subject: Question
To: selinux@tycho.nsa.gov
Message-id: <91A6D3929D6BD4119B8C0008C7E665640C565E08@emss04m03.ems.lmco.com>
MIME-version: 1.0
Content-type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I have a question regarding importing and exporting data from a SELinux
system via the floppy drive. If a user brings data into the system from a
floppy disk with (as an example) a non-ext[2|3] filesystem, am I correct in
thinking that the files will be labeled with the security context of the
directory they are filed under? If the data was labeled on a disk with an
ext2 filesystem are those labels preserved when it is copied or is the label
altered? Or is this policy-dependent?

I'm curious about the reverse cases too; that is, exporting data. I
appreciate any help. 

Thanks,

> Patrick J. Boyne
> M&DS Delaware Valley Technical Operations
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
