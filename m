Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i92KmbrT009791
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 16:48:38 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i92KmWlM006196
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 20:48:36 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 77E3BBF8C
	for <selinux@tycho.nsa.gov>; Sat,  2 Oct 2004 21:48:29 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CDqyn-0001uW-0F
	for selinux@tycho.nsa.gov; Sat, 02 Oct 2004 21:59:45 +0100
Date: Sat, 2 Oct 2004 21:59:44 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: autofs - forcing an autofs4 module to have a context
Message-ID: <20041002205944.GD5827@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

anyone any clues on how best to make an autofs mount point have a
context other than (null)?

not the directories _under_ the mountpoint, the mountpoint itself?

i _really_ don't want to have to cheat by coding up a special thing in
this fuse-hack "if directory == "/media" return
"system_u:object_r:mnt_t" that'd just be... horrible!

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
