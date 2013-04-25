Date: Thu, 25 Apr 2013 22:01:30 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [Ann] SELinux userspace release
Message-ID: <20130425200130.GA17297@siphos.be>
References: <CADjGSjhkWnxg6rEzUowJ4pU0icFYbboxeDh2ejZ6gpg83W0QYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CADjGSjhkWnxg6rEzUowJ4pU0icFYbboxeDh2ejZ6gpg83W0QYA@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 23, 2013 at 10:34:52AM -0400, Joshua Brindle wrote:
> A new release of the SELinux userspace has been posted to:
> http://userspace.selinuxproject.org/trac/wiki/Releases
> 
> Most of the changes were bug fixes related to leaking file descriptors and
> memory errors reported by Coverity. The full Changelog is in each package.

I had a few issues while getting this release in Gentoo.


https://bugs.gentoo.org/show_bug.cgi?id=467258

- libselinux does not provide selinux_current_policy_path() but this method is
  used in policycoreutils in a number of locations.

I had to take the definition from this method from
http://svnweb.mageia.org/packages/cauldron/libselinux/current/SOURCES/libselinux-rhat.patch?revision=400400&view=co&pathrev=400400
(only included the definition in Gentoo for now). Seems that this is a
much-needed function (otherwise tools like semanage just break).


https://bugs.gentoo.org/show_bug.cgi?id=467264

- using semanage permissive fails with stacktrace referring to a Makefile on
  a non-existing location (/usr/share/selinux/default/Makefile)

I have yet to find the culprit of this (getting late so that'll be for
tomorrow evening).


https://bugs.gentoo.org/show_bug.cgi?id=467268

- policycoreutils' sepolicy command requires yum python bindings

Since yum is not available on Gentoo, is this really necessary?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
