Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88McWrT008037
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 18:38:33 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88McVfe006977
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 22:38:31 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 3767CBFCC
	for <selinux@tycho.nsa.gov>; Wed,  8 Sep 2004 23:38:29 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C5BG9-00027c-8M
	for selinux@tycho.nsa.gov; Wed, 08 Sep 2004 23:49:49 +0100
Date: Wed, 8 Sep 2004 23:49:49 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: at last: info regarding boot problems on multiple partitions
Message-ID: <20040908224949.GK7717@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FINALLY i got a useable system when i encountered a boot problem
[well, i got a console login].

the issue is that partitions fail to be mounted.

i had noticed over a period of time that programs like pump and dhclient
and some others would stop partitions from being unmounted during
shutdown.

[remember i have /boot, /, /usr, /var and /home]

for some reason, this also caused the partitions to fail to MOUNT on
startup.

just now i was able to log in.

audit2allow shows these:

	allow local_login_t file_t:dir { search }
	allow rpcd_t file_t:dir { search }.

and, sure enough, doing a ls -Z /usr shows that it is, in fact, set to
file_t.

the question is, therefore... why?

i figure it must be because i have that partition mounted.

consequently, the context of the mount point, /usr, never gets set
to a correct context because, of course, make relabel is only ever
run with all partitions mounted.

so.

my question is:

	how do i restore the context of a mount-point....
	whilst it's actually mounted!

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
