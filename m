Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0PId4Xf013359
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 13:39:04 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0PId0vt017344
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 18:39:01 GMT
Subject: Re: Latest  Diff
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43D6A307.4060801@redhat.com>
References: <43D6A307.4060801@redhat.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 13:41:22 -0500
Message-Id: <1138214482.9344.93.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-24 at 16:58 -0500, Daniel J Walsh wrote:
> Alsa wants access to tty.
> Also need to transiton from locallogin not pam_console.
> 
> kudzu wants to look at removable devices
> 
> prelink is writing files to /var/lib/misc
> Also wants to read etc_t
> 
> readahead wants to read kcore and is not allowed to on MLS machine
> 
> lvm is putting up a symlink in tmpfs_t which a few domains want to read.
> 
> tmpreaper wants to look in the print spooler
> 
> slocate needs access to shared libraries, and localization files
> 
> automount wants to mount on /misc
> 
> cups seems to be looking for serial printers ???
> 
> dbus moved
> 
> I put some fixes in in order to build a default modules.conf file for 
> strict policy.  Still needs lots of loving...
> 
> sulogin needs nscd
> 
> fixes for syslogd to work over the network
> 
> insmod needs to read file_context in order to setup removable_t
> 
> I want to eliminate sysadm_t from running "entry_point" applications.  
> If a sysadm accidently starts a daemon, it will run under sysadm_t which 
> could have dire ramifications in MLS/Strict policy
> 
> Fixes for users file for strict policy

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
