Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA6BllSf016682
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 06:47:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA6BlO1W017923
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 11:47:24 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hA6BlN5e017920
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 11:47:24 GMT
Date: Thu, 6 Nov 2003 11:47:41 +0000
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: Can't get the right debian packages to load
Message-ID: <20031106114741.GA23322@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been trying all morning to create a set of
preference PINS to pick up Russell's new debian
archive entries as top preference while still 
grabbing policycoreutils, login, etc from Colin's
old one, and have both override the current sid
versions which are often higher than either.

I've tried a number of things which should have 
worked, but at best I end up with Colin's packages
coming in and overriding Russells too.

Has anyone else got an apt preference file that pulls
off this neat trick? (Russell's Package file has no
corresponding Release file, so most of the pin 
options don't work)

The preference order I need is:

Coker	override Walters or sid regardless of version
Walters override sid regardless of version
sid     default

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
