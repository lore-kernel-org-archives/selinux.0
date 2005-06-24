Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OJ85gA009666
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 15:08:05 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OJ82UD002654
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 19:08:02 GMT
Subject: Re: mdadm policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: antoine <antoine@nagafix.co.uk>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
   walters@redhat.com
In-Reply-To: <1119636160.9645.46.camel@localhost>
References: <1119569243.9390.77.camel@localhost>
	 <1119577846.20101.26.camel@localhost.localdomain>
	 <1119605711.9645.28.camel@localhost>
	 <1119627684.30464.8.camel@celtics.boston.redhat.com>
	 <1119630905.9645.37.camel@localhost>
	 <1119635200.31852.16.camel@celtics.boston.redhat.com>
	 <1119636160.9645.46.camel@localhost>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:05:33 -0400
Message-Id: <1119639933.31852.82.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> So it looks to me like the transition to sendmail should always be
> included - well actually, ifdef(mta.te).

cc-ed Dan Walsh.
Proposed transition to sendmail from mdadm.te
(so it can send alerts to user).

Re: can_exec({ bin_t, sbin_t }) rule

Antoine, you have to be root/sysadm_t to configure
execution of such programs, right? If you have sysadm_t, you
can disable any and all security. The only protection
from sysadm_t that selinux provides is protection from
inadvertently running hostile code that messes w/ selinux
files - that's why we have a role called secadm_t
(I think this is work in progress).

So, we can't stop an intentional attack like this.
The only question is whether we should stop unintentional
attack (sysadm doesn't know bin_t/sbin_t program is hostile,
sysadm installed it anyway, sysadm doesn't have capability
to write to fixed_disk_device, but mdadm does, and 
gives hostile program desired escalation). 

Don't know..

> > > # RAID block device access
> > > allow mdadm_t fixed_disk_device_t:blk_file create_file_perms;
> > 
> > hmm..yes..
> > 
> > Well, in this case, mdadm_t is the trusted domain,
> > and you *want* to transition it to other domains upon execution
> > of something that you don't trust.
> > 
> > So yes, if  you want want to send mail, you would add 
> > a transition like this:
> > domain_auto_trans(mdadm_t, sendmail_exec_t, sendmail_t (or whatever..))
> > 
> > What is this PROGRAM configurable option - can you describe in more 
> > detail. I don't know anything about mdadm.
> > 
> > > I will tweak my policy to make it run sendmail in
> > > sendmail_t and nothing else. That's safer than mdadm_t.
> > 
> > Perhaps this is something that should be in default policy - it
> > sounds like a good threat model.
> 
> What should be the domain to transition to upon execution of bin/sbin?
> Rather than using can_exec, I believe it should be:
> domain_auto_trans(mdadm_t, bin_t, that_domain_t)
> domain_auto_trans(mdadm_t, sbin_t, that_domain_t)
> But personally, I'll leave that out and rely on the email notification.
> 
> Antoine
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
