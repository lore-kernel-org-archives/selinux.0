Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VA4nrT010913
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 06:04:49 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VA4m5m017566
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 10:04:48 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 16105BEEF
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 11:04:44 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C25gJ-0002sz-0T
	for selinux@tycho.nsa.gov; Tue, 31 Aug 2004 11:16:03 +0100
Date: Tue, 31 Aug 2004 11:16:02 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: /dev entries which also need to be /.?u?dev'd
Message-ID: <20040831101602.GB2098@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

the following entries presently marked as /dev need, imo, to also
be modified to be ":%s/\/dev/\/.?u?dev/g" [in vi].

the reason is as i explained that if someone using udev [with or
without tmpfs] does a

	setfiles /etc/selinux/src/file_contexts/file_contexsts /.dev

then they are buggered, without the above.

for example, /.dev/initctl will suddenly end up with a default_t
type such that bootup will fail!

also /dev/.udev.tdb was set to default_t as well which could
have caused problems.

it's all gone pear-shaped, gloop, gloop.

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
