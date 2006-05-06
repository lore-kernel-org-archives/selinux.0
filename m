Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k46F0N2J008996
	for <selinux@tycho.nsa.gov>; Sat, 6 May 2006 11:00:24 -0400
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k46F0MV0020937
	for <selinux@tycho.nsa.gov>; Sat, 6 May 2006 15:00:23 GMT
Received: from megaweapon.nightmoose.net (HELO d.namei) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 6 May 2006 15:00:21 -0000
Date: Sat, 6 May 2006 11:00:20 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Subject: Reference policy documentation
Message-ID: <Pine.LNX.4.64.0605061056310.13769@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there some canonical documentation on reference policy and related 
infrastructure?

Something which fully describes the format of the source policy modules, 
for example, so I know what to do about:

  ERROR 'This block has no require section.' at token ''

I'm sure I saw something once, but can't remember where.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
