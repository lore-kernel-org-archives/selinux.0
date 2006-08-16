Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7GDbOoL030494
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 09:37:24 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7GDaxXM007482
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 13:37:00 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 4F6DFC4C089
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 15:37:21 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 26553-02 for <selinux@tycho.nsa.gov>;
	Wed, 16 Aug 2006 15:37:20 +0200 (CEST)
Received: from wintermute.xmldesign.de (p549A4807.dip0.t-ipconnect.de [84.154.72.7])
	by legolas.drinsama.de (Postfix) with ESMTP id BD501C4C083
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 15:37:20 +0200 (CEST)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id B900D234959
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 15:37:20 +0200 (CEST)
Subject: Re: Invalid context in targeted SELinux policy
From: Erich Schubert <erich@debian.org>
To: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1155733377.10971.2.camel@localhost.localdomain>
References: <W7685912732296271155678629@webmail16>
	 <1155733377.10971.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 16 Aug 2006 15:37:19 +0200
Message-Id: <1155735440.15689.3.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> role system_r upgrade_t;

You're missing the "types" keyword.

The sxid.te file is missing a

role system_r types sxid_t;

btw. Not committed to the Debian policy yet, maybe tonight.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     Which is worse: ignorance or apathy? Who knows? Who cares?     //\
    Eine Stadt ist einem erst wirklich vertraut wenn man Freunde    V_/_
              in ihr hat. --- Antoine de Saint-Exupéry



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
