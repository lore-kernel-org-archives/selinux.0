Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5PDtotN001371
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2007 09:55:50 -0400
Received: from neve.di.ubi.pt (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5PDtiZs001239
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2007 13:55:46 GMT
Message-ID: <019b01c7b72f$bad00790$fd01000a@ubi.pt>
From: "david carvalho" <david@di.ubi.pt>
To: "James Antill" <jantill@redhat.com>, <selinux@tycho.nsa.gov>
References: <078701c7b4dd$009d7640$fd01000a@ubi.pt> <1182526262.31779.64.camel@code.and.org>
Subject: Re: backups in fedora
Date: Mon, 25 Jun 2007 14:50:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi !
Thanks for the reply.
It doesn't work, though.
I've made a simple backup of /var/www/html, wich contains type
httpd_sys_content_t
attribute, from root's home.

pwd: /root
tar --xattrs -cvf backup.tar /var/www/html

When extracting, the /root/var/www/html files don't have the same attributes
like they used to have under /var/www/html.
So, I can only conclude, once again, that or the attributes aren't being
taken at backup time
or restore time..
Any ideas ?

Thanks
Regards
David


----- Original Message ----- 
From: "James Antill" <jantill@redhat.com>
To: "david carvalho" <david@di.ubi.pt>
Cc: <selinux@tycho.nsa.gov>
Sent: Friday, June 22, 2007 4:31 PM
Subject: Re: backups in fedora



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
