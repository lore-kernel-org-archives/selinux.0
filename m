Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1AI3vL9013064
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 13:03:57 -0500 (EST)
Subject: Re: TTY question
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1108043320.326.1.camel@cobra.ivg2.net>
References: <1107915334.6602.1.camel@cobra.ivg2.net>
	 <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1108000939.5241.10.camel@cobra.ivg2.net>
	 <1108039573.22172.37.camel@moss-spartans.epoch.ncsc.mil>
	 <1108043320.326.1.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 13:04:26 -0500
Message-Id: <1108058666.3808.2.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-10 at 08:48 -0500, Ivan Gyurdiev wrote:
>>Why not just:
>># access_terminal(domain, typeprefix)
>>define(`access_terminal', `
>>allow $1 $2_tty_device_t:chr_file rw_file_perms;
>>allow $1 devtty_t:chr_file rw_file_perms;
>>allow $1 devpts_t:dir r_dir_perms;
>>allow $1 $2_devpts_t:chr_file rw_file_perms;
>>') dnl access_terminal
>>
>>Then the usage in e.g. x_client_domain becomes:
>>access_terminal($1_$2_t, $1)
>>
>>whereas elsewhere it may just be:
>>access_terminal($1_t, $1) 

Should 
allow $1 privfd:fd use;
be in that macro? 

What does that do?
I see it next to the other rules.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
