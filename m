Subject: Re: Missing configure script and instructions?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Doria <daviddoria@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <BANLkTincN516XV4AkGnTPoL2yXvdenJ3zA@mail.gmail.com>
References: <BANLkTincN516XV4AkGnTPoL2yXvdenJ3zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Jun 2011 06:57:10 -0400
Message-ID: <1308740230.17520.13.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-06-21 at 16:03 -0400, David Doria wrote:
> I cloned the SELinux repository and I don't see any README, INSTALL,
> or configure files. There is a Makefile, but typically 'make' is not
> the first step in an installation process, right? How should I build
> SELinux?

There was an attempt to convert to autotools (see the origin/autotools
branch) but it didn't resolve all the lingering issues and was
abandoned.  I'm not much of a fan of autotools anyway - extra work for
maintainers with no real benefit for such a small, simple collection of
software that is inherently Linux-specific and thus doesn't need to be
portable to other OSes.

Set DESTDIR, not PREFIX. e.g. make DESTDIR=~/build.

libustr is a dependency, upstream is http://www.and.org/ustr/, but it is
packaged for Fedora as ustr-devel and for Debian as libustr-devel.

Does your base distribution not already provide the SELinux libraries?
The major ones already do; you just need to install the packages for
them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
