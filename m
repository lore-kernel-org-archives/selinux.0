Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9K3ZIi015593
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 15:03:36 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9K3dEj007841
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 20:03:39 GMT
Subject: Re: Single home directory type for all roles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Colin Walters <walters@redhat.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Russell Coker <rcoker@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <41B8A9BF.2080405@redhat.com>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102613299.10785.21.camel@nexus.verbum.private>
	 <41B8A9BF.2080405@redhat.com>
Content-Type: text/plain
Message-Id: <1102622320.32175.230.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Dec 2004 14:58:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 14:38, Daniel J Walsh wrote:
> Currently few people use staff, because user can do everything staff can 
> do so you are not protected by this protection.
> You also do not protect yourself from staff users attacking other staff 
> users.

Few Fedora SELinux users use staff_r because user_canbe_sysadm is
enabled by default in the Fedora policy.  Disable it, and they'll start
using staff_r, because they will have to do so.  Colin has separation
between staff_r and user_r if he has disabled that tunable, which I
expect he has.  As for staff vs. staff, SELinux can only separate
different security contexts; otherwise, you are relying on DAC (of
course, SELinux does control the Linux capabilities, so your ability to
override DAC controls can be limited by SELinux).

If you disabled user_canbe_sysadm, and provided integrated user
management so that people could update their policy users configuration
(whether via policy sources or using genpolusers) easily when they
update their regular users databases, then you'd see greater use of
staff_r.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
