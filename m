Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01061
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 13:04:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA05334
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 17:04:15 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
	by jazzswing.ncsc.mil  with ESMTP id RAA05330
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 17:04:14 GMT
Subject: RedHat 7.3, 2 May 2002 Release of SELinux
From: Justin Smith <jsmith@mcs.drexel.edu>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 21 May 2002 13:01:19 -0400
Message-Id: <1022000479.5302.6.camel@vorpal.mcs.drexel.edu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've noticed that this distribution runs XFree86 and X rather than
XWrapper, so one must modify the xserver.fc slightly to

/dev/agpgart                    system_u:object_r:agp_device_t
/dev/dri(|/.*)                  system_u:object_r:dri_device_t
/tmp/.X11-unix(|/.*)            system_u:object_r:user_xserver_tmp_t
/tmp/.X0-lock                   system_u:object_r:user_xserver_tmp_t
/usr/X11R6/bin/Xwrapper         system_u:object_r:xserver_exec_t
/usr/X11R6/bin/X                system_u:object_r:xserver_exec_t
/usr/X11R6/bin/XFree86          system_u:object_r:xserver_exec_t
/var/log/XFree86.*              system_u:object_r:xserver_var_log_t


Kudos to the SELinux development group! The 2 May release is much easier
to reconfigure (with its decentralized roles and file contexts).

-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
