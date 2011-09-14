Subject: Re: [PATCH 2/2] libselinux: do not use relative path when creating
 libselinux symlinks
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.com
Date: Wed, 14 Sep 2011 16:21:36 -0400
In-Reply-To: <1316027881.26965.15.camel@moss-pluto>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
	 <1316026239-27148-2-git-send-email-eparis@redhat.com>
	 <1316027881.26965.15.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316031697.2738.37.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-09-14 at 15:18 -0400, Stephen Smalley wrote:
> On Wed, 2011-09-14 at 14:50 -0400, Eric Paris wrote:
> > At the moment we create a symlink:
> > 
> > /usr/lib/libselinux.so -> ../../lib/libselinux.so.1
> > 
> > This works if (and only if) $SHLIBDIR and $LIBDIR are different only by
> > ../../.  Instead create a symlink from
> > 
> > $LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1
> > 
> > Thus it works no matter what values one might use for LIBDIR and
> > SHLIBDIR.
> 
> I'm not sure this works the way you would want.  Consider rpm build of
> libselinux - it does:
> make DESTDIR="%{buildroot}" LIBDIR="%{buildroot}%{_libdir}"
> SHLIBDIR="%{buildroot}/%{_lib}" BINDIR="%{buildroot}%{_sbindir}" install
> 
> And then rpm collects up the files into the package.
> But if the symlink encodes the full pathname used at make install time,
> then it will be wrong on the final system when the rpm is installed.
> Haven't actually tested that theory, but I think it is true.  Welcome to
> hell.

error: Symlink points to BuildRoot: /usr/lib64/libselinux.so
-> /root/rpmbuild/BUILDROOT/libselinux-2.1.5-4.fc16.1.eparis.x86_64/lib64/libselinux.so.1

GRRRRRR.   Every other package I see with similar symlinks seems to be
an autoconf package and I can't understand how they work.  What we have
isn't right, but I don't know how to fix it....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
