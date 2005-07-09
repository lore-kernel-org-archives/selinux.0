Message-ID: <e8a2934d050709003658d0eda7@mail.gmail.com>
Date: Sat, 9 Jul 2005 13:06:45 +0530
From: Preeti Malakar <preeti.malakar@gmail.com>
Reply-To: Preeti Malakar <preeti.malakar@gmail.com>
To: SELinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: some problem SE Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sir
     I am using Fedora Core 2 with SE Linux enabled .. When I was
working in the text mode (with context as root;sysadm_r:sysadm_t), I
encountered some problems


i)  I found that after every few minutes the tty which is opened is
showing the following message

audit(1120886700.973:0):avc : denied { transition } for pid=3429
exe=/usr/sbin/crond path=/bin/bash dev=sda12 ino=355528
scontext=system_u:system_r:crond_t tcontext=user_u:sysadm_r;sysadm_t
tclass=process

Please tell me why is this message being shown

ii)  While adding a user using #useradd foo , I got the following message...
audit(1120890662.162:0);avc:denied { read write } for pid=11204
exe=/usr/sbin/useradd name=group.lock dev=sda12 ino=604951
scontext=root_sysadm_r:useradd_t
tcontext=system_u:object_r:firstboot_rw_t tclass=file
useradd;error locking group file

I could not add user, please help me


iii) While logging in as user preeti it shows audit(1120887420.309:0)
:avc:denied { read } for pid=3563 exe=/bin/bash name=.bash_profile
dev=sda12 ino=664419 scontext= user_u:user_r:user_t
tcontext=system_u:object_r:home_root_t tclass=file
-bash: /home/preeti/.bash_profile Permission denied
-bash-2.05b$

 
Sir, please tell me what is going on, I cannot understand

-- 
PREETI MALAKAR
M.TECH CSE 2nd YR
IIT GUWAHTI


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
