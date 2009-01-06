Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n06L9X3c016749
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 16:09:33 -0500
Message-ID: <4963C88B.10107@tycho.nsa.gov>
Date: Tue, 06 Jan 2009 16:09:31 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Tom London <selinux@gmail.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: "denied null" AVCs from qemu-kvm with latest rawhide policy
References: <4c4ba1530901061046x7145c430p1acd73be3177a4d9@mail.gmail.com>
In-Reply-To: <4c4ba1530901061046x7145c430p1acd73be3177a4d9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tom London wrote:
> Running the latest Fedora rawhide policy packages
> (selinux-policy-targeted-3.6.2-2.fc11.noarch,
> selinux-policy-3.6.2-2.fc11.noarch), I observe the following "null"
> AVCs reported in /var/log/Xorg.0.log:
>   

It's probably a bad security hook callsite.  I'll investigate this.  The
server's operation shouldn't be affected.

Thanks for the report.

>
> (WW) avc:  denied  null for request=X11:MapWindow comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> exaCopyDirty: Pending damage region empty!
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:QueryPointer comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> (WW) avc:  denied  null for request=X11:GetInputFocus comm=qemu-kvm
> xdevice="Virtual core keyboard"
> scontext=unconfined_u:unconfined_r:qemu_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
>
> Doesn't appear that they affect the running process (qemu-kvm, in this case).
>
> What are they and does something need to be adjusted?
>
> Thanks,
>    tom
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
