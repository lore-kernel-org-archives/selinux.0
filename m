Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07823
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 08:50:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA21967
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 12:49:07 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA21961
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 12:49:05 GMT
Date: Tue, 25 Sep 2001 08:49:36 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: "James J." <jjohnson@eclipse.ncsc.mil>
cc: selinux@tycho.nsa.gov
Subject: Re: compiling LSM/SELinux fileutils
In-Reply-To: <200109211246.IAA15519@eclipse.ncsc.mil>
Message-ID: <Pine.SOL.3.95.1010925083321.18877D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 21 Sep 2001, James J. wrote:

> The first problem is that "make" fails because code in 
> fileutils-4.0/aclocal.m4 is duplicated in fileutils-4.0/m4/isc-posix.m4. 
>  Inserting "dnl " in front of lines 519-527 of aclocal.m4 (i.e. 
> commenting out the duplicated lines) appears to fix this problem.  Is 
> there a better solution?
> 
> The second problem is that "make" fails while running autoheader.  Here 
> is the error message:
> 
> make[1]: Entering directory '/usr/src/selinux/utils/fileutils-4.0'
> cd . && autoheader
> autoheader: No template for symbol 'const'
> autoheader: No template for symbol 'mode_t'
> autoheader: No template for symbol 'off_t'
> autoheader: No template for symbol 'size_t'
> make[1]: *** [stamp-h.in] Error 1
> make[1]: Leaving directory '/usr/src/selinux/utils/fileutils-4.0'
> make: *** [all] Error 1
> 
> I'm not familiar with autoheader, so I'm having some difficulty 
> diagnosing this problem.  Any ideas?

These errors don't sound like they are related to SELinux, just general
problems with autoconf - perhaps you need to upgrade your autoconf
package.  What is your base platform - is it RedHat 7.1?  Can you build
the ordinary fileutils source RPM that ships with your system?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
