Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2KGCUx6016842
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 11:12:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2KGCT9P021350
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 16:12:29 GMT
Received: from gemini.nr.no (gemini.nr.no [156.116.2.76])
        by jazzband.ncsc.mil  with ESMTP id h2KGCSP7021341 for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 16:12:29 GMT
Date: Thu, 20 Mar 2003 17:12:15 +0100
Message-Id: <200303201612.h2KGCFL05001@triumph.nr.no>
To: Dale Amon <amon@vnl.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SE-Linux and 2.4.20
References: <20030320002246.GC13288@snoopy.apana.org.au> <20030320111227.GJ24908@vnl.com>
From: Thor Kristoffersen <Thor.Kristoffersen@nr.no>
In-Reply-To: Dale Amon's message of "Thu, 20 Mar 2003 11:12:27 +0000"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dale Amon writes:
> Just as another data point: I had to back a 2.4.20
> kernel off a firewall because it was oopsing in random
> processes after a couple hours. Might not be related...
> the kernel had crypto, freeswan and grsec, the oops
> was during kernel paging.

I think there may be reason to suspect that there is something wrong in the
LSM code, and not necessarily SELinux itself, because in my experience
  LIDS without LSM works fine.
  LIDS with LSM
    - works fine without X
    - OOPSes with X.
This pattern has been repeatable for me across several versions of Linux,
LIDS, and LSM.  I seem to recall that these OOPSes also occured at some
kind of paging request.


Thor

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
