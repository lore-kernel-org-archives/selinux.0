Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA15851
	for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2001 15:38:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA12444
	for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2001 20:38:48 GMT
Received: from ll.mit.edu (LLMAIL.LL.MIT.EDU [129.55.12.40])
	by jazzswing.ncsc.mil  with ESMTP id UAA12440
	for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2001 20:38:47 GMT
Received: (from smtp@localhost)
	by ll.mit.edu (8.8.8/8.8.8) id PAA21580
	for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2001 15:38:50 -0500 (EST)
Message-ID: <711DB7A5731DD111A2E1006097731A0B208686@ets>
From: Robertson Wayne <robertsonw@ll.mit.edu>
To: selinux@tycho.nsa.gov
Subject: Porting to SELinux
Date: Tue, 13 Feb 2001 13:46:57 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hello All,

I have a project where I have a glob of legacy (production) code that runs
on Motorola MVME162/167 single board computers.  The OS is version 5 of
their Unix.  

My project involves upgrading the hardware and the OS and porting our code.
I would like to move to the linux world.  It is still undecided about
PowerPC, Intel, or ?? for the new SBCs.  Because we have some real time
needs and because we do need to be able to switch to a classified network I
was thinking that RT Linux along with SE Linux might do the job.

Does anyone have any comments/thoughts on the applicability of SE Linux in
an environment where RT Linux would be utilized?  Of course, there remains
the hardware issue but as I understand it SE Linux currently is not ported
to the 68K/PPC platforms and so using SE Linux would indicate a choice of
Intel boards (of which there aren't too many vendors that have such products
that are VME based).

Thanks in advance for any suggestions/comments.

Wayne Robertson
MIT - Lincoln Labs

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
