Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8P32AsJ021910
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 23:02:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8P30QZt020599
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 03:00:26 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
	by jazzswing.ncsc.mil  with ESMTP id h8P30PM3020596
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 03:00:25 GMT
Message-ID: <3F725AA4.1090300@diyab.net>
Date: Wed, 24 Sep 2003 23:01:56 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: Dale Amon <amon@vnl.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <20030924221157.GS21997@vnl.com> <20030924222702.GT21997@vnl.com>
In-Reply-To: <20030924222702.GT21997@vnl.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dale Amon wrote:
> On Wed, Sep 24, 2003 at 11:11:57PM +0100, Dale Amon wrote:
> 
>>I'll have to go to the ssh.te now and figure out why it
>>isn't there already. Seems strange that it isn't if it
>>is commonly accessed.
> 
> 
> I've added this:
> 
> # DMA20030924 Added search /var/lib 
> allow $1 var_lib_t:dir search;
> 
> to ssh.te and it gets rid of that avc. I wonder if this
> is needed in the master policy? Up to Steve I guess.
> 
> Okay, now I've still one more, and this one is really
> confusing because ino=48726022 seems not to exist:
> 
> 	48726022        <inode not found>
> 
> I half wonder if I've got a bad link somewhere. It would
> be easy enough to add an allow for this, but I'd like
> to figure out why rather than blindly add things.
> 
> avc:  denied  { read } for  pid=743 exe=/usr/sbin/sshd dev= ino=48726022 scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t tclass=lnk_file
> 

I don't get that /var/lib avc error.  Does the login work without that 
allow rule you added?  If so then maybe it doesn't really need it.

Maybe that "bad" link has something to do with it.  unmount /var and run 
an fsck on it then remount it and see if you still get the error.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
