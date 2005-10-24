Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9OHRPNs010030
	for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2005 13:27:27 -0400 (EDT)
Received: from mx10.ms.so-net.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9OHNJjX023349
	for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2005 17:23:24 GMT
Received: from admin0 (p29cc21.ykhmac00.ap.so-net.ne.jp [218.41.204.33])
	by mx10.ms.so-net.ne.jp  with SMTP id j9OHNf58007980
	for <selinux@tycho.nsa.gov>; Tue, 25 Oct 2005 02:23:41 +0900 (JST)
Message-ID: <007101c5d8bf$9a571a80$0300a8c0@admin0>
From: "shintarou_fujiwara" <shin216@xf7.so-net.ne.jp>
To: "selinux mailing list" <selinux@tycho.nsa.gov>
Subject: daemon_domain does not work on backup_t ?
Date: Tue, 25 Oct 2005 02:23:08 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, again from Japan.

I had been working on cron job to backup files daily.
I added some lines on backup_t and
backup_t works fairly good.
One day, I somehow changed original backup_t line from domain to 
daemon_domain,
Like this...
#######################
#type backup_t, domain, privlog, auth;
#type backup_exec_t, file_type, sysadmfile, exec_type;
daemon_domain(backup,`,privlog,auth')
###########################################
and I found it didn't work properly.
I got these lines by mail ("/etc/cron.backup/backup" is the backup script).

/usr/bin/run-parts: /etc/cron.backup/backup: /bin/sh: bad interpreter: 
Permission denied

Question:

Why does it not work on daemon_domain and work on domain?

Thank you for your attention.

shintarou_fujiwara 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
