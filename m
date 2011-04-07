From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: SELinux: Initialize process_class earlier
Date: Thu,  7 Apr 2011 14:12:56 +0800
Message-Id: <1302156777-30393-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Thanks Eric for pointing this out!

Fortunately all symtabs would have been read before role_transition rules
are read from the policy image, so we could initialize p->process_class
right after all read_f[] completes so that it could be used to setup
role_trans.tclass when a lower version policy.X is being loaded.

Once we bump p->process_class initializaton code eariler a lower version
policy.X could be successfully loaded.

Cheers,
Harry

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
