Subject: Re: [PATCH] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Tue, 13 Sep 2011 23:09:22 +0200
In-Reply-To: <1315946531.12522.96.camel@moss-pluto>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost> <1315946531.12522.96.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315948163.2218.69.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-13 at 16:42 -0400, Stephen Smalley wrote: 
> > Personally, I'd like to see just 'make' at the top level dir build
> > properly and I think your patches get us most of the way there without
> > (further) breaking the building method that sds prefers.
> > 
> > If you get your best patch which does nothing but allow us to just type
> > 'make' at the top level dir and it builds everything properly in place,
> > I'll review and probably commit such a patch.
> 
> Be sure to test at least the following scenarios:
> 1) No sepol/selinux/semanage system headers installed on build host,

I've tested this when creating any of the previous patches. It is
important if Eric and/or somebody else could test it again
independently.

> 2) Old/incompatible sepol/selinux/semanage system headers installed on
> build host (e.g. f14 build host, latest selinux git tree),

This was the original motivation for creating the patch and as such it
has obviously been tested, at least on my system. It is important if
Eric and/or somebody else could test it again independently.

> 3) Ability to build each component separately without the rest of the
> source tree, e.g. package rebuilds.

I have never specifically tested this. But it is supposed to work at
least until the SUBDIR order is respected.

> The make DESTDIR=~/out install approach enabled the first two to work
> without breaking the third, which is why it was attractive.  If he can
> make all three work via another mechanism, then I'm fine with it.

After applying the patch, it should be possible to use "make
DESTDIR=~/out" to build and "make DESTDIR=~/out install" to install it
as a special case of passing special environment variables to the
Makefiles.

If previously it was ever possible to build and install at the same time
by just using "make DESTDIR=~/out" (i.e. without explicitly requiring
the "install" target), it was wrong. It's probably written nowhere
specifically, but install at least about a hundred random Linux packages
and you will tell me it is wrong !

Note: it is generally preferable to prepend the environment variables to
be passed to the make process. If the variables are appended, their
value cannot be changed or manipulated by the Makefile(s). Very often
the Makefiles need to manipulate (for example, conditional append) the
value of some environment variable (for example, CFLAGS).

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
