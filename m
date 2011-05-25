From: Harry Ciao <qingtao.cao@windriver.com>
To: <sds@tycho.nsa.gov>, <jmorris@namei.org>, <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: SELinux: Fix arguments when expanding user_datum_t.roles
Date: Wed, 25 May 2011 17:26:08 +0800
Message-ID: <1306315569-5432-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,

When expanding the role_set_t used in user_datum_t or role_allow and
role_transition rules, the pointer to the policydb_t of the out module
should always be used, I guess when user_copy_callback() invokes
role_set_expand(), the pointer to the policydb_t of the base module
is mistakenly passed.

Thanks,
Harry

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
