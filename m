Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h83CTkLa024736
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 08:29:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h83CSDpQ015357
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:28:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h83CSDQX015354
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:28:13 GMT
Subject: Re: Enable SELinux via boot parameter
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Tom <tom@lemuria.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20030903091258.L30963@lemuria.org>
References: 
	 <Pine.LNX.4.44.0309021942550.11746-100000@thoron.boston.redhat.com>
	 <1062558452.1838.52.camel@chris.pebenito.net>
	 <20030903091258.L30963@lemuria.org>
Content-Type: text/plain
Message-Id: <1062592181.18568.321.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Sep 2003 08:29:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-03 at 03:12, Tom wrote:
> The broad public will not be using SELinux for now, so I'm afraid it's
> not really a special case.
> 
> There should, however, be a kernel config option to turn it on by
> default and FORCE it on. (i.e. no way to boot that kernel without SE
> enabled). Otherwise we have a trivial boot security problem.
> 
> I know securing physical access to the system isn't really the scope of
> SE, but it shouldn't be THAT easy.

It is already the case that you need to specify 'enforcing=1' to boot an
enforcing kernel if you enabled development support.  How many people
disable development support?  And if you do disable development support,
do you also keep around a second kernel that you can boot for emergency
recovery?  In that case, what is the difference?  You are still are
relying on your lilo/grub password to limit the ability to boot the
non-SELinux kernel.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
