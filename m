Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RHLXrT021591
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 13:21:33 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RHLUoM025062
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 17:21:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: file_contexts/types.fc
Date: Sat, 28 Aug 2004 03:21:28 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200408272141.36561.russell@coker.com.au> <200408280305.02429.russell@coker.com.au> <20040827171045.GA18446@vnl.com>
In-Reply-To: <20040827171045.GA18446@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408280321.28519.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 28 Aug 2004 03:10, Dale Amon <amon@vnl.com> wrote:
> On Sat, Aug 28, 2004 at 03:05:02AM +1000, Russell Coker wrote:
> > > It usually means Digital Signal Processor.
> >
> > Yes, the issue however is what a DSP board is.  Is it a software
> > modem/sound card device (like the MWave cards in older Thinkpads)?  Is it
> > a numeric co-processor for offloading some computations from the main CPU
> > (useful for sound/video processing)?
>
> The only ones I'm familiar with were boards that
> had one or more DSP chips on them for massive
> offboard general purpose signal processing. There
> was a dandy one for NeXT's from IRCAM many years
> back...

Maybe for that sort of thing a type external_processor_device_t type would do.  
If the DSP in question is the same as the one from the NEXT.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
