Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36JASDo020497
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 15:10:29 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j36J5KCd021412
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 19:05:22 GMT
Subject: Re: More patches
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>
In-Reply-To: <42542F02.2020304@redhat.com>
References: <200502032350.40924.russell@coker.com.au>
	 <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
	 <4253CD52.1090206@redhat.com>
	 <1112790317.4187.1.camel@moss-lions.epoch.ncsc.mil>
	 <4253D7BA.6030604@redhat.com> <1112810151.7822.4.camel@cobra.ivg2.net>
	 <42542F02.2020304@redhat.com>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 14:13:59 -0400
Message-Id: <1112811239.3469.4.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> My understanding was that
> 
>  netlink_kobject_uevent_socket was added so that we would not need the netlink_socket rule.
> 
> Either I am wrong or you might need an updated kernel.

Ok, I wasn't sure about that, since I didn't see when it was added.
Which kernel do I need? I am running 2.6.11-1.1226_FC4.

Strace still shows protocol 15... same behavior as previously reported.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
