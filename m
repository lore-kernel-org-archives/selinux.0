Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJCLfRb017476
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 07:21:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAJCLeqY026796
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 12:21:40 GMT
Received: from smtp01.net-yan.com (smtp01.net-yan.com [210.0.255.210])
        by jazzband.ncsc.mil  with ESMTP id hAJCLZ0o026776 for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 12:21:39 GMT
Received: from unknown (HELO samgpj2wzuimme) (samwun@hgcbroadband.com@[218.189.140.202])
          (envelope-sender <samwun@hgcbroadband.com>)
          by localhost (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 19 Nov 2003 12:21:29 -0000
From: "samwun" <samwun@hgcbroadband.com>
To: "'SELinux ML'" <selinux@tycho.nsa.gov>
Subject: RE: where to download LSM-patched 2.4 
Date: Wed, 19 Nov 2003 20:23:12 +0800
Message-ID: <013601c3ae97$e658a650$5801a8c0@samgpj2wzuimme>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1069238207.1811.11.camel@kola localhost>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear all,

Where can I download LSM-patched 2.4 for lsm-2.4-selinux-2003040709.tgz
kernel source?

Before I used LSM 2.4 selinux source, I encountered problem when I was
trying to install SELinux.
The problem is the SELinux kernel is able to loaded up after a reboot,
but
whenever issuing a command
"ls --context" or whatever other SELinx related command options, it
always
said that the command ooptions needs SELinux kernel to support,  but I
have
verified the /var/log/messages file and uname command telling the
SELinux
kernel is loaded successfully. What could be missing from my
installation?

That's why I decided to use LSM selinux source instead the one from
http://www.nsa.gov/selinux/download.html

I downloaded LSM source from
http://www.hakin9.org/fr/attachments/nr1/materials/selinux/download/

What are the difference between the LSM source with the one from nsa?

Is there any updated document about how to install selinux on kernel
2.4?

Thanks
Sam



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
