Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA2I7mWt026830
	for <selinux@tycho.nsa.gov>; Sun, 2 Nov 2003 13:07:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA2I7mKl008719
	for <selinux@tycho.nsa.gov>; Sun, 2 Nov 2003 18:07:48 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
        by jazzband.ncsc.mil  with ESMTP id hA2I7k5m008716 for <selinux@tycho.nsa.gov>; Sun, 2 Nov 2003 18:07:47 GMT
Received: from lky (mailwall.shnet.edu.cn [202.112.26.55])
	by sjtu.edu.cn (WorldPost) with ESMTP id 2F28B34097B
	for <selinux@tycho.nsa.gov>; Mon,  3 Nov 2003 02:07:37 +0800 (BEIST)
Message-ID: <006201c3a16d$bf3c1980$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: "SELINUX" <SELinux@tycho.nsa.gov>
Subject: can't use ACL with 2.4 SELinux
Date: Mon, 3 Nov 2003 02:18:42 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

    Hi, I installed 2.4.21-selinux2 (linux-2.4-2003100110.tgz) on Redhat9.0. Because the SElinux kernel has the combined ea+acl+nfsacl patch built in. So I think I can use ACL directly. But I failed. I have enabled the kernel options for ACLs and I mount the file system as follows: 'mount -t ext3 -o exec,dev,suid,rw,acl,user_xattr /dev/hda8 /mnt/test'
but it said : operations not supported. Any ideas?
    Thanks!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
