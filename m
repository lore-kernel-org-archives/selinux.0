Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5CUWXZ002658
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 07:30:35 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5CUXKf017905
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 12:30:33 GMT
Subject: Re: learning about policies/transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Serge Hallyn <serge.hallyn@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46ce702f041104182352cbcd1@mail.gmail.com>
References: <46ce702f041103084530fe8539@mail.gmail.com>
	 <1099510181.1213.198.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104082042e4c02a@mail.gmail.com>
	 <1099588265.3174.158.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104182352cbcd1@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1099657575.6373.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 07:26:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-04 at 21:23, Serge Hallyn wrote:
> Addendum:  running setfilecon works once.  After each reboot, I must again run
> setfilecon.before /bin/login will cause the transition to login_d. 
> Again, running
> /bin/ls -Z /bin/login shows no difference before and after the
> setifilecon - it is always
> of type login_et.

Two scenarios:
1) At boot time (e.g. usual policy load by /sbin/init), you are loading
a policy that does not define login_et, /bin/login inode is brought
incore and mapped to the unlabeled SID, and you then load a policy that
does define login_et, but this doesn't automatically fix the incore
inode SID.
2) At boot time, you are loading a policy that does define login_et,
/bin/login inode is brought incore and mapped to the correct SID, you
then load a policy that does not define login_et (e.g. Fedora policy),
invalidating that SID, and you later reload a policy that does define
login_et, but this doesn't automatically fix the incore inode SID.

While it would be possible to walk the inode lists upon a policy reload
and retry mapping of the on-disk xattr for any inode with the unlabeled
SID, I'm not sure it is worthwhile to do so.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
