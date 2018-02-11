Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1BAkDEW011683
 for <selinux@tycho.nsa.gov>; Sun, 11 Feb 2018 05:46:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 3zfQSz198pz2NjRT
 for <selinux@tycho.nsa.gov>; Sun, 11 Feb 2018 10:46:11 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 3zfQSz0CBsz2NhM8
 for <selinux@tycho.nsa.gov>; Sun, 11 Feb 2018 10:46:11 +0000 (UTC)
Reply-To: dwalsh@redhat.com
To: Matt Callaway <matt.callaway@gmail.com>
Cc: selinux@tycho.nsa.gov
References: <CALWSt-Q3Vcn1Vz9Huj_VJjQaBumdxET6s5L7YpUwrH9dNm0_PQ@mail.gmail.com>
 <2081d8e4-c999-5d08-0970-a0bdef9d8ae5@redhat.com>
 <CALWSt-S3so=+L8mecfV5n=9fuy+BkZ+Fnt6i+_P2B9Z=AtfKWw@mail.gmail.com>
 <CALWSt-Rsnu6-QULQP4D6kUHVMTW_-cgu9hVv8CkcJZYHN9ZCYg@mail.gmail.com>
From: Daniel Walsh <dwalsh@redhat.com>
Message-ID: <d3cb666d-a2ee-bccf-43e4-aae70a642291@redhat.com>
Date: Sun, 11 Feb 2018 05:46:06 -0500
MIME-Version: 1.0
In-Reply-To: <CALWSt-Rsnu6-QULQP4D6kUHVMTW_-cgu9hVv8CkcJZYHN9ZCYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: Does selinux work with kernel namespaces?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Docker and container runtimes on RHEL7.4 is not fully supported.  We are 
hoping to change that in RHEL7.5

There are lots of updates going into the kernel to allow usernamespace 
to work properly.   It should work with SELinux at that time.


On 02/09/2018 08:50 PM, Matt Callaway wrote:
> Then updating to docker-ce again via the docker instructions:
>
> https://docs.docker.com/install/linux/docker-ce/centos/#set-up-the-repository
>
> Then I get:
>
> [root@localhost ~]# docker run hello-world
> docker: Error response from daemon: OCI runtime create failed:
> container_linux.go:296: starting container process caused
> "process_linux.go:301: running exec setns process for init caused
> \"exit status 40\"": unknown.
>
> Which leads me to:
>
> https://github.com/moby/moby/issues/35336
>
> Which suggests that centos 7.4 doesn't support namespaces with docker,
> but one might be able to test by adding:
>
> namespace.unpriv_enable=1
>
> I add that but still get:
>
> [root@localhost ~]# setenforce 0
> [root@localhost ~]# docker run hello-world
> docker: Error response from daemon: OCI runtime create failed:
> container_linux.go:296: starting container process caused
> "process_linux.go:301: running exec setns process for init caused
> \"exit status 40\"": unknown.
>
> So maybe this just doesn't work yet.
>
>
> On Fri, Feb 9, 2018 at 7:19 PM, Matt Callaway <matt.callaway@gmail.com> wrote:
>> I joined the selinux list and sent the above, but I have not seen it posted.
>>
>> I rebuilt my test system with stock centos 7.4 with the docker that it
>> comes with and the kernel that it comes with. It runs fine before
>> enabling userns-remap:
>>
>> [root@localhost ~]# uname -r
>> 3.10.0-693.17.1.el7.x86_64
>> [root@localhost ~]# cat /etc/redhat-release
>> CentOS Linux release 7.4.1708 (Core)
>> [root@localhost ~]# docker --version
>> Docker version 1.12.6, build 3e8e77d/1.12.6
>> [root@localhost ~]# grep 3.10.0-693.17.1.el7.x86_64 /boot/grub2/grub.cfg
>> menuentry 'CentOS Linux (3.10.0-693.17.1.el7.x86_64) 7 (Core)' --class
>> centos --class gnu-linux --class gnu --class os --unrestricted
>> $menuentry_id_option
>> 'gnulinux-3.10.0-693.11.6.el7.x86_64-advanced-3ac2b526-6c37-46f7-8539-67bc4e55dd49'
>> {
>> linux16 /vmlinuz-3.10.0-693.17.1.el7.x86_64
>> root=/dev/mapper/VolGroup00-LogVol00 ro no_timer_check console=tty0
>> console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 crashkernel=auto
>> rd.lvm.lv=VolGroup00/LogVol00 rd.lvm.lv=VolGroup00/LogVol01 rhgb quiet
>> LANG=en_US.UTF-8 user_namespace.enable=1 namespace.unpriv_enable=1
>> initrd16 /initramfs-3.10.0-693.17.1.el7.x86_64.img
>> [root@localhost ~]# docker run hello-world | head -n2
>>
>> Hello from Docker!
>>
>> Then when I add userns-remap it fails:
>>
>> [root@localhost ~]# cat /etc/docker/daemon.json
>> {
>>    "userns-remap": "default"
>> }
>> [root@localhost ~]# systemctl restart docker
>> [root@localhost ~]# docker run hello-world
>> nsenter: unable to unshare namespaces: Invalid argument
>> container_linux.go:247: starting container process caused
>> "process_linux.go:245: running exec setns process for init caused
>> \"exit status 1\""
>> /usr/bin/docker-current: Error response from daemon: invalid header
>> field value "oci runtime error: container_linux.go:247: starting
>> container process caused \"process_linux.go:245: running exec setns
>> process for init caused \\\"exit status 1\\\"\"\n".
>>
>>
>> This symptom is reported here:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1441993
>>
>> CLOSED INSUFFICIENT_DATA
>>
>> Mr. Walsh commented in that:
>>
>> Daniel Walsh 2017-04-13 09:15:06 EDT
>>
>> "Why would usernamespace be required for this?  You might want to try
>> user namespace with docker-latest, but as of now we don't support user
>> namespace on RHEL."
>>
>> But that was obviously several months ago.
>>
>> Also similar here:
>>
>> https://github.com/moby/moby/issues/25929
>>
>> But that suggests adding:
>>
>> user_namespace.enable=1
>>
>> which I've done already:
>>
>> [root@localhost ~]# grep user_namespace.enable /proc/cmdline
>> BOOT_IMAGE=/vmlinuz-3.10.0-693.17.1.el7.x86_64
>> root=/dev/mapper/VolGroup00-LogVol00 ro no_timer_check console=tty0
>> console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 crashkernel=auto
>> rd.lvm.lv=VolGroup00/LogVol00 rd.lvm.lv=VolGroup00/LogVol01 rhgb quiet
>> LANG=en_US.UTF-8 user_namespace.enable=1 namespace.unpriv_enable=1
>>
>> I feel like this problem must be solved, but it doesn't appear solved
>> with the "stock" system.
>>
>> Thoughts?
>
