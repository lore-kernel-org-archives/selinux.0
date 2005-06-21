Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5LN87gA012106
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 19:08:07 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5LMwZkw018304
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 22:58:35 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id F0368AEF83
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 23:17:38 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 30606-13 for <selinux@tycho.nsa.gov>;
 Tue, 21 Jun 2005 23:17:36 +0100 (BST)
Received: from [192.168.0.1] (unknown [81.1.93.24])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 1E3F1AEF82
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 23:17:36 +0100 (BST)
Subject: 'name_connect' undefined!
From: antoine <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 23:58:30 +0100
Message-Id: <1119394710.9416.23.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On a x86 box running Gentoo SELinux profile , I cannot 'emerge sync' (in
enforcing mode): I get the following error message:

audit(1119487194.838:0): avc:  denied  { name_connect } for  dest=873
scontext=root:sysadm_r:portage_fetch_t
tcontext=system_u:object_r:rsyncd_port_t tclass=tcp_socket

audit2allow gives me:
allow portage_fetch_t rsyncd_port_t:tcp_socket name_connect;
Which would make sense, except that 'name_connect' is not defined
anywhere! (and therefore I cannot compile the policy with that value)
So I tried allowing connect, name_bind and so on, but the audit message
is still coming up. Where does this 'name_connect' come from if it is
not in my policy source tree? (and how do I fix it)

Why this is not part for the default policy, I do not understand.
portage_fetch_t is the domain used by portage for fetching things via
rsync (and rsync is the main fetch method - webrsync being the other):
domain_auto_trans(portage_t, rsyncd_exec_t, portage_fetch_t)

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
