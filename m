Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1A1K08A032592
 for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2018 20:20:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 3zdYy550dWz62qW
 for <selinux@tycho.nsa.gov>; Sat, 10 Feb 2018 01:19:57 +0000 (UTC)
Received: from UPBD19PA13.eemsg.mil (unknown [192.168.18.15])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 3zdYy53R7Hz63cF
 for <selinux@tycho.nsa.gov>; Sat, 10 Feb 2018 01:19:57 +0000 (UTC)
Received: by mail-lf0-f48.google.com with SMTP id r143so1277610lfr.11
 for <selinux@tycho.nsa.gov>; Fri, 09 Feb 2018 17:19:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2081d8e4-c999-5d08-0970-a0bdef9d8ae5@redhat.com>
References: <CALWSt-Q3Vcn1Vz9Huj_VJjQaBumdxET6s5L7YpUwrH9dNm0_PQ@mail.gmail.com>
 <2081d8e4-c999-5d08-0970-a0bdef9d8ae5@redhat.com>
From: Matt Callaway <matt.callaway@gmail.com>
Date: Fri, 9 Feb 2018 19:19:54 -0600
Message-ID: <CALWSt-S3so=+L8mecfV5n=9fuy+BkZ+Fnt6i+_P2B9Z=AtfKWw@mail.gmail.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Does selinux work with kernel namespaces?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I joined the selinux list and sent the above, but I have not seen it posted.

I rebuilt my test system with stock centos 7.4 with the docker that it
comes with and the kernel that it comes with. It runs fine before
enabling userns-remap:

[root@localhost ~]# uname -r
3.10.0-693.17.1.el7.x86_64
[root@localhost ~]# cat /etc/redhat-release
CentOS Linux release 7.4.1708 (Core)
[root@localhost ~]# docker --version
Docker version 1.12.6, build 3e8e77d/1.12.6
[root@localhost ~]# grep 3.10.0-693.17.1.el7.x86_64 /boot/grub2/grub.cfg
menuentry 'CentOS Linux (3.10.0-693.17.1.el7.x86_64) 7 (Core)' --class
centos --class gnu-linux --class gnu --class os --unrestricted
$menuentry_id_option
'gnulinux-3.10.0-693.11.6.el7.x86_64-advanced-3ac2b526-6c37-46f7-8539-67bc4e55dd49'
{
linux16 /vmlinuz-3.10.0-693.17.1.el7.x86_64
root=/dev/mapper/VolGroup00-LogVol00 ro no_timer_check console=tty0
console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 crashkernel=auto
rd.lvm.lv=VolGroup00/LogVol00 rd.lvm.lv=VolGroup00/LogVol01 rhgb quiet
LANG=en_US.UTF-8 user_namespace.enable=1 namespace.unpriv_enable=1
initrd16 /initramfs-3.10.0-693.17.1.el7.x86_64.img
[root@localhost ~]# docker run hello-world | head -n2

Hello from Docker!

Then when I add userns-remap it fails:

[root@localhost ~]# cat /etc/docker/daemon.json
{
  "userns-remap": "default"
}
[root@localhost ~]# systemctl restart docker
[root@localhost ~]# docker run hello-world
nsenter: unable to unshare namespaces: Invalid argument
container_linux.go:247: starting container process caused
"process_linux.go:245: running exec setns process for init caused
\"exit status 1\""
/usr/bin/docker-current: Error response from daemon: invalid header
field value "oci runtime error: container_linux.go:247: starting
container process caused \"process_linux.go:245: running exec setns
process for init caused \\\"exit status 1\\\"\"\n".


This symptom is reported here:

https://bugzilla.redhat.com/show_bug.cgi?id=1441993

CLOSED INSUFFICIENT_DATA

Mr. Walsh commented in that:

Daniel Walsh 2017-04-13 09:15:06 EDT

"Why would usernamespace be required for this?  You might want to try
user namespace with docker-latest, but as of now we don't support user
namespace on RHEL."

But that was obviously several months ago.

Also similar here:

https://github.com/moby/moby/issues/25929

But that suggests adding:

user_namespace.enable=1

which I've done already:

[root@localhost ~]# grep user_namespace.enable /proc/cmdline
BOOT_IMAGE=/vmlinuz-3.10.0-693.17.1.el7.x86_64
root=/dev/mapper/VolGroup00-LogVol00 ro no_timer_check console=tty0
console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 crashkernel=auto
rd.lvm.lv=VolGroup00/LogVol00 rd.lvm.lv=VolGroup00/LogVol01 rhgb quiet
LANG=en_US.UTF-8 user_namespace.enable=1 namespace.unpriv_enable=1

I feel like this problem must be solved, but it doesn't appear solved
with the "stock" system.

Thoughts?
