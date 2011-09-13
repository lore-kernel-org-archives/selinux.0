Subject: Re: [PATCH] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1315941958.12522.77.camel@moss-pluto>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Sep 2011 15:34:29 -0400
Message-ID: <1315942469.12522.81.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-13 at 15:25 -0400, Stephen Smalley wrote:
> On Tue, 2011-09-13 at 21:18 +0200, Guido Trentalancia wrote:
> > Hello again.
> > 
> > The security risk associated with the linkage of an old libsepol.a
> > static library is low due to the fact that the tools are usually built
> > from each component separately after all the libraries have been
> > previously built and installed.
> > 
> > On Tue, 2011-09-13 at 14:48 -0400, Stephen Smalley wrote:
> > > On Tue, 2011-09-13 at 20:33 +0200, Guido Trentalancia wrote:
> > > > No, it doesn't currently ! If you want to try reproducing it, then you
> > > > should do so on a system which hasn't got it already installed (or make
> > > > sure you get temporarily rid of
> > > > $(PREFIX)/include/{selinux,sepol,semanage} and
> > > > $(LIBDIR)/lib{selinux,sepol,semanage}.* first).
> > > 
> > > I know it is presently broken, but not sure exactly when/who broke it.
> > > However, as a working example:
> > > $ git clean -fdx
> > > $ rm -rf ~/out
> > > $ git checkout master@{"16 months ago"}
> > > $ make DESTDIR=~/out
> > > 
> > > works just fine for me.
> > 
> > ...
> > make -C src 
> > make[2]: Entering directory
> > `/usr/src/selinux-userspace/git/selinux-13092011-16monthsago/libselinux/src'
> > cc -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn
> > -Wmissing-format-attribute -I../include -I/opt/out/usr/include
> > -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64   -c -o load_policy.o load_policy.c
> > load_policy.c:14:25: fatal error: sepol/sepol.h: No such file or
> > directory
> > compilation terminated.
> > make[2]: *** [load_policy.o] Error 1
> > make[2]: Leaving directory
> > `/usr/src/selinux-userspace/git/selinux-13092011-16monthsago/libselinux/src'
> > make[1]: *** [all] Error 2
> > make[1]: Leaving directory
> > `/usr/src/selinux-userspace/git/selinux-13092011-16monthsago/libselinux'
> > make: *** [all] Error 1
> > 
> > The above is what I get. And there is probably more behind that...
> > 
> > The problem is due to the fact that before "make install" is issued,
> > nothing usually exists under DESTDIR whatever DESTDIR is.
> > 
> > So includes from DESTDIR are getting included but unfortunately they are
> > not there (yet). Until you have temporarily removed DESTDIR, you won't
> > be able to reproduce it.
> 
> I did remove it - look again at my message and see the rm -rf ~/out.
> I also removed the system headers and libraries via yum.  Here we go
> again:
> $ ls ~/out
> ls: cannot access /home/sds/out: No such file or directory
> $ ls /usr/include/selinux
> ls: cannot access /usr/include/selinux: No such file or directory
> $ ls /usr/include/sepol
> ls: cannot access /usr/include/sepol: No such file or directory
> $ make DESTDIR=~/out > out
> <completes successfully>
> $ ls ~/out/lib/
> libselinux.so.1  libsepol.so.1
> $ ls ~/out/usr/include/
> selinux  semanage  sepol
> $ ls ~/out/usr/lib
> libselinux.a   libsemanage.a   libsemanage.so.1  libsepol.so  python2.7
> libselinux.so  libsemanage.so  libsepol.a        pkgconfig
> 
> See, from nothing to a complete build.  I can't explain it any more
> clearly, so I'm stopping this thread here.

I suppose the one thing that might not be clear is that the Makefile
orders the SUBDIRS in order of dependency, so that we build and install
libsepol first, then libselinux, and so on such that the headers and
libraries required to build each component are already installed before
we build that component.  In your case, the sepol headers should have
already been installed before trying to build libselinux, and I don't
know why that didn't happen for you unless your make reorders SUBDIRS
internally or the make install in libsepol failed to complete (but I
wouldn't expect it to proceed in that case).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
