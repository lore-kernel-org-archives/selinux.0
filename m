MIME-Version: 1.0
Date: Thu, 23 Aug 2012 19:01:33 -0700
Message-ID: <CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
Subject: sepol help
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am working on a tool for parsing, and allowing overrides to occur in
seapp_contexts. I also want it to check the output selectors against
the compiled binary. After looking at sepol, it wasn't quite clear to
me how to get going with it. Can anyone give me function calls to do
something like this?

1. Load the compiled binary
2. Check to see if a boolean exists

-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
