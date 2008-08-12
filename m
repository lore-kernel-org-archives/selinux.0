Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7CDLBvj021224
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 09:21:11 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7CDKwLC002452
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 13:20:58 GMT
Message-ID: <48A18E29.6050600@redhat.com>
Date: Tue, 12 Aug 2008 09:20:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: "Daniel P. Berrange" <berrange@redhat.com>, libvir-list@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [libvirt] [ANNOUNCE][RFC] sVirt: Integrating SELinux and Linux-based
 virtualization
References: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org> <20080812110803.GI13067@redhat.com> <alpine.LRH.1.10.0808122115240.14171@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0808122115240.14171@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Tue, 12 Aug 2008, Daniel P. Berrange wrote:
> 
>>         Do we instead add the info the udev rules, so when /dev is
>>         populated at boot time by udev the device nodes get the desired
>>         initial labelling ?  Or do we manually  chcon() the device
>>         at the time we boot the VM ?
> 
> Dan Walsh has mentioned wanting to label the device at VM launch so that 
> MCS labels can be dynamically assigned.  This raises some other possible 
> issues such as revoking any existing access (Linux doesn't have general 
> revocation) and having the security of the system depend on whatever is 
> performing the relabel (although we can enforce relabelfrom/relabelto 
> permissions).
> 
> I wonder if existing work/concepts related to MLS device allocation would 
> be useful here.
> 
> See:
> http://sourceforge.net/projects/devallocator/
> 
> 
> - James
The experimenting I have done has been around labeling of the virt_image
and the process with mcs labels to prevent one process from touching
another process/image with a different MCS label.

system_u:system_r:qemu_t:s0:c1 can read/write
system_u:system_r:virt_image_t:s0:c1

But can not read/write system_u:system_r:virt_image_t:s0:c2
or communicate with process system_u:system_r:qemu_t:s0:c2

The idea would be to have libvirt look at the labeling of the image file
and lauch the qemu process with the correct type and  matching MCS label.

So a more advanced image might be labeled
system_u:system_r:virt_image_nonet_t:s0:c1
and libvirt would launch system_u:system_r:qemu_nonet_t:s0:c2

I have not looked into which devices on the host machine might need
higher levels of protection.

In Fedora 9/Rawhide libvirt runs as virtd_t and has a transition rule on
qemu_exec_t to qemu_t.  So all virtual machines run with
system_u:system_r:qemu_t:s0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
