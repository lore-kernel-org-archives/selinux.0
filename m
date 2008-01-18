Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0IGf92u012806
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 11:41:09 -0500
Received: from web36610.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m0IGf4hV003929
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 16:41:04 GMT
Date: Fri, 18 Jan 2008 08:40:48 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: selinux_inode_setsecurity and fsetxattr
To: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <377171.19862.qm@web36610.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I was looking in selinux_inode_setsecurity for my own
neffarious purposes and was curious what prevents a program
that has a file open from setting the context on the file
using fsetxattr. I confess that I haven't tried it to see
how it actually behaves.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
