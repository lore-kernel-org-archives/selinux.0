Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NNW4rT022369
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 19:32:04 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NNW2wb016287
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 23:32:02 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 6F648BF6F
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 00:32:03 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 02213-01 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 00:32:01 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 65F37BF2F
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 00:32:00 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzOTA-00059M-O1
	for selinux@tycho.nsa.gov; Tue, 24 Aug 2004 00:43:20 +0100
Date: Tue, 24 Aug 2004 00:43:20 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: selinux and kde
Message-ID: <20040823234320.GC12720@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

... does anyone ever actually _use_ strict selinux policy enforcing
and successfully run kde under it??

i mean, i know i've been doing a lot of messing about trying
to get things to work, including perhaps unnecessarily adding
a policy for k3b (and cdrecord) and one for usbmount, and
fireflier too, but a 1,800 line patch to the default 1.14
policy is a heck of a lot of messing.

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
