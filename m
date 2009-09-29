Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8TJsULN026422
	for <selinux@tycho.nsa.gov>; Tue, 29 Sep 2009 15:54:30 -0400
Subject: Configuring libsemanage to invoke a policy checker
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 29 Sep 2009 15:52:47 -0400
Message-Id: <1254253967.2252.232.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This came up as a question at the SELinux summit, so I thought I'd also
post the answer on the list since it is a largely undocumented feature.
If you want libsemanage to invoke a program to check a policy for some
property before allowing it to be installed and loaded, then you can
configure libsemanage as follows.

Add the following lines to your /etc/selinux/semanage.conf file:
[verify kernel]
path = /usr/bin/mypolicychecker
args = $@
[end]

Then create /usr/bin/mypolicychecker, e.g.:
#!/bin/sh
ls -l $1
exit 0

chmod +x /usr/bin/mypolicychecker

Subsequent semodule or semanage commands will trigger its execution,
passing it the path to the kernel policy file in the sandbox before
installing it. If it returns non-zero, the transaction will abort and
roll back.

Obviously you would replace mypolicychecker with an actual program that
applies some set of checks to the policy and exits with an appropriate
error status based on whether the checks passed.

There is also a variant for running a policy checking program on each
individual module ([verify module]) but I'm not sure how useful that
would be.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
