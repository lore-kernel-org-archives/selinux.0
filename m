Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36ItUDo020309
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 14:55:30 -0400 (EDT)
Message-ID: <42542F02.2020304@redhat.com>
Date: Wed, 06 Apr 2005 14:48:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>
Subject: Re: More patches
References: <200502032350.40924.russell@coker.com.au>	 <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>	 <4253CD52.1090206@redhat.com>	 <1112790317.4187.1.camel@moss-lions.epoch.ncsc.mil>	 <4253D7BA.6030604@redhat.com> <1112810151.7822.4.camel@cobra.ivg2.net>
In-Reply-To: <1112810151.7822.4.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>> allow hald_t bin_t:file getattr;
>>-allow hald_t self:netlink_socket create_socket_perms;
>> allow hald_t self:netlink_kobject_uevent_socket create_socket_perms;
>> allow hald_t self:netlink_route_socket r_netlink_socket_perms;
>> allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
>>    
>>
>
>Now I get one of these...
>
>audit(1112809767.410:0): avc:  denied  { create } for  pid=7363
>exe=/usr/sbin/hald scontext=root:system_r:hald_t
>tcontext=root:system_r:hald_t tclass=netlink_socket
>
>...and the console is flooded with those:
>
>audit(1112809741.307:0): avc:  denied  { read } for  pid=2525
>exe=/usr/sbin/hald scontext=system_u:system_r:hald_t
>tcontext=system_u:system_r:hald_t tclass=netlink_socket
>
>Was this removed because of the kobject_uevent rule below it?
>I can't remember if that rule was there to begin with, or if it 
>was put in to address what I was debugging w/ Protocol 15 (?) being
>denied. 
>
>  
>
My understanding was that

 netlink_kobject_uevent_socket was added so that we would not need the netlink_socket rule.

Either I am wrong or you might need an updated kernel.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
