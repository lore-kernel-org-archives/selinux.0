Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89Jb4rT014314
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 15:37:05 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89Jb2VJ010044
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 19:37:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com, fedora-devel-list@redhat.com
Subject: tmpfs /dev
Date: Fri, 10 Sep 2004 05:36:59 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200409100536.59711.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have got a working system with tmpfs /dev and with udev in the initrd.  I 
modified /sbin/init to run the following script immediately after loading the 
policy:

#!/bin/sh
. /etc/selinux/config
/sbin/setfiles-mine /etc/selinux/$SELINUXTYPE/contexts/files/file_contexts /dev

Naturally we need to change the location of setfiles to /sbin from /usr/sbin 
if this is the solution we choose as this script will run before any file 
systems are mounted.

Below is the policy I added.  I had already changed the type declarations to 
use the dev_filesystem attribute for everything that may occur under /dev 
(patch sent to the main SE Linux list).  I have setfiles being run as 
kernel_t because I feel that running setfiles as kernel_t is better than 
granting setfiles_t more access than is otherwise required.  This means that 
I have to grant kernel_t access to relabel the device nodes, no big deal IMHO 
as kernel_t generally has ultimate access anyway.

I relabeled /sbin/MAKEDEV as udev_exec_t so that it runs as udev_t when run 
from /sbin/start_udev and can do the things that it wants to do.  This is a 
minor hack.  Maybe it would be better to label /sbin/start_udev as 
udev_exec_t?  That would remove the need to allow initrc_t to create 
sym-links under /dev.

avc:  denied  { getattr } for  pid=1641 exe=/sbin/lvm.static 
path=/sbin/MAKEDEV dev=dm-0 ino=196261 scontext=system_u:system_r:lvm_t 
tcontext=system_u:object_r:udev_exec_t tclass=file

Why does lvm.static want to stat /sbin/MAKEDEV?  Seems strange to me.

Below is the policy I wrote to allow tmpfs /dev and udev in initrd.  I haven't 
split it into all the relevant .te files because it's still an experiment at 
this stage.  After some discussion I'll produce a release version.

# for tmpfs /dev
allow dev_filesystem tmpfs_t:filesystem associate;
allow kernel_t tmpfs_t:chr_file rw_file_perms;
allow kernel_t tmpfs_t:{ dir file lnk_file chr_file blk_file } { getattr 
relabel
from };
allow kernel_t device_t:{ dir lnk_file chr_file blk_file } relabelto;
allow kernel_t device_type:{ chr_file blk_file } relabelto;
allow kernel_t udev_tbl_t:file relabelto;
can_exec(kernel_t, { sbin_t setfiles_exec_t })
# for /dev/pts on tmpfs
allow mount_t tmpfs_t:dir mounton;
# for /sbin/MAKEDEV - why?
allow lvm_t udev_exec_t:file getattr;
# allow /sbin/start_udev to run ln
allow initrc_t device_t:lnk_file create_lnk_perms;

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
