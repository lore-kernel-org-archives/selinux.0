Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6HevU9005891
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 12:40:57 -0500
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6HeAiG011909
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 17:40:11 GMT
Message-Id: <20061106173814.457967976@tresys.com>>
Date: Mon, 06 Nov 2006 12:38:14 -0500
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/4] SELinux: Validate kernel object classes and permissions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Resending updated patchset to address concerns of Steve and James.

This replaces the object class and permission validation code in the SELinux security server. The current code validates that the object classes and permissions have not changed between policy loads. This requires a simple reboot to circumvent, and more importantly does not allow for any change in object classes or permissions upon reload (say if a new userspace object manager was added to the system).

The new logic simply verifies the values of object classes and permissions against the kernel headers in security/selinux/include. If a class or permission in the new policy that is defined in the kernel headers does not match the kernel headers, then policy will fail to load. Note that there is no longer any comparison between the old policy and the new policy.

Signed-off-by: Chad Sellers <csellers@tresys.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
