Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIULS0001473
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:21 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUKSG027781
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:21 GMT
Message-Id: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:34:55 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 00/33] libsemanage/libsepol object serialization and ps-api
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the majority of the patches from the policy server release a few months ago. This implements object serialization to send objects (eg., booleans, file contexts, etc) across the line to the policy server. It also implements the line protocol to connect to the policy server and the backend for libsemanage so that semodule, semanage, etc will talk to a policy server instead of doing local operations.

The object serialization will also be necessary for the policy representation branch as we will use this infrastructure to serialize the policy tree for module reading and writing.

The only part left for the policy server is the hooks that were implemented in the expander. As the policy representation work is going on and should remove the expander entirely these patches will have to wait until we have enough of the new representation work to implement them there.

This is obviously meant only for trunk and the policyrep branch.

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
