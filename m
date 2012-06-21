Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5LIEcaI014084
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2012 14:14:38 -0400
Received: from [192.168.1.64] (151.76.17.105) by cp-out7.libero.it (8.5.133)
        id 4FD1BC23024866DC for selinux@tycho.nsa.gov; Thu, 21 Jun 2012 20:14:35 +0200
Message-ID: <1340302475.2992.21.camel@vortex>
Subject: libsepol segmentation fault on policy load (role expansion)
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Date: Thu, 21 Jun 2012 20:14:35 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

It seems that while loading the latest reference policy semodule causes
an assertion failure (NULL new_role) and subsequent segmentation fault
in libsepol/src/expand.c:735 role_fix_callback():

Attempting to install module
'/usr/share/selinux/refpolicy-18062012/zosremote.pp':
Ok: return value of 0.
Committing changes:
new_role = 0xfc4a830
new_role->flavor = 1
libsepol.role_fix_callback: fixing role attribute mount_roles
new_role = 0xfc4a960
new_role->flavor = 1
libsepol.role_fix_callback: fixing role attribute usernetctl_roles
new_role = 0xfc357d0
new_role->flavor = 1
libsepol.role_fix_callback: fixing role attribute sysadm_passwd_roles
new_role = 0xfc36260
new_role->flavor = 1
libsepol.role_fix_callback: fixing role attribute groupadd_roles
new_role = 0xfc36460
new_role->flavor = 1
libsepol.role_fix_callback: fixing role attribute portage_roles
new_role = (nil)

Anyone else also hitting anything similar ?

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
