Message-ID: <484D91BB.3080904@manicmethod.com>
Date: Mon, 09 Jun 2008 16:25:31 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: releasibility in mcstransd
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am adding releasibility support to mcstransd and just wanted to see if there were any comments or complaints to what I'm planning here.

Rather than adding a generic prefix mechanism like the CMW encodings I did something specific for releasibility, in setrans.conf:

releasibility c100.c128

then encodings look like:

s0:~c100 = rel_US
s0:~c101 = rel_Texas

so a file with s0:c102.c128 would translate to s0:rel_US,rel_Texas.

any comments? Does anyone think this is absolutely the wrong approach?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
