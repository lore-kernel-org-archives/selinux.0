Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4L9g7Bl026071
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 05:42:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID08.oob.disa.mil (Postfix) with SMTP id 40qDMJ5HW7z3TWMV
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 09:42:04 +0000 (UTC)
Received: from USFB19PA18.eemsg.mil (unknown [192.168.16.14])
 by USFBF3ID08.oob.disa.mil (Postfix) with ESMTP id 40qDMJ1DCXz3TWMW
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 09:42:04 +0000 (UTC)
Received: by mail-pl0-f68.google.com with SMTP id e6-v6so8478456plt.11
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 02:42:02 -0700 (PDT)
Date: Mon, 21 May 2018 17:41:58 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
Message-ID: <20180521094158.GA62096@baraddur.perfinion.com>
References: <20180517051117.48454-1-jason@perfinion.com>
 <CAJfZ7==n4+U6U2TGZDDSO8C6GQp5-8fMAV3C26eoqJfP6Z51OA@mail.gmail.com>
 <20180518050318.GA6239@baraddur.perfinion.com>
 <acddd718-3b1f-9745-00fc-d3115964178a@tycho.nsa.gov>
 <20180518155858.GA35598@baraddur.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518155858.GA35598@baraddur.perfinion.com>
Subject: Re: SELinux musl support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 18, 2018 at 11:58:58PM +0800, Jason Zaman wrote:
> On Fri, May 18, 2018 at 08:58:58AM -0400, Stephen Smalley wrote:
> > On 05/18/2018 01:03 AM, Jason Zaman wrote:
> > > On Thu, May 17, 2018 at 09:22:01PM +0200, Nicolas Iooss wrote:
> > >> On Thu, May 17, 2018 at 7:11 AM, Jason Zaman <jason@perfinion.com> wrote:
> > >>> This series fixes compiling and running on musl libc.
> > >>>
> > >>> patches 1-2 are fairly trivial.
> > >>>
> > >>> patches 3-4 are a feature change on that platform since it does not
> > >>> support GLOB_TILDE and GLOB_BRACE. tilde is coming in musl 1.1.21
> > >>> according to [1]. brace support is not documented anywhere or in the
> > >>> example configs so that is probably not a big problem.
> > >>>
> > >>> patch 5 fixes a bug and it just happens that glibc returns a value for
> > >>> sysconf and the error handling was wrong but never noticed.
> > >>>
> > >>> [1]: https://wiki.musl-libc.org/roadmap.html
> > >>>
> > >>> [PATCH 1/5] sestatus: include limits.h for PATH_MAX
> > >>> [PATCH 2/5] libselinux: enable linking to musl-fts
> > >>> [PATCH 3/5] setfiles: Musl compatibility for GLOB_BRACE and
> > >>> [PATCH 4/5] restorecond: Musl compatibility for GLOB_BRACE and
> > >>> [PATCH 5/5] genhomedircon: sysconf can return -1 without failure
> > >>
> > >> Thanks! These patches look good to me and I would also appreciate if
> > >> they are merged in 2.8.
> > > 
> > > Awesome, I'll push them on monday then unless there are any issues
> > > before then :)
> > 
> > FWIW, the patches look fine to me as well and I did a test PR to trigger travis CI testing
> > and they passed,
> > https://github.com/SELinuxProject/selinux/pull/96
> > 
> > One possible area for improvement (but not necessary to merge this) would be to fix the
> > genhomedircon code to also then handle the case where getpwnam_r/getgrnam_r returns ERANGE,
> > in which case we are supposed to realloc a larger buffer and try again per the man page.
> 
> Yeah i thought about that, but you're supposed to do that even when
> sysconf does return a number and we've apparently never hit this before.
> and the example code in the man pages doesnt really do it either. so as
> small changes as possible before release is better. after release we could
> think about it but probably still not really high importance.

This is all pushed to master now, travis-ci passes on master too.

-- Jason
