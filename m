Message-ID: <4B46A1B7.5070106@gmail.com>
Date: Thu, 07 Jan 2010 19:08:39 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Error building the userspace tools
References: <1262810246.24200.51.camel@localhost>	 <4B44FE57.9050102@gmail.com> <1262901507.26831.11.camel@localhost>
In-Reply-To: <1262901507.26831.11.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/07/10 13:58, James Carter wrote:
> On Wed, 2010-01-06 at 13:19 -0800, Justin P. Mattock wrote:
>> On 01/06/10 12:37, James Carter wrote:
>>> I don't know what the correct fix for this is, but when I make the
>>> userspace tools with "make LIBDIR=/usr/lib64 SHLIBDIR=/lib64", I need
>>> the patch below for everything to compile.
>>>
>>> What I don't know is:
>>> 1)  Why is this only required when I am specifying lib64?
>>> 2)  Since it is libsemanage that is using libustr and libbz2, why does
>>> semodule and setsebool need to specify them?
>>>
>>> This occurs on Fedora 12.  Is the problem due to a difference in the way
>>> Fedora is building the userspace tools?
>>>
>>>
>>>
>>> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
>>> index c96a286..feba570 100644
>>> --- a/policycoreutils/semodule/Makefile
>>> +++ b/policycoreutils/semodule/Makefile
>>> @@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
>>>
>>>    CFLAGS ?= -Werror -Wall -W
>>>    override CFLAGS += -I$(INCLUDEDIR)
>>> -LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
>>> +LDLIBS = -lustr -lbz2 -lsepol -lselinux -lsemanage -L$(LIBDIR)
>>>    SEMODULE_OBJS = semodule.o
>>>
>>>    all: semodule
>>> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
>>> index 556b780..214abc3 100644
>>> --- a/policycoreutils/setsebool/Makefile
>>> +++ b/policycoreutils/setsebool/Makefile
>>> @@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
>>>
>>>    CFLAGS ?= -Werror -Wall -W
>>>    override CFLAGS += -I$(INCLUDEDIR)
>>> -LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
>>> +LDLIBS = -lustr -lbz2 -lsepol -lselinux -lsemanage -L$(LIBDIR)
>>>    SETSEBOOL_OBJS = setsebool.o
>>>
>>>    all: setsebool
>>
>> I'm wondering if you
>> commit 55648 is the reason
>> for the error your getting.
>>
>> from over here your make commands
>> look as it should.
>>
> Looking at it again.  The problem is that when I specify LIBDIR and
> SHLIBDIR, semodule and setsebool are linked against the static
> libsemanage library.
>
> An additional problem is that the creation of the link to
> libsemanage.so.1 fails.
>
> This patch seems to fix these two problems
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 67afc60..137af40 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -127,7 +127,7 @@ install: all
>   	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
>   	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
>   	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
> -	cd $(LIBDIR)&&  ln -sf $(LIBSO) $(TARGET)
> +	cd $(SHLIBDIR)&&  ln -sf $(LIBSO) $(TARGET)
>
>   install-pywrap: pywrap
>   	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
> index c96a286..1ab1f57 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -4,10 +4,11 @@ INCLUDEDIR ?= $(PREFIX)/include
>   SBINDIR ?= $(PREFIX)/sbin
>   MANDIR = $(PREFIX)/share/man
>   LIBDIR ?= ${PREFIX}/lib
> +SHLIBDIR ?= $(PREFIX)/lib
>
>   CFLAGS ?= -Werror -Wall -W
>   override CFLAGS += -I$(INCLUDEDIR)
> -LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
> +LDLIBS = -lsepol -lselinux -lsemanage -L$(SHLIBDIR)
>   SEMODULE_OBJS = semodule.o
>
>   all: semodule
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
> index 556b780..17f96d9 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -4,10 +4,11 @@ INCLUDEDIR ?= $(PREFIX)/include
>   SBINDIR ?= $(PREFIX)/sbin
>   MANDIR = $(PREFIX)/share/man
>   LIBDIR ?= ${PREFIX}/lib
> +SHLIBDIR ?= $(PREFIX)/lib
>
>   CFLAGS ?= -Werror -Wall -W
>   override CFLAGS += -I$(INCLUDEDIR)
> -LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
> +LDLIBS = -lsepol -lselinux -lsemanage -L$(SHLIBDIR)
>   SETSEBOOL_OBJS = setsebool.o
>
>   all: setsebool
>

cool glad you got it..
just noticed /lib/semanage.so
and /usr/lib/libsemamage* (over here)

I'm wondering if there should be some
rm -R /lib/libsemanage* in the Makefile,for the old lib
so people don't have to manually rm it?

but then again how hard is it
rm /lib/libsemanage*

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
