Message-Id: <200207031221.MAA07299@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: IP nfs server in policy/net_contexts
Date: Wed, 3 Jul 2002 14:18:44 +0200
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

in the file policy/net_contexts is follow line:

10.33.1.2 255.255.255.255 system_u:object_r:nfs_t system_u:object_r:nfs_t

I think it is better to comment out this or set it to:

127.0.0.1 255.255.255.255 system_u:object_r:nfs_t system_u:object_r:nfs_t

Or?

Thanks for any comments!

Carsten



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
