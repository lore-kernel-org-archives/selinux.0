Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9ABkEWt002397
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 07:46:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9ABkDUb000893
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 11:46:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9ABkChX000890 for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 11:46:12 GMT
Subject: Re: [selinux] Re: autoconf/libtool for libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: Thorsten Kukuk <kukuk@suse.de>, selinux@tycho.nsa.gov
In-Reply-To: <20031010063200.GB29213@bunuel.tii.matav.hu>
References: <20031006201735.GA28880@suse.de>
	 <1065720375.8181.311.camel@moss-spartans.epoch.ncsc.mil>
	 <20031010063200.GB29213@bunuel.tii.matav.hu>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1065786359.8181.411.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 10 Oct 2003 07:45:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-10 at 02:32, Magosányi Árpád wrote:
> I don't think so. Adhering to standards should not be overkill for any
> project. It is doubly so for open source software; you can attract more
> developers if the build process looks like the usual.
> 
> I wanted to reply to the mail with the patch to tell you
> that I consider it as a seemingly marginal, but very important thing,
> but I thought it would be like telling you that the grass is green.

diffstat -p1 of the libselinux autoconf/libtool patch is:

 INSTALL             |  229 
 Makefile            |   15 
 Makefile.am         |   13 
 Makefile.in         |  561 +
 aclocal.m4          | 6700 +++++++++++++++++
 config.guess        | 1417 +++
 config.h.in         |   67 
 config.sub          | 1501 +++
 configure           |20011 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.in        |   28 
 depcomp             |  472 +
 include/Makefile    |    7 
 include/Makefile.am |   12 
 include/Makefile.in |  365 
 install-sh          |  294 
 ltmain.sh           | 6291 ++++++++++++++++
 missing             |  336 
 mkinstalldirs       |  111 
 src/Makefile        |   36 
 src/Makefile.am     |   18 
 src/Makefile.in     |  504 +
 src/fgetfilecon.c   |    9 
 src/fsetfilecon.c   |    9 
 src/getfilecon.c    |    9 
 src/lgetfilecon.c   |    9 
 src/lsetfilecon.c   |    9 
 src/setfilecon.c    |    9 
 utils/Makefile      |   21 
 utils/Makefile.am   |   20 
 utils/Makefile.in   |  566 +
 30 files changed, 39570 insertions(+), 79 deletions(-)

diffstat -p1 of a patch to simply remove -lattr and change <attr/xattr.h> 
to <sys/xattr.h> in order to always use glibc for the xattr functions is:

 src/Makefile      |    2 +-
 src/fgetfilecon.c |    2 +-
 src/fsetfilecon.c |    2 +-
 src/getfilecon.c  |    2 +-
 src/lgetfilecon.c |    2 +-
 src/lsetfilecon.c |    2 +-
 src/setfilecon.c  |    2 +-
 utils/Makefile    |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

Get the picture?  autoconf/libtool is unnecessary bloat, and I don't want to 
maintain it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
