Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ALNOL9014619
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 16:23:24 -0500 (EST)
Subject: Re: TTY question
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1108069944.3689.9.camel@cobra.ivg2.net>
References: <1107915334.6602.1.camel@cobra.ivg2.net>
	 <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1108000939.5241.10.camel@cobra.ivg2.net>
	 <1108039573.22172.37.camel@moss-spartans.epoch.ncsc.mil>
	 <1108043320.326.1.camel@cobra.ivg2.net>
	 <1108058666.3808.2.camel@cobra.ivg2.net>
	 <1108062931.4443.3.camel@cobra.ivg2.net>
	 <1108063884.22172.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1108067400.5249.10.camel@cobra.ivg2.net>
	 <1108067486.22172.251.camel@moss-spartans.epoch.ncsc.mil>
	 <1108069944.3689.9.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1108070175.22172.262.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Feb 2005 16:16:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-10 at 16:12, Ivan Gyurdiev wrote:
> It's restored fine.
> /dev/pts/x goes to sysadm_devpts_t after su
>   and back to user_devpts_t after exit.
>   
>  There are no denials.

Ok, good.

> The permissions you want to remove are { append lock ioctl } on
> chr_file, and { lock ioctl } on dir.
> 
> What should I do? ioctl could be allowed for su for now, and then if
> denials show up it could be reverted to rw_perms in the macro.

I'd reduce the permissions in the macro for now, and just give ioctl to
su via a separate allow rule.

> P.S. The java policy had dontaudit tty rules and not allow.
> I changed them by accident. Should they be changed back, or 
> do you think allow is correct?

I don't have that policy in our tree.  Is it for the java plugin run
from mozilla or for java run by a user domain?  If the former, likely
want dontaudit.  If the latter, likely want/need allow.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
