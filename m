Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8R1A2rT029370
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 21:10:04 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8R1A0hU014850
	for <selinux@tycho.nsa.gov>; Mon, 27 Sep 2004 01:10:01 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id D946FC101
	for <selinux@tycho.nsa.gov>; Mon, 27 Sep 2004 02:09:57 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CBkCS-0000Nh-VF
	for selinux@tycho.nsa.gov; Mon, 27 Sep 2004 02:21:08 +0100
Date: Mon, 27 Sep 2004 02:21:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: fuse - how to "mirror" user_t file access rights?
Message-ID: <20040927012108.GL28076@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

does anyone have any ideas on how to mirror the exact same file
permissions as a user_t or sysadm_t or staff_t... in another domain?

i'm writing a policy for a fuse program (fusexmp) and yes i'm also
modifying the fuse kernel module to support xattrs.

the issue is as follows:

- a macro similar to mount_domain called fusexmp_domain creates a domain
  $2_fusexmp_t from its argument e.g. user -> user_fusexmp_t.

- user_t running the fusexmp_exec_t program causes a domain_auto_trans
  into user_fusexmp_t.

- any user file access on, say /Documents/foo will result in
  /usr/bin/fusexmp doing a corresponding file access on
  /home/yourusername/foo...

  ... but as explained above, this access is done in the
  user_fusexmp_t domain

i found the privhome domain thing but russell said "no way!"
because privhome allows access to *alll* user domains.

does anyone know if there is a half-way-house that i can use,
which will grant access to just the given user's files and
directories, as if it was that user doing the access?

ta,

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
