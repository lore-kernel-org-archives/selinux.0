Message-ID: <e8a2934d0507132336220fb171@mail.gmail.com>
Date: Thu, 14 Jul 2005 12:06:29 +0530
From: Preeti Malakar <preeti.malakar@gmail.com>
Reply-To: Preeti Malakar <preeti.malakar@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: id -Z causing some problem
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sir,
 When i am the root and issuing the command id -Z <username> why am i
getting the following message? but SELinux is enabled

[root@pryber /]# id preeti
uid=500(preeti) gid=500(preeti) groups=500(preeti)
[root@pryber /]# id -Z preeti
id: cannot display context when selinux not enabled or when displaying the id
of a different user
[root@pryber /]# cat /selinux/enforce
1




regards
-- 
PREETI MALAKAR
M.TECH 2nd YR CSE
IIT GUWAHATI


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
