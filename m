Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8FEoHLa013486
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 10:50:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8FEmaLa017932
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 14:48:37 GMT
Date: Mon, 15 Sep 2003 15:50:04 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Problem relabeling journalfile
Message-ID: <20030915145004.GB8988@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've upgraded an ext2 to an ext3 file and while make relabeling
I get an error message:

/usr/sbin/setfiles: unable to relabel /.journal to system_u:object_r:file_t

suggestions?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
