Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5KGfsba000373
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 12:41:54 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5KGfrNo001812
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 16:41:53 GMT
Received: by an-out-0708.google.com with SMTP id d30so319866and.75
        for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 09:41:53 -0700 (PDT)
Message-ID: <dd18b0c30806200941v2491a83ex35a8dd0fd2ba888a@mail.gmail.com>
Date: Fri, 20 Jun 2008 16:41:48 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: allow sysadm_t usb_device_t:chr_file ioctl;
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello; I've been for a while trying to configure my bluetooth apple
mighty mouse to
wakeup properly from suspend. One of the issues that I'm running into
is for some reason the device or kernel
is putting the device into hidd mode, so as a workaround I have to use
upon wakeup hid2hci --tohci to have the mouse properly working.
Now for the SELinux part, when issuing hid2hci  I keep getting  avc's
message i.g. The device keeps changing:"/dev/bus/usb/005/006"
upon wakeup creating a new denial

[  286.306660] type=1400 audit(1213899242.351:4): avc:  denied  {
ioctl } for  pid=3509 comm="hid2hci" path="/dev/bus/usb/005/006"
dev=tmpfs ino=6140 scontext=a-12:sysadm_r:sysadm_t
tcontext=system_u:object_r:usb_device_t tclass=chr_file
[  286.306660] type=1300 audit(1213899242.351:4): arch=40000003
syscall=54 success=yes exit=0 a0=4 a1=40085511 a2=bfd33534 a3=bfd314fe
items=0 ppid=3258 pid=3509 auid=4294967295 uid=0 gid=0 euid=0 suid=0
fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=4294967295 comm="hid2hci"
exe="/usr/sbin/hid2hci" subj=a-12:sysadm_r:sysadm_t key=(null)


Should I keep adding: allow sysadm_t usb_device_t:chr_file ioctl;
until all of the devices are accounted for, or is there another
solution.
Keep in mind this is just a temporary solution for me until I can
figure out how to have the device stay in hci mode upon wakeup.
regards;
-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
