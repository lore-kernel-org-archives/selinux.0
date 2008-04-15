Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3FDxtIF011512
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 09:59:55 -0400
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3FDxrjo003733
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 13:59:54 GMT
Received: from ns.i.cz (unknown [192.168.24.10])
	by vidle.i.cz (Postfix) with ESMTP id AAA6C1CC07
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 15:59:09 +0200 (CEST)
Received: from bobek.localdomain (bobek.pm.i.cz [192.168.64.71])
	by ns.i.cz (Postfix) with ESMTP id 8692C5C04
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 15:59:09 +0200 (CEST)
Received: from zito by bobek.localdomain with local (Exim 4.63)
	(envelope-from <vaclav.ovsik@i.cz>)
	id 1Jllgj-0002cn-AF
	for selinux@tycho.nsa.gov; Tue, 15 Apr 2008 15:59:09 +0200
Date: Tue, 15 Apr 2008 15:59:09 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Subject: open_init_pty: eats much of the CPU time
Message-ID: <20080415135909.GA10016@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
FYI: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474956
Maybe Manoj is busy and someone wants to review the code and include it
upstream...
Regards
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
