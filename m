Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36JEQDo020565
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 15:14:27 -0400 (EDT)
Subject: Re: More patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: ivg2@cornell.edu, SELinux <selinux@tycho.nsa.gov>,
   Steve Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>
In-Reply-To: <42542F02.2020304@redhat.com>
References: <200502032350.40924.russell@coker.com.au>
	 <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
	 <4253CD52.1090206@redhat.com>
	 <1112790317.4187.1.camel@moss-lions.epoch.ncsc.mil>
	 <4253D7BA.6030604@redhat.com> <1112810151.7822.4.camel@cobra.ivg2.net>
	 <42542F02.2020304@redhat.com>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 15:13:12 -0400
Message-Id: <1112814792.4187.16.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-04-06 at 14:48 -0400, Daniel J Walsh wrote:
> Ivan Gyurdiev wrote:
> 
> >> allow hald_t bin_t:file getattr;
> >>-allow hald_t self:netlink_socket create_socket_perms;
> >> allow hald_t self:netlink_kobject_uevent_socket create_socket_perms;
> >> allow hald_t self:netlink_route_socket r_netlink_socket_perms;
> >> allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
> >>    
> >>
> >

Steve had suggested to me to leave that line in for now for
compatibility with older kernels.


-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
