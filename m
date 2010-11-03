Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA3K3HYu020970
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2010 16:03:17 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id oA3K3AWT025326
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2010 20:03:17 GMT
Date: Wed, 03 Nov 2010 16:03:08 -0400
Subject: CIL: the SELinux Common Intermediate Language
From: Chad Sellers <csellers@tresys.com>
To: SELinux <selinux@tycho.nsa.gov>
Message-ID: <C8F7383C.BB23F%csellers@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Last year, we talked a bit about CIL and showed some of our thinking of what
it could be. Since that time, CIL has evolved significantly. Today, I want
to start some discussions around what we've come up with.

What is CIL? Essentially, it's an intermediate policy language that provides
features to high-level languages to allow them to do what they need to do
and work together with each other. It's text-only (no more binary modules)
and uses S-expressions to make machine parsing easy (though it's definitely
human readable as well). I won't get into all of its goals and features
here, but I encourage you to read about them on the CIL design wiki.

Where are we in the process? Well, we've been continuing to flesh out the
language design for some time, and we're still doing that. You can see this
at the CIL design wiki on the SELinux userspace page:
http://userspace.selinuxproject.org/trac/wiki/CilDesign . This will continue
to grow and evolve as we make progress and get feedback from all of you.

We also have the beginnings of a compiler for this language, and you can
check it out from the git repo listed at the bottom of the design page. The
goal is to eventually merge this into libsepol, though it's a stand-alone
project that statically links against libsepol for now.

Over the next few weeks, I'm going to explain a few of the key features of
CIL here on list in order to get some feedback on them. I look forward to
your responses.

Thanks,
Chad Sellers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
