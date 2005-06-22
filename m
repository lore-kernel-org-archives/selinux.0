Subject: Re: upgrade howto
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119395184.9416.31.camel@localhost>
References: <1119395184.9416.31.camel@localhost>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 07:54:05 -0400
Message-Id: <1119441245.13181.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-22 at 00:06 +0100, antoine wrote:
> What is the safest way of upgrading libselinux and libsepol?
> 
> I attempted it a couple of weeks ago and had to resort to statically
> linked copies of ls and tar to restore the previous version after the
> upgrade broke my system. Clearly, I did something wrong. What is scary
> is that a lot of the core system utilities are linked against libselinux
> (ls, init, portage, etc) and that when I upgrade, it would seem that I
> need to rebuild them (as just upgrading the library left them unusable)
> - which is impossible without these basic tools... catch 22?

Note btw that while upgrading should always work, downgrading is another
matter.  So if Gentoo was using a newer base version of libsepol and
libselinux (e.g. one from the sourceforge CVS tree), and you downgraded
to an older one (e.g. the last nsa.gov release, which was in March),
that could easily break your system as your userland may be depending on
newer interfaces.  nsa.gov releases are only made periodically,
typically when there is a new Linux kernel release (e.g. one should be
occurring soon for 2.6.12), whereas the sourceforge CVS tree tracks
development much more closely, and some distributions (like Fedora)
track the sourceforge CVS tree directly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
