Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ACrHL9010899
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 07:53:18 -0500 (EST)
Subject: Re: TTY question
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1108000939.5241.10.camel@cobra.ivg2.net>
References: <1107915334.6602.1.camel@cobra.ivg2.net>
	 <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1108000939.5241.10.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1108039573.22172.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Feb 2005 07:46:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-09 at 21:02, Ivan Gyurdiev wrote:
> # access_terminal(prefix, domain)
> access_terminal(`
>         allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;
>         allow $1_$2_t devtty_t:chr_file rw_file_perms;
>         allow $1_$2_t devpts_t:dir r_dir_perms;
>         allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;
> ') dnl access_terminal

Why not just:
# access_terminal(domain, typeprefix)
define(`access_terminal', `
allow $1 $2_tty_device_t:chr_file rw_file_perms;
allow $1 devtty_t:chr_file rw_file_perms;
allow $1 devpts_t:dir r_dir_perms;
allow $1 $2_devpts_t:chr_file rw_file_perms;
') dnl access_terminal

Then the usage in e.g. x_client_domain becomes:
access_terminal($1_$2_t, $1)

whereas elsewhere it may just be:
access_terminal($1_t, $1) 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
