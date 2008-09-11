Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8BLlSxu025099
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 17:47:28 -0400
Received: from hs-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8BLkiKk015017
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 21:46:44 GMT
Received: by hs-out-0708.google.com with SMTP id k27so226772hsc.2
        for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 14:47:28 -0700 (PDT)
Message-ID: <dd18b0c30809111447yb1e1d59n30570e0773ae2cb7@mail.gmail.com>
Date: Thu, 11 Sep 2008 14:47:27 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: setkey ipsec no avc's message
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

when starting ipsec, there is a daemon
or I can run /usr/sbin/setkey. at the moment I've disabled
setkey daemon at boot up, and am using the manual
approach. when issuing setkey -f /etc/ipsec-tools.conf
the file does go into the SDP entry without any issues,
 but also leaves avc's in dmesg. (below);

[  157.919674] type=1415 audit(1221168887.813:5): op=SAD-add
auid=4294967295 ses=4294967295 subj=a-12:sysadm_r:sysadm_t
src=10.0.0.8 dst=10.0.0.5 spi=512(0x200) res=1
[  157.919714] type=1300 audit(1221168887.813:5): arch=40000003
syscall=102 success=yes exit=120 a0=9 a1=bfee55b0 a2=805a6d0 a3=20
items=0 ppid=3830 pid=3916 auid=4294967295 uid=0 gid=0 euid=0 suid=0
fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=4294967295 comm="setkey"
exe="/usr/sbin/setkey" subj=a-12:sysadm_r:sysadm_t key=(null)
[  157.919907] type=1415 audit(1221168887.873:6): op=SAD-add
auid=4294967295 ses=4294967295 subj=a-12:sysadm_r:sysadm_t
src=10.0.0.5 dst=10.0.0.8 spi=768(0x300) res=1
[  157.919936] type=1300 audit(1221168887.873:6): arch=40000003
syscall=102 success=yes exit=120 a0=9 a1=bfee55b0 a2=805a7a0 a3=20
items=0 ppid=3830 pid=3916 auid=4294967295 uid=0 gid=0 euid=0 suid=0
fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=4294967295 comm="setkey"
exe="/usr/sbin/setkey" subj=a-12:sysadm_r:sysadm_t key=(null)
[  157.997476] type=1415 audit(1221168887.873:7): op=SAD-add
auid=4294967295 ses=4294967295 subj=a-12:sysadm_r:sysadm_t
src=10.0.0.8 dst=10.0.0.5 spi=513(0x201) res=1
[  157.997518] type=1300 audit(1221168887.873:7): arch=40000003
syscall=102 success=yes exit=128 a0=9 a1=bfee55b0 a2=805a880 a3=20
items=0 ppid=3830 pid=3916 auid=4294967295 uid=0 gid=0 euid=0 suid=0
fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=4294967295 comm="setkey"
exe="/usr/sbin/setkey" subj=a-12:sysadm_r:sysadm_t key=(null)
[  157.997717] type=1415 audit(1221168887.953:8): op=SAD-add
auid=4294967295 ses=4294967295 subj=a-12:sysadm_r:sysadm_t
src=10.0.0.5 dst=10.0.0.8 spi=769(0x301) res=1
[  157.997745] type=1300 audit(1221168887.953:8): arch=40000003
syscall=102 success=yes exit=128 a0=9 a1=bfee55b0 a2=805a978 a3=20
items=0 ppid=3830 pid=3916 auid=4294967295 uid=0 gid=0 euid=0 suid=0
fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=4294967295 comm="setkey"
exe="/usr/sbin/setkey" subj=a-12:sysadm_r:sysadm_t key=(null)
[  157.997940] type=1415 audit(1221168887.953:9): op=SPD-add
auid=4294967295 ses=4294967295 subj=a-12:sysadm_r:sysadm_t res=1
src=10.0.0.8 dst=10.0.0.5
[  157.997968] type=1300 audit(1221168887.953:9): arch=40000003
syscall=102 success=yes exit=112 a0=9 a1=bfee3550 a2=ffffffff
a3=805ab70 items=0 ppid=3830 pid=3916 auid=4294967295 uid=0 gid=0
euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=4294967295
comm="setkey" exe="/usr/sbin/setkey" subj=a-12:sysadm_r:sysadm_t
key=(null)

When using audit2allow -d
there is a message of: No AVC's found.
Anyways not sure if this is good or bad...
thaught it would be better to post than to not at all.
Besides that ipsec seems to be running nicely, with the policy
in enforcing mode.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
