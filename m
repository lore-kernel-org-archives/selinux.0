Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9GGMUWt004253
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 12:22:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9GGMRmR004834
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 16:22:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9GGMQjp004829 for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 16:22:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: genfscon and /boot
Date: Fri, 17 Oct 2003 02:22:23 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310162109.25021.russell@coker.com.au> <20031016160225.GM6726@vnl.com>
In-Reply-To: <20031016160225.GM6726@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310170222.23531.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 17 Oct 2003 02:02, Dale Amon wrote:
> On Thu, Oct 16, 2003 at 09:09:25PM +1000, Russell Coker wrote:
> > The Sun/Cobalt people are aware of this issue and it will hopefully be
> > resolved soon, but we still want a solution to this as probably not all
> > hardware will get the bugs fixed soon enough.  Also some people who own
> > Cobalt hardware may not desire a ROM upgrade.
>
> I haven't worked with one for two years, but I seem to remember
> it is possible to upgrade the boot room yourself. Or it may be
> a parity error in my memory banks... :-)

Yes, you can upgrade it yourself.  But keep in mind that an error or 
corruption will result in unusable hardware.  Such an upgrade makes ME 
nervous, many people will refuse to do such things to their hardware.  Also 
this is just one example of a problem situation where a work-around is 
desirable, there are others.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
