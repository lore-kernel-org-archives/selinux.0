Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AJqOrT000744
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 15:52:24 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5AJqLaH021573
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 15:52:21 -0400 (EDT)
Subject: RE: [debian] postfix chroot setup from /etc/init.d/postfix isn't
	working.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ed Street <edstreet@street-tek.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
In-Reply-To: <20040610193218.8DD243A4066@abyss.simplyaquatics.com>
References: <20040610193218.8DD243A4066@abyss.simplyaquatics.com>
Content-Type: text/plain
Message-Id: <1086897134.4397.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Jun 2004 15:52:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-06-10 at 15:32, Ed Street wrote:
> Well like they say chroot is the poor mans security setup :) Disabling the
> chroot jail would be the best solution overall.

Defense in depth is a good idea, so using chroot (or other measures) in
combination with SELinux is quite sensible...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
