Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9KK4s6k007199
 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2014 16:04:55 -0400
Message-ID: <54456ADC.9030700@redhat.com>
Date: Mon, 20 Oct 2014 16:04:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
Subject: Re: libselinux packaging
References: <CAJfZ7=nCcaCZSu=dXqZ8Jfpm15nqED9FOK14U7F25LcW=+kf0A@mail.gmail.com>
In-Reply-To: <CAJfZ7=nCcaCZSu=dXqZ8Jfpm15nqED9FOK14U7F25LcW=+kf0A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 10/19/2014 09:40 AM, Nicolas Iooss wrote:
> Hello,
>
> Before the next libselinux release I've looked how libselinux 2.3 have
> been packaged by several distros and it is quite disturbing. Here are
> the strange things I've seen so far, related to the build and
> installation.
>
> * Fedora deletes a bunch of binaries installed from libselinux/utils/
> and renames some [1]. Arch Linux does this too since the previous
> maintainer tried to follow Fedora as much as possible [2]. Neither
> Debian nor Gentoo delete these binaries, even if they raise Lintian
> warnings for Debian because their man pages don't exist [3]. Moreover,
> as "policyvers" is removed on some distros, refpolicy reimplemented it
> in python [4]. Why are these binaries removed in Fedora?
Because we do not want to support them and some of them are available
via other means.
> * For recent versions of ruby, "pkg-config --cflags ruby" no longer
> works as has to be replaced with "pkg-config --cflags ruby-2.1" (for
> example). Gentoo has a patch for this [5] and Arch is using a
> less-generic sed command to patch this [6]. Debian is doing some magic
> to make things build, with a comment about SELinux build process [7].
> I don't know whether applying the Gentoo patch upstream is fine
> because Fedora is still using "ruby" [8].

> * libselinux forces "-I$(INCLUDEDIR)" into the CFLAGS [9], which
> breaks cross-compilation on Debian [10]. This is also modified on
> Gentoo, which also removes -L$(LIBDIR) and puts $(LDFLAGS) before
> object files [11].
>
> * There is also a bug about creating /usr/lib/libselinux.so symlink to
> a non-existing file on systems where SHLIBDIR and LIBDIR are both
> /usr/lib. I've already reported this issue on GitHub [12].
>
> Cheers,
>
> Nicolas
> Maintainer of SELinux-related packages on Arch Linux since yesterday.
>
> [1] http://pkgs.fedoraproject.org/cgit/libselinux.git/tree/libselinux.spec?id=a139be8c7e0cae589591684018775aae1fed71f2#n162
> [2] https://github.com/archlinuxhardened/selinux/commit/a0c3da5b88d622c31f429d003aad16334e16919f#diff-7cdd8d38b65e2926b6f547b0786e9128R64
> [3] https://lintian.debian.org/maintainer/selinux-devel@lists.alioth.debian.org.html#libselinux
> (package selinux-utils)
> [4] https://github.com/TresysTechnology/refpolicy/blob/master/support/policyvers.py
> [5] http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/sys-libs/libselinux/files/0005-use-ruby-include-with-rubylibver.patch?revision=1.1&view=markup
> [6] https://github.com/archlinuxhardened/selinux/blob/63e6c3ddbc159775d5d1bfeaa81166e9d429d424/libselinux/PKGBUILD#L34
> [7] http://anonscm.debian.org/cgit/selinux/libselinux.git/tree/debian/ruby.mk?id=ac18cbf00199db539c888eb81df03d2584bcbb8e#n17
> [8] http://pkgs.fedoraproject.org/cgit/libselinux.git/tree/libselinux.spec?id=a139be8c7e0cae589591684018775aae1fed71f2#n5
> [9] https://github.com/SELinuxProject/selinux/blob/libselinux-2.4-rc3/libselinux/src/Makefile#L75
> [10] http://anonscm.debian.org/cgit/selinux/libselinux.git/tree/debian/patches/fix-cross-compile.patch?id=938d7da9097de458a70b0f4f8bc24dcefcd0b26b
> [11] http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/sys-libs/libselinux/files/0006-build-related-fixes-bug-500674.patch?revision=1.1&view=markup
> [12] https://github.com/SELinuxProject/selinux/issues/2
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
