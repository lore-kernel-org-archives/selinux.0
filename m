Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o178C7e8026956
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 03:12:07 -0500
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o178CDW6020717
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 08:12:13 GMT
Received: by wwc33 with SMTP id 33so1154950wwc.12
        for <selinux@tycho.nsa.gov>; Sun, 07 Feb 2010 00:12:04 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 7 Feb 2010 09:12:04 +0100
Message-ID: <bf30b281002070012q1d9a33ffsc90781d217e05f9b@mail.gmail.com>
Subject: Selinux in enforcing mode prevent network interface to be configured
	at boot for Debian stable ( 5.0)
From: Elko Kuric <elkokuric@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I decided to move my debian installation to use Selinux, and I
installed it using

http://wiki.debian.org/SELinux  howto ( Debian 5 )


When Selinux is in "permissive" mode, network connection is up and it works
but when I switch Selinux to "enforcing" mode network interface is
down after reboot.

seaudit-report report the following output:

Feb 07 08:36:58 firewall kernel: avc: denied pid=1290 comm=ifup
name=ifstate ino=4103 dev=hda1 \
scontext=system_u:system_r:udev_t
tcontext=system_u:object_r:etc_runtime_t tclass=file

Feb 07 08:36:58 firewall kernel: avc: denied pid=1297 comm=ifup
name=ifstate ino=4103 dev=hda1 \
scontext=system_u:system_r:udev_t
tcontext=system_u:object_r:etc_runtime_t tclass=file

I can understand that selinux is preventing ifup to be executed, but I
still do not have counterpart in debian
for RedHat's

sealert -a audit.log

, where it suggest what is necessary to do in order to allow access.

I can bring interface up when logged as rood and using "ifconfig "

Any comment is welcome and thank you in advance,

Regards,

Elko

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
