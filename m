Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA02665
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2002 03:27:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA24074
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2002 08:25:25 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id IAA24070
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2002 08:25:21 GMT
Date: Wed, 13 Nov 2002 19:29:03 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Brad Chapman <jabiru_croc@yahoo.com>, Joshua Brindle <JBrindle@snu.edu>,
        Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: SELinux distro building
Message-ID: <20021113082902.GA26850@snoopy.apana.org.au>
References: <sdd11fd2.035@atlas.snu.edu> <20021113005009.53937.qmail@web40018.mail.yahoo.com> <20021113013123.GA21921@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021113013123.GA21921@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 13, 2002 at 12:31:23PM +1100, Brian May wrote:
> Would somebody be willing to test a patch that does this?

I have modified Russell's version of libselinux-small,
to build with autoconf/automake/libtool.

See
<URL:http://www.microcomaustralia.com.au/debian/selinux-small-2002102211.tar.gz>

This mainly involved creating configure.in, AUTHORS, NEWS and
**/Makefile.am, but I had to change some source code too (most noteably
module/checkpolicy/policy_scan.l to reflect the new name of
policy_parse.h and utils/spasswd to reflect the fact that automake
doesn't appear to allow compiling the same source code multiple times
with different compile time options).

I am highly confident that some things will still be broken ;-)

-----------
What works:
-----------

make distcheck (this does some pretty strict tests; for instance to make
sure no files are missing and that it can build the object files in
another directory)


make install prefix=....

where prefix is the place to install.

-----------
What sort of works:
-----------

--with-lsm=dir can be used to change path to LSM directory, but
directory must be a full directory name, relative directories names
will break.

-----------
What doesn't work:
-----------

debian/rules not updated.

Makefile in top level source directory totally replaced.

devfsd-se.so will go into the wrong directory by default (anyone know
how get automake to put plugin modules in the correct directory?)

devfsd-se.so is linked with libsecure.a, as per previous build setup.
This is broken; it means the shared library has code in it that
wasn't compiled with PIC. However, it is not possible to compile
libselinux with PIC (position independent code); the compiler
complains with an error:

gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../libsecure/include -Wall -g
-O2 -Wp,-MD,.deps/security.pp -c security.c -fPIC -DPIC -o
.libs/security.lo security.c: In function `security': security.c:5:
Invalid `asm' statement: security.c:5: fixed or forbidden register 3
(bx) was spilled for class BREG. make[3]: *** [security.lo] Error 1

For now we can get away with using non-PIC code on i386; it might be a
major problem on other platforms though.

MLS support has been completely ommited; it should be easy to add
though.

AUTHORS and NEWS are empty files.

-----------
What should work but I haven't checked:
-----------

Does everything get installed in the correct place?

Does anything get installed that shouldn't be installed?

Are any files from the source archive missing?
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
