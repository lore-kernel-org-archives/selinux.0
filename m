Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6JEckrT012807
	for <selinux@tycho.nsa.gov>; Mon, 19 Jul 2004 10:38:46 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6JEchF4014280
	for <selinux@tycho.nsa.gov>; Mon, 19 Jul 2004 14:38:44 GMT
Date: Mon, 19 Jul 2004 16:38:57 +0200
From: Erich Schubert <erich@debian.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov, bam@snoopy.apana.org.au
Subject: Re: SELinux Policy patches
Message-ID: <20040719143857.GD13205@wintermute.xmldesign.de>
References: <20040716002210.GA1081@wintermute.xmldesign.de> <200407161234.03434.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407161234.03434.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> > # I also added (don't remember what that was needed for):
> > can_exec(logrotate_t, logrotate_exec_t)
> 
> Can you find out what it is needed for?

For executing /usr/bin/savelog:

denied  { execute_no_trans } for  pid=21289 exe=/bin/dash
path=/usr/bin/savelog dev=sda3 ino=299540
scontext=system_u:system_r:logrotate_t
tcontext=system_u:object_r:logrotate_exec_t tclass=file

I do have some weird behaviour with logrotate OR logcheck on this box:

denied  { search } for  pid=21251 exe=/usr/sbin/logrotate name=selinux
dev=sda3 ino=274182 scontext=system_u:system_r:logrotate_t
tcontext=system_u:object_r:selinux_config_t tclass=dir

denied  { search } for  pid=21251 exe=/usr/sbin/logrotate name=root
dev=sda3 ino=318865 scontext=system_u:system_r:logrotate_t
tcontext=root:object_r:staff_home_dir_t tclass=dir

Seems like some logrotate cron job is doing a "find"?

Also i do get this error message frequently:

denied  { relabelfrom } for  pid=4768 exe=/bin/cp name=checked dev=md0
ino=160726 scontext=system_u:system_r:logrotate_t
tcontext=system_u:object_r:logrotate_tmp_t tclass=file
denied  { relabelto } for  pid=4768 exe=/bin/cp name=checked dev=md0
ino=160726 scontext=system_u:system_r:logrotate_t
tcontext=system_u:object_r:logrotate_tmp_t tclass=file

What is happening here?
This appears to be logcheck, which currently is running in the
"logrotate" domain. Has some written a policy for logcheck yet?
OTOH,
/usr/sbin/logcheck      --      system_u:object_r:logrotate_exec_t
appears to be intentional.

Greetings,
Erich Schubert
-- 
    erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C     (o_
           There are only 10 types of people in the world:           //\
           Those who understand binary and those who don't           V_/_
  Wenn zwei gute Freunde sind, die einander kennen, Sonn' und Mond
    begegnen sich, ehe sie sich trennen. --- Clemens von Brentano

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
