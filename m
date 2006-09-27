Message-ID: <451A707E.7070504@tresys.com>
Date: Wed, 27 Sep 2006 08:37:18 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Jeremy Mowery <jmowery@tresys.com>, selinux@tycho.nsa.gov,
        selinux-dev <selinux-dev@tresys.com>
Subject: Re: [PATCH] libsepol: compile archive with -fpic
References: <1159293291.2723.14.camel@Bishop.columbia.tresys.com> <1159357424.32075.22.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1159357424.32075.22.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>
> On Tue, 2006-09-26 at 13:54 -0400, Jeremy A. Mowery wrote:
> > The libsepol archive is compiled normally without the -fpic flag.  This
> > causes problems with other things that use libsepol.a with dynamic
> > relocation on 64-bit machines.  The setools project uses libsepol.a in a
> > shared object library; checkpolicy is prevented from being built as a
> > position independent executable.  The following patch modifies
> > libsepol's Makefile to build the archive using position independent
> > code.
> >
>
The cost is negligible, especially since the only static users are going 
to be checkpolicy and apol. FWIW hardened gentoo users build every 
binary (and object) on their system with -fpic (so that the address 
space can be randomized at runtime) and the slowdown has never been 
apparent and the extra register is only necessary in rare cases (eg., 
media apps).

Fedora has already started building some of their binaries as shared 
objects so it won't be long before they'd want checkpolicy linking 
against the pic version of libsepol anyway (file `which su` for 
evidence). I don't think its worth it to make another archive.

> > --- libsepol/src/Makefile-orig  2006-09-19 10:03:54.000000000 -0400
> > +++ libsepol/src/Makefile       2006-09-19 10:06:21.000000000 -0400
> > @@ -24,7 +24,7 @@ $(LIBSO): $(LOBJS)
> >         ln -sf $@ $(TARGET)
> >
> >  %.o:  %.c
> > -       $(CC) $(CFLAGS) -c -o $@ $<
> > +       $(CC) $(CFLAGS) -fpic -c -o $@ $<
> >
> >  %.lo:  %.c
> >         $(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<
> >
>
> There is a cost associated with doing that.  Possibly we could provide a
> libsepol_pic.a.  See:
> http://www.mail-archive.com/debian-devel@lists.debian.org/msg239046.html
>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
