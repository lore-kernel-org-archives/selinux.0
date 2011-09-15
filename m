Subject: Re: [PATCH 2/2] libselinux: do not use relative path when creating
 libselinux symlinks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.com
In-Reply-To: <1316031697.2738.37.camel@localhost>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
	 <1316026239-27148-2-git-send-email-eparis@redhat.com>
	 <1316027881.26965.15.camel@moss-pluto> <1316031697.2738.37.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Sep 2011 13:29:54 -0400
Message-ID: <1316107794.16483.37.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-09-14 at 16:21 -0400, Eric Paris wrote:
> On Wed, 2011-09-14 at 15:18 -0400, Stephen Smalley wrote:
> > On Wed, 2011-09-14 at 14:50 -0400, Eric Paris wrote:
> > > At the moment we create a symlink:
> > > 
> > > /usr/lib/libselinux.so -> ../../lib/libselinux.so.1
> > > 
> > > This works if (and only if) $SHLIBDIR and $LIBDIR are different only by
> > > ../../.  Instead create a symlink from
> > > 
> > > $LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1
> > > 
> > > Thus it works no matter what values one might use for LIBDIR and
> > > SHLIBDIR.
> > 
> > I'm not sure this works the way you would want.  Consider rpm build of
> > libselinux - it does:
> > make DESTDIR="%{buildroot}" LIBDIR="%{buildroot}%{_libdir}"
> > SHLIBDIR="%{buildroot}/%{_lib}" BINDIR="%{buildroot}%{_sbindir}" install
> > 
> > And then rpm collects up the files into the package.
> > But if the symlink encodes the full pathname used at make install time,
> > then it will be wrong on the final system when the rpm is installed.
> > Haven't actually tested that theory, but I think it is true.  Welcome to
> > hell.
> 
> error: Symlink points to BuildRoot: /usr/lib64/libselinux.so
> -> /root/rpmbuild/BUILDROOT/libselinux-2.1.5-4.fc16.1.eparis.x86_64/lib64/libselinux.so.1
> 
> GRRRRRR.   Every other package I see with similar symlinks seems to be
> an autoconf package and I can't understand how they work.  What we have
> isn't right, but I don't know how to fix it....

Do we really need to change this?  While it is making an assumption
about LIBDIR and SHLIBDIR relative location, when is that assumption
false?  We certainly haven't had any complaints about it from any of the
distros.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
