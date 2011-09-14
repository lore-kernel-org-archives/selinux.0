Subject: Re: [PATCH v4] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1315951507.2218.91.camel@vortex>
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
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Sep 2011 08:56:05 -0400
Message-ID: <1316004965.26965.9.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-09-14 at 00:05 +0200, Guido Trentalancia wrote:
> Hello Eric !
> 
> On Tue, 2011-09-13 at 16:26 -0400, Eric Paris wrote:
> > Personally, I'd like to see just 'make' at the top level dir build
> > properly and I think your patches get us most of the way there without
> > (further) breaking the building method that sds prefers.
> > 
> > If you get your best patch which does nothing but allow us to just type
> > 'make' at the top level dir and it builds everything properly in place,
> > I'll review and probably commit such a patch.
> 
> Yes, let's get to the point. The latest version of the patch that you
> should test is attached below. Please note that it also changes the
> creation of symbolic links to shared libraries (needs to be
> double-checked for correctness).
> 
> diff -pruN selinux/checkpolicy/Makefile selinux-13092011/checkpolicy/Makefile
> --- selinux/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
> +++ selinux-13092011/checkpolicy/Makefile	2011-09-13 02:58:19.314224502 +0200
> @@ -19,7 +19,7 @@ CHECKOBJS = y.tab.o lex.yy.o queue.o mod
>  CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
>  CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
>  
> -LDLIBS=$(LIBDIR)/libsepol.a -lfl
> +LDLIBS=../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
>  
>  GENERATED=lex.yy.c y.tab.c y.tab.h

The above will break when building checkpolicy separately.  Ditto for
the other components that need to reference a static lib.  I think this
is why we didn't go down this path previously.

BTW, your patch wouldn't quite compile as is for me even aside from this
issue; you don't seem to have defined LIBDIR in
policycoreutils/restorecond/Makefile before using it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
