Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA5HHdSf012667
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2003 12:17:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA5HHG1W018020
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2003 17:17:16 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
	by jazzswing.ncsc.mil  with ESMTP id hA5HH75e017949
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2003 17:17:14 GMT
Message-ID: <001801c3a3c2$34093f30$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: <jwcart2@epoch.ncsc.mil>
Cc: "SELINUX" <SELinux@tycho.nsa.gov>
References: <006201c3a16d$bf3c1980$5d38a8c0@lky> <1067963731.15639.24.camel@moss-lions.epoch.ncsc.mil>
Subject: Re: can't use ACL with 2.4 SELinux
Date: Thu, 6 Nov 2003 01:28:17 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, November 05, 2003 12:35 AM,James Carter wrote: 
> I tried the kernel from our website (linux-2.4-2003100110.tgz) with
> following ext3 options (and all the other normal options for SELinux):
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_XATTR_SHARING=y
> CONFIG_EXT3_FS_XATTR_USER=y
> CONFIG_EXT3_FS_XATTR_TRUSTED=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_EXT3_FS_SECURITY=y
> 
> I had no problem mounting my root ext3 filesystem with both the acl and
> user_xattr options.  I had no problems setting and getting user,
> trusted, and security.selinux extended attributes.  I also had no
> problems setting and getting acls.  It doesn't seem to be a problem with
> the kernel.
> 
> -- 
> James Carter <jwcart2@epoch.ncsc.mil>
> National Security Agency
Sorry,it's my fault.I made a mistake when I mount the filesystem.So ACL can't work.
Thanks!
lky



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
