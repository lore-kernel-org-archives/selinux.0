Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7VHZInO009230
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 13:35:18 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7VHYdi2029159
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 17:34:40 GMT
Date: Thu, 31 Aug 2006 12:19:08 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Joshua Brindle <method@gentoo.org>, russell@coker.com.au,
        selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
Subject: Re: type transitioning script race condition?
Message-ID: <20060831171908.GF12307@w-m-p.com>
References: <20060830223937.GB12307@w-m-p.com> <200608310918.03263.russell@coker.com.au> <44F6539E.7090800@gentoo.org> <1157030632.3106.7.camel@localhost.localdomain> <1157032383.24429.90.camel@twoface.columbia.tresys.com> <1157038164.14623.6.camel@localhost.localdomain> <20060831160222.GD12307@w-m-p.com> <1157042350.14623.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157042350.14623.25.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 31, 2006 at 12:39:10PM -0400, Karl MacMillan wrote:
> On Thu, 2006-08-31 at 11:02 -0500, Klaus Weidner wrote:
> > - create link to executable (the link can be one of the path components),
> >   for example:
> > 
> > 	ln -s /usr/sbin /tmp/hack
> 
> In a strict environment the creation of the symlinks to privileged
> applications should be controlled.

Yes, but this gets tricky in a case like this where the symlink just
points to a directory used as a path component, and stat()ing the
executable file won't reveal that it's accessed through a link.  You'd
need to very restrictive about symlinks, for example not permitting links
pointing to something you don't own or can't write.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
