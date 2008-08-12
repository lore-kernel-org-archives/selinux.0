Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7C4G1PQ031820
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 00:16:01 -0400
Received: from smtp103.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7C4Fu41014619
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 04:16:01 GMT
Message-ID: <48A10E79.1090205@schaufler-ca.com>
Date: Mon, 11 Aug 2008 21:15:53 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: libvir-list@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ANNOUNCE][RFC] sVirt: Integrating SELinux and Linux-based virtualization
References: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org> <489FC2F9.7090905@schaufler-ca.com> <alpine.LRH.1.10.0808111824290.5543@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0808111824290.5543@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Sun, 10 Aug 2008, Casey Schaufler wrote:
>
>   
>>> 1.1  Rationale
>>>
>>>     With increased use of virtualization, one security benefit of
>>>     physically separated systems -- strong isolation -- is reduced,
>>>       
>> This issue can always be readily resolved by going back to physically
>> separated hardware. The strength of isolation of a virtual machine
>> mechanism is one of the important characteristics that should be
>> considered when it is chosen over a hardware isolation scheme, but
>> the systems available today appear to do a pretty good job on this,
>> so I would like to see some evidence of this claim before accepting
>> it as a primary premise.
>>     
>
> I suspect you misunderstood an important aspect of this in that we are 
> targeting Linux-based virtualization, where the VMs are running inside 
> Linux processes.  In this case, the isolation depends on DAC in the host, 
> and the idea behind sVirt is to apply MAC security to these VMs and their 
> resources.
>
> Currently, all such VMs run with the same security label, and all of the 
> resources accessed (e.g. disk images) have the same labels.
>
> We are simply proposing a mechanism to allow distinct security labels to 
> be applied to these entities, which in the simplest case, will allow MAC 
> policy to enforce isolation between them.
>   

Well, let's look at the situation and see what sort of risk we're
talking about. A VM running inside a Linux process is subject to the
same kinds of vulnerabilities as any other program too be sure. So
the problem you are looking to address is that the label of the process
is based on the label of the program file. This problem is hardly unique
to VMs, as anyone who wants to run two web servers with different MLS
values will tell you.

> ...
>> You are not going to solve any problems of misconfiguration this way,
>> you are just going to make the environment more complicated and prone
>> to misconfiguration.
>>     
>
> I don't think this is valid as an absolute statement.
>   

You're correct. It is a strong opinion that I hold. My strong
opinions and $4.55 will get you a nice coffee at Peets.

> ...
>>>   
>>>       
>> I can see where someone who is not familiar with VMs might think
>> this is plausible, but looking at the interfaces and separation provided
>> by VMs makes it pretty clear that this isn't even a belts and braces
>> level of extra protection.
>>     
>
> I disagree.
>
> VMs are software, and all software has bugs.  If you can break out of the 
> VM in Linux-based virtualization, you can probably get to all of the other 
> VMs on the system (they are running in the same DAC and MAC contexts).  
>   

Assuming again that you're using program based MAC. A traditional
B&L system where the process retains its label through exec() would
not have this shortcoming.

> Applying distinct labels allows MAC policy to be enforced by the host 
> kernel so that such breaches are contained within the isolated host VM 
> process.
>
> Or are you saying that you don't think hypervisors can be broken out of ?
>   

Not any more than web servers, name servers, or game programs,
many of which don't do particularly well in a program based MAC
environment, either.

>   
>>>       o Increased protection of VM guests from each other in the event
>>>         of host flaws or misconfiguration.  Some protection may also be
>>>         provided against a compromised host.
>>>           
>>>       
>> Flaws and misconfiguration will not be helped by this.
>>     
>
> I don't see why not.  With MAC containment, if, say, a web server on the 
> host was compromised, an attacker may be prevented from interfering with 
> the VMs running on the system.  This is already true to some extent with 
> coarse-grained MAC.
>   

Sure, there are some flaws and misconfigurations that will be caught,
but I would never count on it as a security feature in an environment
that matters.

> ...
>
>> OK, I get the picture. You really want to run VMs under SELinux.
>> Go wild, but I think you are significantly overstating the value
>> and creating a project where a a little bit of policy work ought
>> to handle all but the most extreme cases.
>>     
>
> The proof of concept code is indeed simple policy/labeling changes, 
> although we want to ensure that we fully understand the requirements, and 
> implement a flexible and generally useful scheme.
>
> Support for this also needs to be built directly into the virt toolchain 
> so that the user is provided with a complete solution, rather than a 
> collection of pieces.
>   

How do you envision the Virt toolchain changing to support SELinux?
I confess to being pretty curious about what you think needs to change.

>   
>> DAC, MAC, Containers, VMs, and separate hardware are all mechanisms
>> for providing (in ascending order) measures of isolation. It makes
>> sense to tighten a DAC system by adding MAC, or running a MAC system
>> under a VM, but to each the sort of isolation it is good at.
>>     
>
> So, in the case of a Linux-based VM running as a process in a DAC context, 
> we are indeed tightening a DAC system by adding MAC.
>   

Yeah, you're right there.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
