Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RH58rT021437
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 13:05:08 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RH4JpX007472
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 17:04:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: file_contexts/types.fc
Date: Sat, 28 Aug 2004 03:05:02 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200408272141.36561.russell@coker.com.au> <20040827152538.GD8872@vnl.com>
In-Reply-To: <20040827152538.GD8872@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408280305.02429.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 28 Aug 2004 01:25, Dale Amon <amon@vnl.com> wrote:
> On Fri, Aug 27, 2004 at 09:41:36PM +1000, Russell Coker wrote:
> > for /dev/mdsp (it's a DSP board whatever that means, not a hard disk).
>
> It usually means Digital Signal Processor.

Yes, the issue however is what a DSP board is.  Is it a software modem/sound 
card device (like the MWave cards in older Thinkpads)?  Is it a numeric 
co-processor for offloading some computations from the main CPU (useful for 
sound/video processing)?

What uses this board?  What does it use it for?

Without answers to these questions we can't do anything about assigning a type 
to it apart from determining that it's not a hard disk.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
