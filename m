Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81K5irT024279
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 16:05:44 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81K5geu016225
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 20:05:43 GMT
Received: from lkcl.net (th-pm01-21.ndirect.co.uk [195.7.225.85])
	by open.hands.com (Postfix) with ESMTP id 54CFDBFD5
	for <selinux@tycho.nsa.gov>; Wed,  1 Sep 2004 21:05:28 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C2ZEL-0001S7-8a
	for selinux@tycho.nsa.gov; Wed, 01 Sep 2004 18:49:09 +0100
Date: Wed, 1 Sep 2004 18:49:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: what to do with matchpathcon on S_IFCHR, S_IFBLK, hard links and fifos
Message-ID: <20040901174909.GF4400@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

when using matchpathcon(), is there anything special that should
be done for the above filetypes, or should the mode_t argument
just be passed through and let libselinux worry about it?

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
