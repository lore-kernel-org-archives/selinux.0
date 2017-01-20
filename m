MIME-Version: 1.0
In-Reply-To: <1484846420.28584.12.camel@tycho.nsa.gov>
References: <CANjvhbOeeRaFw_DhEL=QqLnycvHDd4rAnuLNVikhjQOjPYQVkQ@mail.gmail.com>
 <1484846420.28584.12.camel@tycho.nsa.gov>
From: Karl MacMillan <karlwmacmillan@gmail.com>
Date: Fri, 20 Jan 2017 12:15:24 -0500
Message-ID: <CANjvhbPETU83sYrdA4B+eA_fd2=kBQgdD0fQMg7XrsWea+wigQ@mail.gmail.com>
Subject: Re: [PATCH] Compilation fixes for macOS
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jan 19, 2017 at 12:20 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-01-18 at 12:07 -0500, Karl MacMillan wrote:
>> Compilation fixes for macOS
>>
>> ln on macOS doesn't support --relative, so use the gnu version by
>> default.
>>
>> Changes to how PREFIX is used in recent Makefiles make it so that
>> installation to /usr/local is broken on all systems, but /usr is not
>> writable on recent macOS versions so that is needed. This patch makes
>> 'PREFIX=/usr/local make install' work again, but will break the
>> default of having LIBDIR be /usr/lib and SHLIBDIR be /usr/lib. I'm
>> not
>> certain what this might break.
>
> The default was LIBDIR=/usr/lib SHLIBDIR=/lib.
> We certainly don't want to break that.
> Of course, on usrmerge environments (i.e. modern Fedora), /lib is just
> a symlink to /usr/lib so it doesn't matter, but not everyone is using
> usrmerge.
>

I opted to just document how to make this work on macOS and dropped
this part of the patch.

> Also, your patch was corrupted and not appliable. Use git send-email.
>

Sigh.

Another patch on the way.

Karl

>
>>
>> ---
>>  README                | 3 +++
>>  libsepol/src/Makefile | 6 ++++--
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/README b/README
>> index e6f7276..2e04fa6 100644
>> --- a/README
>> +++ b/README
>> @@ -14,6 +14,9 @@ make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
>> install-pywrap relabel
>>  or on x86 (32-bit), run:
>>  make install install-pywrap relabel
>>
>> +To install everyting under /usr/local run:
>> +make PREFIX=/usr/local install install-pywrap relabel
>> +
>>  This may render your system unusable if the upstream SELinux
>> userspace
>>  lacks library functions or other dependencies relied upon by your
>>  distribution.  If it breaks, you get to keep both pieces.
>> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
>> index 497cd56..1a924e1 100644
>> --- a/libsepol/src/Makefile
>> +++ b/libsepol/src/Makefile
>> @@ -2,7 +2,7 @@
>>  PREFIX ?= $(DESTDIR)/usr
>>  INCLUDEDIR ?= $(PREFIX)/include
>>  LIBDIR ?= $(PREFIX)/lib
>> -SHLIBDIR ?= $(DESTDIR)/lib
>> +SHLIBDIR ?= $(PREFIX)/lib
>>  RANLIB ?= ranlib
>>  LIBBASE ?= $(shell basename $(LIBDIR))
>>  CILDIR ?= ../cil
>> @@ -32,10 +32,12 @@ endif
>>
>>  LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=$(LIBMAP),-z,defs
>>
>> +LN=ln
>>  OS := $(shell uname)
>>  ifeq ($(OS), Darwin)
>>  LD_SONAME_FLAGS=-install_name,$(LIBSO)
>>  LDFLAGS += -undefined dynamic_lookup
>> +LN=gln
>>  endif
>>
>>  all: $(LIBA) $(LIBSO) $(LIBPC)
>> @@ -84,7 +86,7 @@ install: all
>>         install -m 755 $(LIBSO) $(SHLIBDIR)
>>         test -d $(LIBDIR)/pkgconfig || install -m 755 -d
>> $(LIBDIR)/pkgconfig
>>         install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
>> -       ln -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
>> +       $(LN) -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
>>
>>  relabel:
>>         /sbin/restorecon $(SHLIBDIR)/$(LIBSO)
