Date: Thu, 31 May 2007 20:45:02 +0100
From: Stephen Bennett <spb@gentoo.org>
To: "Joshua Brindle" <jbrindle@tresys.com>
Cc: "Karl MacMillan" <kmacmill@redhat.com>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: SELinux userspace infrastructure language
Message-ID: <20070531204502.3a667419@maya>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
References: <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	<1180633622.3534.78.camel@localhost.localdomain>
	<6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 31 May 2007 13:54:23 -0400
"Joshua Brindle" <jbrindle@tresys.com> wrote:

> Given all this I think C++ is the best bet, though I'm not adverse to
> most of the frontends being written in python, it would just be nice
> if the actual policy representation and accessors are available from a
> shared library API that most languages can use.

>From the library side, C++ has the advantage that it can produce
bindings for any language that C can. Writing a library in python
pretty much guarantees that noone will write anything using it in
anything but python, and on smaller systems the python interpreter can
get to be a lot of overhead.

Python for the frontend apps though is entirely reasonable -- it's
probably quicker to write, and people are unlikely to want to import it
into another application.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
