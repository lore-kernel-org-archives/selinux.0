To: SELinux@tycho.nsa.gov
Subject: make check failure on glibc using rh9
Message-ID: <1062625489.3f5660d19f704@cc.utulsa.edu>
Date: Wed, 03 Sep 2003 16:44:49 -0500 (CDT)
From: tyronne-nash@utulsa.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Greetings,

I am attempting to complete a SELinux install using the using Red Hat 9 using the 2.6.0.test3 kernel. I have rebuilt the kernel and most of the utilities in the Userland archive.

Note. This is a separate problem (installation) than the one being done by Nick Davis of the same institution

I am encountering problems with glibc. I was able to do the "configure" and the "make" without any problems but when I run the "make check" I receive the following errors:

make[2]: *** [/home/tgn/wa/glib-build/intl/tst-gettext.out] Error 1
make[2]: Leaving directory `/home/tgn/wa/glibc-source/intl'
make[1]: *** [intl/tests] Error 2
make[1]: Leaving directory `/home/tgn/wa/glibc-source'
make: *** [check] Error 2

Reagards,

Tyronne Nash
Center for Information Security
University of Tulsa

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
