Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8NIwKNs001239
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2005 14:58:20 -0400 (EDT)
Received: from narnia3.rutgers.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8NIrbnY002582
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2005 18:53:37 GMT
Message-ID: <2511.172.18.148.164.1127501625.squirrel@webmail.eden.rutgers.edu>
In-Reply-To: <20050918215841.GA7480@vnl.com>
References: <20050917233111.GA17916@vnl.com> <20050918001512.GR9092@lkcl.net>
    <20050918095806.GC25649@vnl.com> <20050918104219.GW9092@lkcl.net>
    <20050918215841.GA7480@vnl.com>
Date: Fri, 23 Sep 2005 14:53:45 -0400 (EDT)
Subject: Re: State of Debian SELinux
From: sswami@eden.rutgers.edu
To: "Dale Amon" <amon@vnl.com>
Cc: "Dale Amon" <amon@vnl.com>, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I was trying to install SELinux using the 2.6 kernel. I have been using
relevant packages from the coker site. When I do "make policy", I get the
following error message:


 	/usr/bin/checkpolicy: loading policy configuration from policy.conf
 	libsepol.expand_avtab_insert: Type conflict!
 	Out of memory - unable to check assertions.
 	Check assertions failed.

Can anyone please let me know what I should do to get rid of this?

thanks
saswati


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
