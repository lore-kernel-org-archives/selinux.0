Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98BQ9rT020796
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 07:26:09 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98BQ7Z2000437
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 11:26:07 GMT
Date: Fri, 8 Oct 2004 12:37:10 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
   lkml <linux-kernel@vger.kernel.org>, SELinux@tycho.nsa.gov,
   Ingo Molnar <mingo@redhat.com>, netdev@oss.sgi.com,
   linux-net@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4-VP-S7 - ksoftirq and selinux oddity
Message-ID: <20041008113710.GC5551@lkcl.net>
References: <200410070542.i975gkHV031259@turing-police.cc.vt.edu> <1097157367.13339.38.camel@moss-spartans.epoch.ncsc.mil> <20041008093154.GA5089@lkcl.net> <1097234322.16641.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1097234322.16641.3.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 08, 2004 at 07:18:42AM -0400, Stephen Smalley wrote:
> On Fri, 2004-10-08 at 05:31, Luke Kenneth Casson Leighton wrote:
> >  an alternative possible solution is to get the packet _out_ from
> >  the interrupt context and have the aux pid comm exe information added.
> 
> No, the network permission checks are intentionally layered to match the
> network protocol implementation.  There is a process-to-socket check
> performed in process context when the data is received from the socket
> by an actual process, but there is also the socket-to-netif/node/port
> check performed in softirq context when the packet is received on the
> socket from the network.
 
 ah.  oh well!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
