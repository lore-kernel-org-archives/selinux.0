Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OGXWgA007777
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 12:33:33 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OGXVUD021289
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 16:33:31 GMT
Subject: Re: mdadm policy
From: antoine <antoine@nagafix.co.uk>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>, walters@redhat.com
In-Reply-To: <1119627684.30464.8.camel@celtics.boston.redhat.com>
References: <1119569243.9390.77.camel@localhost>
	 <1119577846.20101.26.camel@localhost.localdomain>
	 <1119605711.9645.28.camel@localhost>
	 <1119627684.30464.8.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 17:35:05 +0100
Message-Id: <1119630905.9645.37.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > I guess it allows execution of /bin and /sbin for the "PROGRAM" user
> > defined action, so I could keep it more restricted by only allowing
> > execution of sendmail_exec_t for my use.
> 
> Perhaps...
> 
> Note that the execution occurs without a transition (execute_no_trans),
> which means that while executing the sub-program, it runs in
> the same confined domain.
Well that's no comfort at all, mdadm_t domain has the ability to access
raw disks and send mail... That's worrying enough.

# RAID block device access
allow mdadm_t fixed_disk_device_t:blk_file create_file_perms;

> >  Since this is the only
> > statement in the policy that allows execution of external code, it feels
> > like the most important place to put restrictions on.
> 
> See above - execution of external code isn't so much of a problem
> as long as it occurs in the same domain. If the external code
> does anything undesirable, it will be done in the mdadm domain.
True as long as the domain is sufficiently constrained, which is not the
case for mdadm. I will tweak my policy to make it run sendmail in
sendmail_t and nothing else. That's safer than mdadm_t.

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
