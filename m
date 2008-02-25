Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PIKqi9016339
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 13:20:52 -0500
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1PIKpJD021069
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 18:20:51 GMT
Received: by an-out-0708.google.com with SMTP id c38so375951ana.75
        for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 10:20:45 -0800 (PST)
Reply-To: w.chimiak@ieee.org
To: selinux <selinux@tycho.nsa.gov>
Subject: Silly audit2allows
Date: Mon, 25 Feb 2008 13:11:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802251311.09098.w.chimiak@ieee.org>
From: Bill Chimiak <wch1m1@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Three things:
1. If one does the audit2allow ...
	checkmodule -M -m -o mynewmodule.mod mynewmodule.te
	semodule_package -o mynewmodule.pp -m mynewmodule.mod
	semodule -i mynewmodule.pp

How does one undo that if mynewmodule.te is a stupid policy?
Doesn't the semodule make that part of the policy on every boot?

2. As a selinux wannabee and an selinux enthusiast, I want more of
my coworkers to use selinux.  They are highly resistant and usually
have selinux=0 or enforce=0 on their boot commands.
Having a list of dumb audit2allow rules would be most helpful so 
I could explain to them how to use selinux without it being too cumbersome.
I know, a lot depends on the situation, but some should make one nervous,

For example, if one saw the following:
	allow unconfined_t root_t:file { read write append create};
one should be very nervous (I would think).  

There are other suggestions that I think you all see that might 
make you all chuckle.  I would like a list of chucklers so I do not
accidentally become a comedian.

3. Are any of these potentially dangerous (my apologies if this is a stupid 
request)?
allow automount_t unlabeled_t:dir search;
allow fsdaemon_t urandom_device_t:chr_file read;
allow groupadd_t devpts_t:chr_file { read write };
allow httpd_t default_t:dir search;
allow insmod_t src_t:dir search;
allow irqbalance_t user_home_t:dir search;
allow ldconfig_t var_t:dir write;
allow pam_console_t file_t:dir read;
allow semanage_t devpts_t:chr_file { read write };
allow setfiles_t devpts_t:chr_file { read write };
allow useradd_t devpts_t:chr_file { read write };


Thank you for your time and effort.
-- 
William Chimiak
Laboratory for Telecommunications Sciences
8080 Greenmead Road
College Park, MD
240-949-2778

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
