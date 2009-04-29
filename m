Subject: Re: load_policy.c:351:1: error: "MNT_DETACH" redefined
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <dd18b0c30904282217y10fc6c6coe115e83e89ce1536@mail.gmail.com>
References: <dd18b0c30904282217y10fc6c6coe115e83e89ce1536@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 29 Apr 2009 07:51:50 -0400
Message-Id: <1241005910.18249.124.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-28 at 22:17 -0700, Justin Mattock wrote:
> I get an error while compiling libselinux
> with a simple "make"
> 
> load_policy.c:351:1: error: "MNT_DETACH" redefined
> In file included from load_policy.c:5:
> /usr/include/sys/mount.h:102:1: error: this is the location of the
> previous definition
> make[1]: *** [load_policy.o] Error 1
> make[1]: Leaving directory `/home/name/LFS/SELinux/libselinux-2.0.79/src'
> make: *** [all] Error 2
> 
> but if I:
> make CC="/usr/bin/i686-pc-linux-gnu-gcc-4.4.0" CFLAGS="-march=core2
> -mtune=core2 -pipe -O2 -fomit-frame-pointer" CXXFLAGS="${CFLAGS}"
> MAKEOPTS="{-j3}"
> libselinux will compiled with just a:
> 
> load_policy.c:351:1: warning: "MNT_DETACH" redefined
> In file included from load_policy.c:5:
> /usr/include/sys/mount.h:102:1: warning: this is the location of the
> previous definition
> 
> 
> if I change load_policy.c(to the best of my knowledge)
> with the attached patch
> and then run make normally
> libselinux will compile

Your patch doesn't make sense - defining a symbol to itself.  If the
symbol were always defined in sys/mount.h, one would just remove the
duplicate definition from load_policy.c.  But it isn't defined in
sys/mount.h in any version of glibc that I can see, and thus has to at
least be conditionally defined in load_policy.c.  Now, you could bracket
it with:
#ifndef MNT_DETACH
#define MNT_DETACH 2
#endif

Then it will build correctly with either set of headers.
Out of curiosity, where are you obtaining your sys/mount.h from?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
