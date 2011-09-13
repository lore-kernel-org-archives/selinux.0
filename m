Subject: Re: [PATCH] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1315939603.2218.19.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex>  <1315939603.2218.19.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Sep 2011 15:17:15 -0400
Message-ID: <1315941435.12522.72.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-13 at 20:46 +0200, Guido Trentalancia wrote:
> To be more precise...

> > And to that add that the actual LDFLAGS possibly introduces an unwanted
> > and potentially dangerous libsepol.a cache !
> 
> Please read LDLIBS instead of LDFLAGS.
> 
> At the least the following objects could be affected: checkpolicy,
> semodule_deps, mcstransd and the audit2why.so python module. A security
> notice might be need to be issued if confirmed.
> 
> > In fact, somewhere the LDFLAGS currently adds $(LIBDIR)/libsepol.a
> > instead of the local copy of static library libsepol.a. This should be
> > further investigated as it might need to be treated as a security flaw
> > (binaries available from different vendors might be affected if linked
> > against the existing old libsepol.a static library).

If you build with make DESTDIR=~/out > out and then grep libsepol.a out,
you'll see that it picks up the locally built one:
$ grep libsepol.a out 
ar rcs libsepol.a hierarchy.o genusers.o roles.o context_record.o port_record.o boolean_record.o interfaces.o assertion.o avtab.o polcaps.o link.o ports.o genbools.o handle.o module.o write.o users.o policydb.o symtab.o policydb_public.o mls.o ebitmap.o user_record.o hashtab.o debug.o util.o conditional.o policydb_convert.o services.o nodes.o sidtab.o iface_record.o context.o expand.o booleans.o constraint.o avrule_block.o node_record.o
ranlib libsepol.a
install -m 644 libsepol.a  /home/sds/out/usr/lib
cc   checkpolicy.o y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o policy_define.o  /home/sds/out/usr/lib/libsepol.a -lfl -o checkpolicy
cc   checkmodule.o y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o policy_define.o  /home/sds/out/usr/lib/libsepol.a -lfl -o checkmodule
cc   dispol.o  -lfl -lsepol -lselinux /home/sds/out/usr/lib/libsepol.a -L/home/sds/out/usr/lib -o dispol
cc   dismod.o  -lfl -lsepol -lselinux /home/sds/out/usr/lib/libsepol.a -L/home/sds/out/usr/lib -o dismod
cc   semodule_deps.o  /home/sds/out/usr/lib/libsepol.a -o semodule_deps

At least with that 16 month old checkout where make DESTDIR=~/out still
works.

In any event, the distributions don't build this way; they build
libsepol as a separate package and install it first before building the
packages that depend on it.

No CVEs filed for libsepol, and it isn't supposed to be a trust
boundary.

Nonetheless, I agree that reducing the number of users of the static
libsepol would be a good thing.  Only checkpolicy (and setools) has a
legitimate claim to needing it.  The rest ought to be reworked to use
new interfaces provided by the shared lib with proper encapsulation of
the data structures and implementation details.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
