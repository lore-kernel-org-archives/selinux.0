Message-ID: <48D3B220.1060903@manicmethod.com>
Date: Fri, 19 Sep 2008 10:07:28 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: typebounds lookup from userspace
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For symbol labeling purposes for policy access control we need to be able to look up symbol hierarchy relationships. I expect we'll do this by exporting the symbol hierarchy via selinuxfs. Does anyone have suggestions on what that should look like? Do we want to export additional information on the symbols at the same time?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
