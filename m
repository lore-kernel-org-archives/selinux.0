Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8GLdMLa022343
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 17:39:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8GLdLmw002003
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 21:39:21 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8GLdL9d002000 for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 21:39:21 GMT
Date: Tue, 16 Sep 2003 22:39:20 +0100
From: Dale Amon <amon@vnl.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: More on reiserfs
Message-ID: <20030916213920.GS8988@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I almost forgot: you have to add a rule for reiserfs
to fs_use:

	fs_use_xattr reiserfs system_u:object_r:fs_t

Then
	make load
	make relabel        # assuming you changed the awk args

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
