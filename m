Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PKBmdo029918
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 15:11:48 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1PKBj3w006091
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 20:11:45 GMT
Message-ID: <47C320D9.9030102@redhat.com>
Date: Mon, 25 Feb 2008 15:11:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: w.chimiak@ieee.org
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: Silly audit2allows
References: <200802251311.09098.w.chimiak@ieee.org>
In-Reply-To: <200802251311.09098.w.chimiak@ieee.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bill Chimiak wrote:
> Three things:
> 1. If one does the audit2allow ...
> 	checkmodule -M -m -o mynewmodule.mod mynewmodule.te
> 	semodule_package -o mynewmodule.pp -m mynewmodule.mod
> 	semodule -i mynewmodule.pp
> 
> How does one undo that if mynewmodule.te is a stupid policy?
> Doesn't the semodule make that part of the policy on every boot?
> 
> 2. As a selinux wannabee and an selinux enthusiast, I want more of
> my coworkers to use selinux.  They are highly resistant and usually
> have selinux=0 or enforce=0 on their boot commands.
> Having a list of dumb audit2allow rules would be most helpful so 
> I could explain to them how to use selinux without it being too cumbersome.
> I know, a lot depends on the situation, but some should make one nervous,
> 
> For example, if one saw the following:
> 	allow unconfined_t root_t:file { read write append create};
> one should be very nervous (I would think).  
> 
> There are other suggestions that I think you all see that might 
> make you all chuckle.  I would like a list of chucklers so I do not
> accidentally become a comedian.
> 
> 3. Are any of these potentially dangerous (my apologies if this is a stupid 
> request)?
> allow automount_t unlabeled_t:dir search;
automount trying to mount a file system that SELinux Policy/Kernel does
not understand.  Potentially dangerous
> allow fsdaemon_t urandom_device_t:chr_file read;
fsdaemon reading /dev/urandom - Not dangerous
> allow groupadd_t devpts_t:chr_file { read write };
groupadd read/write of a generice pty. Not dangerous, since what
groupadd can do is far more dangerous.
> allow httpd_t default_t:dir search;
http is trying to read a directory that has the default label.  Probably
need to label it httpd_sys_content_t
> allow insmod_t src_t:dir search;
modutils command searching /src.  Highly unusual.  Might be executing
the command while sitting in /src directory.  Seems apps like to getcwd
when starting up.
> allow irqbalance_t user_home_t:dir search;
irqbalance is trying to search home directories.  Not something I like
to allow, since my homedirectories contain important information like
passwords and credit card data.  Might be the same reason as insmod_t
wants to search /src

> allow ldconfig_t var_t:dir write;
Probably a labeling problem.
> allow pam_console_t file_t:dir read;
Unlabeled file, potentially major labeling problem on your system.  This
means you have a file that was created on a machine that was running
without SELinux.  Should relabel.
> allow semanage_t devpts_t:chr_file { read write };
> allow setfiles_t devpts_t:chr_file { read write };
> allow useradd_t devpts_t:chr_file { read write };
All three of these are trying to read/write pty that has generic label.
 Nothing to worry about since these domains can do much more interesting
damage.
> 
> 
> Thank you for your time and effort.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfDINgACgkQrlYvE4MpobMCvwCeIBCVp3h6UtvLj0xiXKgZrLFj
DfQAoJmTJRZvDGmZBpGHmEMbRaJ5tjep
=Rzwe
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
