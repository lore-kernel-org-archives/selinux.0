Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9DKIvrT023307
	for <selinux@tycho.nsa.gov>; Wed, 13 Oct 2004 16:18:57 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9DKIvhD012551
	for <selinux@tycho.nsa.gov>; Wed, 13 Oct 2004 20:18:57 GMT
Subject: Re: policy patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200410131555.15726.russell@coker.com.au>
References: <200410131555.15726.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1097698672.28227.13.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 13 Oct 2004 16:17:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Wed, 2004-10-13 at 01:55, Russell Coker wrote:
> Allow checkpolicy to access /dev/tty.
> 
> Change var_lib_rpm_t to rpm_var_lib_t.
> 
> Allow load_policy to access /dev/tty.
> 
> Removed a dontaudit from login.te that was only needed if you had both a buggy 
> init and booted in permissive mode.
> 
> Allow setfiles to access /dev/tty, create unix datagram sockets, and read 
> locale data.
> 
> syslogd should not be running before /dev is labelled so it has no need to 
> access tmpfs_t.
> 
> Make useradd and groupadd run in the correct domain when run from firstboot to 
> give the files the right context.
> 
> Allow fsdaemon_t to access etc_runtime_t for /etc/smartd.conf.
> 
> Make kmodule run in kudzu_t (it's from the same code base).
> 
> Some minor improvements to mailman policy.
> 
> Fix a Red Hat Postfix problem and the postconf problem.
> 
> Removed some typealias rules that aren't needed any more.
> 
> tftpdir_t generally is not the root of a file system and should not have 
> attribute root_dir_type.
> 
> Added support for the new master socket support in ssh.
> 
> xdm_t should not even get access to most types that are labeled as 
> homedirfile, so changed the rule to use the attribute home_dir_type.
> 
> Fixed howl_t port assignments.  Either howl code has changed recently or the 
> current policy was merged wrong.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
