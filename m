Message-ID: <4239F161.8030403@redhat.com>
Date: Thu, 17 Mar 2005 16:06:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Need functions to manipulare users file.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen we want to build a patch to either libselinux or libsepol or a 
third library to manipulate the local.users file.

Basically useradd, usermod, userdel and freinds need to call

selinux_adduser(dwalsh, staff_r, sysadm_r, ...)
selinux_deluser(dwalsh)
selinux_moduser(dwalsh, user_r, ...)

Do you think this belongs to libgenpol or libselinux or some third 
libary, like tresys has this.

Basically libgenpol understands the file format and libselinux 
understands the way selinux
is installed. 

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
