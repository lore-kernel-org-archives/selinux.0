Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ALBrL9014544
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 16:11:53 -0500 (EST)
Subject: Re: TTY question
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1108067486.22172.251.camel@moss-spartans.epoch.ncsc.mil>
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
Content-Type: text/plain
Date: Thu, 10 Feb 2005 16:12:24 -0500
Message-Id: <1108069944.3689.9.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-10 at 15:31 -0500, Stephen Smalley wrote:
>On Thu, 2005-02-10 at 15:29, Ivan Gyurdiev wrote:
>> There's su_domain($1) in admin_macros.te, so
>> access_terminal(sysadm_su_t, sysadm_t) should be invoked.
>
>Yes, but that doesn't help if you are starting in user_t (if
>user_canbe_sysadm is enabled) or staff_t.  There was a specific rule
>removed by the patch between $1_su_t and sysadm_*_t, not just $1_*_t.
>Not clear whether those permissions were truly necessary or not, but su
>does need to be able to restore the label on the tty/pty when the su'd
>shell exits.

It's restored fine.
/dev/pts/x goes to sysadm_devpts_t after su
  and back to user_devpts_t after exit.
  
 There are no denials.

>> Changed, but it creates problems:
>> 
>> audit(1108067222.381:0): avc:  denied  { ioctl } for  pid=5435
>> exe=/bin/su path=/dev/pts/1 dev=devpts ino=3
>> scontext=root:sysadm_r:sysadm_su_t
>> tcontext=root:object_r:sysadm_devpts_t tclass=chr_file
>
>Yes, but the question is whether this is always needed for all domains
>using this macro or whether we can selectively allow it for certain
>domains. A diff of the generated policy before and after showed that
>many domains only had getattr read write prior to the patch.

Actually the vast majority of domains had rw_file_perms allowed.
On the other hand I haven't gotten any denials so far other than
an ioctl for su (which makes the system unusable). 

The permissions you want to remove are { append lock ioctl } on
chr_file, and { lock ioctl } on dir.

What should I do? ioctl could be allowed for su for now, and then if
denials show up it could be reverted to rw_perms in the macro.

P.S. The java policy had dontaudit tty rules and not allow.
I changed them by accident. Should they be changed back, or 
do you think allow is correct?
>
-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
