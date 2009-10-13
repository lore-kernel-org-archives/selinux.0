Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9DE7brM006353
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 10:07:37 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9DE6jcs023055
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 14:06:46 GMT
Message-ID: <4AD489A5.7010708@manicmethod.com>
Date: Tue, 13 Oct 2009 10:07:33 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, Raphael Geissert <geissert@debian.org>,
        549610-forwarded@bugs.debian.org
Subject: Re: /lib/libsemanage.so.1 links to  /usr/lib/libustr-1.0.so.1
References: <87aazvu5d4.fsf@anzu.internal.golden-gryphon.com>
In-Reply-To: <87aazvu5d4.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Manoj Srivastava wrote:
> Hi,
>
>          As demonstrated by
>
> $ ldd /lib/libsemanage.so.1
>          linux-gate.so.1 =>   (0xb8092000)
>          libsepol.so.1 =>  /lib/libsepol.so.1 (0xb8015000)
>          libselinux.so.1 =>  /lib/libselinux.so.1 (0xb7ffa000)
>          libbz2.so.1.0 =>  /lib/libbz2.so.1.0 (0xb7fe9000)
>          libustr-1.0.so.1 =>  /usr/lib/libustr-1.0.so.1 (0xb7fbf000)
>          libc.so.6 =>  /lib/i686/cmov/libc.so.6 (0xb7e60000)
>          libdl.so.2 =>  /lib/i686/cmov/libdl.so.2 (0xb7e5c000)
>          /lib/ld-linux.so.2 (0xb8093000)
>
> 	libsemanage1 links to libustr which is located under the,
>   possible separate or external, /usr partition, which would render
>   libsemanage unusable in such setups. (This dependency has been around
>   since 2.0.9).
>
>          Should we move libsemanage1 to /usr/lib? The only reason for it
>   to be in /lib would be for early boot, where /usr might not be
>   available, but at this point, it is likely not usable without /usr
>   anyway.
>
>          manoj


Yes, I'm not sure why you'd need libsemanage during early boot, we 
probably should apply this:

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index cfb9558..c531a2f 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -1,7 +1,7 @@
  # Installation directories.
  PREFIX ?= $(DESTDIR)/usr
  LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(DESTDIR)/lib
+SHLIBDIR ?= $(PREFIX)/lib
  INCLUDEDIR ?= $(PREFIX)/include
  PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % 
sys.version_info[0:2]')
  PYINC ?= /usr/include/${PYLIBVER}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
