Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17742
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 14:24:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA24610
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:22:57 GMT
Received: from mail.hallcomp.com (hallcomp.com [208.140.194.52])
        by jazzband.ncsc.mil  with ESMTP id SAA24606 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:22:57 GMT
Subject: Re: sysadm_tty_device_t
From: Timothy Wood <timothy@hallcomp.com>
To: blacknet@simplyaquatics.com
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
In-Reply-To: <00cc01c228f5$d73b6e10$0a01a8c0@ed>
References: <00cc01c228f5$d73b6e10$0a01a8c0@ed>
Content-Type: text/plain; charset=koi8-r
Date: 11 Jul 2002 14:28:26 -0400
Message-Id: <1026412113.2947.10.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

В Чтв, 11.07.2002, в 12:13, Ed Street написал:
> Hello,
> 
> Was working with putting syslog on /dev/tty24 (entry in /etc/syslog.conf
> is 
> *.*	/dev/tty24
> 
> Selinux shows /dev/tty1 as syadm_tty_device_t but /dev/tty24 is just
> tty_device_t.  I started poking around looking for sysadm_tty_device_t
> but not exactly sure what tty's are being set to this.  My question is
> where is the control file, is it /etc/securetty?
> 
> Ed
> 
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

you need to edit the file context for the tty devices.  I think it is in
/usr/src/selinux/policy/file_contexts/dev.fc (I do not have my SE box up
and running at the moment so I do not know for certain.  Can any
acknowledge if that is the right file please).  Now changing it there
will make the change permanent but you still need to either relabel the
file system (do a make relabel from the policy directory) or use chcon
to change just the one device (eg chcon <file_context> /dev/tty24)



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
