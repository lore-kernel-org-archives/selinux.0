Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h58DQUI4010892
	for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2003 09:26:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h58DQUtV020480
	for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2003 13:26:30 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h58DQRal020477 for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2003 13:26:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Kurt Roeckx <Q@ping.be>, selinux@tycho.nsa.gov
Subject: Re: Weird problem using latest kernel.
Date: Sun, 8 Jun 2003 23:25:13 +1000
References: <20030608114617.GA4456@ping.be>
In-Reply-To: <20030608114617.GA4456@ping.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306082325.13088.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 8 Jun 2003 21:46, Kurt Roeckx wrote:
> I've been using 2.4.21-rc2, without patch, for a while without
> problems.  Then I switched to 2.4.21-rc7 with the patch for rc6
> found on http://www.coker.com.au/selinux/kern/
>
> Using that, the first night something must have gone wrong using
> updatedb, it was still running when I got back home that night,
> which is ore than 12 hours after it starts.  You could hear the
> hard disk going, the load was around 8, it was very unresponsive.
> I just rebooted it.

I am having similar problems with 2.4.21-rc6 and also with rc3.

It seems that there is some sort of memory leak in the kernel.  After a while 
the machine starts thrashing even when there is nothing much happening.

One example is a machine running KDE3 and Mozilla became extremely slow.  It 
was then changed to run FVWM and Mozilla and was still extremely slow (even 
though FVWM uses much less memory than KDE).  I then rebooted the machine and 
ran KDE3 with Mozilla in the same manner as before, swap was not used at all!

I conclude that there is a memory leak in the kernel which requires a periodic 
reboot.

I don't think that this is a SE Linux related issue as my patch was a very 
simple forward-port of the 2.4.20 patch (which worked for a long time without 
such issues).  If you have evidence to the contrary then please describe it.

I believe that the bug is in the main kernel code.  I have not reported this 
to the linux-kernel list because I don't have enough hard evidence, and I 
expect that lots of other people have discovered the same bug.  If you choose 
to post to linux-kernel then please feel free to quote my message or provide 
the URL for the SE Linux list archives.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
