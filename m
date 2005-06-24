Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OHnBgA008584
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 13:49:11 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OHmZ2B028492
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 17:48:35 GMT
Subject: Re: mdadm policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>, walters@redhat.com
In-Reply-To: <1119630905.9645.37.camel@localhost>
References: <1119569243.9390.77.camel@localhost>
	 <1119577846.20101.26.camel@localhost.localdomain>
	 <1119605711.9645.28.camel@localhost>
	 <1119627684.30464.8.camel@celtics.boston.redhat.com>
	 <1119630905.9645.37.camel@localhost>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 13:46:40 -0400
Message-Id: <1119635200.31852.16.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Well that's no comfort at all, mdadm_t domain has the ability to access
> raw disks and send mail... That's worrying enough.

I don't see anything about sending mail, but perhaps
I'm not looking hard enough. You're talking about adding this
privilege?

> # RAID block device access
> allow mdadm_t fixed_disk_device_t:blk_file create_file_perms;

hmm..yes..

Well, in this case, mdadm_t is the trusted domain,
and you *want* to transition it to other domains upon execution
of something that you don't trust.

So yes, if  you want want to send mail, you would add 
a transition like this:
domain_auto_trans(mdadm_t, sendmail_exec_t, sendmail_t (or whatever..))

What is this PROGRAM configurable option - can you describe in more 
detail. I don't know anything about mdadm.

> I will tweak my policy to make it run sendmail in
> sendmail_t and nothing else. That's safer than mdadm_t.

Perhaps this is something that should be in default policy - it
sounds like a good threat model.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
