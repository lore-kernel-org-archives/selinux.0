Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i749JQrT026812
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 05:19:26 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i749JOWC012408
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 09:19:24 GMT
Date: Tue, 3 Aug 2004 16:26:23 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: [patch] udev-selinux: restores file security context and sets mode in matchpathcon
Message-ID: <20040803152623.GE4043@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, updated.

this is an experimental patch.

- records former security context
- assumes any file creates (directories, symlinks, nodes) are hunky-dory
  and going to be the only file creates
- restores former security context.

matchpathcon mode on:

- directories (for the mkdirs) uses S_IFDIR
- inodes (for the mknod) uses the mode passed in.
- symlinks uses S_IFDIR


the reason for using this patch is because of speed:
if matchpathcon is used in the same process, the lookups etc.
are cached.

a reason for _not_ using this patch is for a udev in initrd
where the smaller klibc is used.  it would be necessary to add
rexeg to klibc and to compile a special libselinux1 with it.

if you do not intend to put udev into an initrd, this patch is
perfectly acceptable for use.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
