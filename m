Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HBnBrT012866
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 07:49:12 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HBnAKV011793
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 11:49:11 GMT
Subject: Re: udev and capabilities
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <200408170925.36215.russell@coker.com.au>
References: <200408170925.36215.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1092743231.25650.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 17 Aug 2004 07:47:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-16 at 19:25, Russell Coker wrote:
> avc:  denied  { dac_read_search } for  pid=4079 exe=/bin/bash capability=2 
> scontext=system_u:system_r:udev_t tcontext=system_u:system_r:udev_t 
> tclass=capability
> 
> I notice the above in my log files with the latest rawhide.  However udev.te 
> has the following policy.  I was under the impression that dac_override was 
> checked before dac_read_search and it was redundant to have dac_read_search 
> if you already had dac_override.  Did I misunderstand this or have things 
> changed in this regard?
> 
> allow udev_t self:capability { chown dac_override fowner fsetid sys_admin 
> mknod};

Looks like fs/ext3/acl.c:ext3_permission() is inconsistent with
fs/namei.c:vfs_permission(), not in a way that affects the final
outcome, but in performing the capable() call prior to other tests that
would short circuit the logic and avoid the spurious audit.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
