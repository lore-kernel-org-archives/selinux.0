Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7FI6ZrT003393
	for <selinux@tycho.nsa.gov>; Sun, 15 Aug 2004 14:06:35 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7FI6X7E024951
	for <selinux@tycho.nsa.gov>; Sun, 15 Aug 2004 18:06:34 GMT
Date: Sun, 15 Aug 2004 19:17:11 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: 258214@bugs.debian.org, SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: udev script does NOT mount /dev/pts as claimed by debian maintainer
Message-ID: <20040815181711.GK11256@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

the debian maintainer for udev claims in his response to closing the
above bugreport that:

	"> initscript it unmounts /dev/pts because udev mounts
	 > a tmpfs over /dev. The problem is that it does not seem to mount it
	 > again.

	 And it does not need to, S36mountvirtfs does. "


i have looked in /etc/rcS.d for S36mountvirtfs and i am sorry
to have to report that it does not exist.  [on debian/unstable,
initscripts version 2.86-1 or 2.85-22.se2]

i upgraded initscripts temporarily from version 2.85-22.se2
to version 2.86-1 in order to check: i found that in both cases,
/etc/rcS.d/S36mountvirtfs did not exist.

[maybe this is one of the reasons why i cannot see shmfs unless
 i specify enforcing=0 but hey, that's another story]


so:

- the bug reported by mario boikov is still unresolved;

- initscripts appears to have a bug in it where there is a missing
  symlink in /etc/rcS.d;

- some of the dependencies of udev-0.030 are broken: udev-0.030 should
  depend on a version of initscripts that has the S36mountvirtfs
  symlink, and it does not.

the temporary fix is, like /etc/init.d/udev's "stop" case, to add
/etc/init.d/mountvirtfs start into the "start" case (as previously
attached).

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
