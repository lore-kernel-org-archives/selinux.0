Subject: Re: [PATCH 2/2] libselinux: do not use relative path when creating
 libselinux symlinks
From: Guido Trentalancia <guido@trentalancia.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
Date: Thu, 15 Sep 2011 14:34:18 +0200
In-Reply-To: <4E71EDFB.4040707@tresys.com>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
	   <1316026239-27148-2-git-send-email-eparis@redhat.com>
	   <1316027881.26965.15.camel@moss-pluto>
	  <1316031697.2738.37.camel@localhost> <4E71E8FD.8020505@tresys.com>
	 <1316088961.2319.36.camel@vortex> <4E71EDFB.4040707@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316090059.2319.43.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-15 at 08:22 -0400, Christopher J. PeBenito wrote:
> On 09/15/11 08:16, Guido Trentalancia wrote:
> > Hi Christopher !
> > 
> > Thanks for the idea.
> > 
> > On Thu, 2011-09-15 at 08:01 -0400, Christopher J. PeBenito wrote:
> >> On 09/14/11 16:21, Eric Paris wrote:
> >>> On Wed, 2011-09-14 at 15:18 -0400, Stephen Smalley wrote:
> >>>> On Wed, 2011-09-14 at 14:50 -0400, Eric Paris wrote:
> >>>>> At the moment we create a symlink:
> >>>>>
> >>>>> /usr/lib/libselinux.so -> ../../lib/libselinux.so.1
> >>>>>
> >>>>> This works if (and only if) $SHLIBDIR and $LIBDIR are different only by
> >>>>> ../../.  Instead create a symlink from
> >>>>>
> >>>>> $LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1
> >>>>>
> >>>>> Thus it works no matter what values one might use for LIBDIR and
> >>>>> SHLIBDIR.
> >>>>
> >>>> I'm not sure this works the way you would want.  Consider rpm build of
> >>>> libselinux - it does:
> >>>> make DESTDIR="%{buildroot}" LIBDIR="%{buildroot}%{_libdir}"
> >>>> SHLIBDIR="%{buildroot}/%{_lib}" BINDIR="%{buildroot}%{_sbindir}" install
> >>>>
> >>>> And then rpm collects up the files into the package.
> >>>> But if the symlink encodes the full pathname used at make install time,
> >>>> then it will be wrong on the final system when the rpm is installed.
> >>>> Haven't actually tested that theory, but I think it is true.  Welcome to
> >>>> hell.
> >>>
> >>> error: Symlink points to BuildRoot: /usr/lib64/libselinux.so
> >>> -> /root/rpmbuild/BUILDROOT/libselinux-2.1.5-4.fc16.1.eparis.x86_64/lib64/libselinux.so.1
> >>>
> >>> GRRRRRR.   Every other package I see with similar symlinks seems to be
> >>> an autoconf package and I can't understand how they work.  What we have
> >>> isn't right, but I don't know how to fix it....
> >>
> >> Its easy.  The makefile needs to be tweaked so you don't have to specify %{buildroot} as part of the LIBDIR, SHLIBDIR, and BINDIR variables.  Then when you use those variables, you prepend DESTDIR as necessary.  So if you have usages like
> >>
> >> install foo $(BINDIR)
> >>
> >> it turns into
> >>
> >> install foo $(DESTDIR)(BINDIR)
> >>
> >> Then when you have your symlink you can do
> >>
> >> ln -s $(SHLIBDIR)/bar.so.1 $(DESTDIR)$(SHLIBDIR)/bar.so
> > 
> > Yes, this is even better, although $(DESTDIR) is not necessary in the
> > target, as SHLIBDIR already includes (begins with) DESTDIR:
> > 
> > ln -sf $(SHLIBDIR)/$(LIBSO) $(SHLIBDIR)/$(TARGET)
> 
> I think you're missing the point.  I said you need to stop specifying $(DESTDIR) as part of $(SHLIBDIR).  Otherwise you get the broken symlinks that Eric talks about above.

Yes, that's true. There must be a way of stripping DESTDIR from SHLIBDIR
to create another variable called RELATIVE_SHLIBDIR which is not
absolute but relative to DESTDIR.

And then use that relative variable for the source of the link:

ln -sf $(RELATIVE_SHLIBDIR)/$(LIBSO) $(SHLIBDIR)/$(TARGET)

and eventually:

ln -sf $(RELATIVE_SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)

Sorry for creating further confusion ! Hopefully it makes sense now...

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
