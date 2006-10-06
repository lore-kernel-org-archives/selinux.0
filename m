Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96KB3Wi007798
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 16:11:03 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96KARru005844
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 20:10:27 GMT
Message-Id: <20061006200951.006196000@tresys.com>>
Date: Fri, 06 Oct 2006 16:09:51 -0400
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/4] Validate kernel object classes and permissions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch replaces the object class and permission validation code in the SELinux security server. The current code validates that the object classes and permissions have not changed between policy loads. This requires a simple reboot to circumvent, and more importantly does not allow for any change in object classes or permissions upon reload (say if a new userspace object manager was added to the system).

The new logic simply verifies the values of object classes and permissions against the kernel headers in security/selinux/include. If a class or permission in the new policy that is defined in the kernel headers does not match the kernel headers, then policy will fail to load. Note that there is no longer any comparison between the old policy and the new policy.

This patch set will soon be followed by patches allowing userspace to query object class and permission values for the running policy, thereby providing full support for adding and modifying object classes and permissions for userspace object managers. However, I wanted to go ahead and send this patch set as it is useful on its own.

Signed-off-by: Chad Sellers <csellers@tresys.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
