Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43LTERb008739
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 17:29:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i43LR0Zx013218
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 21:27:00 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i43LQuJv013124
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 21:27:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: Policy file for 'aide' and/or 'tripwire'?
Date: Tue, 4 May 2004 07:27:44 +1000
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
References: <200404271752.i3RHqC8E015562@turing-police.cc.vt.edu> <200405030245.39737.russell@coker.com.au> <200405031802.i43I2sw2001668@turing-police.cc.vt.edu>
In-Reply-To: <200405031802.i43I2sw2001668@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405040727.44433.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 May 2004 04:02, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 03 May 2004 02:45:39 +1000, Russell Coker said:
> > On Wed, 28 Apr 2004 03:52, Valdis.Kletnieks@vt.edu wrote:
> > > Has anybody already done a policy file for Tripwire or its
> > > open-sourced replacement 'aide'?
> >
> > Why not run it in the domain backup_t?  Tripwire and backup programs both
> > need read access to all files..
>
> Good hint - I'll have to chase that.  Looks like it's almost but not quite
> what I want - looks like a few lines of tweaking should suffice (I'm pretty
> sure that can_network can be heaved over the side of the .te file, and I
> need other directories labeled with backup_store_t in the .fc file).

However a tripwire program that sends md5 checksums over the wire could be 
handy.

If there are standard locations for the tripwire database and binaries then 
let me know and I'll add them to the policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
