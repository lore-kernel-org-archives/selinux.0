Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HJacrT016010
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 15:36:38 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HJaaKV028769
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 19:36:36 GMT
Date: Tue, 17 Aug 2004 20:47:12 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Cc: Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: idea - running setfiles out of inetd!
Message-ID: <20040817194712.GV18321@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, this may sound a bit mad.

i'm trying to think of simple ways to speed up udev, amongst other
things.

i'd like to canvas people's opinions of running
"setfiles -q -s /etc/selinux/contexts/file_contexts" from inetd 
on a unix-domain-socket, or a tcpwrapper or _something_ that will
get it to listen on its stdin for filenames to restore contexts
on.

the alternative is, in the case of udev, to merge the functionality
of udevd and udevsend, such that the file context cacheing can
be taken advantage of.

at present, udevd execv's a new udevsend on each and _every_ device.

thoughts anyone?

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
