Subject: Re: [PATCH] Fix include semanage/handle.h for semanage_set_root()
 as used by semodule
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Guido Trentalancia <guido@trentalancia.com>,
        SELinux Mail List
 <selinux@tycho.nsa.gov>
In-Reply-To: <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Sep 2011 08:57:33 -0400
Message-ID: <1315832253.17035.5.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-09-09 at 13:31 -0400, Eric Paris wrote:
> I'm also really annoyed by this at times, but I don't know what the
> right answer is.
> 
> We really treat it like we have 5+ separate projects which just all
> happen to live in the same git tree.  Thus to build libselinux you
> must have already built and installed libsepol.  And then to build
> libsemanage you need to have done that with both libsepol and
> libselinux.  Then of course to get the builds and install right (on
> Fedora/RHEL) you have to know to use LIBDIR=/usr/lib64 SHLIBDIR=/lib64
> for libsepol and libsepol, but SHLIBDIR=/usr/lib64 for libsemanage.
> Its a mess, but I don't know what to do that's better....

make DESTDIR=~/out at top-level should work fine - it will build and
install each library into a private tree (as specified by DESTDIR) and
then build and install the programs against those libraries.  Without
needing to clobber the system ones.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
