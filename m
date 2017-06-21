Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5L9d8k0008376
 for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2017 05:39:08 -0400
Subject: Re: [PATCH 2/4] libselinux, libsemanage: link Ruby wrapper with -lruby
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161114212817.15781-1-nicolas.iooss@m4x.org>
 <20161114212817.15781-2-nicolas.iooss@m4x.org>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <d0922e29-f6ab-6302-ec8d-8e22ec2368b8@debian.org>
Date: Wed, 21 Jun 2017 11:38:57 +0200
MIME-Version: 1.0
In-Reply-To: <20161114212817.15781-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

Le 14/11/16 à 22:28, Nicolas Iooss a écrit :
> When linking with -Wl,-no-undefined in LDFLAGS (in order to find
> possible link-time errors), the Ruby wrapper module needs to be linked
> with the libruby.so which is used by $(RUBY). Introduce a new RUBYLIBS
> variable to find this library.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>   libselinux/src/Makefile  | 3 ++-
>   libsemanage/src/Makefile | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 4fe1f7002181..82a1010af2d8 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -15,6 +15,7 @@ INCLUDEDIR ?= $(PREFIX)/include
>   PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>   PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
>   RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
> +RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')

I'm trying to package 2.7-rc2 in debian and unfortunately this is not 
working out of the box for me. The library is not installed as -lruby 
but as -lruby-2.3 (for ruby 2.3). In addition the lib is not installed 
in /usr/lib.

I can see in the RbConfig::CONFIG hash a key called LIBRUBYARG_SHARED or 
LIBRUBYARG which contains "-lruby-2.3". Also I see a "archlibdir" or 
"sitearchlibdir" key which contains the correct path to the lib (the 
multiarch path)

RUBYLIBS ?= $(shell $@ -e 'puts "-L" + RbConfig::CONFIG["archlibdir"] + 
" " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')

Could this be a possible alternatives for the other distributions?

Regards,

Laurent Bigonville
