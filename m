Date: Fri, 1 Jun 2007 12:40:53 +0100
From: Stephen Bennett <spb@gentoo.org>
To: James Antill <jantill@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan
 <kmacmill@redhat.com>, selinux@tycho.nsa.gov,
        Stephen Smalley
 <sds@tycho.nsa.gov>
Subject: Re: SELinux userspace infrastructure language
Message-ID: <20070601124053.5942ac27@maya>
In-Reply-To: <1180671015.7793.22.camel@code.and.org>
References: <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	<1180633622.3534.78.camel@localhost.localdomain>
	<6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	<20070531204502.3a667419@maya>
	<1180671015.7793.22.camel@code.and.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 01 Jun 2007 00:10:15 -0400
James Antill <jantill@redhat.com> wrote:

> > From the library side, C++ has the advantage that it can produce
> > bindings for any language that C can.
> 
>  Do you have a examples of this? From what little I know it's _much_
> harder to produce usable bindings from C++, the Qt/KDE bindings seem
> to have been in the works for years now and AIUI only very
> recently[1] got into KDE's stable branch. With the first non-C++
> application being written in ... python.

I know from recent experience that Ruby and Python can be done directly
without too much trouble. If anything else is needed that particularly
defies bindings in C++, one can (in principle, and if you haven't
relied upon too many of the more advanced language features) create a C
API by turning all object pointers into opaque types and wrapping
methods in regular function calls, then go from that.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
