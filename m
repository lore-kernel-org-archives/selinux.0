Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFGgWIi024355
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 11:42:32 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFGf6vq002115
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 16:41:06 GMT
Subject: Re: learning about policies/transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Serge Hallyn <serge.hallyn@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46ce702f041115081242f9f8e7@mail.gmail.com>
References: <46ce702f041103084530fe8539@mail.gmail.com>
	 <1099510181.1213.198.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104082042e4c02a@mail.gmail.com>
	 <1099588265.3174.158.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104182352cbcd1@mail.gmail.com>
	 <1099657575.6373.5.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041115081242f9f8e7@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1100536712.31773.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 15 Nov 2004 11:38:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-15 at 11:12, Serge Hallyn wrote:
> Thanks for your help, Stephen.  I've *briefly* looked around at the
> inird and /bin/init sources, and can't find an initiial policy that
> would be loaded before the root filesystem pivot_root.  I expect to
> have more time at the end of this week to figure it out, though.

In Fedora, policy is loaded from the real root filesystem by /sbin/init,
not from the initrd.  We did use an initrd originally when we first
overhauled SELinux for mainline inclusion and moved the initial policy
load into userspace, but RedHat encountered practical issues with using
an initrd and migrated to a patched /sbin/init.  So /sbin/init is
loading policy from /etc/security/selinux/policy.NN under FC2 or
/etc/selinux/(strict|targeted)/policy/policy.NN under FC3.  The question
is whether you are subsequently loading a different policy, possibly too
late, after /bin/login has already been looked up and brought incore.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
