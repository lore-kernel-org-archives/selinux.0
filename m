Subject: Re: [PATCH] pkgconfig support for libsepol, libselinux, and
 libsemanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Caleb Case <ccase@tresys.com>, srivasta@golden-gryphon.com,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1256127809.4061.170.camel@moss-pluto.epoch.ncsc.mil>
References: <4ADE735D.9020901@tycho.nsa.gov>
	 <1256127809.4061.170.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 21 Oct 2009 08:31:32 -0400
Message-Id: <1256128292.4061.174.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-10-21 at 08:23 -0400, Stephen Smalley wrote:
> On Tue, 2009-10-20 at 22:35 -0400, Eamon Walsh wrote:
> > Add pkgconfig files for libsepol, libselinux, and libsemanage.
> > 
> > Having a pkgconfig file allows the pkg-config(1) tool to be used to
> > query the presence of the library (or a particular version of it),
> > and to obtain the C flags and linker arguments required to use it.
> > 
> > Based on Debian patches by Manoj Srivastava<srivasta@debian.org>.
> > 
> > Signed-off-by: Eamon Walsh<ewalsh@tycho.nsa.gov>
> > ---
> > 
> > Note that the .pc.in files themselves could use some review to make
> > sure the Requires and Libs lines are correct.  The sepol and selinux
> > ones are from the Debian repos; the semanage one I wrote myself.
> 
> > diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
> > new file mode 100644
> > index 0000000..c9608d9
> > --- /dev/null
> > +++ b/libselinux/src/libselinux.pc.in
> > @@ -0,0 +1,13 @@
> > +prefix=@prefix@
> > +exec_prefix=${prefix}
> > +libdir=${exec_prefix}/lib
> > +includedir=@includedir@
> > +
> > +Name: libselinux
> > +Description: SELinux utility library
> > +Version: @VERSION@
> > +URL: http://www.nsa.gov/research/selinux/

Also the URLs should now point to the userspace.selinuxproject.org site.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
