Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k84FEBg7006177
	for <selinux@tycho.nsa.gov>; Mon, 4 Sep 2006 11:14:11 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k84FDng0029348
	for <selinux@tycho.nsa.gov>; Mon, 4 Sep 2006 15:13:50 GMT
Subject: Re: Latest updates
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44F88DD4.6020804@redhat.com>
References: <44F7358E.4010101@redhat.com>
	 <1157125888.3199.157.camel@sgc.columbia.tresys.com>
	 <44F88DD4.6020804@redhat.com>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 11:15:46 -0400
Message-Id: <1157382946.3199.211.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 15:45 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Thu, 2006-08-31 at 15:16 -0400, Daniel J Walsh wrote:
> >> Fixing some labels to march what actually ends up on disk  see /boot/grub
> >
> > These say /boot/grup; I assume this is a typo.  Also they should be in
> > the files module.

on further review, why does /boot/grub/* need to be boot_runtime_t?
GRUB shouldn't be writing these files.

> >> Please change /opt java line to match what IBM ships
> >>     
> >
> > I'm concerned this is too broad.  Can we get additional, more specific
> > regexes?
> >
> >   
> I went looking for this, and I believe it was placed in a IBM directory, 
> but can not find it right now.
> Also not sure where BEA places there java.

I'm still going to have to drop this.  The more complex regexs we have,
the more likely there will be fc sorting problems.

> >> Lots of domains need term_dontaudit_use_unallocated_ttys for startup 
> >> from a tty.
> >>     
> >
> > Can you clarify this?  I don't know what you mean by "startup from a
> > tty".
> >
> >   
> Log in to console terminals
> 
> ctrl-alt-f1
> 
> restart daemons, generated lots of avc messages when daemons try to talk 
> to tty_device_t. 
> 
> you will see this same pattern on almost all daemons.

Ok, so this is a direct_run_init+targeted issue.  Now it makes sense to
put it back into init_daemon_domain().  I'll take care of that.

> >> NetworkManager wants to ptrace itself
> >
> > I can't reproduce this on my notebook.  Can you look more into this?  It
> > seems highly irregular.
> >   
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=204161

I installed gdb to reproduce this, and I got the ptrace denial but
didn't get a sys_ptrace denial.

> > udev transition to dhcpc
> >   
> It does when networks are plugged in, I believe.

Thats odd, because that sounds like networkmanager's job.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
