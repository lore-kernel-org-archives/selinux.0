Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAULVkRb003880
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 16:31:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAULVjqY017615
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 21:31:45 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hAULVi0o017612 for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 21:31:45 GMT
Date: Sun, 30 Nov 2003 21:31:42 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy error of the day
Message-ID: <20031130213141.GF11972@vnl.com>
References: <20031129123120.GI18062@vnl.com> <200312010708.37773.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200312010708.37773.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 01, 2003 at 07:08:37AM +1100, Russell Coker wrote:
> setfiles is supposed to operate on a non-SE machine.  The current version 
> apparently still has the code to check for validity of a context before 
> applying it, the plan is to fix this and I thought it was already fixed.  It 
> will be fixed soon.

BTW, this would be doubly good. I'm ever so slowly 
working my way towards a CD and to do so I'll need to
run setfiles in a chroot on a non-selinux machine. If
setfiles could still mark, that would be really good.

I might also note that during much of my builds I 
temporarily replace setfiles with a script that
always returns true; (debootstrap does this also)
I had to do this for a few other things like 
hostname and such or else script mediated package 
installs in a chroot get horrible messed up.

If setfiles can now act reasonably on a non-selinux
build machine, perhaps I should drop the temporary
override?

It would be really nice if I could get by just with a 
policy.15 file instead of needing to write the
disk image to a test machine, boot, label and then
save the disk image.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
