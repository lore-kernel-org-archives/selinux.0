Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A40@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: glibc check errors
Date: Tue, 30 Sep 2003 11:34:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I have built the glibc library with the SELinux patches.  When running "make
check", I get the following errors.  Any ideas what is going on here and how
I can resolve it because I'm at a loss?  Thanks for any help.

/bin/sh -e tst-gettext.sh /usr/src/redhat/BUILD/glibc-2.3.2-build/
/usr/src/redhat/BUILD/glibc-2.3.2-build/intl/ \
	/usr/src/redhat/BUILD/glibc-2.3.2-build/intl/tst-gettext.mtrace
make[2]: *** [/usr/src/redhat/BUILD/glibc-2.3.2-build/intl/tst-gettext.out]
Error 1
make[2]: Leaving directory
'/usr/src/redhat/BUILD/glibc-2.3.2-200304020432/intl'
make[1]: *** [intl/tests] Error 2

James Kratzer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
