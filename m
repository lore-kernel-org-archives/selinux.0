Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89KJRrT014633
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 16:19:28 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89KIPo3002202
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 20:18:25 GMT
Message-ID: <4140BAB8.8070808@redhat.com>
Date: Thu, 09 Sep 2004 16:19:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
CC: fedora-devel-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: tmpfs /dev
References: <200409100536.59711.russell@coker.com.au>
In-Reply-To: <200409100536.59711.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>I have got a working system with tmpfs /dev and with udev in the initrd.  I 
>modified /sbin/init to run the following script immediately after loading the 
>policy:
>
>#!/bin/sh
>. /etc/selinux/config
>/sbin/setfiles-mine /etc/selinux/$SELINUXTYPE/contexts/files/file_contexts /dev
>
>Naturally we need to change the location of setfiles to /sbin from /usr/sbin 
>if this is the solution we choose as this script will run before any file 
>systems are mounted.
>
>Below is the policy I added.  I had already changed the type declarations to 
>use the dev_filesystem attribute for everything that may occur under /dev 
>(patch sent to the main SE Linux list).  I have setfiles being run as 
>kernel_t because I feel that running setfiles as kernel_t is better than 
>granting setfiles_t more access than is otherwise required.  This means that 
>I have to grant kernel_t access to relabel the device nodes, no big deal IMHO 
>as kernel_t generally has ultimate access anyway.
>
>I relabeled /sbin/MAKEDEV as udev_exec_t so that it runs as udev_t when run 
>from /sbin/start_udev and can do the things that it wants to do.  This is a 
>minor hack.  Maybe it would be better to label /sbin/start_udev as 
>udev_exec_t?  That would remove the need to allow initrc_t to create 
>sym-links under /dev.
>
>avc:  denied  { getattr } for  pid=1641 exe=/sbin/lvm.static 
>path=/sbin/MAKEDEV dev=dm-0 ino=196261 scontext=system_u:system_r:lvm_t 
>tcontext=system_u:object_r:udev_exec_t tclass=file
>
>Why does lvm.static want to stat /sbin/MAKEDEV?  Seems strange to me.
>
>Below is the policy I wrote to allow tmpfs /dev and udev in initrd.  I haven't 
>split it into all the relevant .te files because it's still an experiment at 
>this stage.  After some discussion I'll produce a release version.
>
># for tmpfs /dev
>allow dev_filesystem tmpfs_t:filesystem associate;
>allow kernel_t tmpfs_t:chr_file rw_file_perms;
>allow kernel_t tmpfs_t:{ dir file lnk_file chr_file blk_file } { getattr 
>relabel
>from };
>allow kernel_t device_t:{ dir lnk_file chr_file blk_file } relabelto;
>allow kernel_t device_type:{ chr_file blk_file } relabelto;
>allow kernel_t udev_tbl_t:file relabelto;
>can_exec(kernel_t, { sbin_t setfiles_exec_t })
># for /dev/pts on tmpfs
>allow mount_t tmpfs_t:dir mounton;
># for /sbin/MAKEDEV - why?
>allow lvm_t udev_exec_t:file getattr;
># allow /sbin/start_udev to run ln
>allow initrc_t device_t:lnk_file create_lnk_perms;
>
>  
>
You will need to talk to Bill Nottingham about modifying /sbin/init to 
do this.  They are not crazy about
putting additional code into /sbin/init since it is very hard to debug.  
They prefer rc.sysinit.  They also do not
want to relabel the /dev file system if it is not a tmpfs,  since with 
8000 or more files it could take a while and
slow down the boot up.  The modification that we are currently using 
only modifies rc.sysinit to do a restorecon
on /dev/* when it is tmpfs and adds a couple of allows for hostname, 
init, mount and consoletype to use tmpfs_t.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
