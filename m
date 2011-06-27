Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5RFiNUP010049
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2011 11:44:23 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5RFiLBJ019064
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2011 15:44:22 GMT
Received: by wyh22 with SMTP id 22so1625336wyh.12
        for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2011 08:44:21 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 27 Jun 2011 08:44:21 -0700
Message-ID: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com>
Subject: login process unable to execute /bin/sh
From: Sam Gandhi <samgandhi9@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have labelled login and sh as shown below.

-rwxr-xr-x    1     25024 Jun 24 22:20 system_u:object_r:login_exec_t
 /bin/login
-rwxr-xr-x    1          15 Jun 24 18:40 system_u:object_r:bin_t
   /bin/sh

Following is output of ps -Z
      1 system_u:system_r:init_t         S    init
  583 system_u:system_r:local_login_t  S    login -- root

But when I login I see these messages :

Jan  1 10:00:23 192.168.137.1 kernel: type=1400 audit(23.040:40): avc:
 granted  { transition } for  pid=596 comm="getty" path="/bin/login"
dev=ubifs ino=99 scontext=system_u:system_r:initrc_t
tcontext=system_u:system_r:local_login_t tclass=process
Jun 28 01:30:17 192.168.137.1 kernel: type=1400
audit(1309188617.348:46): avc:  denied  { transition } for  pid=833
comm="login" path="/bin/sh" dev=ubifs ino=93
scontext=system_u:system_r:local_login_t
tcontext=root:system_r:initrc_t tclass=process

I do see following statement in policy.conf (monolithic)

allow local_login_t initrc_t:process transition;

Also root is allowed to enter following roles:

user root roles { user_r sysadm_r staff_r system_r };

seusers file looks like this.

system_u:system_u
root:root
diags:diags_u
__default__:user_u

I am using pam for so here are the relevant debug messages from PAM,
in case something is going wrong there.

Jun 28 01:30:17 192.168.137.1 login: pam_selinux(login:session): Open Session
Jun 28 01:30:17 192.168.137.1 login: pam_selinux(login:session):
Username= root SELinux User = root Level= (null)
Jun 28 01:30:17 192.168.137.1 login: pam_selinux(login:session): pam:
default-context=root:system_r:initrc_t
selected-context=root:system_r:initrc_t success 1
Jun 28 01:30:17 192.168.137.1 login: pam_selinux(login:session):
Security Context root:system_r:initrc_t Assigned
Jun 28 01:30:17 192.168.137.1 login: pam_selinux(login:session): set
root security context to root:system_r:initrc_t
Jun 28 01:30:17 192.168.137.1 login: pam_selinux(login:session): Key
Creation Context root:system_r:initrc_t Assigned
Jun 28 01:30:17 192.168.137.1 login: pam_selinux(login:session): set
root key creation context to root:system_r:initrc_t


Can someone PLEASE help me understand why login processes is not being
allowed to transition to /bin/sh and what do I need to do fix this?

Regards,
-Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
