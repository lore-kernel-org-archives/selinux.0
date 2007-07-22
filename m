Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6MHd7i7024506
	for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2007 13:39:07 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6MHd68A015471
	for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2007 17:39:06 GMT
Received: by wx-out-0506.google.com with SMTP id h30so1335784wxd
        for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2007 10:39:06 -0700 (PDT)
Date: Sun, 22 Jul 2007 13:39:00 -0400
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
From: David Windsor <dwindsor@gmail.com>
To: Anthony Liguori <anthony@codemonkey.ws>
CC: Avi Kivity <avi@qumranet.com>, kvm-devel <kvm-devel@lists.sourceforge.net>,
        David Windsor <dwindsor@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>
Message-ID: <C2C90E74.36FE%dwindsor@gmail.com>
In-Reply-To: <46A22C37.5030004@codemonkey.ws>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/21/07 11:54 AM, "Anthony Liguori" <anthony@codemonkey.ws> wrote:

> David Windsor wrote:
>> On 7/21/07 2:21 AM, "Avi Kivity" <avi@qumranet.com> wrote:
>> 
>>   
>>> Anthony Liguori wrote:
>>>     
>>>> James Morris wrote:
>>>>   
>>>>       
>>>>> On Fri, 20 Jul 2007, Daniel P. Berrange wrote:
>>>>> 
>>>>>   
>>>>>     
>>>>>         
>>>>>> It could be - if your put the policy at the control API layer instead of
>>>>>> in QEMU itself.
>>>>>>     
>>>>>>       
>>>>>>           
>>>>> Then you can bypass MAC security by invoking qemu directly.
>>>>>   
>>>>>     
>>>>>         
>>>> You can bypass MAC security by writing your own binary that uses the KVM
>>>> kernel interfaces.
>>>> 
>>>>   
>>>>       
>>> I guess modifying qemu makes sense if the modification gives you *more*
>>> permissions.
>>> 
>>> i.e. you start out just with the ability to access the disk image, and
>>> then you transition to a new domain that allows you to access some network.
>>> 
>>> 
>>> Is that what is intended here?
>>>     
>> 
>> The intent here is to provide some mechanism for a policy-driven transition
>> to occur when loading a virtual disk.  So, an administrator would write
>> policy for say, a topsecret_vm_t domain, in which the top secret VM can run.
>> All access requests from this VM would have a source type of topsecret_vm_t
>> on the host machine.  The virtual disk, labeled perhaps as topsecret_disk_t,
>> would need to be authorized in policy to be an entrypoint into the
>> topsecret_vm_t domain.  This patch proposes a mechanism that allows us to
>> provide policy driven controls both over which files can be used as a disk
>> image, and to which domain a qemu process will transition after loading the
>> disk image.  
>>   
> 
> Can you already write an selinux policy that changes the label of a
> process when it open()s a different file?
> 

Yes, technically a process can change its context without executing execve.
However, this is generally considered to be bad from a security perspective,
as domain transitions should always occur at the boundary of an execve,
because of the environmental cleansing that occurs as a result of executing
a new binary.  This type of behavior, the changing of a process' security
context outside of an execve, is called a dynamic transition and violates
various useful security properties, namely label tranquility.  See
http://beyondabstraction.net/2006/04/06/the-environment-environmental-contam
ination-and-selinux-part-1 for more information about how SELinux and the
linux environment interact.

> Regards,
> 
> Anthony Liguori
> 
>> Originally, I thought qemu was the proper place for this type of an
>> enforcement hook, but libvirt may be more appropriate because qemu could be
>> launched with a different security context if loading a virtual disk, rather
>> than having qemu set up the security context of the VM.  Thoughts?
>> 
>> 
>> 
>>   
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
