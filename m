Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA28418
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 18:32:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA04788
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 22:32:06 GMT
Received: from ns.caldera.de (ns.caldera.de [212.34.180.1])
	by jazzband.ncsc.mil  with ESMTP id WAA04784
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2001 22:32:06 GMT
Date: Tue, 17 Jul 2001 00:30:57 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Ulrich Drepper <drepper@cygnus.com>
Cc: James A Griffin <agriffin@cpcug.org>,
        Ramsey Wally Contr AFRL/IFEB <Wally.Ramsey@rl.af.mil>,
        "'NSA SELinux Mailing List'" <selinux@tycho.nsa.gov>
Subject: Re: Linux and Posix compliance
Message-ID: <20010717003057.A8279@caldera.de>
References: <D98BF3C61B66D311BA820000D11B4BDF01438540@FSJREZ03.adm.rl.af.mil> <3B533733.BE3E2167@cpcug.org> <m3hewcprcs.fsf@otr.mynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3hewcprcs.fsf@otr.mynet>; from drepper@redhat.com on Mon, Jul 16, 2001 at 01:10:43PM -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jul 16, 2001 at 01:10:43PM -0700, Ulrich Drepper wrote:
> James A Griffin <agriffin@cpcug.org> writes:
> 
> > One thing that I have noticed for years is the boot time message "POSIX
> > conformance testing by UNIFIX".  The message appears just after the CPU
> > testing and before the PCI: Probe.  UNIFIX is a UK company, IIRC.  What
> > the results of the "conformance testing" are, I do not know.
> 
> I think (and hope) they've finally removed this output.  It never was
> true and is anyway completely outdated.

It's still there.  And though it is outdated I bet it was once right.

> There hasn't been any formal POSIX testing done.  The reason is
> simple: who'd pay this?

UNIFIX, as the message shows.  UNIFIX is (or was?) a German Linux
distributor, located in Braunschwieg (100km from my home, so I could
take a look if no one believes in this ;)).

In 1995 or 1996 they sold a UNIFIX 2.0 distribution which was heavily
modified not only to pass the posix.1 and posix.2 (IIRC) conformance
test, but also too look more sysvish (I remeber yhey modified e.g.
ps to take ps -elf for long output instead of ps aux).

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
