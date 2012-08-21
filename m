Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7LGFkAi001373
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2012 12:15:47 -0400
Message-Id: <201208211615.q7LGFg3M000832@vivaldi49.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: sven.vermeulen@siphos.be, selinux@tycho.nsa.gov
Subject: Re: [PATCH/RFC] setools: update swig interfaces for swig-2.0.7 (and higher?)
Date: Tue, 21 Aug 2012 18:15:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

For your information. Apparently swig version 2.0.8 has been just released...


>Hi guys,
>
>In Gentoo, I had to patch the setools package' swig interfaces to build with
>the swig-2.0.7 (and probably a few previous ones, version 2.0.4 still seemed
>to build the code properly). The patch is fairly large (228 KiB) so I've put
>it online for now. However, I'm not sure if this is the right way to fix
>things or not.
>
>In any case, the build failures we got were:
>
>../qpol.i:241: Warning 504: Function qpol_module::qpol_module_t(char const
>*) must have a return type. Ignored.
>../qpol.i:244: Warning 521: Illegal destructor name
>qpol_module::~qpol_module_t(). Ignored.
>
>and
>
>qpol_wrap.c:1831:24: error: conflicting types for qpol_module_get_path
>../../../libqpol/include/qpol/module.h:69:13: note: previous declaration of qpol_module_get_path was here
>qpol_wrap.c: In function qpol_module_get_path:
>qpol_wrap.c:1834:3: error: too many arguments to function qpol_module_get_path
>qpol_wrap.c:1831:24: note: declared here
>
>I fixed it by changing the constructors/destructor names to the struct name
>(as in "typedef struct qpol_module {} qpol_module_t" so the
>constructur/destructor uses "qpol_module" rather than "qpol_module_t", and
>by introducing %rename() calls for each collision found during the build
>process.
>
>The patch is at
>http://dev.gentoo.org/~swift/patches/0008-fix_swig_build_failures_bug_430262.patch
>
>If it is the right patch, I hope this saves a few hours of work for the
>other developers ;-)
>
>Wkr,
>	Sven Vermeulen
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
