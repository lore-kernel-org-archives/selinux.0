Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA19431
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 10:01:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA18775
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 15:01:32 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id PAA18771
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 15:01:31 GMT
Date: Wed, 14 Feb 2001 10:00:01 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Redhat 7
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524083@csoc-mail-box.csoconline.com>
Message-ID: <Pine.SOL.3.95.1010214095204.5716F-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> avc:  denied  { read } for  pid=69
>       exe=/bin/mount path=/dev/hda1 dev=03:01 ino=176886
>       scontext=system_u:system_r:initrc_t
>       tcontext=system_u:object_r:fixed_disk_device_t
>       tclass=blk_file

I'm not sure why /bin/mount is trying to directly read from
the block device.  I would suggest putting /bin/mount into
its own domain in the same way that you put hwclock into
its own domain and then granting that domain this permission.
We don't want to grant the more general initrc_t domain
direct access to disk devices.

> avc:  denied  { read } for  pid=179
>       exe=/sbin/hdparm path=/dev/hda dev=03:01 ino=176885
>       scontext=system_u:system_r:initrc_t
>       tcontext=system_u:object_r:fixed_disk_device_t
>       tclass=blk_file
>
> avc:  denied  { ioctl } for  pid=179
>       exe=/sbin/hdparm path=/dev/hda dev=03:01 ino=176885
>       scontext=system_u:system_r:initrc_t
>       tcontext=system_u:object_r:fixed_disk_device_t
>       tclass=blk_file

Similarly, it looks like we should put hdparm into its own domain.

> avc:  denied  { sys_module } for  pid=529
>       exe=/sbin/insmod capability=16
>       scontext=system_u:system_r:system_crond_t
>       tcontext=system_u:system_r:system_crond_t
>       tclass=capability

Currently, the example policy configuration allows system_crond_t
to transition to rmmod_t when running /sbin/rmmod for the
/etc/crond.d/kmod crontab.  Take a look at your system crontab
files to see why it is running insmod.  If you want to allow
it to do so, then add a set of rules similar to the 
existing rules for rmmod_t in policy/domains/system/crond.te, e.g.

domain_auto_trans(system_crond_t, insmod_exec_t, insmod_t)
allow insmod_t crond_t:fd inherit_fd_perms;
allow insmod_t crond_t:process sigchld;

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
