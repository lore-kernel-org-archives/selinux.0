Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n06IkvWe025762
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 13:46:57 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n06IiHMK002860
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 18:44:17 GMT
Received: by nf-out-0910.google.com with SMTP id b21so1253998nfd.4
        for <selinux@tycho.nsa.gov>; Tue, 06 Jan 2009 10:46:54 -0800 (PST)
Message-ID: <4c4ba1530901061046x7145c430p1acd73be3177a4d9@mail.gmail.com>
Date: Tue, 6 Jan 2009 10:46:54 -0800
From: "Tom London" <selinux@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: "denied null" AVCs from qemu-kvm with latest rawhide policy
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Running the latest Fedora rawhide policy packages
(selinux-policy-targeted-3.6.2-2.fc11.noarch,
selinux-policy-3.6.2-2.fc11.noarch), I observe the following "null"
AVCs reported in /var/log/Xorg.0.log:


(WW) avc:  denied  null for request=X11:MapWindow comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
exaCopyDirty: Pending damage region empty!
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:QueryPointer comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
(WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
xdevice="Virtual core keyboard"
scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device

Doesn't appear that they affect the running process (qemu-kvm, in this case).

What are they and does something need to be adjusted?

Thanks,
   tom
-- 
Tom London

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
