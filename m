Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6UEOHmS021511
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 10:24:17 -0400
Received: from web36605.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l6UEOFJp028753
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 14:24:15 GMT
Date: Mon, 30 Jul 2007 07:24:10 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: selinux_audit_set_callback
To: SELinux List <selinux@tycho.nsa.gov>, Audit List <linux-audit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <160485.79511.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


What is the rationale behind the selinux_audit_set_callback()
mechanism? It looks for all the world as if the selinux code
ought to be able to call the registered function directly.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
