Date: Thu, 31 May 2007 21:28:31 +0100
From: Stephen Bennett <spb@gentoo.org>
To: Karl MacMillan <kmacmill@redhat.com>
Cc: Chad Sellers <csellers@tresys.com>, Joshua Brindle
 <jbrindle@tresys.com>,
        selinux@tycho.nsa.gov, Stephen Smalley
 <sds@tycho.nsa.gov>
Subject: Re: SELinux userspace infrastructure language
Message-ID: <20070531212831.039d6949@maya>
In-Reply-To: <1180641428.22021.34.camel@localhost.localdomain>
References: <C2848590.223A5%csellers@tresys.com>
	<1180638802.22021.17.camel@localhost.localdomain>
	<20070531205635.3b85f72b@maya>
	<1180641092.22021.30.camel@localhost.localdomain>
	<1180641428.22021.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 31 May 2007 15:57:08 -0400
Karl MacMillan <kmacmill@redhat.com> wrote:

> > I think there are things that are very useful for us around config
> > file parsing, general string handling, etc. Also the graph library
> > would be great for some of the analysis tasks.

This is true, though last time I looked at the boost parser libraries
(admittedly quite a few years ago) they felt more like a nice
demonstration of how to abuse certain language features in new and
interesting ways than a practical way to get things done. The other
parts I've not yet had a need to use.

> > Last time I used it I kept a private copy and only linked in what I
> > used. I guess we could limit the use to python, though, and only
> > have it as a runtime requirement for the python bindings.

Yeah, in many cases this is the only reasonable way to use it. Which is
a shame, really, because some small parts can be nice to have but
aren't worth depending on the entire thing for.

> Most of boost is just headers, so it is just a compile time
> dependency.

Another good point, though my perception here is rather skewed towards
Gentoo, where compile time dependencies are just as much of a pain, and
boost is a really big compile time depend for just a couple of headers.
That's fixed by importing small parts of it into the source tree,
though, so it's not a massive problem.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
