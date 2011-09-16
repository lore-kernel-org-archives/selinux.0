Subject: Re: [PATCH 11/67] policycoreutils: setfiles: FIXME switch from stat
 to
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, eparis@redhat.com,
        selinux@tycho.nsa.gov
Date: Fri, 16 Sep 2011 15:07:38 +0200
In-Reply-To: <1316176884.20456.7.camel@moss-pluto>
References: <4E724F22.20402@redhat.com>  <1316157190.2364.57.camel@vortex>
	 <1316176884.20456.7.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316178458.2211.38.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-09-16 at 08:41 -0400, Stephen Smalley wrote:
> On Fri, 2011-09-16 at 09:13 +0200, Guido Trentalancia wrote:
> > On Thu, 2011-09-15 at 15:16 -0400, Daniel J Walsh wrote:
> > > From 1268e66e94286a55c399383d5959734d3597792d Mon Sep 17 00:00:00 2001
> > > From: Eric Paris <eparis@redhat.com>
> > > Date: Sun, 10 Jul 2011 16:54:25 +0200
> > > Subject: [PATCH 11/67] policycoreutils: setfiles: FIXME switch from
> > > stat to
> > >  stat64
> > > 
> > > This looks bad.  glibc takes care of this.  We should do send this
> > > upstream but I would like to know why you did it in Fedora....
> > > 
> > > NOT-Signed-off-by: Eric Paris <eparis@redhat.com>
> > > ---
> > >  policycoreutils/setfiles/restore.c |    8 ++++----
> > >  1 files changed, 4 insertions(+), 4 deletions(-) 
> > 
> > Perhaps you could exploit a few #ifdef's here ?
> > 
> > Such as _LARGEFILE_SOURCE _LARGEFILE64_SOURCE and/or
> > _FILE_OFFSET_BITS=64 ?
> > 
> > More available from:
> > 
> > info libc 'Feature Test Macros'
> 
> We were doing that before converting setfiles from using nftw(3) to
> using fts(3) for the file tree walk.  But fts.h has this gem:
> /* The fts interface is incompatible with the LFS interface which
>    transparently uses the 64-bit file access functions.  */
> #ifdef __USE_FILE_OFFSET64
> # error "<fts.h> cannot be used with -D_FILE_OFFSET_BITS==64"
> #endif

That must be the reason why other projects are moving in the opposite
direction, see for example:

http://sourceforge.net/tracker/index.php?func=detail&aid=3126942&group_id=3382&atid=103382

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
