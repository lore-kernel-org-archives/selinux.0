Message-Id: <20080103184331.485176161@tresys.com>
Date: Thu, 03 Jan 2008 13:43:31 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: method@madmethod.com, sds@tycho.nsa.gov
Subject: [patch 0/7] quiet gcc warnings
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These patches fix a number of gcc warnings in the selinux userland
build process.  They allow everything but libsemanage to build with
-Werror.  The only thing in the way of libsemanage using -Werror is the
flex-generated scanner.  We could just drop a few of the -W flags for
libsemanage (like -Wundef) to make it pass.

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
