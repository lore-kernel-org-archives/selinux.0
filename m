Date: Fri, 30 May 2003 20:15:59 -0400
From: Dave Dodge <dododge@alpha.ncsc.mil>
To: Paul Dwerryhouse <paul@dwerryhouse.com.au>
Cc: dododge@alpha.ncsc.mil, SELinux@tycho.nsa.gov
Subject: Re: sparc support
Message-Id: <20030530201559.149244d4.dododge@alpha.ncsc.mil>
In-Reply-To: <20030529062528.GA22122@localhost>
References: <sed3de3a.002@atlas.snu.edu>
	<20030529062528.GA22122@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 May 2003 08:25:28 +0200
Paul Dwerryhouse <paul@dwerryhouse.com.au> wrote:
> That'll be me. It's actually a port to sparc64, since I don't have
> access to a plain old sparc processor at the moment. It doesn't work
> yet, and I've got stuck, so I haven't done any work on it for a while.
[...]
> Basically I've used the i386 patch & Russell's arm port as a guide

Another example you can look at is the arm version from NSA's site,
in particular the linux-2.4.19-rmk4-pxa2-hh3-lsm1-arm.patch which
contains the arm-specific code. That implementation is slightly different
from Russell's and does not contain his 2.4.20 backport. I doubt it will
help much in your case, but it's another data point.

> And I'm sure I've screwed up the part for the 32-bit userspace.

I seem to recall from LKML that the 32-64 translation issue on Sparc64
is one of the reasons that sys_security was rejected for 2.5. I don't
know enough about Sparc64 Linux to recommend a workaround. Here's the
thread:

  http://www.ussg.iu.edu/hypermail/linux/kernel/0210.2/0854.html

                                      -Dave Dodge/dododge@alpha.ncsc.mil

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
