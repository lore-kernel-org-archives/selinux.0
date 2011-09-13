Subject: Re: [RFC] Improve installation of userspace shared libraries (was
 Re: [RFC] Userspace top-level Makefile)
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, Eric Paris <eparis@redhat.com>,
        Eric Paris <eparis@parisplace.org>,
        SELinux Mail List
 <selinux@tycho.nsa.gov>
Date: Tue, 13 Sep 2011 23:35:49 +0200
In-Reply-To: <1315948380.2218.71.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315590383.2170.32.camel@vortex> <1315591143.2170.36.camel@vortex>
	 <1315603187.2482.22.camel@vortex> <4E6A8707.9080602@manicmethod.com>
	 <1315607702.2482.28.camel@vortex> <4E6A9C4D.6010303@redhat.com>
	 <1315609967.2482.39.camel@vortex> <4E6A9E26.9080806@redhat.com>
	 <4E6D429A.7060403@manicmethod.com> <1315793570.2209.22.camel@vortex>
	 <4E6DFDE5.2070709@manicmethod.com>  <1315858620.2223.13.camel@vortex>
	 <1315947600.12522.103.camel@moss-pluto> <1315948380.2218.71.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315949750.2218.83.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-13 at 23:12 +0200, Guido Trentalancia wrote:
> On Tue, 2011-09-13 at 17:00 -0400, Stephen Smalley wrote:
> > On Mon, 2011-09-12 at 22:17 +0200, Guido Trentalancia wrote:
> > > +++ selinux-12092011-test/libsepol/src/Makefile	2011-09-12 21:53:56.414127000 +0200
> > > @@ -43,7 +43,7 @@ install: all
> > >  	install -m 755 $(LIBSO) $(SHLIBDIR)
> > >  	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
> > >  	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
> > > -	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
> > > +	cd $(SHLIBDIR) && ln -sf $(LIBSO) $(TARGET)
> > >  
> > >  relabel:
> > >  	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
> > > 
> > > Is there anything else that looks odd in it ? Partial description could
> > > be something like this:
> > > 
> > > Simply use the filename as the target instead of the full path to the
> > > shared libraries when creating the links in SHLIBDIR during
> > > installation.
> > 
> > The symlink and the shared object aren't always in the same directory,
> > e.g. in Fedora the shared object may live in /lib or /lib64 while the
> > symlink may live in /usr/lib or /usr/lib64.
> 
> The spec file would create the second one I suppose.

You might actually be right.

Apparently in Fedora, it is still being created by the upstream Makefile
and it only gets sorted between packages by the spec file. Apart from
that, libsemanage from F15 (re)creates that independently in the spec
file.

However, apart from the specific case above (any distribution in general
depends on its own build scheme), I do not consider a good idea
installing the library executable file and the generic symbolic link to
it in two different places. This is mainly because the unique directory
is assumed to be in the LD search path and thus the link is only
intended to select the specific version amongst several different
versions available. That is why I am still a little reluctant about
changing that.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
