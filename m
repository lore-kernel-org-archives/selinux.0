Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAGDXFRb002414
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 08:33:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAGDWkBb012126
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 13:32:46 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAGDWk4o012122
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 13:32:46 GMT
Date: Sun, 16 Nov 2003 13:33:13 +0000
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: initrd package problem fixed
Message-ID: <20031116133313.GF17041@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In case anyone else is interested, Howard Xu has
fixed a bug report of mine against the initrd-tools
package so that no longer should force a load of
modutil. This is good for those who want small
systems with no modules.

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
