Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KDXYrT003732
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 09:33:34 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KDWq4v007497
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 13:32:52 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 2C19CBFD9
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 14:33:32 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 14987-03-2 for <selinux@tycho.nsa.gov>;
	Fri, 20 Aug 2004 14:33:28 +0100 (BST)
Received: from lkcl.net (unknown [212.44.25.89])
	by open.hands.com (Postfix) with ESMTP id A7883BFD6
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 14:33:27 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1By9hG-0002Ol-GW
	for selinux@tycho.nsa.gov; Fri, 20 Aug 2004 14:44:46 +0100
Date: Fri, 20 Aug 2004 14:44:46 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: mozilla with macromedia flash plugin 6
Message-ID: <20040820134446.GD8429@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

... just a word to the wise that raised the hackles on the back of my
fangs.

i just visited a web site that had a flash plugin, very pretty, stole
99% cpu time so i couldn't access any other parts of the site.

right-mouse button, settings, it said "allow <this site> access to your
microphone and camera" at which point i began to freak out a bit.

fortunately the default is set to "no".

*sweetly* could someone who is familiar with the mozilla selinux policy
please double-check that the policy somehow bans access to video
and microphone unless explicity granted?

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
