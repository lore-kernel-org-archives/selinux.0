Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9KIjp4x031872
 for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2015 14:45:51 -0400
Received: by pasz6 with SMTP id z6so28939193pas.2
 for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2015 11:45:49 -0700 (PDT)
Date: Wed, 21 Oct 2015 02:45:45 +0800
From: Jason Zaman <jason@perfinion.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: did libselinux grow a new build dependency? (openssl-devel:
 openssl.h)
Message-ID: <20151020184545.GA5255@meriadoc>
References: <20151018140730.GB19335@x250>
 <1360366462.3121760.1445180447166.JavaMail.yahoo@mail.yahoo.com>
 <562531F6.8010609@tycho.nsa.gov>
 <562644AE.3080001@quarksecurity.com>
 <5626452C.6010806@tycho.nsa.gov>
 <56264829.5040609@quarksecurity.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56264829.5040609@quarksecurity.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Oct 20, 2015 at 09:56:57AM -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On 10/20/2015 09:42 AM, Joshua Brindle wrote:
> >> Stephen Smalley wrote:
> >> <snip>
> >>>
> >>> Wondering if dependency on openssl might be a license issue for Debian
> >>> or others. Apparently openssl license is considered GPL-incompatible [1]
> >>> [2], and obviously libselinux is linked by a variety of GPL-licensed
> >>> programs. Fedora seems to view this as falling under the system library
> >>> exception [3] but not clear that other distributions would view it that
> >>> way. On the other hand, using gnutls would be subject to the reverse
> >>> problem; it would make libselinux depend on a LGPL library, and that
> >>> could create issues for non-GPL programs that statically link
> >>> libselinux. We might need to revert this change and revisit how to solve
> >>> this in a manner that avoids such issues.
> >>
> >> LGPL explicitly allows non-GPL programs to link against an LGPL licensed
> >> library without tainting the non-GPL program, which is the whole point
> >> of the LGPL. Is there some other issue with static linking or something?
> >
> > Yes, that's the concern.
> 
> So, not static linking but a fully static binary that would pull gnutls 
> into the binary?
> 
> What static binaries exist like that? It is not a great idea to carry 
> around system level libraries statically.

>From a quick look through Gentoo, we have a USE-flag to build busybox
and LVM and a few other core tools statically which requres libselinux.a
too.

-- Jason
