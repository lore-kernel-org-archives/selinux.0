Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA4GZeWt006759
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 11:35:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA4GZHC7017399
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 16:35:17 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [144.51.25.4])
	by jazzswing.ncsc.mil  with ESMTP id hA4GZHuw017396
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 16:35:17 GMT
Subject: Re: can't use ACL with 2.4 SELinux
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: lky <lky77@sjtu.edu.cn>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <006201c3a16d$bf3c1980$5d38a8c0@lky>
References: <006201c3a16d$bf3c1980$5d38a8c0@lky>
Content-Type: text/plain
Message-Id: <1067963731.15639.24.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 04 Nov 2003 11:35:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-11-02 at 13:18, lky wrote:
>     Hi, I installed 2.4.21-selinux2 (linux-2.4-2003100110.tgz) on Redhat9.0. Because the SElinux kernel has the combined ea+acl+nfsacl patch built in. So I think I can use ACL directly. But I failed. I have enabled the kernel options for ACLs and I mount the file system as follows: 'mount -t ext3 -o exec,dev,suid,rw,acl,user_xattr /dev/hda8 /mnt/test'
> but it said : operations not supported. Any ideas?
>     Thanks!

I tried the kernel from our website (linux-2.4-2003100110.tgz) with
following ext3 options (and all the other normal options for SELinux):
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_XATTR_SHARING=y
CONFIG_EXT3_FS_XATTR_USER=y
CONFIG_EXT3_FS_XATTR_TRUSTED=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y

I had no problem mounting my root ext3 filesystem with both the acl and
user_xattr options.  I had no problems setting and getting user,
trusted, and security.selinux extended attributes.  I also had no
problems setting and getting acls.  It doesn't seem to be a problem with
the kernel.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
