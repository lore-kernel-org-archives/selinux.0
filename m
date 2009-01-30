Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0UNjGuY004064
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2009 18:45:17 -0500
Received: from dmzms99901.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0UNgCmx019365
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2009 23:42:12 GMT
Message-Id: <7b4dai$ejec6@dmzms99901.na.baesystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: filesystem mount AVC denial
Date: Fri, 30 Jan 2009 15:45:10 -0800
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I got the following AVC denial in the audit logs and I'm wondering what
would cause this:

type=AVC msg=audit(1232734163.528:997720):avc: denied { mount } for
pid=28016 comm="find" name="/" dev=0:1c ino=0
scontext=root:staff_r:libstart_t:s0-s4:c0.c255
tcontext=system_u:object_r:nfs_t:s0 tclass=filesystem

The program running in the libstart_t domain is using the "find" cmd,
and find is requiring the "mount" permission. Could this be caused by
"find" traversing into an automounted (NFS) directory? But in that case
I would expect the automount daemon, which is running in the automount_t
domain, to do the mounting.

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
