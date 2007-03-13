Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2DG2X2k024629
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 12:02:33 -0400
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2DG2SW5002336
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 16:02:30 GMT
Received: by nf-out-0910.google.com with SMTP id n15so2620896nfc
        for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 09:01:54 -0700 (PDT)
Message-ID: <9d1b82480703130901s767720eex709936ac66485cfb@mail.gmail.com>
Date: Tue, 13 Mar 2007 21:31:53 +0530
From: Pravin <shindepravin@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Getting Security Identifier (SID) for newly created process
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I have some doubts in how the security context of newly created
process is decided.
I think that there are some policies written by user, which will
decides the security context of new process depending on the security
context of the parent process and the executable from which process
has been created.

If this is the case, Can I know which is the interface function
provided by selinux, that will tell the SID of new process created.

This also raises the question that How first process is getting its
security context?
is it from selinux policy or is it being constant?

Thanx,
-- 
Pravin Shinde

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
