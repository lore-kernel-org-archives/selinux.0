Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j88KftOb013219
	for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2005 16:41:55 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j88KdYAI001176
	for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2005 20:39:34 GMT
Date: Thu, 8 Sep 2005 21:39:29 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Cc: pere@hungry.com
Subject: [pere@hungry.com: Bug#270919: Can you test a new version of sysvinit?]
Message-ID: <20050908203929.GE8960@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

fyi esp. to manoj.

this fixes the problem of initrc_t attempting to write to /etc (it's
just a "touch /etc/" which fails).

the daft test concludes "oops, /etc isn't writeable, therefore /etc/mtab
must not be writeable, therefore we must not be able to delete
/etc/mtab, so we won't.  therefore on the previous shutdown, there must
have been partitions that weren't shut down properly, therefore we won't
mount them now"

basically this simple fix - attempting "touch /etc/mtab" as a
test instead of "touch /etc" - stops a debian/selinux system
getting into deeper and deeper shit :)

l.

----- Forwarded message from Petter Reinholdtsen <pere@hungry.com> -----

Resent-From: Debian BTS <debbugs@bugs.debian.org>

Hello

I'm preparing an NMU of sysvinit, to fix a few bugs.  Your bug report
is one of these bugs.  To reduce the possibility of messing up, I want
to ask if you can test the packages I have prepared and verify that it
work for you and solve your problem.

The test packages are available from
<URL:http://developer.skolelinux.no/~pere/debian/packages/>.  To test,
download them like this, and install them.

  for f in initscripts_2.86.ds1-1.1.pere.7_i386.deb \
           sysv-rc_2.86.ds1-1.1.pere.7_all.deb \
           sysvinit_2.86.ds1-1.1.pere.7_i386.deb ; do \
      wget http://developer.skolelinux.no/~pere/debian/packages/$f ; \
  done

This is the current changelog:

sysvinit (2.86.ds1-1.1.pere.7) UNRELEASED; urgency=low

  * Rewrote /etc/mtab handling in mountvirtfs to work with
    SELinux. (Closes: #270919)
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^


----- End forwarded message -----

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
