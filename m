Subject: Re: [PATCH v5] Fix includes for userspace tools and libraries
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Thu, 15 Sep 2011 21:37:09 +0200
In-Reply-To: <1316110489.16483.68.camel@moss-pluto>
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
	 <1316106992.16483.35.camel@moss-pluto>  <1316107603.2202.43.camel@vortex>
	 <1316110489.16483.68.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316115430.2202.96.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-15 at 14:14 -0400, Stephen Smalley wrote:
> On Thu, 2011-09-15 at 19:26 +0200, Guido Trentalancia wrote:
> > My requirements are that I am on a 64-bit system and therefore I
> > need/want to distiguish between "lib" and "lib64". I do not need/care
> > about distinguishing between SHLIBDIR and LIBDIR. I am fine either
> > without a DESTDIR or with a DESTDIR as you suggested (both are
> > problematic).
> 
> rm -rf ~/out
> make DESTDIR=~/out install
> rm -rf ~/out
> make DESTDIR=~/out LIBDIR=~/out/usr/lib64 SHLIBDIR=~/out/lib64 install
> 
> Both work fine for me with current selinux git master branch + Eric's
> patch 1/2 libselinux + my policycoreutils sandbox patch.
> 
> > And it breaks again after that...
> 
> You'd have to show where it fails.  It seems to work for me and Eric.

With the original git the breakage is as follows (simple "make" with
default target which is not "install"):

(missing libsepol header when compiling libselinux):

cc -O3 -march=corei7 -mtune=corei7 -I../include -I/usr/include
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64   -c -o load_policy.o load_policy.c
load_policy.c:14:25: fatal error: sepol/sepol.h: No such file or
directory

and from then on, it is a long series of failures:

(missing libsepol header when compiling libsemanage)
(missing libselinux header when compiling libsemanage)
(missing libsepol header when compiling checkpolicy)
(missing libsepol static lib when linking checkpolicy)
(missing libsepol header when compiling under checkpolicy/test)
(missing libsepol header when compiling policycoreutils/setfiles)
(missing libselinux header when compiling policycoreutils/setfiles)
(same as previous two for policycoreutils/load_policy)
(missing libselinux header for newrole)
(missing libselinux header for run_init)
(same as above for sandbox)
(same as above for secon)
(same as above for sestatus)
(missing libsepol header for semodule_package)
(missing libsemanage header for semodule)
(missing libsepol header for semodule_link)
(missing libsepol header for semodule_expand)
(missing libsepol static lib for semodule_deps)
...

Only if "install" target is forced, then it works. That's why I still
believe the patch is worth.

It is not normal that an installation is mandatory for building a
package...

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
