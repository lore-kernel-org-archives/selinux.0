Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OJjUrT000372
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:45:30 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OJijMZ001961
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 19:44:45 GMT
Subject: Re: Policy changes
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <412B607F.6070708@redhat.com>
References: <412B607F.6070708@redhat.com>
Content-Type: text/plain
Message-Id: <1093376688.6831.13.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 15:44:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-24 at 11:36, Daniel J Walsh wrote:
> I am trying to remove unrestricted_admin, so I added a new attribute 
> unrestricted.  Then replaced all the special code within
> assert.te to check unrestricted.
> 
> Dan
> 
> 
> 
> ______________________________________________________________________
Thanks.  Merged everything except the domains/program/unused/udev.te,
tunables/distro.tun, and tunables/tunable.tun stuff.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
