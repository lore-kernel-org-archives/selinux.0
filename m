Subject: Re: [PATCH] XATTR issues on JFFS2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <430B0FED.9070307@ak.jp.nec.com>
References: <430AF95F.1050704@ak.jp.nec.com>
	 <430B0FED.9070307@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 08:30:06 -0400
Message-Id: <1124800206.7874.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-23 at 21:00 +0900, KaiGai Kohei wrote:
> Hello,
> 
> In recent days, I'm interrested in XATTR support in JFFS2.
> 
> I have started a discussion about it on MTD-ML.
> http://lists.infradead.org/pipermail/linux-mtd/2005-August/013415.html
> 
> By ML-archive, an implementation use hidden-file to store XATTR was
> rejected finally. Thus, I adopted different approach.
> This implementation added two new node types JFFS2_NODETYPE_XATTR
> and JFFS2_NODETYPE_XREF for XATTR representation.
> 
> If your comment can be gotten, I'm so glad.
> 
> # I think it's not appropriate to discuss JFFS2 at SELinux-ML.
> # Please comment it on MTD-ML, if possible.
> 
> Thanks,
> 
> *---- Example of use ------------
> 
> In my desktop PC, "fs_use_xattr jffs2 system_u:object_r:fs_t;"
> was configured. :)
> 
> [root@saba ~]# dd if=jffs2.xattr.img of=/dev/mtdblock0
> 8192+0 records in
> 8192+0 records out
> [root@saba ~]# mount -t jffs2 /dev/mtdblock0 /mnt/0
> [root@saba ~]# ls -lZ /mnt/0
> drwxr-xr-x  root     root     system_u:object_r:bin_t          bin/
> drwxr-xr-x  root     root     system_u:object_r:mnt_t          dev/
> drwxr-xr-x  root     root     system_u:object_r:etc_t          etc/
> -rw-r--r--  root     root     system_u:object_r:mnt_t          hoge
> -rwxr-xr-x  root     root     system_u:object_r:mnt_t          init*
> drwxr-xr-x  root     root     system_u:object_r:lib_t          lib/
> drwxr-xr-x  root     root     system_u:object_r:mnt_t          loopfs/
> drwxr-xr-x  root     root     system_u:object_r:mnt_t          proc/
> lrwxrwxrwx  root     root     system_u:object_r:bin_t          sbin
> drwxr-xr-x  root     root     system_u:object_r:mnt_t          sys/
> drwxr-xr-x  root     root     system_u:object_r:mnt_t          sysroot/
> [root@saba ~]#

Thanks for working on this functionality.  From a very brief look at the
patch, one question I had was whether you could be using the generic
xattr methods introduced by James Morris' earlier xattr code
consolidation patches that are now in the mainline kernel.  See the
generic_* functions in fs/xattr.c and how they are used by the fs code
(e.g. look at the ext3 xattr implementation).  Per recent discussions on
linux-fsdevel, using those helpers is the preferred approach for the
future.  You can then just set sb->s_xattr for the specific handlers in
jffs2, e.g. see the ext3 code for an example.

Might be worth mentioning this work on acl-devel as well, although you
don't yet support ACLs or other xattrs.  But I'm sure Andreas
Gruenbacher would be interested, as he did the original xattr and ACL
development work for ext[23], and he may be able to give feedback on
your approach to various aspects like the attribute caching.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
