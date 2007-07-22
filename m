Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6MKN2PL030947
	for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2007 16:23:02 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6MKN1nP001804
	for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2007 20:23:01 GMT
Received: by wx-out-0506.google.com with SMTP id h30so1354255wxd
        for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2007 13:23:01 -0700 (PDT)
Date: Sun, 22 Jul 2007 16:22:57 -0400
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
From: David Windsor <dwindsor@gmail.com>
To: Anthony Liguori <anthony@codemonkey.ws>,
        Joshua Brindle <jbrindle@tresys.com>
CC: James Morris <jmorris@namei.org>,
        kvm-devel <kvm-devel@lists.sourceforge.net>,
        David Windsor <dwindsor@tresys.com>, selinux <selinux@tycho.nsa.gov>
Message-ID: <C2C934E1.3709%dwindsor@gmail.com>
In-Reply-To: <46A3AB09.3090800@codemonkey.ws>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/22/07 3:07 PM, "Anthony Liguori" <anthony@codemonkey.ws> wrote:

> Joshua Brindle wrote:
>> James Morris wrote:
>>   
>>> On Sat, 21 Jul 2007, Anthony Liguori wrote:
>>> 
>>>     
>>>> Can you already write an selinux policy that changes the label of a
>>>> process when it open()s a different file?
>>>>       
>>> No, and you normally want to do this over an exec anyway, to
>>> ensure the new execution state is clean.
>>> 
>>>     
>> 
>> This is correct and the object model being proposed isn't just about
>> opening files. 
>> 
>> Anthony - There are several userspace object managers for SELinux,
>> basically they manage resources that are too abstract for the kernel to
>> manage. These include DBUS connections, X windows/pixmaps/cursors/etc,
>> postgresql tables and rows, etc. SELinux is designed to designed to have
>> non-centralized enforcement of the policy (but centralized decision
>> making). In this case the object model isn't just about opening a file,
>> its about lauching and restricting a vm based on an abstract resource,
>> in this case a virtual disk file, that the kernel can't differenciate
>> from any other file.
>> 
>> The reason for this abstraction is simple, think about all the files
>> that qemu has to open that aren't disk files. For example, if you have 3
>> vm's, unclass, secret, top secret, those qemu processes still have to
>> share resources, library files, configuration files, devices,
>> potentially log, pid etc. If someone could manage to get a top secret
>> disk labeled lib_t they could boot any of those vm's with that disk
>> image (using snapshot or some feature to prevent write attempts on it),
>> and disclose top secret data where it shouldn't be disclosed.
>>   
> 
> The only way that the VM could possible see the top secret data is if
> the disk file was readable by the QEMU process running the secret
> guest.  That's the security problem.  You address this "attack" by
> simply not letting the user that launched the QEMU process have read
> access to the top secret disk file.   Why would you ever want to allow
> the QEMU process that's running a "secret" domain to have any read
> access to top secret files?
> 

There will be some cases where VMs of different integrity levels have
file:read permissions in common for certain files, for example, shared
libraries, or other resources which may be explicitly shared.

The vm:entrypoint is similar in nature to the file:entrypoint permission.
For files, only a certain trusted codebase is authorized in policy as an
entrypoint into a certain domain; this codebase is given file:entrypoint
permission wrt the target domain.  Similarly, for virtual machines, it would
be nice to authorize in policy a certain disk image as an entrypoint into a
certain domain.  It would also be nice to have SELinux policy decide which
domain a VM will execute in not only based on the type of the virtual disk,
but on the type of the process loading the virtual disk.  This can be
accomplished using the vm:entrypoint permission and type_transition rules.
If the patch that I posted is moved to libvirt, no modification of qemu is
necessary, and those wishing to use qemu (and likely other userspace
backends later) would just link against libvirt and libselinux.

Thanks,

David Windsor


> Regards,
> 
> Anthony Liguori
> 
>> With David's object model this kind of attack can be prevented because
>> virtual disk files aren't 'just files' to qemu, they are an abstract
>> resource that means more than just a regular file, just like a database
>> file is more than just a regular file for SE-Postgresql.
>> 
>>   
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
