Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAN6WZIi010070
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 01:32:36 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAN6V25q024639
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 06:31:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Serge Hallyn <serge.hallyn@gmail.com>
Subject: Re: learning about policies/transitions
Date: Tue, 23 Nov 2004 15:21:39 +1100
Cc: selinux@tycho.nsa.gov
References: <46ce702f041103084530fe8539@mail.gmail.com> <1099657575.6373.5.camel@moss-spartans.epoch.ncsc.mil> <46ce702f041115081242f9f8e7@mail.gmail.com>
In-Reply-To: <46ce702f041115081242f9f8e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411231521.42560.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 16 November 2004 03:12, Serge Hallyn <serge.hallyn@gmail.com> 
wrote:
> Thanks for your help, Stephen.  I've *briefly* looked around at the
> inird and /bin/init sources, and can't find an initiial policy that
> would be loaded before the root filesystem pivot_root.  I expect to

Only the initrd is running before pivot_root and the initrd does not load 
policy any more.  So there is no policy loaded until after the root file 
system is mounted as "/" and /sbin/init is executed.

/sbin/init loads the policy and then re-exec's itself to transition from 
kernel_t to init_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
