Subject: [RELEASE] Setools version 1.2
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Selinux Dev <selinux-dev@tresys.com>
Content-Type: text/plain
Message-Id: <1076017451.19245.55.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 05 Feb 2004 16:44:12 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Setools version 1.2 has been released. It is available from the Tresys
website:

http://www.tresys.com/selinux/

This version includes the following features:

- Support for the new policy language features in libapol. This   
  includes "-" in type/attribute lists, typealias, and the 
  conditional policy extensions from Tresys. This allows all of the 
  tools to support the latest RedHat policies.

- Support for initial SIDs.

- Realtime log monitoring in seaudit.

- Support for filtering logs without an open policy in seaudit.
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
