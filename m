Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ALdOL9014785
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 16:39:24 -0500 (EST)
Subject: Re: TTY question
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1108070175.22172.262.camel@moss-spartans.epoch.ncsc.mil>
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
	 <1108070175.22172.262.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 16:39:56 -0500
Message-Id: <1108071596.3689.15.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-10 at 16:16 -0500, Stephen Smalley wrote:
>On Thu, 2005-02-10 at 16:12, Ivan Gyurdiev wrote:
>> It's restored fine.
>> /dev/pts/x goes to sysadm_devpts_t after su
>>   and back to user_devpts_t after exit.
>>   
>>  There are no denials.
>
>Ok, good.

Actually here's probably why:
it's duplicated in su_mini_domain:

# Close and re-open ttys and ptys to get the fd into the correct domain.
allow $1_su_t { ttyfile ptyfile }:chr_file { read write };

So it's all good.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
