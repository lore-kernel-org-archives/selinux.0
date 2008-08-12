Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7CEH45V004160
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 10:17:04 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7CEH3dN001118
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 14:17:04 GMT
Message-ID: <48A19B43.4050506@redhat.com>
Date: Tue, 12 Aug 2008 10:16:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Daniel P. Berrange" <berrange@redhat.com>
CC: James Morris <jmorris@namei.org>, libvir-list@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [libvirt] [ANNOUNCE][RFC] sVirt: Integrating SELinux and Linux-based
 virtualization
References: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org> <20080812110803.GI13067@redhat.com> <alpine.LRH.1.10.0808122115240.14171@tundra.namei.org> <48A18E29.6050600@redhat.com> <20080812132513.GN13067@redhat.com> <48A1960F.90301@redhat.com> <20080812140620.GO13067@redhat.com>
In-Reply-To: <20080812140620.GO13067@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel P. Berrange wrote:
> On Tue, Aug 12, 2008 at 09:54:23AM -0400, Daniel J Walsh wrote:
>> Daniel P. Berrange wrote:
>>> On Tue, Aug 12, 2008 at 09:20:41AM -0400, Daniel J Walsh wrote:
>>>> The experimenting I have done has been around labeling of the virt_image
>>>> and the process with mcs labels to prevent one process from touching
>>>> another process/image with a different MCS label.
>>>>
>>>> system_u:system_r:qemu_t:s0:c1 can read/write
>>>> system_u:system_r:virt_image_t:s0:c1
>>>>
>>>> But can not read/write system_u:system_r:virt_image_t:s0:c2
>>>> or communicate with process system_u:system_r:qemu_t:s0:c2
>>>>
>>>> The idea would be to have libvirt look at the labeling of the image file
>>>> and lauch the qemu process with the correct type and  matching MCS label.
>>> That's not going to fly for VMs without disks in the host - either totally
>>> diskless VMs, or VMs using iSCSI/NFS network blockdevices / root FS.
>>>
>>> Daniel
>> We could store the label to run qemu for a particular image in the
>> libvirt database.  But this mechanism would have to match up with the
>> labeling on disk or remote storage.
> 
> Ok, one minor point worth mentioning is that libvirt does not have a
> general purpose database of configurations. The way VM configuration
> is stored is hypervisor-specific. In the Xen/OpenVZ/VMWware case we 
> pass the config straight through to XenD which takes care of persisting
> it.  In QEMU/LXC case we store the XML config files in /etc/libvirt.
> 
>> Or you have rules that state if virtd_t wants to start an image labeled
>> nfs_t it will use qemu_nfs_t
>>
>> You could still use the MCS label to prevent processes from attacking
>> each other, but if the remote storage does not support labelling you
>> will not be able to prevent them from attacking each others image files.
> 
> We don't need to restrict ourselves to a single NFS type qemu_nfs_t/nfs_t.
> A single NFS server can export many directories each of which can be
> mounted with a different context.
> 
Yes and no.  The mountpoint can be labeled differently at the directory
level I believe.  So you would have to store each image in it's own
directory and mount at that level in order for mount -o context to work.

>> I think libvirt being SELinux aware and have it decide which context to
>> run qemu at is the important point.
>>
>> The argument about whether it needs to store the SELinux label in its
>> database or base it off the label of the image can be hashed out later.
> 
> So the important thing is that the label is represented in the libvirt
> XML format, and this XML config is persisted in a manner which is most
> applicable for the virtualization driver in question. While I know James
> wants to target KVM primarily, we need make sure the approach we take 
> doesn't paint ourselves into a corner wrt supporting other virt platforms
> like Xen.
> 
I probably should have used "datastore" rather then database.  Wherever
this data is stored it should be protected as libvirt will be making
security decisions based on the data.  (Of course this is controlled by
kernel policy.  the kernel would prevent virtd_t for execing an
application as sshd_t for example.
> Our guiding rule with libvirt is that for every capability we add, we need
> to come up with a conceptual model that is applicable to all virtualization
> drivers, even if we only implement it for one particular driver.
> 
Isn't libvirt going to be execing q program like qemu_t to run xen
images?  If yes then this should all work with the defined mechanism.
> Daniel


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
