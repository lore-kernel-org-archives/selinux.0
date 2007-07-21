Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6L2n0Oj011378
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 22:49:00 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6L2mxEE003530
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2007 02:48:59 GMT
Received: by wx-out-0506.google.com with SMTP id h30so1060422wxd
        for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 19:48:59 -0700 (PDT)
Date: Fri, 20 Jul 2007 22:48:57 -0400
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
From: David Windsor <dwindsor@gmail.com>
To: James Morris <jmorris@namei.org>, Anthony Liguori <anthony@codemonkey.ws>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>,
        Joshua Brindle <jbrindle@tresys.com>,
        David Windsor <dwindsor@tresys.com>, selinux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <C2C6EC59.36BC%dwindsor@gmail.com>
In-Reply-To: <Line.LNX.4.64.0707201834490.10703@d.namei>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/20/07 6:42 PM, "James Morris" <jmorris@namei.org> wrote:

> On Fri, 20 Jul 2007, Anthony Liguori wrote:
> 
>> James Morris wrote:
>>> On Fri, 20 Jul 2007, Daniel P. Berrange wrote:
>>> 
>>>   
>>>> It could be - if your put the policy at the control API layer instead of
>>>> in QEMU itself.
>>>>     
>>> 
>>> Then you can bypass MAC security by invoking qemu directly.
>>>   
>> 
>> You can bypass MAC security by writing your own binary that uses the KVM
>> kernel interfaces.
> 
> Yep, I was thinking only about qemu.
> 
> I guess you'd have OS policy preventing normal domains from accessing
> /dev/kvm (or /dev/lguest etc.), while a security-aware launcher would
> enforce access control policy over which domains could launch which disk
> images as VMs, and also setup the execution context & fork.
>

Yes, the use case I was targeting was an environment in which access to
/dev/kvm from normal user domains was not permitted.
 
> So, perhaps this would be better done at the libvirt layer (i.e. make
> libvirt the object manager).
>

The more that I think about this, I think that libvirt may indeed be the
correct place for the vm:entrypoint hook.  Rather than have individual
userspace backends be responsible for setting up the correct execution
context and forking, it makes sense for libvirt itself to set up the correct
context for the qemu process prior to launching qemu.  And as Daniel said,
it would allow policy writers to write coherent policy about VMs regardless
of the userspace backend used.

The SELinux specific bits of the patch are still relevant, I think I will
just move the enforcement code to libvirt.

> 
> 
> - James



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
