Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7FITSrT003476
	for <selinux@tycho.nsa.gov>; Sun, 15 Aug 2004 14:29:28 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7FISmZR004292
	for <selinux@tycho.nsa.gov>; Sun, 15 Aug 2004 18:28:49 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 46B62BF73
	for <selinux@tycho.nsa.gov>; Sun, 15 Aug 2004 19:29:27 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 18417-03 for <selinux@tycho.nsa.gov>;
	Sun, 15 Aug 2004 19:29:24 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id A01C2BF70
	for <selinux@tycho.nsa.gov>; Sun, 15 Aug 2004 19:29:24 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BwPvI-0002kz-TP
	for selinux@tycho.nsa.gov; Sun, 15 Aug 2004 19:40:04 +0100
Date: Sun, 15 Aug 2004 19:40:04 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: kdm 3.3 is deleting and recreating /var/run/xdmctl
Message-ID: <20040815184004.GL11256@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

heads up for something to watch out for: kdm 3.3 is deleting and
then recreating /var/run/xdmctl, presumably as a way of clearing
out any messy sockets in that directory.

kdm 3.2.2 did not behave in this manner.

it means that people doing a new install of kdm under selinux
may run into problems.

e.g. if dpkg has not been given write permission to /var/run
in order for /var/run/xdmctl to be created at postinst time.

e.g. if postinst does _not_ create this directory, it doesn't exist,
and kdm attempts to create it for the first time.

i am not allowing the xdm_t permission to unlink and create in
var_run_t: consequently, if that directory already exists, everything
is hunky-dory: selinux bans kdm from deleting it, and consequently,
it still exists such that kdm doesn't try to create it.

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
