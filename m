Subject: Re: [PATCH] Fix includes for userspace tools and libraries (was
 Re: [PATCH] Fix include semanage/handle.h for semanage_set_root() as used
 by semodule)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1315931495.2248.29.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Sep 2011 13:20:21 -0400
Message-ID: <1315934421.12522.46.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-13 at 18:31 +0200, Guido Trentalancia wrote:
> But let me just try again pointing out a few further details so that
> everybody would better understand the issue.
> 
> It is a maintenance issue with the Makefiles.
> 
> The DESTDIR variable does not matter much because the problem is that it
> breaks not only the installation but also the compilation itself (prior
> to the installation) !
> 
> So, DESTDIR is generally only used during the installation process (what
> DESTINATION directory shall I write to ?).

That may be true, but we have been using it to perform local builds of
the entire source repository for a very long time.  In the case of
package builds, it doesn't matter because there each component is
separately compiled and the package dependencies ensure that the
required components are built and installed first.  At some distant
point in the past, this approach of using make DESTDIR was introduced as
a way to allow us to build the entire tree without requiring us to
introduce -I and -L options relative to the current directory, as that
was viewed as being more painful to maintain and wrong when built
separately (as for packages).

> The compilation problem being discussed here is twofold: compilation
> itself (from *.c source code to *.o object code) and linking (from *.o
> object code to the tool or shared library executable).
> 
> So the first side of the problem (compilation stage) is due to the fact
> that gcc is only allowed to include header files from the system-wide
> header repository (e.g. -I/usr/include) while unfortunately it is not
> allowed/configured to try picking up local header files first (as in
> having -I$(CURDIR)/libselinux/include -I$(CURDIR)/libsepol/include -I
> $(CURDIR)/libsemanage/include before any eventual system-wide
> -I/usr/include).

Build with make DESTDIR=/some/path install, and it should already add
-I/some/path/usr/include to your CFLAGS, which will then get picked up
before the system headers (as per man gcc and confirmed by experiment).

> The second side of the problem (linking stage) is due to a somewhat
> similar fact that gcc is only allowed to search dynamic (shared)
> libraries in system-wide repositories (such as -L/usr/lib) while it is
> not allowed/configured to search the local build directories first (as
> in having -L$(CURDIR)/libselinux/src -L$(CURDIR)/libsepol/src -L
> $(CURDIR)/libsemanage/src before any system-wide -L/usr/lib).

Likewise, make DESTDIR=/some/path install will adjust your LDFLAGS
correctly.

> For reference: the CURDIR variable is expanded by the GNU make tools to
> the current directory (it is a GNU make functionality). I propose
> exploiting such variable in the top-level Makefile in order to determine
> the top-level SELinux-userspace directory and subsequently pass it
> recursively to lower-level Makefiles (so that it is used in turn as the
> base for the *local* -I include and -L link compiler/linker flags).

Ok, maybe we didn't know about CURDIR back then or thought it would
break separate package builds.  I don't recall.  I'm not fundamentally
opposed to the changes so long as they don't introduce any regressions,
but I wanted to be sure that people understand the history.

> That said, I must admit I do not know much about the history, although
> it seems to me from the git logs that the problem has been there since
> the very first git commit.

Yet it has worked for us for quite a long time, via make DESTDIR.  If it
is broken, it is a recent change that broke it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
