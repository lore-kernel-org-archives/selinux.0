Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1AKcYL9014263
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 15:38:34 -0500 (EST)
Subject: Re: TTY question
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1108067400.5249.10.camel@cobra.ivg2.net>
References: <1107915334.6602.1.camel@cobra.ivg2.net>
	 <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1108000939.5241.10.camel@cobra.ivg2.net>
	 <1108039573.22172.37.camel@moss-spartans.epoch.ncsc.mil>
	 <1108043320.326.1.camel@cobra.ivg2.net>
	 <1108058666.3808.2.camel@cobra.ivg2.net>
	 <1108062931.4443.3.camel@cobra.ivg2.net>
	 <1108063884.22172.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1108067400.5249.10.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1108067486.22172.251.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Feb 2005 15:31:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-10 at 15:29, Ivan Gyurdiev wrote:
> There's su_domain($1) in admin_macros.te, so
> access_terminal(sysadm_su_t, sysadm_t) should be invoked.

Yes, but that doesn't help if you are starting in user_t (if
user_canbe_sysadm is enabled) or staff_t.  There was a specific rule
removed by the patch between $1_su_t and sysadm_*_t, not just $1_*_t.
Not clear whether those permissions were truly necessary or not, but su
does need to be able to restore the label on the tty/pty when the su'd
shell exits.

> Changed, but it creates problems:
> 
> audit(1108067222.381:0): avc:  denied  { ioctl } for  pid=5435
> exe=/bin/su path=/dev/pts/1 dev=devpts ino=3
> scontext=root:sysadm_r:sysadm_su_t
> tcontext=root:object_r:sysadm_devpts_t tclass=chr_file

Yes, but the question is whether this is always needed for all domains
using this macro or whether we can selectively allow it for certain
domains.  A diff of the generated policy before and after showed that
many domains only had getattr read write prior to the patch.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
