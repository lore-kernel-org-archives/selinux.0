Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBKFo1Ii014864
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 10:50:02 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBKFo3eP018299
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 15:50:04 GMT
Received: from lkcl.net (host81-153-247-118.range81-153.btcentralplus.com [81.153.247.118])
	by open.hands.com (Postfix) with ESMTP id 2C984BFF4
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 15:49:52 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CgPxf-0000Qs-LP
	for selinux@tycho.nsa.gov; Mon, 20 Dec 2004 16:00:39 +0000
Date: Mon, 20 Dec 2004 16:00:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: paranoid FC3 setup: banning all login access (!)
Message-ID: <20041220160039.GE24188@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

i have a requirement for setting up a server that might even ban
logins - even admin logins.

the only things that should be allowed are reboot (ctrl-alt-delete at
console) and services (e.g apache).

my question is, therefore: is it possible to _conveniently_
load a completely different selinux policy file (by typing
"linux init 3" or other incantation at the grub prompt)

what i want to be able to do is say to my customer "yes, in
order to do upgrades and maintenance, you press ctrl-alt-delete,
selection option 2) on the boot-loader menu, and you will be
dropped into standard admin mode.  when you are done, reboot
again and let it go back into 'paranoid' mode")

can anyone help advise?

ta,

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
