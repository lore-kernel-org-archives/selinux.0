Message-ID: <1497960868.12069.1.camel@tycho.nsa.gov>
Subject: Re: ANN: SELinux userspace 2.7-rc2 release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Tue, 20 Jun 2017 08:14:28 -0400
In-Reply-To: <6388c501-4700-ac73-fc1f-4b5a641cefba@redhat.com>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1497632109.7898.5.camel@tycho.nsa.gov>
 <20170618073233.GA24080@meriadoc.perfinion.com>
 <20170618074655.GA9590@meriadoc.perfinion.com>
 <6388c501-4700-ac73-fc1f-4b5a641cefba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-06-20 at 12:54 +0200, Petr Lautrbach wrote:
> On 06/18/2017 09:46 AM, Jason Zaman wrote:
> > On Sun, Jun 18, 2017 at 03:32:33PM +0800, Jason Zaman wrote:
> > > There is a bug that needs to be fixed before the final release:
> > > https://bugs.gentoo.org/show_bug.cgi?id=621762
> > > 
> > > I think the fix is just add override in utils/Makefile to the
> > > LDLIBS and
> > > LDFLAGS bits. I'm not sure I'll have time to get around to
> > > testing
> > > it so just wanted to let you know before the final release.
> > 
> > Yep, thats the fix, I sent a patch.
> > https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-libs/libselinux/
> > libselinux-9999.ebuild#n58
> > The gentoo ebuild overrides LDFLAGS on the commandline which is why
> > the
> > override was required. When i first tried to repro manually i just
> > exported LDFLAGS and couldnt repro. once i read the docs on
> > override it
> > was pretty obvious.
> 
> A similar patch is needed almost for every other part when you try
> to 
> build everything from git first and then install it.
> 
> In order to that I need to apply a patch [1] and do the following
> steps:
> 
> ln -s ../../cil/include/cil libsepol/include/sepol/cil
> 
> make \
>    CFLAGS="%{optflags}" LDFLAGS="%{?__global_ldflags}" \
>    LIBSEPOLA="`pwd`/libsepol/src/libsepol.a"
> 
> make -C libselinux \
>    CFLAGS="%{optflags}" LDFLAGS="%{?__global_ldflags}" \
>    LIBSEPOLA="`pwd`/libsepol/src/libsepol.a" \
>    PYTHON=%{__python} pywrap
> 
> make \
>    DESTDIR="%{buildroot}" LIBDIR="%{buildroot}%{_libdir}" \
>    CFLAGS="%{optflags}" LDFLAGS="%{?__global_ldflags}" \
>    SHLIBDIR="%{buildroot}/%{_lib}" \
>    BINDIR="%{buildroot}%{_bindir}" \
>    SBINDIR="%{buildroot}%{_sbindir}" \
>    PYTHON=%{__python} \
>    install install-pywrap
> 
> 
> [1] 
> https://gitlab.com/bachradsusi/selinux-rpm/blob/master/0001-Fix-build
> -without-install.patch
> 
> Using this I preserve rpath problems pointing to DESTDIR and rpm can 
> simply use everything from DESTDIR for /

That seems very onerous for packagers.
So, are you advocating for reverting
fcb5d5cc721187b3e3a19b44155d5b824d7be7e6, or are you proposing the
patch cited above for upstream instead?
