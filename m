Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8BE9Csc017850
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 10:09:12 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8BE8N0o026842
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 14:08:23 GMT
Subject: Re: Latest updates
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1157968163.15350.27.camel@wintermute.xmldesign.de>
References: <44F7358E.4010101@redhat.com>
	 <1157125888.3199.157.camel@sgc.columbia.tresys.com>
	 <44F88DD4.6020804@redhat.com>  <1157382946.3199.211.camel@sgc>
	 <1157968163.15350.27.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 10:11:43 -0400
Message-Id: <1157983904.26420.49.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-11 at 11:49 +0200, Erich Schubert wrote:
> Hello Christopher,
> > > >> Lots of domains need term_dontaudit_use_unallocated_ttys for startup 
> > > >> from a tty.
> > > > Can you clarify this?  I don't know what you mean by "startup from a
> > > > tty".
> > Ok, so this is a direct_run_init+targeted issue.  Now it makes sense to
> > put it back into init_daemon_domain().  I'll take care of that.
> 
> I see that a lot on strict policy, too. Strict needs some love.
> 
> denied  { read write } for  pid=10820 comm="logcheck" name="tty"
> dev=tmpfs
> ino=3269 scontext=system_u:system_r:logrotate_t
> tcontext=system_u:object_r:tty_device_t tclass=chr_file

Since the device node is "tty", I assume it refers to /dev/tty, in which
case it is mislabeled.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
