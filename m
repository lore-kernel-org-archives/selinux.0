Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HBIirT012756
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 07:18:45 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HBI42E011989
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 11:18:05 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id DE200C052
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 12:18:43 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 12912-03 for <selinux@tycho.nsa.gov>;
	Tue, 17 Aug 2004 12:18:38 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 5145AC051
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 12:18:38 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bx29U-0001iM-7F
	for selinux@tycho.nsa.gov; Tue, 17 Aug 2004 12:29:16 +0100
Date: Tue, 17 Aug 2004 12:29:16 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: bug in policy (1.14-3+?) with apache.te unused
Message-ID: <20040817112916.GN18321@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

i'm not using apache.

i upgraded to 1.14-6 on the policycoreutils and i get
httpd_sysadm_content_t does not exist in file_contexts
on a make relabel.

so.... well, i figured okay, let's make apache.te unused
(as i should have done in the first place) because apache
isn't on this system.

i get a compile error on openca.te not being able to find
httpd_t.

okay _now_ my make install relabel works :)

it's not such a big deal that openca.te can't find httpd_t
because, well, if you don't have an http server, what use
is the open cert auth stuff?

if that's not a rhetorical question then there is a bug in
the policy files there.

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
