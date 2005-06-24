Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OI0ugA008708
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 14:00:56 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OI0J2B029121
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 18:00:20 GMT
Subject: Re: mdadm policy
From: antoine <antoine@nagafix.co.uk>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>, walters@redhat.com
In-Reply-To: <1119635200.31852.16.camel@celtics.boston.redhat.com>
References: <1119569243.9390.77.camel@localhost>
	 <1119577846.20101.26.camel@localhost.localdomain>
	 <1119605711.9645.28.camel@localhost>
	 <1119627684.30464.8.camel@celtics.boston.redhat.com>
	 <1119630905.9645.37.camel@localhost>
	 <1119635200.31852.16.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 19:02:40 +0100
Message-Id: <1119636160.9645.46.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 13:46 -0400, Ivan Gyurdiev wrote:
> > Well that's no comfort at all, mdadm_t domain has the ability to access
> > raw disks and send mail... That's worrying enough.
> 
> I don't see anything about sending mail, but perhaps
> I'm not looking hard enough. You're talking about adding this
> privilege?
Sorry, sending mail is not actually a function of mdadm (in code), it is
just a configuration option that pipes to sendmail:

>From the man page:

MAILADDR
The mailaddr line gives an E-mail address that alerts should be sent to
when is running in --monitor mode (and was given the --scan option).
There  should  only be one MAILADDR line and it should have only one
address.

PROGRAM
The  program  line  gives the name of a program to be run when mdadm
--monitor detects potentially interesting events on any of the arrays
that it is monitoring.
This program gets run with two or three arguments, they being the Event,
the md device, and possibly the related component device.
There should only be one program line and it should be give only one
program.


So it looks to me like the transition to sendmail should always be
included - well actually, ifdef(mta.te).

> > # RAID block device access
> > allow mdadm_t fixed_disk_device_t:blk_file create_file_perms;
> 
> hmm..yes..
> 
> Well, in this case, mdadm_t is the trusted domain,
> and you *want* to transition it to other domains upon execution
> of something that you don't trust.
> 
> So yes, if  you want want to send mail, you would add 
> a transition like this:
> domain_auto_trans(mdadm_t, sendmail_exec_t, sendmail_t (or whatever..))
> 
> What is this PROGRAM configurable option - can you describe in more 
> detail. I don't know anything about mdadm.
> 
> > I will tweak my policy to make it run sendmail in
> > sendmail_t and nothing else. That's safer than mdadm_t.
> 
> Perhaps this is something that should be in default policy - it
> sounds like a good threat model.

What should be the domain to transition to upon execution of bin/sbin?
Rather than using can_exec, I believe it should be:
domain_auto_trans(mdadm_t, bin_t, that_domain_t)
domain_auto_trans(mdadm_t, sbin_t, that_domain_t)
But personally, I'll leave that out and rely on the email notification.

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
