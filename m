Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA11653
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 18:09:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBEN9cI18366
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 23:09:38 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id gBEN9Zf18362 for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 23:09:36 GMT
Date: Sun, 15 Dec 2002 10:13:58 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: new Debian packages
Message-ID: <20021214231358.GA4484@snoopy.apana.org.au>
References: <20021213223108.GA5424@lyta.coker.com.au> <20021214004206.D22479@lemuria.org> <20021214005331.GG13385@snoopy.apana.org.au> <200212142245.15413.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212142245.15413.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Dec 14, 2002 at 10:45:15PM +0100, Russell Coker wrote:
> That'll keep you busy!

The main reason I haven't been racing to do 2.4.20!

> I've given up on EVMS as Linus is not accepting the full EVMS thing and they 
> have been forced to radically change their plans.  As this happened before I 
> got around to doing anything serious with EVMS I decided to skip it until 
> it's all settled down.

EVMS looks pretty good, the reason it wouldn't work on my test
machine was because the lvm EVMS module wasn't going to autoload.
All EVMS modules need to be manually loaded, it appears.

I will be interested to see what happens with EVMS now, apparently
the user front ends will remain identical, just the backend will use
existing kernel components, like LVM2 and device mapper, instead
of "re-inventing the wheel".

> FreeS/WAN is in a similar situation, it's never going into the main kernel 
> tree and there's already a replacement for 2.6.

Agreed here, it may be that I never get FreeS/WAN working as a result
(although I came pretty close on my last attempt).

> I've been thinking that it may be time to start moving some of my machines to 
> 2.5.x.  I think that 2.5.x development has slowed down enough for me to port 
> the LSM patches between kernels.
> 
> I'm just looking at 2.5 now.  It appears to have IPSec, it has device-mapper 
> (not sure if this means LVM2 is in), it has ACLs, and lots of other nice 
> things such as CryptoAPI.

My impression was that LVM2 was in already, but I might be mistaken.

> Maybe next time I run SE play machines I'll run one on a 2.4.x kernel and one 
> on 2.5.x (Sun gave me a RaQ to use for this sort of thing - thanks Sun).
> 
> > I am not sure if there are version of these patches that will work
> > with 2.4.20 yet, that is something I need to investigate (DOV at least
> > is suppost to have been integrated into the kernel by now).
> 
> What is DOV?

Data-Over-Voice, an ugly hack for ISDN in Australia to get cheaper ISDN
call rates (Telstra thinks it is a voice call, not a data call...).

Getting back to SE-Linux, and my private archive, I have been
experimentating with DAK (the official Debian archive scripts).
I have almost entirely converted my archive to use these scripts
instead of my own (which had certain limitations that were going
to be hard to fix).

This means that I can:
- Support automatic package installs, without manual intervention.
- Better checks new files, eg. to make sure the version is correct
  and there is a copy of the *.orig.tar.gz file available.
- Support automatically deleting obsolete files.
- Cryptographic signing of Release file, which can be used to ensure
  that all other files in the archive are valid.
- Support automatic building on other architectures (except
  I don't have any spare non-i386 computers to do this...).
- Automatic notifications to a mailing list for new uploads
  (would anybody be interested in subscribing to such a mailing list?).
- There are 3 distributions: unstable (where new uploads will go),
  testing (only there because some of the scripts stupidly hardcode it),
  and stable (where packages go when there appear to be working).

What I still have to do:
- Create announce mailing list?
- Fix packages that DAK rejects, due to technical errors in packaging.
- Learn who to move packages from "unstable" to "stable"
  (I suspect I know how; not tested yet).
- Think of some use for the "testing" distribution.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
