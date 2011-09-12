Subject: Re: [PATCH] Fix includes for userspace tools and libraries (was Re:
 [PATCH] Fix include semanage/handle.h for semanage_set_root() as used by
 semodule)
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Tue, 13 Sep 2011 01:05:58 +0200
In-Reply-To: <4E6E8149.30702@redhat.com>
References: <1315587716.2170.16.camel@vortex>
	  <1315588656.2170.26.camel@vortex>
	  <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	  <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315868758.2177.8.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Eric.

On Mon, 2011-09-12 at 18:01 -0400, Eric Paris wrote:
> On 09/12/2011 04:29 PM, Guido Trentalancia wrote:
> > Hi Stephen.
> > 
> > On Mon, 2011-09-12 at 08:57 -0400, Stephen Smalley wrote:
> >> On Fri, 2011-09-09 at 13:31 -0400, Eric Paris wrote:
> >>> I'm also really annoyed by this at times, but I don't know what the
> >>> right answer is.
> >>>
> >>> We really treat it like we have 5+ separate projects which just all
> >>> happen to live in the same git tree.  Thus to build libselinux you
> >>> must have already built and installed libsepol.  And then to build
> >>> libsemanage you need to have done that with both libsepol and
> >>> libselinux.  Then of course to get the builds and install right (on
> >>> Fedora/RHEL) you have to know to use LIBDIR=/usr/lib64 SHLIBDIR=/lib64
> >>> for libsepol and libsepol, but SHLIBDIR=/usr/lib64 for libsemanage.
> >>> Its a mess, but I don't know what to do that's better....
> >>
> >> make DESTDIR=~/out at top-level should work fine - it will build and
> >> install each library into a private tree (as specified by DESTDIR) and
> >> then build and install the programs against those libraries.  Without
> >> needing to clobber the system ones.
> > 
> > At the moment, it does not, until the Makefile(s) are modified or at
> > least until the libraries are manually installed first.
> > 
> > Try by yourself, but do not forget to remove
> > $(PREFIX)/usr/include/{selinux,semanage,sepol} and
> > $(PREFIX){/usr,}/lib/libse{linux,manage,pol}* first !
> 
> I recently added the patch which changed the global to be 'build'
> instead of 'install', so sds might not realize that 'install' is no
> longer the default, however I think Guido is right about the install
> having a number of paces that it hard coded things...

The new target seems to be "all" (introduced on Aug the 11th by Eric).

However, at the moment, without an existing installation in place the
build fails on my system because it cannot source header files from
$(PREFIX)/include/{selinux,sepol,semanage} during compilation and then
because it cannot source shared libraries from LIBDIR ?= $(PREFIX)/lib
during linking.

It also fails if an existing installation provides obsolete header
files.

Another (even better) way of achieving the same would probably be to set
a TOPLEVEL variable to "pwd" (shell builtin for current directory) in
the top-level Makefile and then add -I
$(TOPLEVEL)/{selinux,sepol,semanage}/include and -L
$(TOPLEVEL)/lib{selinux,sepol,semanage}/src to CFLAGS and LDFLAGS
respectively...

What do you think ?

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
