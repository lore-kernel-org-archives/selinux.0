Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m88Engqp020774
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 10:49:42 -0400
Received: from rn-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m88EneGU013202
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 14:49:41 GMT
Received: by rn-out-0910.google.com with SMTP id k40so92696rnd.17
        for <selinux@tycho.nsa.gov>; Mon, 08 Sep 2008 07:49:40 -0700 (PDT)
Message-ID: <4c4ba1530809080749g6c57dcces64a5439305bed06a@mail.gmail.com>
Date: Mon, 8 Sep 2008 07:49:38 -0700
From: "Tom London" <selinux@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: rsync issues with 'security.selinux': copying unlabelled files to a 'labelled' file system ... ?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I run rsync to backup my Fedora rawhide system onto a USB hard drive:

rsync --archive --recursive --acls --xattrs --delete
--exclude='/selinux' --exclude='/lost+found/*' --exclude='/dev/*'
--exclude='/media/*' --exclude='/proc/*' --exclude='/sys/*'
--exclude='*/.gvfs' --exclude='/mnt/disk*/*' --stats / /media/Backup1

'/media/Backup1' is mounted on an ext4 file system.  Two (fuse)
mounted ntfs-3g file systems (/mnt/windows and /mnt/music) are backed
up with this as well.

The ntfs-3g files systems project SELinux labels of fuse_t:

[root@tlondon temp]# ls -lZ /mnt/windows/temp
-rwxrwxrwx  root root system_u:object_r:fusefs_t:s0    setup.log
[root@tlondon temp]#

But they "really" have no attributes:

[root@tlondon temp]# getfattr /mnt/windows/temp/*
getfattr: /mnt/windows/temp/setup.log: Operation not supported
[root@tlondon temp]#

When I run the above rsync command, I get error spew from rsync
complaining about failures trying to remove 'security.selinux'
attributes from the destination copies of files from the ntfs-3g file
systems:

rsync: rsync_xal_clear:
lremovexattr("mnt/windows/WINDOWS/twain_32/wiatwain.ds","security.selinux")
failed: Permission denied (13)
rsync: rsync_xal_clear:
lremovexattr("mnt/windows/temp","security.selinux") failed: Permission
denied (13)
rsync: rsync_xal_clear:
lremovexattr("mnt/windows/temp/setup.log","security.selinux") failed:
Permission denied (13)

Seems that rsync is trying to 'match' the attributes on the
destination to 'match' those from the source.  In this case, the
source files have no attributes.

So, what should the behavior be (in this case) when rsync-ing files
from a file system not supporting attributes to one that does?

Seems wrong to me to allow rsync to remove the 'security.selinux'
attributes (as it is attempting but failing now), leaving unlabelled
files on the destination file system.

This could be the code at issue:

static int rsync_xal_set(const char *fname, item_list *xalp,
                        const char *fnamecmp, stat_x *sxp)
{
<<<<<SNIP>>>>>
       /* Remove any extraneous names. */
       for (name = namebuf; list_len > 0; name += name_len) {
               name_len = strlen(name) + 1;
               list_len -= name_len;

#ifdef HAVE_LINUX_XATTRS
               /* We always ignore the system namespace, and non-root
                * ignores everything but the user namespace. */
               if (am_root ? HAS_PREFIX(name, SYSTEM_PREFIX)
                           : !HAS_PREFIX(name, USER_PREFIX))
                       continue;
#endif

A simple patch could include checking for "SECURITY_PREFIX" in the
'am_root' leg, but is that correct?

What about other kinds of attributes (e.g., "Trusted extended
attributes")?  Should they be handled this way?

I've BZ'd this here: https://bugzilla.redhat.com/show_bug.cgi?id=461486

Thoughts/wisdom?

thanks,
   tom
-- 
Tom London

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
