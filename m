Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA00333
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2001 04:30:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA18943
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2001 08:30:05 GMT
Received: from mailgate.rdg.opengroup.org (mailgate.rdg.opengroup.org [192.153.166.4])
	by jazzswing.ncsc.mil  with SMTP id IAA18939
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2001 08:30:05 GMT
Received: from skye.rdg.opengroup.org [192.153.166.247] by smtp.opengroup.org via smtpd  V1.38 (00/07/25 13:18:13) for <selinux@tycho.nsa.gov> ; Tue Jul 17 09:31 BST 2001
Date: Tue, 17 Jul 2001 09:26:45 +0100
From: Andrew Josey <ajosey@rdg.opengroup.org>
Message-Id: <1010717082645.ZM14928@skye.rdg.opengroup.org>
In-Reply-To: JOSEPH I. BERGMANN's message as of Jul 17, 12:10am.
References: <5.0.2.1.2.20010717000931.01f74680@mail00708.popserver.pop.net>
Reply-To: ajosey@rdg.opengroup.org (Andrew Josey)
To: "'NSA SELinux Mailing List'" <selinux@tycho.nsa.gov>
Subject: Re: Linux and Posix compliance
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>2) The tests do not cost a fortune since the IEEE still (I believe) owns
>them, what costs a fortune is the certification by an independent body that
>a candidate platform meets the tests.  The bar was always set high to
>preclude the unscrupulous vendor from cheating, as many would be prone to
>do.  If one wanted to test Linux it would be fairly cheap if not free to do
>the testing.  And as I mailed Wally privately it would likely come pretty
>close to passing (my subjective guess would be that it would be about 80%
>compliant) with no changes, and with some work around certain IPC constructs
>could probably be made to comply.

I believe the fee structure setup with the NVLAP accredited labs
(for NIST) typically included some aspect of consultancy to complete the
paperwork of the conformance documentation. The actual certification
fees were typically much lower (the order of a few hundred dollars).

Today you can pick up the VSX-PCTS, pre-configured for Linux
in the form of the LSB-VSX test suite being used as part of
the Linux Standard Base testing efforts, and run this quite easily
on any machine.  Unofficial results are available from
the LSB test website at http://www.linuxbase.org/
The Open Group would be happy to certify an application for
compliance using the VSX-PCTS and charge just an administrative
processing fee

best regards
Andrew


-----
Andrew Josey                                The Open Group
Director, Server Platforms                  Apex Plaza,Forbury Road,
Email: a.josey@opengroup.org                Reading,Berks.RG1 1AX,England
Tel:   +44 118 9508311 ext 2250             Fax: +44 118 9500110
Mobile: +44 774 015 5794

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
