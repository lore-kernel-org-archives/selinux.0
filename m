Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GBvVrT028620
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 07:57:31 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6GBv8bx003642
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 11:57:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 4DA13C4C09A
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 13:57:30 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 21885-07 for <selinux@tycho.nsa.gov>;
	Fri, 16 Jul 2004 13:57:29 +0200 (CEST)
Date: Fri, 16 Jul 2004 13:57:29 +0200
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux Policy patches
Message-ID: <20040716115729.GC25607@legolas.drinsama.de>
References: <20040716002210.GA1081@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040716002210.GA1081@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> allow nsupdate_t self:netlink_socket create_socket_perms;

Maybe due to changes from policy 17 to 18 this could be
"netlink_route_socket" by now. Was this class split?

Gruss,
Erich Schubert
-- 
      erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
   Wer nicht zuweilen zuviel empfindet, der empfindet immer zuwenig.   V_/_

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
