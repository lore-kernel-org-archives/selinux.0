Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79JjxrT028076
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 15:45:59 -0400 (EDT)
Received: from smtp814.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i79JjNnn018717
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 19:45:23 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp814.mail.ukl.yahoo.com with SMTP; 9 Aug 2004 19:45:58 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BuFdi-0000LG-91
	for selinux@tycho.nsa.gov; Mon, 09 Aug 2004 19:16:58 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BuGGn-00040u-5a
	for selinux@tycho.nsa.gov; Mon, 09 Aug 2004 20:57:21 +0100
Date: Mon, 9 Aug 2004 20:57:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: different selinux file-context root
Message-ID: <20040809195721.GP3868@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i'm thinking of doing installs of selinux systems and online
backups/restores from an initial ramdisk.

e.g. modifying rsync to cope with selinux file contexts.

e.g. there are several backup programs that create bootable CDs, that
then redo the entire system.

what would make sense is for rsync, star etc. to have a context-"chroot"
under which the selinux file contexts get recreated relative to that
directory as the root filesystem.

then i don't have to mess about ensuring that the entire filesystem
is correctly there and then doing something like this:

	chroot /mnt-point make -C /etc/selinux/src relabel

l.

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
