From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com
Cc: selinux@tycho.nsa.gov
Subject: selinux: add object class discovery v2
Date: Wed, 23 May 2007 09:12:05 -0400
Message-Id: <1179925929721-git-send-email-cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support to SELinux for userland to discover object classes and their
permissions.  This patch set adds a class directory to the root of selinuxfs
and a tree of object classes and permissions, with the value for each of the
respective component.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
