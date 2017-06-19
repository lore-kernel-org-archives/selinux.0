Message-ID: <1497891970.27645.5.camel@tycho.nsa.gov>
Subject: Re: ANN: SELinux userspace 2.7-rc2 release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Zaman <jason@perfinion.com>
Cc: selinux@tycho.nsa.gov
Date: Mon, 19 Jun 2017 13:06:10 -0400
In-Reply-To: <20170618073233.GA24080@meriadoc.perfinion.com>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1497632109.7898.5.camel@tycho.nsa.gov>
 <20170618073233.GA24080@meriadoc.perfinion.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, 2017-06-18 at 15:32 +0800, Jason Zaman wrote:
> There is a bug that needs to be fixed before the final release:
> https://bugs.gentoo.org/show_bug.cgi?id=621762
> 
> I think the fix is just add override in utils/Makefile to the LDLIBS
> and
> LDFLAGS bits. I'm not sure I'll have time to get around to testing
> it so just wanted to let you know before the final release.

I wondering if we should actually revert
fcb5d5cc721187b3e3a19b44155d5b824d7be7e6, at least wrt removal of -L/-
I.  This seems to have broken usage of DESTDIR (except from top-level,
via 9a7763e18604c4649ff67ea6d43a730f90311592, which doesn't help people
using the individual tar balls.  And it seems like many package recipes
are relying on make DESTDIR= to work as expected.
