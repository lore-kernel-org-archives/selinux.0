Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j37DvFDo025798
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 09:57:15 -0400 (EDT)
Subject: Re: More patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, jwcart2@epoch.ncsc.mil,
   SELinux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <42542F02.2020304@redhat.com>
References: <200502032350.40924.russell@coker.com.au>
	 <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
	 <4253CD52.1090206@redhat.com>
	 <1112790317.4187.1.camel@moss-lions.epoch.ncsc.mil>
	 <4253D7BA.6030604@redhat.com> <1112810151.7822.4.camel@cobra.ivg2.net>
	 <42542F02.2020304@redhat.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 08:13:11 -0400
Message-Id: <1112875991.27110.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-04-06 at 14:48 -0400, Daniel J Walsh wrote:
> My understanding was that
> 
>  netlink_kobject_uevent_socket was added so that we would not need the netlink_socket rule.
> 
> Either I am wrong or you might need an updated kernel.

Ultimately, we can phase out the old rule, but we need to wait until the
kernel change makes its way into the Fedora kernels.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
