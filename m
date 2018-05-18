Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4I54dBd003762
 for <selinux@tycho.nsa.gov>; Fri, 18 May 2018 01:04:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id x9-v6so3166677pfm.2
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 22:03:37 -0700 (PDT)
Date: Fri, 18 May 2018 13:03:18 +0800
From: Jason Zaman <jason@perfinion.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Message-ID: <20180518050318.GA6239@baraddur.perfinion.com>
References: <20180517051117.48454-1-jason@perfinion.com>
 <CAJfZ7==n4+U6U2TGZDDSO8C6GQp5-8fMAV3C26eoqJfP6Z51OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJfZ7==n4+U6U2TGZDDSO8C6GQp5-8fMAV3C26eoqJfP6Z51OA@mail.gmail.com>
Subject: Re: SELinux musl support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 17, 2018 at 09:22:01PM +0200, Nicolas Iooss wrote:
> On Thu, May 17, 2018 at 7:11 AM, Jason Zaman <jason@perfinion.com> wrote:
> > This series fixes compiling and running on musl libc.
> >
> > patches 1-2 are fairly trivial.
> >
> > patches 3-4 are a feature change on that platform since it does not
> > support GLOB_TILDE and GLOB_BRACE. tilde is coming in musl 1.1.21
> > according to [1]. brace support is not documented anywhere or in the
> > example configs so that is probably not a big problem.
> >
> > patch 5 fixes a bug and it just happens that glibc returns a value for
> > sysconf and the error handling was wrong but never noticed.
> >
> > [1]: https://wiki.musl-libc.org/roadmap.html
> >
> > [PATCH 1/5] sestatus: include limits.h for PATH_MAX
> > [PATCH 2/5] libselinux: enable linking to musl-fts
> > [PATCH 3/5] setfiles: Musl compatibility for GLOB_BRACE and
> > [PATCH 4/5] restorecond: Musl compatibility for GLOB_BRACE and
> > [PATCH 5/5] genhomedircon: sysconf can return -1 without failure
> 
> Thanks! These patches look good to me and I would also appreciate if
> they are merged in 2.8.

Awesome, I'll push them on monday then unless there are any issues
before then :)
> 
> Nicolas
> 
