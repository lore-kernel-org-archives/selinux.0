Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4LFwtLt008552
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2008 11:58:55 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4LFws3O022370
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2008 15:58:55 GMT
Message-ID: <483446D5.3050300@redhat.com>
Date: Wed, 21 May 2008 11:59:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Suggested global change to policy
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove all init programs calls to
sysadm_dontaudit_list_home_dirs and put that call in the

init_system_domain and init_daemon_domain

That way we can think about making role/sysadm a module.

Of course I believe the /root should have a special context of
admin_home_t and not be affected by whether or not you have sysadm
policy defined.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
