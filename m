Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71Jnh8j024453
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 15:49:43 -0400
Received: from web36606.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l71JngpI002838
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 19:49:42 GMT
Date: Wed, 1 Aug 2007 12:49:37 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: security_task_getsecid and selinux_get_task_sid
To: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <82670.92517.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Is there any difference between calls to security_task_getsecid() and
selinux_get_task_sid() with selinux installed? It doesn't look like
there is, but I could be missing something.

Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
