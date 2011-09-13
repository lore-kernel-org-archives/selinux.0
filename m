Subject: Re: [PATCH] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Tue, 13 Sep 2011 22:04:04 +0200
In-Reply-To: <1315942469.12522.81.camel@moss-pluto>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315944244.2218.41.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-13 at 15:34 -0400, Stephen Smalley wrote:
> On Tue, 2011-09-13 at 15:25 -0400, Stephen Smalley wrote:
> > On Tue, 2011-09-13 at 21:18 +0200, Guido Trentalancia wrote:
> > > Hello again.
> > > 
> > > The security risk associated with the linkage of an old libsepol.a
> > > static library is low due to the fact that the tools are usually built
> > > from each component separately after all the libraries have been
> > > previously built and installed.
> > > 
> > > On Tue, 2011-09-13 at 14:48 -0400, Stephen Smalley wrote:
> > > > On Tue, 2011-09-13 at 20:33 +0200, Guido Trentalancia wrote:
> > > > > No, it doesn't currently ! If you want to try reproducing it, then you
> > > > > should do so on a system which hasn't got it already installed (or make
> > > > > sure you get temporarily rid of
> > > > > $(PREFIX)/include/{selinux,sepol,semanage} and
> > > > > $(LIBDIR)/lib{selinux,sepol,semanage}.* first).

[cut]

> I suppose the one thing that might not be clear is that the Makefile
> orders the SUBDIRS in order of dependency, so that we build and install
> libsepol first, then libselinux, and so on such that the headers and
> libraries required to build each component are already installed before
> we build that component.

It is up to the maintainer to keep the SUBDIRS variable ordered
(according to the dependency relations).

See for example:

http://www.gnu.org/s/hello/manual/make/Phony-Targets.html#Phony-Targets
http://www.gnu.org/s/hello/manual/automake/Subdirectories.html

> In your case, the sepol headers should have
> already been installed before trying to build libselinux, and I don't
> know why that didn't happen for you unless your make reorders SUBDIRS
> internally or the make install in libsepol failed to complete (but I
> wouldn't expect it to proceed in that case).

The make tool should not reorder variables in any case.

I did not issue a "make install" (yet). I did just issue "make" from the
top-level directory.

I am not building the components separately, I am building the whole
bundle (tools + libraries) from the top-level directory of the git
version. That's the point.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
