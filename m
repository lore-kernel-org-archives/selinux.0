Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9LEtIbv009418
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 10:55:18 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9LEsNY0011459
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 14:54:23 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n9LEnLQ0010241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 09:49:22 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n9LEdhvu032152
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 09:39:43 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] pkgconfig support for libsepol, libselinux, and libsemanage
References: <4ADE735D.9020901@tycho.nsa.gov>
	<1256127809.4061.170.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 21 Oct 2009 09:39:43 -0500
In-Reply-To: <1256127809.4061.170.camel@moss-pluto.epoch.ncsc.mil> (Stephen
	Smalley's message of "Wed, 21 Oct 2009 08:23:29 -0400")
Message-ID: <87ljj4vmj4.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 21 2009, Stephen Smalley wrote:

> On Tue, 2009-10-20 at 22:35 -0400, Eamon Walsh wrote:
>> Add pkgconfig files for libsepol, libselinux, and libsemanage.
>> 
>> Having a pkgconfig file allows the pkg-config(1) tool to be used to
>> query the presence of the library (or a particular version of it),
>> and to obtain the C flags and linker arguments required to use it.
>> 
>> Based on Debian patches by Manoj Srivastava<srivasta@debian.org>.
>> 
>> Signed-off-by: Eamon Walsh<ewalsh@tycho.nsa.gov>
>> ---

>
> Requires.private only applies to the static lib, right?  In the shared
> lib, libsepol is dlopen'd on demand these days and is only needed if
> loading a policy file whose version is greater than the version
> supported by the kernel.

> I'd drop the >= 1.12 or make it more current.  
>
> libpthread should not be necessary any longer (it was temporarily from
> libselinux 2.0.82 through 2.0.84); if the program is already linked with
> libpthread then libselinux will use pthread_once for lazy
> initialization; otherwise it will fall back to a simple test.
>
> Not sure if you should specify libdl or if that is implicitly handled.

        It is implicitly handled. 
>
>> diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsemanage.pc.in
>> new file mode 100644
>> index 0000000..6d0024c
>> --- /dev/null
>> +++ b/libsemanage/src/libsemanage.pc.in
>> @@ -0,0 +1,12 @@
>> +prefix=@prefix@
>> +exec_prefix=${prefix}
>> +libdir=${exec_prefix}/lib
>> +includedir=@includedir@
>> +
>> +Name: libsemanage
>> +Description: SELinux management library
>> +Version: @VERSION@
>> +URL: http://www.nsa.gov/research/selinux/
>> +Requires: libselinux
>> +Libs: -L${libdir} -lsemanage
>> +Cflags: -I${includedir}
>
> Modern libsemanage requires libsepol, libselinux, libbz2, and libustr.

        I need to update that, thanks.

        Also, I have patches now to libselinux/src/Makefile to use
 pkg-config to look for the location of libsepol.a.

     manoj

    [topic--debian]: Add support for cross compilation
    
    The Python bindings are always linked against /usr/lib/libsepol.a. This
    patch allows the specification of the directory one may find libsepol.a
    in.
    
    Signed-off-by: Manoj Srivastava <srivasta@debian.org>

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index b68d586..ac4f467 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -52,6 +52,11 @@ ifneq (,$(filter i386,$(ARCH)))
 TLSFLAGS += -mno-tls-direct-seg-refs
 endif
 
+LIBSEPOLDIR=$(shell pkg-config --variable=libdir libsepol)
+ifeq (,$(strip $(LIBSEPOLDIR)))
+LIBSEPOLDIR=$(LIBDIR)
+endif
+
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
@@ -86,7 +90,7 @@ audit2why.lo: audit2why.c
 	$(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(AUDIT2WHYSO): audit2why.lo
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux $(LIBSEPOLDIR)/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<




-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
