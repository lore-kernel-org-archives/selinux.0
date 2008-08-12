Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7CDsxsO030755
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 09:54:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7CDsvdN023106
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 13:54:57 GMT
Message-ID: <48A1960F.90301@redhat.com>
Date: Tue, 12 Aug 2008 09:54:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Daniel P. Berrange" <berrange@redhat.com>
CC: James Morris <jmorris@namei.org>, libvir-list@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [libvirt] [ANNOUNCE][RFC] sVirt: Integrating SELinux and Linux-based
 virtualization
References: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org> <20080812110803.GI13067@redhat.com> <alpine.LRH.1.10.0808122115240.14171@tundra.namei.org> <48A18E29.6050600@redhat.com> <20080812132513.GN13067@redhat.com>
In-Reply-To: <20080812132513.GN13067@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel P. Berrange wrote:
> On Tue, Aug 12, 2008 at 09:20:41AM -0400, Daniel J Walsh wrote:
>> James Morris wrote:
>>> On Tue, 12 Aug 2008, Daniel P. Berrange wrote:
>>>
>>>>         Do we instead add the info the udev rules, so when /dev is
>>>>         populated at boot time by udev the device nodes get the desired
>>>>         initial labelling ?  Or do we manually  chcon() the device
>>>>         at the time we boot the VM ?
>>> Dan Walsh has mentioned wanting to label the device at VM launch so that 
>>> MCS labels can be dynamically assigned.  This raises some other possible 
>>> issues such as revoking any existing access (Linux doesn't have general 
>>> revocation) and having the security of the system depend on whatever is 
>>> performing the relabel (although we can enforce relabelfrom/relabelto 
>>> permissions).
>>>
>>> I wonder if existing work/concepts related to MLS device allocation would 
>>> be useful here.
>>>
>>> See:
>>> http://sourceforge.net/projects/devallocator/
>>>
>>>
>>> - James
>> The experimenting I have done has been around labeling of the virt_image
>> and the process with mcs labels to prevent one process from touching
>> another process/image with a different MCS label.
>>
>> system_u:system_r:qemu_t:s0:c1 can read/write
>> system_u:system_r:virt_image_t:s0:c1
>>
>> But can not read/write system_u:system_r:virt_image_t:s0:c2
>> or communicate with process system_u:system_r:qemu_t:s0:c2
>>
>> The idea would be to have libvirt look at the labeling of the image file
>> and lauch the qemu process with the correct type and  matching MCS label.
> 
> That's not going to fly for VMs without disks in the host - either totally
> diskless VMs, or VMs using iSCSI/NFS network blockdevices / root FS.
> 
> Daniel

We could store the label to run qemu for a particular image in the
libvirt database.  But this mechanism would have to match up with the
labeling on disk or remote storage.

system_u:system_r:qemu_nfs_t:s0:c1 can read/write
system_u:system_r:nfs_t:s0

Or you have rules that state if virtd_t wants to start an image labeled
nfs_t it will use qemu_nfs_t

You could still use the MCS label to prevent processes from attacking
each other, but if the remote storage does not support labelling you
will not be able to prevent them from attacking each others image files.

I think libvirt being SELinux aware and have it decide which context to
run qemu at is the important point.

The arguement about whether it needs to store the SELinux label in its
database or base it off the label of the image can be hashed out later.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
