Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OFhsgA007128
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 11:43:54 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OFhJ2B017780
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 15:43:19 GMT
Subject: Re: mdadm policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>, walters@redhat.com
In-Reply-To: <1119605711.9645.28.camel@localhost>
References: <1119569243.9390.77.camel@localhost>
	 <1119577846.20101.26.camel@localhost.localdomain>
	 <1119605711.9645.28.camel@localhost>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 11:41:24 -0400
Message-Id: <1119627684.30464.8.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> What naming conventions did I miss?

The bin type should be named mdadm_exec_t, not mdadm_bin_t

> Thanks for the policy, it is definitely much cleaner with macros
> (although fundamentally not that different - which is good news for me),

It's Colin Walters' policy according to the header.

> Just few questions, does it really need:
> * read access to all of etc_t and etc_runtime_t?

The current policy assumes that etc_t and etc_runtime_t
are not protected types. It takes the opposite approach of 
marking specific types that should be protected. I find
this rather undesirable, but that's the way it is done...

Those rules are usually added to access /etc/fstab and
/etc/mtab.

> * self:capability dac_override ipc_lock

This looks interesting...

> * read_sysctl(mdadm_t)
> * r_dir_file(mdadm_t, sysfs_t)
> * read_locale(mdadm_t)
> Anyone know? Mine works without them.

Not sure, but those don't seem too much of a threat.
How do you know it works without them? Your setup
is just one of many... 

> I guess it allows execution of /bin and /sbin for the "PROGRAM" user
> defined action, so I could keep it more restricted by only allowing
> execution of sendmail_exec_t for my use.

Perhaps...

Note that the execution occurs without a transition (execute_no_trans),
which means that while executing the sub-program, it runs in
the same confined domain.

>  Since this is the only
> statement in the policy that allows execution of external code, it feels
> like the most important place to put restrictions on.

See above - execution of external code isn't so much of a problem
as long as it occurs in the same domain. If the external code
does anything undesirable, it will be done in the mdadm domain.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
