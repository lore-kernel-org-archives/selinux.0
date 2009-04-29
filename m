MIME-Version: 1.0
In-Reply-To: <1241029569.18249.260.camel@localhost.localdomain>
References: <dd18b0c30904282217y10fc6c6coe115e83e89ce1536@mail.gmail.com>
	 <1241005910.18249.124.camel@localhost.localdomain>
	 <dd18b0c30904290755s603d6549o6b1866ecd68915a@mail.gmail.com>
	 <1241029569.18249.260.camel@localhost.localdomain>
Date: Wed, 29 Apr 2009 13:09:05 -0700
Message-ID: <dd18b0c30904291309x59cf80a6g55664fd25c056a66@mail.gmail.com>
Subject: Re: load_policy.c:351:1: error: "MNT_DETACH" redefined
From: Justin Mattock <justinmattock@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 29, 2009 at 11:26 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2009-04-29 at 07:55 -0700, Justin Mattock wrote:
>> On Wed, Apr 29, 2009 at 4:51 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> > On Tue, 2009-04-28 at 22:17 -0700, Justin Mattock wrote:
>> >> I get an error while compiling libselinux
>> >> with a simple "make"
>> >>
>> >> load_policy.c:351:1: error: "MNT_DETACH" redefined
>> >> In file included from load_policy.c:5:
>> >> /usr/include/sys/mount.h:102:1: error: this is the location of the
>> >> previous definition
>> >> make[1]: *** [load_policy.o] Error 1
>> >> make[1]: Leaving directory `/home/name/LFS/SELinux/libselinux-2.0.79/src'
>> >> make: *** [all] Error 2
>> >>
>> >> but if I:
>> >> make CC="/usr/bin/i686-pc-linux-gnu-gcc-4.4.0" CFLAGS="-march=core2
>> >> -mtune=core2 -pipe -O2 -fomit-frame-pointer" CXXFLAGS="${CFLAGS}"
>> >> MAKEOPTS="{-j3}"
>> >> libselinux will compiled with just a:
>> >>
>> >> load_policy.c:351:1: warning: "MNT_DETACH" redefined
>> >> In file included from load_policy.c:5:
>> >> /usr/include/sys/mount.h:102:1: warning: this is the location of the
>> >> previous definition
>> >>
>> >>
>> >> if I change load_policy.c(to the best of my knowledge)
>> >> with the attached patch
>> >> and then run make normally
>> >> libselinux will compile
>> >
>> > Your patch doesn't make sense - defining a symbol to itself.  If the
>> > symbol were always defined in sys/mount.h, one would just remove the
>> > duplicate definition from load_policy.c.  But it isn't defined in
>> > sys/mount.h in any version of glibc that I can see, and thus has to at
>> > least be conditionally defined in load_policy.c.  Now, you could bracket
>> > it with:
>> > #ifndef MNT_DETACH
>> > #define MNT_DETACH 2
>> > #endif
>> >
>> > Then it will build correctly with either set of headers.
>> > Out of curiosity, where are you obtaining your sys/mount.h from?
>> >
>> > --
>> > Stephen Smalley
>> > National Security Agency
>> >
>> >
>>
>> yeah I admit it, I frantically looked in sys/mount.h
>> for any kind of hints(which lead to what I had created).
>>
>> As for what version I have, sounds like these are headers
>> from libc. In that case,  it's the latest from:
>> ftp://sources.redhat.com/pub/glibc/snapshots/
>> version glibc-2.9-20090427.tar.bz2
>
> I see - the definition was added 5 days ago to the glibc source tree.
> So, yes, we'll want to wrap the definition of MNT_DETACH as above, but
> we still need to keep the fallback definition for older glibc and for
> alternative libc implementations that lack the definition altogether.
>
>> As for you're idea: bracketing it, well
>> this is why you make the big bucks,
>> and I'm stuck working at MCDonalds
>> ;^)
>
> Hey, at least you have happy customers.
>
> --
> Stephen Smalley
> National Security Agency
>
>

I'm just having a little fun!!

Anyways I think the best approach is how
you had handled the fix(rather than what I had done).
If need be I can go and try what you had suggested
to make sure everything is legit.

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
