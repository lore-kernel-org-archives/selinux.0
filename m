Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5ALWfI4020912
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2003 17:32:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5ALWU5e007566
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2003 21:32:30 GMT
Received: from tartarus.telenet-ops.be (tartarus.telenet-ops.be [195.130.132.46])
        by jazzband.ncsc.mil  with ESMTP id h5ALWT92007557 for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2003 21:32:29 GMT
Date: Tue, 10 Jun 2003 23:32:06 +0200
From: Kurt Roeckx <Q@ping.be>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Weird problem using latest kernel.
Message-ID: <20030610213206.GA4837@ping.be>
References: <20030608114617.GA4456@ping.be> <200306082325.13088.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200306082325.13088.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 08, 2003 at 11:25:13PM +1000, Russell Coker wrote:
> On Sun, 8 Jun 2003 21:46, Kurt Roeckx wrote:
> > I've been using 2.4.21-rc2, without patch, for a while without
> > problems.  Then I switched to 2.4.21-rc7 with the patch for rc6
> > found on http://www.coker.com.au/selinux/kern/
> >
> > Using that, the first night something must have gone wrong using
> > updatedb, it was still running when I got back home that night,
> > which is ore than 12 hours after it starts.  You could hear the
> > hard disk going, the load was around 8, it was very unresponsive.
> > I just rebooted it.
> 
> I believe that the bug is in the main kernel code.  I have not reported this 
> to the linux-kernel list because I don't have enough hard evidence, and I 
> expect that lots of other people have discovered the same bug.  If you choose 
> to post to linux-kernel then please feel free to quote my message or provide 
> the URL for the SE Linux list archives.

Just for update, the current uptime is just over 4 days now
without any problems at all running on a plain 2.4.21-rc7.

I really believe the problem is in the patch.


Kurt


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
