Subject: Re: [PATCH] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1315944244.2218.41.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto>  <1315944244.2218.41.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Sep 2011 16:20:26 -0400
Message-ID: <1315945226.12522.87.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-13 at 22:04 +0200, Guido Trentalancia wrote:
> It is up to the maintainer to keep the SUBDIRS variable ordered
> (according to the dependency relations).
> 
> See for example:
> 
> http://www.gnu.org/s/hello/manual/make/Phony-Targets.html#Phony-Targets
> http://www.gnu.org/s/hello/manual/automake/Subdirectories.html

Ok, we have ordered SUBDIRS in the Makefile in such a manner that each
component is built before anything that depends on it.

> > In your case, the sepol headers should have
> > already been installed before trying to build libselinux, and I don't
> > know why that didn't happen for you unless your make reorders SUBDIRS
> > internally or the make install in libsepol failed to complete (but I
> > wouldn't expect it to proceed in that case).
> 
> The make tool should not reorder variables in any case.

Good.

> I did not issue a "make install" (yet). I did just issue "make" from the
> top-level directory.

Right, that can't work and never has, which is why 'make' used to invoke
'make install' until Eric (incorrectly) changed that behavior.

> I am not building the components separately, I am building the whole
> bundle (tools + libraries) from the top-level directory of the git
> version. That's the point.

Understood, and the only way to do that has always been make
DESTDIR=~/out.  Reverting/fixing the changes that have broken that
behavior is the right solution.

Looking at your last patch, I don't see how it can possibly work in the
case where one isn't building the entire source tree (e.g. for package
building), because it encodes a relative path to the static libs in
LDLIBS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
