Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8OMR5sJ021139
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 18:27:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8OMPLZt007580
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 22:25:21 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8OMPKM3007577
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 22:25:20 GMT
Date: Wed, 24 Sep 2003 23:27:02 +0100
From: Dale Amon <amon@vnl.com>
To: "Inger, Slav (S.B.)" <vinger@ford.com>
Cc: "'Dale Amon'" <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030924222702.GT21997@vnl.com>
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <20030924221157.GS21997@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030924221157.GS21997@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 24, 2003 at 11:11:57PM +0100, Dale Amon wrote:
> I'll have to go to the ssh.te now and figure out why it
> isn't there already. Seems strange that it isn't if it
> is commonly accessed.

I've added this:

# DMA20030924 Added search /var/lib 
allow $1 var_lib_t:dir search;

to ssh.te and it gets rid of that avc. I wonder if this
is needed in the master policy? Up to Steve I guess.

Okay, now I've still one more, and this one is really
confusing because ino=48726022 seems not to exist:

	48726022        <inode not found>

I half wonder if I've got a bad link somewhere. It would
be easy enough to add an allow for this, but I'd like
to figure out why rather than blindly add things.

avc:  denied  { read } for  pid=743 exe=/usr/sbin/sshd dev= ino=48726022 scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t tclass=lnk_file

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
