Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8I6oOxF004548
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 02:50:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8I6mgLY019327
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 06:48:42 GMT
Received: from sjtu.edu.cn ([202.112.26.54])
	by jazzswing.ncsc.mil  with ESMTP id h8I6mesG019321
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 06:48:41 GMT
Message-ID: <001001c37db2$0d2f9a20$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: <jwcart2@epoch.ncsc.mil>
Cc: "SELINUX" <SELinux@tycho.nsa.gov>
References: <000a01c37d46$29ed8300$5d38a8c0@lky> <1063823878.7533.38.camel@moss-lions.epoch.ncsc.mil>
Subject: Re: Installation Problem
Date: Thu, 18 Sep 2003 14:56:53 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Absolutely right! Thanks a lot!


> SELinux uses extended attributes for file security contexts.  We (and
> others) have encountered problems booting unmodified 2.4 kernels after
> assigning extended attributes to the root filesystem.  
> 
> A 2.4 kernel with the Extended Attribute patch applied will boot.  The
> kernel source that you are using for SELinux has the EA patch, so you
> can use it to make a non-SELinux kernel.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
