Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2VJ1QDo027999
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 14:01:26 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2VIvPTg010746
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 18:57:25 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j2VJ04B9021823
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 14:00:05 -0500 (EST)
Subject: Logrotate, ssh_agent - read selinux_config_t
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 31 Mar 2005 14:06:15 -0500
Message-Id: <1112295975.12948.72.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

logrotate and ssh_agent try to read /etc/selinux/config and fail.
I thought it would be reasonable to allow that, but I see this:

apache_macros.te:dontaudit httpd_$1_script_t selinux_config_t:dir
search;
crontab_macros.te:dontaudit $1_crontab_t selinux_config_t:dir search;
inetd_macros.te:dontaudit $1_t selinux_config_t:dir search;
ssh_agent_macros.te:dontaudit $1_ssh_agent_t selinux_config_t:dir
search;
ssh_macros.te:dontaudit $1_ssh_keysign_t selinux_config_t:dir search;
xserver_macros.te:dontaudit $1_xserver_t selinux_config_t:dir search;

Why?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
