Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8PCu0sJ023713
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 08:56:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8PCtxCG010928
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 12:55:59 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
        by jazzband.ncsc.mil  with ESMTP id h8PCtwqJ010925 for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 12:55:59 GMT
Message-ID: <3F72E5DC.20603@diyab.net>
Date: Thu, 25 Sep 2003 08:55:56 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: Dale Amon <amon@vnl.com>
CC: Tom <tom@lemuria.org>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <20030924221157.GS21997@vnl.com> <20030925084613.H11866@lemuria.org> <20030925102955.GC10234@vnl.com>
In-Reply-To: <20030925102955.GC10234@vnl.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dale Amon wrote:
> On Thu, Sep 25, 2003 at 08:46:17AM +0200, Tom wrote:
>>You might want to define a special type for the empty dir, so you can
>>move it around and don't have to give sshd access to all of /var
> 

I did this when I installed it on slackware.  In ssh.fc I added

	/var/empty	system_u:object_r:sshd_privsep_dir_t

and in sshd.te I added

	type sshd_privsep_dir_t, file_type, sysadmfile;

and

	allow sshd_t sshd_privsep_dir_t:dir { getattr search };

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
