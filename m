Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8GLRnLa022258
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 17:27:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8GLQ8LY008407
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 21:26:08 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8GLQ8sG008404
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 21:26:08 GMT
Date: Tue, 16 Sep 2003 22:27:47 +0100
From: Dale Amon <amon@vnl.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Mod to Makefile for reiserfs
Message-ID: <20030916212747.GQ8988@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm about to try labeling a reiserfs disk... wish
me luck. 

Also, I note that in the relabel and reset sections
of the Makefile, the expression fed to awk will have
to be modified to:

	/ext[23]|reiserfs/

However this gets messy because even at best (assuming
they work!) the new patches are only going to be 
present if someone goes to the trouble of finding and
installing them. 

Is there any way to deal with this other than just
telling folk "If you use the reiserfs patch on your
kernel, you'll have to edit the selinux Makefile"?

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
