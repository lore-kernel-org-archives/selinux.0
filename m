Message-Id: <20070521095414.832619201@tresys.com>
Date: Mon, 21 May 2007 05:54:14 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: [patch 0/3] genhomedircon replacement in libsemanage
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This replaces genhomedircon with equivalent functionality in libsemanage. The homedir_template is also no longer installed, this leaves some unused path functions in libselinux but removing those would break the ABI. 

This does the same things that genhomedircon did though some seemed strange, like removing /sbin/nologin from the list of valid shells, presumably to keep ftp users and such from getting file contexts generated for them, I'm not sure how valid the assumption is but we didn't want to change the functionality of genhomedircon in this patch set.

The first patch adds genhomedircon.c to libsemanage and calls it from the semanage_store.c and removes the prior call to genhomedircon.

The second patch is a set of tests for the new functions

And the third patch removes the old genhomedircon script.


Signed-Off-By: Joshua Brindle <jbrindle@tresys.com>

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
