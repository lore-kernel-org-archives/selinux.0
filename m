Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6KBwprT019229
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 07:58:52 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6KBwmYW019189
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 11:58:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: SELinux Policy patches
Date: Tue, 20 Jul 2004 15:25:10 +1000
Cc: selinux@tycho.nsa.gov, bam@snoopy.apana.org.au
References: <20040716002210.GA1081@wintermute.xmldesign.de> <200407161234.03434.russell@coker.com.au> <20040719143857.GD13205@wintermute.xmldesign.de>
In-Reply-To: <20040719143857.GD13205@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407201525.10272.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 Jul 2004 00:38, Erich Schubert <erich@debian.org> wrote:
> Hi,
>
> > > # I also added (don't remember what that was needed for):
> > > can_exec(logrotate_t, logrotate_exec_t)
> >
> > Can you find out what it is needed for?
>
> For executing /usr/bin/savelog:
>
> denied  { execute_no_trans } for  pid=21289 exe=/bin/dash
> path=/usr/bin/savelog dev=sda3 ino=299540
> scontext=system_u:system_r:logrotate_t
> tcontext=system_u:object_r:logrotate_exec_t tclass=file

OK, I've added that to my tree.

> I do have some weird behaviour with logrotate OR logcheck on this box:
>
> denied  { search } for  pid=21251 exe=/usr/sbin/logrotate name=selinux
> dev=sda3 ino=274182 scontext=system_u:system_r:logrotate_t
> tcontext=system_u:object_r:selinux_config_t tclass=dir

I think that we can dontaudit that one, that would be from SE Linux library 
calls.

> denied  { search } for  pid=21251 exe=/usr/sbin/logrotate name=root
> dev=sda3 ino=318865 scontext=system_u:system_r:logrotate_t
> tcontext=root:object_r:staff_home_dir_t tclass=dir
>
> Seems like some logrotate cron job is doing a "find"?

As discussed on IRC that would be from cron setting the current directory to 
the home directory.

> Also i do get this error message frequently:
>
> denied  { relabelfrom } for  pid=4768 exe=/bin/cp name=checked dev=md0
> ino=160726 scontext=system_u:system_r:logrotate_t
> tcontext=system_u:object_r:logrotate_tmp_t tclass=file
> denied  { relabelto } for  pid=4768 exe=/bin/cp name=checked dev=md0
> ino=160726 scontext=system_u:system_r:logrotate_t
> tcontext=system_u:object_r:logrotate_tmp_t tclass=file
>
> What is happening here?

That's a bug in cp.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
