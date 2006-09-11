Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8B9sNw8011345
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 05:54:26 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8B9rv19015508
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 09:53:59 GMT
Subject: Re: Latest updates
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1157382946.3199.211.camel@sgc>
References: <44F7358E.4010101@redhat.com>
	 <1157125888.3199.157.camel@sgc.columbia.tresys.com>
	 <44F88DD4.6020804@redhat.com>  <1157382946.3199.211.camel@sgc>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 11:49:23 +0200
Message-Id: <1157968163.15350.27.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Christopher,
> > >> Lots of domains need term_dontaudit_use_unallocated_ttys for startup 
> > >> from a tty.
> > > Can you clarify this?  I don't know what you mean by "startup from a
> > > tty".
> Ok, so this is a direct_run_init+targeted issue.  Now it makes sense to
> put it back into init_daemon_domain().  I'll take care of that.

I see that a lot on strict policy, too. Strict needs some love.

denied  { read write } for  pid=10820 comm="logcheck" name="tty"
dev=tmpfs
ino=3269 scontext=system_u:system_r:logrotate_t
tcontext=system_u:object_r:tty_device_t tclass=chr_file

denied  { read write } for  pid=18403 comm="sshd" name="tty" dev=tmpfs 
ino=3269 scontext=system_u:system_r:sshd_t
tcontext=system_u:object_r:tty_device_t tclass=chr_file

denied  { read write } for  pid=18403 comm="bash" name="tty" dev=tmpfs 
ino=3269 scontext=erich:user_r:user_t 
tcontext=system_u:object_r:tty_device_t tclass=chr_file

denied  { read write } for  pid=18407 comm="sh" name="tty" dev=tmpfs 
ino=3269 scontext=system_u:system_r:system_crond_t 
tcontext=system_u:object_r:tty_device_t tclass=chr_file

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     Which is worse: ignorance or apathy? Who knows? Who cares?     //\
      Ein Freund ist ein Geschenk, das man sich selbst macht.       V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
