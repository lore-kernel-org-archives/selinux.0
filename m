Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36IqNDo020261
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 14:52:23 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j36IlECd019481
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 18:47:16 GMT
Subject: Re: More patches
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4253D7BA.6030604@redhat.com>
References: <200502032350.40924.russell@coker.com.au>
	 <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
	 <4253CD52.1090206@redhat.com>
	 <1112790317.4187.1.camel@moss-lions.epoch.ncsc.mil>
	 <4253D7BA.6030604@redhat.com>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 13:55:51 -0400
Message-Id: <1112810151.7822.4.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>  allow hald_t bin_t:file getattr;
> -allow hald_t self:netlink_socket create_socket_perms;
>  allow hald_t self:netlink_kobject_uevent_socket create_socket_perms;
>  allow hald_t self:netlink_route_socket r_netlink_socket_perms;
>  allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };

Now I get one of these...

audit(1112809767.410:0): avc:  denied  { create } for  pid=7363
exe=/usr/sbin/hald scontext=root:system_r:hald_t
tcontext=root:system_r:hald_t tclass=netlink_socket

...and the console is flooded with those:

audit(1112809741.307:0): avc:  denied  { read } for  pid=2525
exe=/usr/sbin/hald scontext=system_u:system_r:hald_t
tcontext=system_u:system_r:hald_t tclass=netlink_socket

Was this removed because of the kobject_uevent rule below it?
I can't remember if that rule was there to begin with, or if it 
was put in to address what I was debugging w/ Protocol 15 (?) being
denied. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
