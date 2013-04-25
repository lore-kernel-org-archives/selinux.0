MIME-Version: 1.0
In-Reply-To: <20130425200130.GA17297@siphos.be>
References: <CADjGSjhkWnxg6rEzUowJ4pU0icFYbboxeDh2ejZ6gpg83W0QYA@mail.gmail.com>
	<20130425200130.GA17297@siphos.be>
Date: Thu, 25 Apr 2013 19:15:22 -0400
Message-ID: <CADjGSjipXROGK+9_bpJZngjBF7rH-=U3nUpwyUdgA_UERbn=Vg@mail.gmail.com>
Subject: Re: [Ann] SELinux userspace release
From: Joshua Brindle <brindle@quarksecurity.com>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Cc: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 25, 2013 at 4:01 PM, Sven Vermeulen
<sven.vermeulen@siphos.be> wrote:
> On Tue, Apr 23, 2013 at 10:34:52AM -0400, Joshua Brindle wrote:
>> A new release of the SELinux userspace has been posted to:
>> http://userspace.selinuxproject.org/trac/wiki/Releases
>>
>> Most of the changes were bug fixes related to leaking file descriptors and
>> memory errors reported by Coverity. The full Changelog is in each package.
>
> I had a few issues while getting this release in Gentoo.
>

I suppose this is what I get for testing on Fedora with everything
already installed...

>
> https://bugs.gentoo.org/show_bug.cgi?id=467258
>
> - libselinux does not provide selinux_current_policy_path() but this method is
>   used in policycoreutils in a number of locations.
>
> I had to take the definition from this method from
> http://svnweb.mageia.org/packages/cauldron/libselinux/current/SOURCES/libselinux-rhat.patch?revision=400400&view=co&pathrev=400400
> (only included the definition in Gentoo for now). Seems that this is a
> much-needed function (otherwise tools like semanage just break).
>
>
> https://bugs.gentoo.org/show_bug.cgi?id=467264
>
> - using semanage permissive fails with stacktrace referring to a Makefile on
>   a non-existing location (/usr/share/selinux/default/Makefile)
>
> I have yet to find the culprit of this (getting late so that'll be for
> tomorrow evening).
>

semanage permissive builds a module to make a permissive domain. On
Fedora there is an out-of-tree policy build environment in
/usr/share/selinux. Without this environment it can't build a module.
Does Gentoo have it in a different place or just not at all?

>
> https://bugs.gentoo.org/show_bug.cgi?id=467268
>
> - policycoreutils' sepolicy command requires yum python bindings
>
> Since yum is not available on Gentoo, is this really necessary?
>

Unfortunate. I'd exclude it for now and hopefully we can work out
making it more distro independent.

> Wkr,
>         Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
