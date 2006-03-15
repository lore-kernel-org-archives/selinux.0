Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2F075O8013844
	for <selinux@tycho.nsa.gov>; Tue, 14 Mar 2006 19:07:05 -0500
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2F073iu014791
	for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2006 00:07:03 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 846A9457F0
	for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2006 00:07:03 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 30244-16 for <selinux@tycho.nsa.gov>;
 Wed, 15 Mar 2006 00:07:02 +0000 (GMT)
Received: from [192.168.0.6] (host-87-74-21-20.bulldogdsl.com [87.74.21.20])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 314B8457EF
	for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2006 00:07:02 +0000 (GMT)
Subject: postfix mysql
From: Antoine Martin <antoine@nagafix.co.uk>
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <439A671E.8040804@redhat.com>
References: <439A671E.8040804@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 00:07:01 +0000
Message-Id: <1142381221.16403.16.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Based on a similar policy update, I guess that what I have been adding
to the postfix policy to enable it to use the mysql backend could be
achieved with a boolean and merged upsteam?


ifdef(`mysqld.te', `
tunable_policy(`postfix_can_network_connect_db',`
can_unix_connect(postfix_smtpd_t, mysqld_t)
allow postfix_smtpd_t mysqld_var_run_t:dir { search };
allow postfix_smtpd_t mysqld_var_run_t:sock_file { write };

can_unix_connect(postfix_pipe_t, mysqld_t)
allow postfix_pipe_t mysqld_var_run_t:dir { search };
allow postfix_pipe_t mysqld_var_run_t:sock_file { write };

can_unix_connect(postfix_master_t, mysqld_t)
allow postfix_master_t mysqld_var_run_t:dir { search };
allow postfix_master_t mysqld_var_run_t:sock_file { write };

can_unix_connect(postfix_cleanup_t, mysqld_t)
allow postfix_cleanup_t mysqld_var_run_t:dir { search };
allow postfix_cleanup_t mysqld_var_run_t:sock_file { write };

can_unix_connect(postfix_postdrop_t, mysqld_t)
allow postfix_postdrop_t mysqld_var_run_t:dir { search };
allow postfix_postdrop_t mysqld_var_run_t:sock_file { write };
')
# Why postfix_cleanup/postdrop needs access to this charset file?
(/usr/share/mysql/charsets/Index)
# beats me:
allow postfix_cleanup_t usr_t:file { getattr read };
allow postfix_postdrop_t usr_t:file { getattr read };
 ')
')


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
