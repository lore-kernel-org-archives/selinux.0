Date: Wed, 6 Jun 2007 18:07:45 +0100
From: Stephen Bennett <spb@gentoo.org>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Stephen
 Smalley <sds@tycho.nsa.gov>
Subject: Re: SELinux userspace infrastructure language
Message-ID: <20070606180745.1052eece@maya>
In-Reply-To: <1181147401.5358.1.camel@localhost.localdomain>
References: <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	<1180633622.3534.78.camel@localhost.localdomain>
	<6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	<1180639909.22021.26.camel@localhost.localdomain>
	<1180995888.9766.63.camel@localhost.localdomain>
	<6FE441CD9F0C0C479F2D88F959B01588BF044D@exchange.columbia.tresys.com>
	<1180975778.2862.36.camel@localhost.localdomain>
	<6FE441CD9F0C0C479F2D88F959B01588BF0507@exchange.columbia.tresys.com>
	<1181141337.12540.16.camel@localhost.localdomain>
	<6FE441CD9F0C0C479F2D88F959B01588BF0548@exchange.columbia.tresys.com>
	<1181143088.12540.42.camel@localhost.localdomain>
	<6FE441CD9F0C0C479F2D88F959B01588BF055F@exchange.columbia.tresys.com>
	<20070606171904.30916713@maya>
	<1181147401.5358.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 06 Jun 2007 12:30:01 -0400
Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:

> > It's not painful really, even for very small or very large classes.
> > If you're using it a lot in a given library it's not too hard to
> > add a few templated utility classes to make life somewhat easier
> > either.
> > 
> 
> Can you give an example of what those templated classes do?

The one I've been using recently is found at 
http://paludis.pioto.org/trac/browser/trunk/paludis/util/private_implementation_pattern.hh
and
http://paludis.pioto.org/trac/browser/trunk/paludis/util/private_implementation_pattern-impl.hh
(apologies for long URLs). Usage is fairly simple: in a class Foo,
simply inherit from PrivateImplementationPatter<Foo>, and then
initialise _imp with 'new Implementation<Foo>(args here)'. The entirety
of Implementation<Foo> can then be hidden away in the .cc file,
inaccessible to the outside world.

> Hmm - I thought that adding a member function (virtual or non-virtual)
> changed the ABI. Is there some technique for addressing that problem?

Not as far as I'm aware .. adding a new virtual method will break the
ABI if it's placed before any existing ones, but non-virtual methods
and virtual methods added to the end shouldn't cause problems.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
