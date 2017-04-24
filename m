Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3O3lIBp017177
 for <selinux@tycho.nsa.gov>; Sun, 23 Apr 2017 23:47:19 -0400
Received: by mail-it0-f45.google.com with SMTP id x188so35779462itb.0
 for <selinux@tycho.nsa.gov>; Sun, 23 Apr 2017 20:47:14 -0700 (PDT)
Date: Mon, 24 Apr 2017 11:47:11 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: last call for selinux 2.7-rc1 release
Message-ID: <20170424034711.GA25053@meriadoc.perfinion.com>
References: <1492783467.26658.6.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492783467.26658.6.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Apr 21, 2017 at 10:04:27AM -0400, Stephen Smalley wrote:
> Hi,
> 
> We plan to cut a 2.7-rc1 selinux userspace release in the next week or
> so.  If you have any additional patches you want included in 2.7,
> please post them to the list soon.

Thanks for the notice, I have a couple things:
1) mcstransd still needs to be ported to libpcre2 from the looks of it.
I know nothing about libpcre so probably easier if someone else does it ;)

2) the libpcre CFLAGS and LDLIBS should get stuff from pkg_config cuz i
think some arches have special requirements (but i forgot which was the
problem)

3) I have a patch for policycoreutils so that it honours LINGUAS and
only installs the .po files that the user wants. I'll send it with the
next things.

4) There are a few things with the build system that have had patches in
gentoo for a fair while that I want to upstream but I'm not sure the
best way.

4a) there is a bit of mixup with LDLIBS and LDFLAGS throughout, -lfoo
goes in LDLIBS and -L/usr/lib/foo goes in LDFLAGS.
https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html
This is pretty uncontroversial so i'll send a patch to set/reorder them. It
matters because some compilers are stricter and things can also break with
things like -Wl,as-needed.
https://ao2.it/en/blog/2011/11/27/dont-mix-ldflags-and-ldlibs

4b) This is the one im confused about, we've had a patch in gentoo for
ages to remove -I/usr/include and -L/usr/lib cuz the toolchain
automatically handles those and apparently they are wrong if you are
cross compiling and stuff or compiling into a SYSROOT.
https://bugs.gentoo.org/500674
The latest incarnation of the patch is at:
https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-libs/libselinux/files/libselinux-2.6-0007-build-related-fixes-bug-500674.patch
https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-libs/libsemanage/files/libsemanage-2.7-build-paths.patch

I was working on a patch to remove these everywhere and it works to
build on my machine from my initial testing but it appears to break
if you do make DESTDIR=/tmp/selinux install which is in the README.
Arguably, this is abusing DESTDIR because DESTDIR should never affect
compilation and currently that command uses /tmp/selinux/include/*.h
and stuff instead of the global ones. On the other hand, it is fairly
convenient to build and test it all in one command.

What is the best way to approach this? As far as I can tell, the correct
way to install into /tmp/selinux would be to override *FLAGS and add
those search dirs manually but that gets rather verbose.
We could add a new target to the root Makefile to add all those extra
paths so we can be lazy?

Thoughts?
Jason
