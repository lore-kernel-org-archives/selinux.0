Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8Q0GDsJ027821
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 20:16:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8Q0ETZt011086
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2003 00:14:29 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
	by jazzswing.ncsc.mil  with ESMTP id h8Q0ESM3011083
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2003 00:14:28 GMT
Message-ID: <3F73854B.1080408@diyab.net>
Date: Thu, 25 Sep 2003 20:16:11 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <20030925102955.GC10234@vnl.com> <3F72E5DC.20603@diyab.net> <200309260247.39337.russell@coker.com.au>
In-Reply-To: <200309260247.39337.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Thu, 25 Sep 2003 22:55, Diyab wrote:
> 
>>Dale Amon wrote:
>>
>>>On Thu, Sep 25, 2003 at 08:46:17AM +0200, Tom wrote:
>>>
>>>>You might want to define a special type for the empty dir, so you can
>>>>move it around and don't have to give sshd access to all of /var
>>
>>I did this when I installed it on slackware.  In ssh.fc I added
>>
>>	/var/empty	system_u:object_r:sshd_privsep_dir_t
>>
>>and in sshd.te I added
>>
>>	type sshd_privsep_dir_t, file_type, sysadmfile;
>>
>>and
>>
>>	allow sshd_t sshd_privsep_dir_t:dir { getattr search };
> 
> 
> Why not just label it as var_run_t?

When I initially setup sshd with the default setting of /var/empty I 
decided to just give it it's own type in case there was ever a need to 
change the privsep location or the permissions it needs.

> In my latest policy I have the privsep directory (which is under /var/run in 
> Debian) labeled as var_run_t.  In the case of sshd as a daemon it can create 
> files under that, but in the case of sshd run from inetd (which is what you 
> will be doing if you want to lock down sshd) then it gets { getattr search } 
> access.

What do you get by running sshd through inetd that you don't get by 
running sshd alone?

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
