Message-ID: <3D42C94D.8000100@web.de>
Date: Sat, 27 Jul 2002 18:24:45 +0200
From: =?ISO-8859-1?Q?Mark_M=FCller?= <trusted@web.de>
MIME-Version: 1.0
To: SELinux Mailing List <SELinux@tycho.nsa.gov>
Subject: How to make sftp work?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
when I want to use sftp (with a Windows-SSH client) several AVC denied 
messages come:

--------
avc:  denied  { search } for  pid=3303 exe=/usr/sbin/sshd 
path=/usr/lib/ssh dev=08:09 ino=61510 scontext=system_u:system_r:sshd_t 
tcontext=system_u:object_r:sshd_exec_t tclass=dir

avc:  denied  { search } for  pid=3452 exe=/bin/bash path=/usr/lib/ssh 
dev=08:09 ino=61510 scontext=root:user_r:user_t 
tcontext=system_u:object_r:sshd_exec_t tclass=dir

avc:  denied  { getattr } for  pid=3452 exe=/usr/lib/ssh/sftp-server 
path=/root/.bash_history dev=08:09 ino=208 scontext=root:user_r:user_t 
tcontext=system_u:object_r:sysadm_home_t tclass=lnk_file

avc:  denied  { read } for  pid=3452 exe=/usr/lib/ssh/sftp-server 
path=/root/.bash_history dev=08:09 ino=208 scontext=root:user_r:user_t 
tcontext=system_u:object_r:sysadm_home_t tclass=lnk_file
--------

The sftp-server files are on a SuSE 7.3 distro in /usr/lib/ssh. I 
labelled them with sshd_exec_t.

The first AVC message can be solved with:
allow sshd_t sshd_exec_t:dir { search };

but why is bash involved in the second AVC denied message, and how can I 
  use sftp? Am I wrong or does bash in user_t start sftp-server and thus 
sftp-server is placed in the user_t domain?

Did I miss something important in order to work with sftp-server or do I 
have to launch a normal ftp server as there is already a TE 
configuration file?

Thanks in advance,
Mark


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
