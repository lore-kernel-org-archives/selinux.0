Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8OMC1sJ021080
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 18:12:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8OMC0CG018382
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 22:12:00 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8OMBxqJ018379 for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 22:11:59 GMT
Date: Wed, 24 Sep 2003 23:11:57 +0100
From: Dale Amon <amon@vnl.com>
To: "Inger, Slav (S.B.)" <vinger@ford.com>
Cc: "'Dale Amon'" <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030924221157.GS21997@vnl.com>
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 24, 2003 at 05:55:40PM -0400, Inger, Slav (S.B.) wrote:
> Don't know if this helps much, but the only reference I see to /var/lib in the trace is sshd doing a stat on directory /var/lib/empty.

It certainly does. I wonder why I can't find it via a source grep? 
I guess that means it does have a valid reason to have access to 
that directory.

I'll have to go to the ssh.te now and figure out why it
isn't there already. Seems strange that it isn't if it
is commonly accessed.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
