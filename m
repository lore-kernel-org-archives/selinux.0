Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l73JrIii016382
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2007 15:53:18 -0400
Received: from web36615.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l73JrHRA001690
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2007 19:53:18 GMT
Date: Fri, 3 Aug 2007 12:53:12 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Scope of SECMARK_MODE_SEL
To: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <593652.90657.qm@web36615.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


It is my assumption that SECMARK_MODE_SEL is defined and coded solely
for use by SELinux and that it is not intended as a general purpose
secmark for any random LSM to use. I assume that if another LSM wants
to use SECMARK that it needs to supply its own SECMARK_MODE value and
checkentry function.

Are my assumptions accurate?

Thank you.

Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
