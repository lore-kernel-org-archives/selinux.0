Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1A21pL9009133
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2005 21:01:51 -0500 (EST)
Subject: Re: TTY question
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
References: <1107915334.6602.1.camel@cobra.ivg2.net>
	 <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 09 Feb 2005 21:02:18 -0500
Message-Id: <1108000939.5241.10.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> in a macro of some sort.
>> I see tty rules all over the selinux policy, and perhaps
>> they could be made more consistent with a macro.
>
>Possibly.

Maybe something like this:

# access_terminal(prefix, domain)
access_terminal(`
        allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;
        allow $1_$2_t devtty_t:chr_file rw_file_perms;
        allow $1_$2_t devpts_t:dir r_dir_perms;
        allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;
') dnl access_terminal

Then use this in:
- mplayer_macros
- mount_macros
- x_client_macros
- gpg_macros
- gpg_agent macros
- su_macros
- xauth_macros
- irc_macros
- chkpwd_macros
- cdrecord macros

other places?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
