Message-Id: <200208021511.PAA22068@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: file_t or root_t
Date: Fri, 2 Aug 2002 17:12:39 +0200
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all together!

If it not recommend to use file_t, why labelling we all unknown entries 
with it.

Should we change follow lines in policy/file_contexts/types.fc
#
# The security context for all files not otherwise specified.
#
/.*				system_u:object_r:file_t

to

#
# The security context for all files not otherwise specified.
#
/.*				system_u:object_r:root_t

??

Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
