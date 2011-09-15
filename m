Subject: Re: [PATCH v5] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Thu, 15 Sep 2011 19:26:43 +0200
In-Reply-To: <1316106992.16483.35.camel@moss-pluto>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost>  <1315951507.2218.91.camel@vortex>
	 <1316004965.26965.9.camel@moss-pluto>  <1316054641.23290.48.camel@vortex>
	 <1316091385.16483.13.camel@moss-pluto>  <1316102675.2202.23.camel@vortex>
	 <1316104531.16483.26.camel@moss-pluto>  <1316106206.2202.33.camel@vortex>
	 <1316106992.16483.35.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316107603.2202.43.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-15 at 13:16 -0400, Stephen Smalley wrote:
> On Thu, 2011-09-15 at 19:03 +0200, Guido Trentalancia wrote:
> > Nope, with original from git.
> > 
> > With my patch everything works all right. Otherwise why did I create the
> > patch in the first place ??
> 
> I don't know.  As I've said, make DESTDIR=~/out install worked fine
> until recently, and with Eric's patch 1/2 to fix up the recent breakage
> of the libselinux Makefile and my just-posted patch for the sandbox
> Makefile, I can once again do a make DESTDIR=~/out install on a system
> without the system -devel packages.
> 
> > I only forgot to mention the flags that I used:
> > 
> > CFLAGS="-O3 -march=corei7 -mtune=corei7" LIBDIR=/usr/lib64
> > SHLIBDIR=/usr/lib64 DESTDIR=/opt/out make install
> 
> So it is picking up the wrong libs because you told it to do so by
> separately specifying incompatible DESTDIR and LIBDIR/SHLIBDIR
> definitions.  Either only specify DESTDIR and let it automatically
> derive LIBDIR/SHLIBDIR underneath, or specify them all with the same
> prefix.

My requirements are that I am on a 64-bit system and therefore I
need/want to distiguish between "lib" and "lib64". I do not need/care
about distinguishing between SHLIBDIR and LIBDIR. I am fine either
without a DESTDIR or with a DESTDIR as you suggested (both are
problematic).

And it breaks again after that...

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
