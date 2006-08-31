Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7VK2pbt014325
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 16:02:51 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7VK2VSk008794
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 20:02:31 GMT
Subject: Re: type transitioning script race condition?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Klaus Weidner <klaus@atsec.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Joshua Brindle <method@gentoo.org>, russell@coker.com.au,
        selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
In-Reply-To: <20060831171908.GF12307@w-m-p.com>
References: <20060830223937.GB12307@w-m-p.com>
	 <200608310918.03263.russell@coker.com.au> <44F6539E.7090800@gentoo.org>
	 <1157030632.3106.7.camel@localhost.localdomain>
	 <1157032383.24429.90.camel@twoface.columbia.tresys.com>
	 <1157038164.14623.6.camel@localhost.localdomain>
	 <20060831160222.GD12307@w-m-p.com>
	 <1157042350.14623.25.camel@localhost.localdomain>
	 <20060831171908.GF12307@w-m-p.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 16:02:33 -0400
Message-Id: <1157054553.26051.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-31 at 12:19 -0500, Klaus Weidner wrote:
> On Thu, Aug 31, 2006 at 12:39:10PM -0400, Karl MacMillan wrote:
> > On Thu, 2006-08-31 at 11:02 -0500, Klaus Weidner wrote:
> > > - create link to executable (the link can be one of the path components),
> > >   for example:
> > > 
> > > 	ln -s /usr/sbin /tmp/hack
> > 
> > In a strict environment the creation of the symlinks to privileged
> > applications should be controlled.
> 
> Yes, but this gets tricky in a case like this where the symlink just
> points to a directory used as a path component, and stat()ing the
> executable file won't reveal that it's accessed through a link.  You'd
> need to very restrictive about symlinks, for example not permitting links
> pointing to something you don't own or can't write.
> 

And perhaps the bigger issue is that I am totally making up the ability
to control what target a symlink has (as was pointed out by Dave Caplan
in a private mail). The only control we get is the creation of symlinks
not control over their targets.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
