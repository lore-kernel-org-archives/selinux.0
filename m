Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBLMQZRb019494
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 17:26:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBLMPfjx020368
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 22:25:41 GMT
Received: from zaphod.crypt.gen.nz (218-101-46-111.paradise.net.nz [218.101.46.111])
	by jazzswing.ncsc.mil  with ESMTP id hBLMPeSR020365
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 22:25:41 GMT
Message-ID: <2665.202.27.185.71.1072045590.squirrel@www.crypt.gen.nz>
In-Reply-To: <003201c3c72b$b32c6c60$5d38a8c0@lky>
References: <001e01c3c65f$5849f320$5d38a8c0@lky>
    <1071865851.11143.98.camel@moss-spartans.epoch.ncsc.mil>
    <003201c3c72b$b32c6c60$5d38a8c0@lky>
Date: Mon, 22 Dec 2003 11:26:30 +1300 (NZDT)
Subject: Re: question about remote login
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: "lky" <lky77@sjtu.edu.cn>
Cc: "SELINUX" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

lky said:

>
> Sorry,I think I didn't express my meaning clearly.I just want to stop the
> deny messages on screen but keep them in the log file such as messages.I
> set the log level via the avc_log_level= kernel boot parameter.It did stop
> the display of deny messages but disable the logging as well.Any advice?
> Thanks!
> lky
>

Basically:
echo "7 7 1 7" >/proc/sys/kernel/printk

from http://www.crypt.gen.nz/selinux/faq.html#L.1 :
SELinux sends a lot of messages to the system console by default. This can
be very annoying if you're busy on the console trying to solve some
important problem. The following command will direct all messages of
default priority away from the console. The default is "7 4 1 7". The
second number is the priority of default messages, setting it to 7 makes
default messages of too low a priority to be on the console.
(Credits to Russell for this)


-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
