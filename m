Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6AHmpaQ001973
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 13:48:53 -0400
Received: from dmzmta103.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6AHmon6003597
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 17:48:50 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l6AHmCsi016504
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 13:48:12 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l6AHm8Rf031371
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 13:48:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: using newrole to reset the mls level
Date: Tue, 10 Jul 2007 10:48:45 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01FB6D93@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've found that I need to provide the following mls privileges to allow
resetting the mls level with newrole (newrole -l s2)


mls_process_set_level (needed to allow modifying the level)
mls_file_write_down (needed to allow relabeling the tty)
mls_file_read_up (needed to read the tty)
mls_file_upgrade (needed to set a new level for the tty)
mls_file_downgrade (needed to restore tty when exiting newrole)
mls_fd_use_all_levels (needed to allow using the tty fd)

These are a lot of privileges to provide to a domain.

Is there another way to allow newrole to work without having to provide
all of these privileges?

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
