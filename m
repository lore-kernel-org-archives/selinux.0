Date: Thu, 29 May 2003 08:25:28 +0200
From: Paul Dwerryhouse <paul@dwerryhouse.com.au>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: SELinux@tycho.nsa.gov
Subject: Re: sparc support
Message-ID: <20030529062528.GA22122@localhost>
References: <sed3de3a.002@atlas.snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <sed3de3a.002@atlas.snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 27, 2003 at 09:52:15PM -0500, Joshua Brindle wrote:
> russel said one of his friends started a sparc port, i was wondering
> if anything had been done on this, particularly i'm interested in the
> wrapper.c for sparc since i know nothing of registers or kernel
> hacking, etc. 

That'll be me. It's actually a port to sparc64, since I don't have
access to a plain old sparc processor at the moment. It doesn't work
yet, and I've got stuck, so I haven't done any work on it for a while.

You can download a patch for what I've done so far, here:

http://leapster.org/linux/lsm-sparc64-2.4.20-patch.3

I don't really know what I'm doing, however, so don't expect to see
anything sane there ;)

Basically I've used the i386 patch & Russell's arm port as a guide - so now,
it compiles and boots fine, but it doesn't seem to do what it's
supposed to do, and I didn't know what to do next.

And I'm sure I've screwed up the part for the 32-bit userspace.

Cheers,

Paul

-- 
Paul Dwerryhouse						| PGP Key ID: 
Amsterdam, The Netherlands (X) <-> Melbourne, Australia ( )	| 0x6B91B584

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
