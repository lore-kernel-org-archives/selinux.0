Message-Id: <201206051647.q55GlIsE024431@vivaldi36.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: SELinux@tycho.nsa.gov
Subject: Re: [PATCH]: allow standard compilation of GIT development tree (was Re: [PATCH]: do not link static libraries from the system library directory)
Date: Tue, 05 Jun 2012 18:47:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Eric.

>On Tue, 2012-06-05 at 00:07 +0200, Guido Trentalancia wrote:
>
>> Allow standard compilation with separate installation of the SELinux
>> GIT development tree.
>> 
>> To build, just type "make".
>> 
>> To install (after successful build), just type "make install".
>> 
>> During installation, it is possible to pass the variables DESTDIR,
>> LIBDIR and SHLIBDIR to GNU make in order to fine tune the results.
>> 
>> Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
>> 
>> ---
>>  Makefile |   14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>> 
>> --- selinux/Makefile	2011-09-09 20:12:55.977662144 +0200
>> +++ selinux-04062012/Makefile	2012-06-04 23:35:49.859339267 +0200
>> @@ -2,11 +2,21 @@ SUBDIRS=libsepol libselinux libsemanage
>>  PYSUBDIRS=libselinux libsemanage
>>  DISTCLEANSUBIDRS=libselinux libsemanage
>>  
>> +TOPDIR := $(shell pwd)
>> +
>> +CPPFLAGS ?= -I$(TOPDIR)/libselinux/include -I$(TOPDIR)/libsepol/include -I$(TOPDIR)/libsemanage/include
>> +LDFLAGS ?= -L$(TOPDIR)/libselinux/src -L$(TOPDIR)/libsepol/src -L$(TOPDIR)/libsemanage/src
>> +CFLAGS ?= $(CPPFLAGS)
>> +
>>  ifeq ($(DEBUG),1)
>> -	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
>> -	export LDFLAGS = -g
>> +	CFLAGS += -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
>> +	LDFLAGS += -g
>>  endif
>
>My problem with this patch is that now all of the CFLAGS stuff we have
>lower in the tree (namely -W* stuff) is not going to get picked up since
>CFLAGS are already exported...
>
>So how do we solve that one too?

I suppose that happens because you are appending the variables to the make invocation, as in:

make DEBUG=1

If you set them in the environment (i.e. set and export them prior to the make invocation) or pre-append them to the make invocation as in:

DEBUG=1 make

then it should work as expected.

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
