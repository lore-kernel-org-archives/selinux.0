Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HIc5rT015618
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 14:38:05 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HIbO2E010937
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 18:37:25 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 32586C0E6
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 19:38:04 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 29330-03-2 for <selinux@tycho.nsa.gov>;
	Tue, 17 Aug 2004 19:38:02 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id E8866C0E4
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 19:38:01 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bx90h-0006F6-K5
	for selinux@tycho.nsa.gov; Tue, 17 Aug 2004 19:48:39 +0100
Date: Tue, 17 Aug 2004 19:48:39 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: k3b finding files
Message-ID: <20040817184839.GS18321@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

... or, is there a different way to do file finding / listing?

why does konqueror manage to do file finding / listing?

is there some sort of filesystem monitoring service that could be used
(such that famd could use it as well)?

does anyone know of a DCOP-based KDE service (konqueror itself, even)
that could track files?

i'm thinking of modifications to k3b that could keep its file accessing
under control.

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
