Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA06674
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 08:28:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA00289
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 12:27:38 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id MAA00285 for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 12:27:38 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524375@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'f980215'" <f980215@mailandnews.com>, selinux@tycho.nsa.gov
Subject: RE: help: about boot message
Date: Tue, 30 Apr 2002 07:29:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Are you using a initrd ?


> 
> * display on tty? console
>   ===============
>   INIT: Id "3" respawning too fast: disabled for 5 minutes
> 
> * /var/log/messages
>   =================
>   Apr 28 16:13:57 sea2 kernel:
>   Apr 28 16:13:57 sea2 /sbin/mingetty[892]: /dev/tty2: 
> Permission denied
>   Apr 28 16:13:57 sea2 kernel: avc:  denied  { setattr } for  
> pid=881 exe=/sbin/mingetty path=/dev/tty3 dev=03:43 ino=36350 
> scontext=system_u:system_r:getty_t 
> tcontext=system_u:object_r:file_t tclass=chr_file

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
