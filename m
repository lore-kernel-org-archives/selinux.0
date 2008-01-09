MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Policyrep to policydb
Date: Wed, 9 Jan 2008 14:37:12 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880153F4D2@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "SELinux List" <selinux@tycho.nsa.gov>
Cc: "Todd Miller" <tmiller@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So we are at the point where we are trying to create a policydb out of
the tree in policyrep and are wondering what the best approach is:

1) create an API in libsepol that lets us add each kind of object
(symbol, rules, ocontexts, etc). For the sake of comparison this yeilds
14 functions just for symbol tables (symbol_add, role_set_type,
user_set_role, level_set_alias and so on). 

2) Let libpolicyrep statically link against libsepol. This creates much
strangeness such as inconsistencies in the runtime behavior if libsepol
changes on the system but libpolicyrep wasn't rebuilt.

3) (Karls suggestion), remove libsepol entirely and replace the libsepol
api with wrappers in libpolicyrep.

Thoughts?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
