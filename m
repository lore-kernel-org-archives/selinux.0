Date: Wed, 10 Jul 2002 10:40:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Wierdness with lsm 2.5
In-Reply-To: <1026309847.9320.67.camel@phobos>
Message-ID: <Pine.GSO.4.33.0207101009080.26546-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 10 Jul 2002, Timothy Wood wrote:

> Has anyone been using the 2.5 lsm since the last release?  I'm getting a
> whole lot of errors the 2.4 never gave me.  Here are some of them.

First, you should be very cautious about using 2.5, as it is the
development kernel series and can be very unsafe to use.  I wouldn't
recommend using it for any production systems.

> -----md errors------
>
> avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md0
> dev=03:03 ino=66778 scontext=system_u:system_r:fsadm_t
> tcontext=system_u:object_r:device_t tclass=blk_file

The md[0-9]* devices are for metadisk (RAID) devices.  See
Documentation/devices.txt in the kernel tree.  Ed Street noted earlier
that entries for these devices are missing from the current types.fc
configuration.  We've added them to our internal tree, and you can pull an
updated copy from the sourceforge CVS tree, or just add the following
directly to your types.fc file.  Then do a make relabel.  [Or, if using
devfs, you'll need to update your genfs_contexts configuration, do
a make install, and reboot].
/dev/ataraid/d[^/]*             system_u:object_r:fixed_disk_device_t
/dev/md[0-9]*                   system_u:object_r:fixed_disk_device_t

> --------some wierd device -----------
> (new thing in 2.5 kernel I guess, disks of some sort or another)
>
> avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck
> path=/dev/cciss/c2d4p14 dev=03:03 ino=2425518
> scontext=system_u:system_r:fsadm_t tcontext=system_u:object_r:device_t
> tclass=blk_file

devices.txt identifies these as devices for Compaq Next Generation Drive
Array. Feel free to add entries to the types.fc to assign
fixed_disk_device_t to these devices [or update genfs_contexts if using
devfs].

> avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/hitcd
> dev=03:03 ino=66633 scontext=system_u:system_r:fsadm_t
> tcontext=system_u:object_r:device_t tclass=blk_file

This would be a Hitachi CD-ROM.  Assign removable_device_t to it in
types.fc or genfs_contexts.

> -------some other wierd thing.
>
> avc:  denied  { sys_tty_config } for  pid=721 comm=sh capability=26
> scontext=system_u:system_r:checkpc_t
> tcontext=system_u:system_r:checkpc_t tclass=capability

Yes, I've seen this as well.  Many legacy suser() checks have been
replaced with capable() calls in 2.5, so you need to add capabilities to
the policy.  We haven't updated the example policy for this yet.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
