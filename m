Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9D36aWt012381
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2003 23:06:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9D36ZUb013991
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 03:06:35 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
        by jazzband.ncsc.mil  with ESMTP id h9D36YhX013988 for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 03:06:34 GMT
Message-ID: <002b01c39138$22820bd0$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: <russell@coker.com.au>, "SELINUX" <SELinux@tycho.nsa.gov>
References: <000901c390ef$d8b3c770$5d38a8c0@lky> <200310130811.28355.russell@coker.com.au>
Subject: Re: can't start X window in enforce mode
Date: Mon, 13 Oct 2003 11:14:33 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, October 13, 2003 6:11 AM,Russell Coker wrote:

> # memory_device_t access is needed if not using the frame buffer
> dontaudit $1_xserver_t memory_device_t:chr_file read;
> 
> The above is the relevant section of policy in
> macros/program/xserver_macros.te.  The X server tries to access /dev/mem even 
> if it doesn't need to.  Change the dontaudit rule to an allow for 
> rw_file_perms and it should work.

Absolutely right! It really works,Thanks a lot!



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
