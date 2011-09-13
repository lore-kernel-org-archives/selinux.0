Subject: Re: [PATCH] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Guido Trentalancia <guido@trentalancia.com>,
        Eric Paris
 <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1315945618.2738.13.camel@localhost>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Sep 2011 16:42:11 -0400
Message-ID: <1315946531.12522.96.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-13 at 16:26 -0400, Eric Paris wrote:
> On Tue, 2011-09-13 at 22:04 +0200, Guido Trentalancia wrote:
> > On Tue, 2011-09-13 at 15:34 -0400, Stephen Smalley wrote:
> > > On Tue, 2011-09-13 at 15:25 -0400, Stephen Smalley wrote:
> > > > On Tue, 2011-09-13 at 21:18 +0200, Guido Trentalancia wrote:
> > > > > Hello again.
> > > > > 
> > > > > The security risk associated with the linkage of an old libsepol.a
> > > > > static library is low due to the fact that the tools are usually built
> > > > > from each component separately after all the libraries have been
> > > > > previously built and installed.
> > > > > 
> > > > > On Tue, 2011-09-13 at 14:48 -0400, Stephen Smalley wrote:
> > > > > > On Tue, 2011-09-13 at 20:33 +0200, Guido Trentalancia wrote:
> > > > > > > No, it doesn't currently ! If you want to try reproducing it, then you
> > > > > > > should do so on a system which hasn't got it already installed (or make
> > > > > > > sure you get temporarily rid of
> > > > > > > $(PREFIX)/include/{selinux,sepol,semanage} and
> > > > > > > $(LIBDIR)/lib{selinux,sepol,semanage}.* first).
> > 
> > [cut]
> > 
> > > I suppose the one thing that might not be clear is that the Makefile
> > > orders the SUBDIRS in order of dependency, so that we build and install
> > > libsepol first, then libselinux, and so on such that the headers and
> > > libraries required to build each component are already installed before
> > > we build that component.
> > 
> > It is up to the maintainer to keep the SUBDIRS variable ordered
> > (according to the dependency relations).
> > 
> > See for example:
> > 
> > http://www.gnu.org/s/hello/manual/make/Phony-Targets.html#Phony-Targets
> > http://www.gnu.org/s/hello/manual/automake/Subdirectories.html
> > 
> > > In your case, the sepol headers should have
> > > already been installed before trying to build libselinux, and I don't
> > > know why that didn't happen for you unless your make reorders SUBDIRS
> > > internally or the make install in libsepol failed to complete (but I
> > > wouldn't expect it to proceed in that case).
> > 
> > The make tool should not reorder variables in any case.
> > 
> > I did not issue a "make install" (yet). I did just issue "make" from the
> > top-level directory.
> > 
> > I am not building the components separately, I am building the whole
> > bundle (tools + libraries) from the top-level directory of the git
> > version. That's the point.
> 
> I, recently, applied a patch which changed the top level default from
> install to all.  sds says the 'right' way to build the git tree WAS to
> call "make DESTDIR=~/out"  (Remember the default was to install).  Since
> I changed the default target the new way to build out of the tree is to
> call "make DESTDIR=~/out install"
> 
> I have no plans at this time to revert my commit which changed the
> default from 'install' to 'all'.  It is just flat out totally wrong that
> cloning the git tree and typing make can break your running system.
> Period.  I agree that we must be certain not to break anyone who decides
> to still use 'make DESTDIR=~/out install' method.  Note: I'm fine that
> this means I'm forcing sds to use the install target instead of the
> default target from here out.  The old default target was a very bad
> idea.  If you know you need to type DESTDIR= you can also know to type
> 'install.'  If this doesn't work, I need to fix it.  (It doesn't work
> for me, but I'm not certain why just yet)
> 
> Personally, I'd like to see just 'make' at the top level dir build
> properly and I think your patches get us most of the way there without
> (further) breaking the building method that sds prefers.
> 
> If you get your best patch which does nothing but allow us to just type
> 'make' at the top level dir and it builds everything properly in place,
> I'll review and probably commit such a patch.

Be sure to test at least the following scenarios:
1) No sepol/selinux/semanage system headers installed on build host,
2) Old/incompatible sepol/selinux/semanage system headers installed on
build host (e.g. f14 build host, latest selinux git tree),
3) Ability to build each component separately without the rest of the
source tree, e.g. package rebuilds.

The make DESTDIR=~/out install approach enabled the first two to work
without breaking the third, which is why it was attractive.  If he can
make all three work via another mechanism, then I'm fine with it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
