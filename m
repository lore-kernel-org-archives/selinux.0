Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0EEKFC6018295
	for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2012 09:20:15 -0500
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q0EEKE0O014503
	for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2012 14:20:14 GMT
Received: by eaah10 with SMTP id h10so579881eaa.12
        for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2012 06:20:13 -0800 (PST)
Date: Sat, 14 Jan 2012 15:20:02 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: SELinux with initramfs
Message-ID: <20120114142001.GA5632@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi guys,

I'm trying to get a system to boot up with initramfs (without the initramfs
all things work just fine, but we need to get initramfs supported) with
SELinux running in enforcing mode, and without relying on unconfined
domains.

However, it looks to be quite challenging. 

An initramfs' /init will run in the kernel_t domain (and unconfined until
load_policy is called ?) but does quite a lot of activities before it can
even call load_policy (get /dev in shape, including starting udev, mounting
root file system, etc.) because load_policy needs access to the policy.26
file on the root file system.

But because all of this, udev doesn't run in the proper domain (also in
kernel_t), device entries are wrongly labeled (and relabeling fails because
kernel_t does not have relabel privileges) and the system just doesn't want
to boot.

Is it correct to say that load_policy should occur as soon as possible (even
before udev starts)? If so, does that mean than a SELinux-supporting
initramfs should actually include the policy.26 file in the initramfs?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
