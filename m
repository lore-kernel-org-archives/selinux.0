MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Kernel oops on fc6 with non-mls policy
Date: Thu, 1 Feb 2007 14:58:07 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015887BA64D@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Paul Moore" <paul.moore@hp.com>, "James Morris" <jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There seems to be a kernel oops on non-mls policies with the fc6 kernel.
It appears that netlabel is the culprit but I couldn't immediately track
down the issue, the mls functions all seem to be returning if mls is
disabled. The oops and ksymoops output is available at
http://pastebin.com/872996.

I have seen another that isn't there that happens on unix_stream_connect
and oopses in security_sid_mls_copy->ebitmap_cpy.

Is this a known issue?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
