Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NC9jOb027162
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 08:09:46 -0400 (EDT)
Received: from mail.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7NBwToM022835
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 11:58:29 GMT
Received: from [192.168.11.3] (j069218.ppp.asahi-net.or.jp [61.213.69.218])
	by mail.asahi-net.or.jp (Postfix) with ESMTP id 6193F1C441
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 20:59:23 +0900 (JST)
Message-ID: <430B0FED.9070307@ak.jp.nec.com>
Date: Tue, 23 Aug 2005 21:00:45 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] XATTR issues on JFFS2
References: <430AF95F.1050704@ak.jp.nec.com>
In-Reply-To: <430AF95F.1050704@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

In recent days, I'm interrested in XATTR support in JFFS2.

I have started a discussion about it on MTD-ML.
http://lists.infradead.org/pipermail/linux-mtd/2005-August/013415.html

By ML-archive, an implementation use hidden-file to store XATTR was
rejected finally. Thus, I adopted different approach.
This implementation added two new node types JFFS2_NODETYPE_XATTR
and JFFS2_NODETYPE_XREF for XATTR representation.

If your comment can be gotten, I'm so glad.

# I think it's not appropriate to discuss JFFS2 at SELinux-ML.
# Please comment it on MTD-ML, if possible.

Thanks,

*---- Example of use ------------

In my desktop PC, "fs_use_xattr jffs2 system_u:object_r:fs_t;"
was configured. :)

[root@saba ~]# dd if=jffs2.xattr.img of=/dev/mtdblock0
8192+0 records in
8192+0 records out
[root@saba ~]# mount -t jffs2 /dev/mtdblock0 /mnt/0
[root@saba ~]# ls -lZ /mnt/0
drwxr-xr-x  root     root     system_u:object_r:bin_t          bin/
drwxr-xr-x  root     root     system_u:object_r:mnt_t          dev/
drwxr-xr-x  root     root     system_u:object_r:etc_t          etc/
-rw-r--r--  root     root     system_u:object_r:mnt_t          hoge
-rwxr-xr-x  root     root     system_u:object_r:mnt_t          init*
drwxr-xr-x  root     root     system_u:object_r:lib_t          lib/
drwxr-xr-x  root     root     system_u:object_r:mnt_t          loopfs/
drwxr-xr-x  root     root     system_u:object_r:mnt_t          proc/
lrwxrwxrwx  root     root     system_u:object_r:bin_t          sbin
drwxr-xr-x  root     root     system_u:object_r:mnt_t          sys/
drwxr-xr-x  root     root     system_u:object_r:mnt_t          sysroot/
[root@saba ~]#

-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
