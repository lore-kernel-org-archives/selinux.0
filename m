Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA28285
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 18:11:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA03974
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 22:11:17 GMT
Received: from prserv.net (out4.prserv.net [32.97.166.34])
	by jazzband.ncsc.mil  with ESMTP id WAA03970
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 22:11:17 GMT
Message-ID: <3B536686.FCABC4F8@cpcug.org>
Date: Mon, 16 Jul 2001 18:11:18 -0400
From: James A Griffin <agriffin@cpcug.org>
MIME-Version: 1.0
To: Ulrich Drepper <drepper@cygnus.com>
CC: Ramsey Wally Contr AFRL/IFEB <Wally.Ramsey@rl.af.mil>,
        "'NSA SELinux Mailing List'" <selinux@tycho.nsa.gov>
Subject: Re: Linux and Posix compliance
References: <D98BF3C61B66D311BA820000D11B4BDF01438540@FSJREZ03.adm.rl.af.mil>
		<3B533733.BE3E2167@cpcug.org> <m3hewcprcs.fsf@otr.mynet>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ulrich Drepper wrote:
> 
> James A Griffin <agriffin@cpcug.org> writes:
> 
> > One thing that I have noticed for years is the boot time message "POSIX
> > conformance testing by UNIFIX".  The message appears just after the CPU
> > testing and before the PCI: Probe.  UNIFIX is a UK company, IIRC.  What
> > the results of the "conformance testing" are, I do not know.
> 
> I think (and hope) they've finally removed this output.  It never was
> true and is anyway completely outdated.
> 
The "POSIX conformance testing by UNIFIX" message is still in the
kernel, see:

Linux version 2.4.7-pre5 (root@sparta.athena.inc) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-85)) #29 Tue Jul 10 21:08:23 EDT 2001
[snip]
CPU: AMD-K5(tm) Processor stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf04e0, last bus=0
PCI: Using configuration type 1
[snip]

May be time to send a note to Allen or Linus.

[snip discussion of formal testing and issues]

Regards,
Jim

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
