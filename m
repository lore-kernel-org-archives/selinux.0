Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7PGlZ5F024885
	for <selinux@tycho.nsa.gov>; Sat, 25 Aug 2012 12:47:35 -0400
Received: by vcbfl17 with SMTP id fl17so3754532vcb.12
        for <selinux@tycho.nsa.gov>; Sat, 25 Aug 2012 09:47:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACLa4puinrGaotQ5f5rqvYusA7mV-0qTaBUaF+teYfRezZE6Rw@mail.gmail.com>
References: <201208211615.q7LGFg3M000832@vivaldi49.register.it>
	<CAPzO=Nyqc0=cyeOh6Aj3A-bSbtpbnjSfsXc_Lf-kO3ceeK3w2A@mail.gmail.com>
	<CACLa4puinrGaotQ5f5rqvYusA7mV-0qTaBUaF+teYfRezZE6Rw@mail.gmail.com>
Date: Sat, 25 Aug 2012 18:47:33 +0200
Message-ID: <CAPzO=NwR-7KruhfYYRO+SFGD2=cmuG+w5dNPaqbz=UhiJ4=Ziw@mail.gmail.com>
Subject: Re: [PATCH/RFC] setools: update swig interfaces for swig-2.0.7 (and higher?)
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 24, 2012 at 7:17 PM, Eric Paris <eparis@parisplace.org> wrote:
> With your patch does it still build with the old swig version?  I know
> we put a nasty hack in Fedora which made it build with new swig, but
> wouldn't build with old swig.

It builds fine with swig-2.* (tested with 2.0.3, 2.0.4, 2.0.7 and now 2.0.8).

swig-1.3.40 doesn't, but without my patch it fails with 1.3.40 as well.

make[1]: Entering directory
`/var/tmp/portage/app-admin/setools-3.3.7-r6/work/setools-3.3.7/libsefs/swig/python-3.2'
x86_64-pc-linux-gnu-g++ -shared -o _sefs.so.4.0.3 sefs_wrap.cc
-fno-strict-aliasing   -I/usr/include -I/usr/include
-I../../../libqpol/include -I../../../libapol/include -I../../.. -fpic
-I../../../libsefs/include -march=native -ggdb -O2 -pipe
-I/usr/include/python3.2 -lpython3.2 ../../../libapol/src/libapol.so
../../../libqpol/src/libqpol.so ../../../libsefs/src/libsefs.so
-lsqlite3   -lxml2   -Wl,-O1 -Wl,--as-needed -Wl,-soname,_sefs.so.4
sefs_wrap.cc: In function 'swig_module_info* SWIG_Python_GetModule()':
sefs_wrap.cc:2452:51: error: 'PyCObject_Import' was not declared in this scope
sefs_wrap.cc: In function 'void SWIG_Python_SetModule(swig_module_info*)':
sefs_wrap.cc:2521:92: error: 'PyCObject_FromVoidPtr' was not declared
in this scope
sefs_wrap.cc: In function 'swig_type_info* SWIG_Python_TypeQuery(const char*)':
sefs_wrap.cc:2544:60: error: 'PyCObject_AsVoidPtr' was not declared in
this scope
sefs_wrap.cc:2549:51: error: 'PyCObject_FromVoidPtr' was not declared
in this scope

We switched building with swig-2 at the time that the latest stable
SELinux policy utilities (libselinux, libsemanage, policycoreutils,
...) were released as that was the then stable swig version in Gentoo.

> WTF was swig thinking making a non-backwards compat change like this?!

It's probably considered to be a bug(fix) than a change - more strict
checking or so. What is the swig version you build setools with?

Wkr,
  Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
