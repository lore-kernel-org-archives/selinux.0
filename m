Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA25956
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 14:06:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA01627
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 19:05:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA01623
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 19:05:56 GMT
Date: Tue, 27 Nov 2001 14:05:32 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: lsm-selinux-200111191100.tgz
In-Reply-To: <1006885442.1246.0.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0111271341370.28935-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 27 Nov 2001, Justin Smith wrote:

> When I did make install in module, it did not complete successfully
> because the makefile expected a directory to be named
<snip>
> When I moved asm-i386 to asm it worked and I was able to boot
> selinux.

include/asm and arch/machine are created by the 'make dep' in the BUILDING
instructions.  They are symbolic links that are automatically set to refer
to the appropriate architecture.  Of course, at present, we only support
x86, but by using these symbolic links, we make it easier to add support
for other architectures in the future.  I'm not sure why your include/asm
link was not set by the time you did the 'make install' in the module
directory unless you did a 'make clean'.

> Having done so, I received the following messages:
>
> avc:  denied  { mounton } for  pid=75 exe=/bin/mount path=/bus/usb
> dev=00:03 ino=4459
>    scontext=system_u:system_r:mount_t
>    tcontext=system_u:object_r:proc_t
>    tclass=dir

Ok, so you are mounting another filesystem under /proc.  Add a 'allow
mount_t proc_t:dir mounton;' rule to policy/domains/system/mount.te.

> avc:  denied  { search } for  pid=93 exe=/bin/cat dev=00:08 ino=1
>    scontext=system_u:system_r:initrc_t
>    tcontext=system_u:object_r:unlabeled_t
>    tclass=dir
>
> avc:  denied  { read } for  pid=93 exe=/bin/cat path=/devices dev=00:08
> ino=2
>    scontext=system_u:system_r:initrc_t
>    tcontext=system_u:object_r:unlabeled_t
>    tclass=file
>
> avc:  denied  { getattr } for  pid=93 exe=/bin/cat path=/devices
> dev=00:08 ino=2
>    scontext=system_u:system_r:initrc_t
>    tcontext=system_u:object_r:unlabeled_t
>    tclass=file

This indicates that you are using a filesystem type that isn't recognized
by SELinux, so it is left unlabeled.  This is most likely some kind of
pseudo filesystem type, like usbdevfs.  The handling for each pseudo
filesystem type is specialized to provide reasonable security semantics
for that type.  At present, SELinux defines labeling behaviors for procfs,
devpts, tmpfs and devfs.  I haven't used usbdevfs or looked at its
implementation, so I don't know whether it should just use the same
labeling behavior as devfs or not.

> avc:  denied  { write } for  pid=10 exe=/bin/bash path=/etc/mtab
> dev=03:01 ino=28440
>    scontext=system_u:system_r:initrc_t
>    tcontext=system_u:object_r:file_t
>    tclass=file

This is typical on the first boot of the SELinux kernel.  Run setfiles
again, as recommended by step 15 of the README.

> avc:  denied  { create } for  pid=296 exe=/sbin/ipchains
>    scontext=system_u:system_r:initrc_t
>    tcontext=system_u:system_r:initrc_t
>    tclass=rawip_socket
>
> avc:  denied  { setopt } for  pid=296 exe=/sbin/ipchains lport=255
>    scontext=system_u:system_r:initrc_t
>    tcontext=system_u:system_r:initrc_t
>    tclass=rawip_socket

Ok, so you either need to grant these permissions to initrc_t if you
want to allow this to run, or you need to define a separate domain for
ipchains that can do this.

> avc:  denied  { search } for  pid=838 exe=/usr/sbin/httpd
> path=/www/tomcat dev=03:05 ino=336750
>    scontext=system_u:system_r:httpd_t
>    tcontext=system_u:object_r:httpd_user_script_rw_t
>    tclass=dir

I'm not sure why httpd_t doesn't have this permission.  You can certainly
add it.

> (plus many messages connected with running the Gnome desktop)

Did you follow the instructions in step 4 prior to trying to run
GNOME?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
