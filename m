Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81BZVrT020007
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 07:35:31 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81BYgY2020065
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 11:34:42 GMT
Subject: Re: Progress! .532 boots! -- but dbus/hotplug/udev problems remain?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: Tom London <selinux@comcast.net>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409011637.41952.russell@coker.com.au>
References: <4130CF1B.3090909@comcast.net>
	 <200408291737.17497.russell@coker.com.au> <41322F5E.90409@comcast.net>
	 <200409011637.41952.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1094038404.13328.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 01 Sep 2004 07:33:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-01 at 02:37, Russell Coker wrote:
> One thing to remember is that any time you see user_t in policy it's a local 
> customisation or a bug.
> 
> In this case it seems to me that one correct way of writing policy for this is 
> the following:
> allow { dbus_client_domain userdomain } etc_dbusd_t:dir { search };
> allow { dbus_client_domain userdomain } etc_dbusd_t:file { getattr read };
> allow { dbus_client_domain userdomain } user_t:netlink_selinux_socket { bind 
> create };
> 
> But then we are granting almost every domain that has any significance in the 
> security of the system read access.  So why not just label the files as etc_t 
> and remove the etc_dbusd_t type entirely?

These permissions shouldn't be granted directly to the user domains.  We
need per-userdomain dbusd domains defined via a macro for the
per-session message bus.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
