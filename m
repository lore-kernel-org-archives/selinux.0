Message-ID: <42efd069041012162143f7aa9a@mail.gmail.com>
Date: Tue, 12 Oct 2004 16:21:31 -0700
From: Ryan Graham <ryan.graham@gmail.com>
Reply-To: ryan.graham+cr@gmail.com
To: SELinux@tycho.nsa.gov
Subject: vsftpd and chrooted home directories
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, I'm going to throw out an AVC message and part of my config here.
Maybe someone will recognize this.

audit(1097622518.160:0): avc:  denied  { getattr } for  pid=2774
exe=/usr/sbin/vsftpd path=/proc/2774/mounts dev= ino=181796880
scontext=root:system_r:ftpd_t tcontext=root:system_r:ftpd_t
tclass=file

audit(1097622518.174:0): avc:  denied  { search } for  pid=2778
exe=/usr/sbin/vsftpd name=media dev=hda2 ino=5210119
scontext=root:system_r:ftpd_t
tcontext=system_u:object_r:user_home_dir_t tclass=dir

Response:	220 (vsFTPd 1.2.1)
Command:	USER media
Response:	331 Please specify the password.
Command:	PASS *****
Response:	500 OOPS: cannot change directory:/home/media
Error:	Unable to connect!

local_enable=YES
write_enable=YES
local_umask=022
chroot_local_user=YES
pam_service_name=vsftpd
userlist_enable=YES
listen=YES
tcp_wrappers=YES

This all works on an almost identical FC2 box with enforcing off.

Am I being stupid here? Should I go back to the manuals or spam
audit2allow at it?

Thanks,
Ryan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
