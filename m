Message-ID: <46AF3C5E.8080700@redhat.com>
Date: Tue, 31 Jul 2007 09:42:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Problem with semanage, looks like we don't handle the <<none>> context
 type?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

cat /tmp/test.py
#!/usr/bin/python
from semanage import *
sh = semanage_handle_create()
rc, con = semanage_context_from_string(sh, "<<none>>")
rc,fcontext = semanage_fcontext_create(sh)
semanage_fcontext_set_con(sh, fcontext, con)


# python /tmp/test.py
Segmentation fault


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
