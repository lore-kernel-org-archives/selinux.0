Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89KVvrT014732
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 16:31:57 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89KVuVJ012203
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 20:31:56 GMT
Subject: Re: New policy to allow strict to run X again with tmpfs on /dev
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <413F7BA4.1060002@redhat.com>
References: <413F7BA4.1060002@redhat.com>
Content-Type: text/plain
Message-Id: <1094761861.2895.59.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Sep 2004 16:31:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Wed, 2004-09-08 at 17:37, Daniel J Walsh wrote:
> Bigest change is xserver needs to create /dev/dri directory.  This 
> should be fixed so Xorg uses udev in the future
> but for now I have granted the privs.
> 
> ipsec seems to be a mess.
> 
> Dan
> 
> ______________________________________________________________________
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
