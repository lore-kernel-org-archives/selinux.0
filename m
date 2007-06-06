Subject: Re: SELinux userspace infrastructure language
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Bennett <spb@gentoo.org>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <20070606171904.30916713@maya>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
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
Content-Type: text/plain
Date: Wed, 06 Jun 2007 12:30:01 -0400
Message-Id: <1181147401.5358.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-06 at 17:19 +0100, Stephen Bennett wrote:
> On Wed, 6 Jun 2007 11:28:04 -0400
> "Joshua Brindle" <jbrindle@tresys.com> wrote:
> 
> > >>> Not certain what you mean - you mean the private variables? You
> > >>> can use the PIMPL idiom - http://www.codepedia.com/1/CppPimpl -
> > >>> but I'm not convinced it's worth the pain. After the care we took
> > >>> to hide implementation in libsepol we didn't really make changes
> > >>> that would have broken in the ABI. 
> > >>> 
> > >> 
> > 
> > How painful is it? The examples on that page don't look too bad, and
> > they claim it reduces compile time (something you've already griped
> > about)
> 
> It's not painful really, even for very small or very large classes. If
> you're using it a lot in a given library it's not too hard to add a few
> templated utility classes to make life somewhat easier either.
> 

Can you give an example of what those templated classes do?

> > So are we going to have to pad it to be able to add stuff later on?
> > Would adding something in the public part shift the private part down
> > in a way that would break the ABI? This worries me a bit, I know QT
> > does padding to handle this but I haven't looked at what they do
> > specifically.
> 
> The public part should consist solely of one or two pointers --one to
> the private implementation part, and possibly one to the vtable if it
> has virtual functions. That sort of ABI is extremely resilient, and
> members (both data and functions) can be added without breaking it.

Hmm - I thought that adding a member function (virtual or non-virtual)
changed the ABI. Is there some technique for addressing that problem?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
