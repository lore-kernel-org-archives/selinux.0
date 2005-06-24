Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5O9j6gA004499
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 05:45:06 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5O9Ya2B022341
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 09:34:37 GMT
Subject: Re: mdadm policy
From: antoine <antoine@nagafix.co.uk>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>, walters@redhat.com
In-Reply-To: <1119577846.20101.26.camel@localhost.localdomain>
References: <1119569243.9390.77.camel@localhost>
	 <1119577846.20101.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 10:35:11 +0100
Message-Id: <1119605711.9645.28.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> (1) It allows everything the program wants to do, regardless
> of whether it is a good idea.
> > "I think it should probably use macros for shlib and
ptys, and use dontaudit instead of allow for some of the devices"
AFAIK, the only one I had missed in the statement above was the tmpfs.
I'll admit I was going to keep zero_device_t and a few others...

> (2) It is not organized in any sensible way. Sensible way means
> making use of existing macros, grouping rules together,
> and commenting *everything* with the purpose for adding
> that rule (or better yet group of rules) - this is the
> overall action that you want to allow with this block of rules.
As above. Once the devices are gone and you use macros where possible,
it kind of organises itself.

> (3) It adds primitive rules for things already present in macros.
> For example, the daemon_domain covers the transition.
Missed that little one, thanks. (no harm done)

> (4)...and there's numerous specific things wrong with it,
Numerous? That covers pretty much everything already! It isn't that big
> that I won't go into....starting from lack of exec_type on
> the bin_type, not following naming conventions, etc..
bin_type: Ooops.
What naming conventions did I miss?

Thanks for the policy, it is definitely much cleaner with macros
(although fundamentally not that different - which is good news for me),
Just few questions, does it really need:
* read access to all of etc_t and etc_runtime_t?
* self:capability dac_override ipc_lock
* read_sysctl(mdadm_t)
* r_dir_file(mdadm_t, sysfs_t)
* read_locale(mdadm_t)
Anyone know? Mine works without them.

I guess it allows execution of /bin and /sbin for the "PROGRAM" user
defined action, so I could keep it more restricted by only allowing
execution of sendmail_exec_t for my use. Since this is the only
statement in the policy that allows execution of external code, it feels
like the most important place to put restrictions on.

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
