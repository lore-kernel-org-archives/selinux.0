Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2B5PhLa022042
	for <selinux@tycho.nsa.gov>; Sun, 11 Mar 2007 00:25:43 -0500
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2B5PgQZ005489
	for <selinux@tycho.nsa.gov>; Sun, 11 Mar 2007 05:25:43 GMT
Received: by ug-out-1314.google.com with SMTP id y2so2145293uge
        for <selinux@tycho.nsa.gov>; Sat, 10 Mar 2007 21:25:42 -0800 (PST)
Message-ID: <e739902b0703102125r205f725bs89242fdf00480662@mail.gmail.com>
Date: Sat, 10 Mar 2007 21:25:41 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Problems with login from serial port.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,

I have been making good progress on my customized policy, but I ran
into a problem that I do not understand.   I changed the type on the
/dev/ttyS0 device file because my larger security goal is to require
user access to the system_t domain to come from the ttyS0 serial port.
 Ignoring the larger security goal for now, I am just trying to
address the avc messages when I login to the system on the ttyS0
serial port.

Here are the relevant parts of my policy:

# ls -lZ /bin/busybox
-r-xr-xr-x    1 system_u:object_r:system_exec_t     259664 Feb 27
00:29 /bin/busybox

# ls -lZ /bin/login
lrwxrwxrwx    1 system_u:object_r:system_t           7 Feb 27 00:43
/bin/login -> busybox

# ls -lZ /dev/ttyS0
crw-------    1 root:object_r:sysadm_tty_device_t    4,  64 Mar 11
04:39 /dev/ttyS0


Here are the avc message I get when I login in permissive mode:

audit(1173587017.702:3): avc:  denied  { relabelfrom } for  pid=199
comm="login" name="ttyS0" dev=hda1 ino=31387
scontext=system_u:system_r:system_t
tcontext=root:object_r:sysadm_tty_device_t tclass=chr_file

audit(1173587017.702:3): avc:  denied  { relabelto } for  pid=199
comm="login" name="ttyS0" dev=hda1 ino=31387
scontext=system_u:system_r:system_t
tcontext=root:object_r:sysadm_tty_device_t tclass=chr_file

audit(1173587017.702:3): arch=40000003 syscall=226 success=yes exit=0
a0=808b040 a1=b7f9f2c7 a2=8090638 a3=22 items=0 ppid=1 pid=199
auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sg
id=0 fsgid=0 tty=ttyS0 comm="login" exe="/bin/busybox"
subj=system_u:system_r:system_t key=(null)



I have the following rule in my policy file (I thought this rule will
have addressed the avc  message):

allow system_t sysadm_tty_device_t:chr_file { read write ioctl getattr
setattr relabelto relabelfrom };


Running the avc messages through audit2allow does not produce anything
I do not already have:

# audit2allow < /root/dmesg
allow system_t sysadm_tty_device_t:chr_file { relabelfrom relabelto };


It seems that I am missing an avc message, but I can not figure out
what it would be.  I have reviewed my policy and removed all the
dontaudit messages.   I am also in the process of reviewing the
standard refpolicy modules that deal with login and serial ports.

I just really curious what I am missing and why when I apply the
suggested fixes to allow the action, I am still receiving the avc
messages.   Any thoughts or ideas on how to solve this would be
greatly appreciated!

Thanks,

- Ryan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
