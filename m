Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j192F6L9002950
	for <selinux@tycho.nsa.gov>; Tue, 8 Feb 2005 21:15:06 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j192Cqgj027851
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2005 02:12:52 GMT
Received: from [192.168.2.96] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j192ExQ1010965
	for <selinux@tycho.nsa.gov>; Tue, 8 Feb 2005 21:15:02 -0500 (EST)
Subject: TTY question
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 08 Feb 2005 21:15:34 -0500
Message-Id: <1107915334.6602.1.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I don't quite understand the difference between all the TTY/PTY devices
on Linux - could you explain how this works a bit, so that I will know
for the future. 

Which of those rules would be required for stdin/stdout?

allow $1_$2_t tty_device_t:chr_file rw_file_perms;
allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;

allow $1_$2_t devtty_t:chr_file rw_file_perms;
allow $1_$2_t devpts_t:dir r_dir_perms;
allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;

What about proc permissions required?

Can some of those rules be put in a macro of some sort.
I see tty rules all over the selinux policy, and perhaps
they could be made more consistent with a macro.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
