Message-ID: <48FDDFBB.8020005@redhat.com>
Date: Tue, 21 Oct 2008 09:57:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> This is a request for comments on the initial prototype release of sVirt, 
> a project to add security labeling support to Linux-based virtualization.
> 
> Project page: 
>   http://www.selinuxproject.org/page/SVirt
> 
> Previous libvirt discussions:
> 
>   High-level requirements:
>     https://www.redhat.com/archives/libvir-list/2008-August/msg00255.html
> 
>   XML security labels:
>     https://www.redhat.com/archives/libvir-list/2008-August/msg00740.html
> 
> A patch for libvirt is attached; and also included in a release tarball at 
> http://namei.org/svirt/.  See 'readme.txt' there for more details on 
> building and running the code.
> 
> The purpose of this release is to establish a proof of concept of applying 
> security labels to VMs, and for discussion of the underlying technical 
> approach.
> 
> With this release, it is possible to define a security label for a 
> kvm/qemu domain in its XML configuration ('virsh edit'), launch the domain 
> and have it transition to the specified security label ('virsh start'), 
> then query the security label of the running domain ('virsh dominfo').
> 
> The following changes were made to libvirt:
> 
> 1. Implementing a pluggable security label driver framework;
> 
> 2. Implementing an SELinux security label driver for (1);
> 
> 3. Wiring the security label framework into the Qemu driver;
> 
> 4. Implementing basic libvirt API calls for initializing the driver, 
>    and getting/setting domain security labels;
> 
> 5. Extending the domain XML configuration to include security labels;
> 
> 6. Adding domain security label display/edit/dump support to virsh.
> 
> One of the design principles I've followed with this is to reduce or 
> eliminate configuration wherever possible.  If a variety of security 
> labeling drivers are present, libvirtd automatically detects which one to 
> enable and enables it.  e.g. if SELinux is enabled on the system, the 
> SELinux labeling driver is enabled automatically when livbirtd starts.
> 
> Another is to treat security labels as opaque unless they're actually 
> being used for security purposes (e.g. to launch the domain).  So, virsh 
> and the domain configuration code currently do not need to semantically 
> interpet security labels, just understand their format.  This should suit 
> the initial simple goal of isolated domains, which only requires security 
> labels to be distinct.
> 
> The domain security label configuration format is as follows:
> 
> # virsh dumpxml sys1
> <domain>
>     ....
>   <seclabel model='selinux'>
>     <label>system_u:system_r:virtd_t:s0</label>
>     <policytype>targeted</policytype>
>   </seclabel>
> </domain>
> 
> It's possible to query the security label of a running domain via virsh:
> 
> # virsh dominfo sys1
> Id:             1
> Name:           sys1
> UUID:           fa3c8e06-0877-2a08-06fd-f2479b7bacb4
> OS Type:        hvm
> State:          running
> CPU(s):         1
> CPU time:       11.4s
> Max memory:     524288 kB
> Used memory:    524288 kB
> Autostart:      disable
> Security label: system_u:system_r:virtd_t:s0 (selinux/targeted/enforcing)
> 
> The security label is deterimed via the new virDomainGetSecLabel() API 
> method, which is transported over RPC to the backend driver (qemu in this 
> case), and is entirely independent of the local security model, if any.  
> e.g. this command could be run remotely from an entirely different 
> platform: you just see what's happening on the remote system, as with 
> other attributes of the domain.
> 
> Feedback on the design thus far is sought before proceeding to more 
> comprehensive integration.
> 
> In particular, I'd be interested in any thoughts on the placement of the 
> security labeling driver within libvirt, as this seems to be the most 
> critical architectural issue (I've already refactored this aspect once).  
> 
> Currently, the idea is to attach the security labeling driver to the virt 
> driver, rather than implement it independently as a top-level component as 
> in the case of other types of drivers (e.g. storage).  This is because 
> process-based security labeling is highly dependent on the kind of 
> virtualization in use, and may not make sense at all in some cases (e.g. 
> when using a non-Linux hypervisor, or containers).
> 
> In the case of qemu, a security labeling driver is added to qemud:
> 
> @@ -63,6 +64,7 @@ struct qemud_driver {
>      char *vncListen;
>  
>      virCapsPtr caps;
> +    virSecLabelDriverPtr secLabelDriver;
>  };
> 
> and then initialized during qemud startup from qemudSecLabelInit().  
> 
> During initialization, any available security labeling drivers are probed, 
> and the first one which thinks it should be used is installed. Top-level 
> libvirt API calls are then dispatched to the active security labeling 
> driver via the backend virt driver, as necessary.
> 
> Note that the security labeling framework in this release is always 
> built-in -- it can be made a compile-time option later if desired.
> 
> Requirements not yet addressed include:
> - Labeling of resources and generally comprehensive labeling management
> - Automatic labeling (e.g. for the simple isolation use-case)
> - Integration of labeling support into higher-level management tools such 
>   as virt-manager
> - Integration with the audit subsystem to help with administration and 
>   debugging
> - Domain of interpretation (DOI) checking/translation
> - Python bindings
> 
> As mentioned, the goal at this stage is to get feedback on the underlying 
> design: comments welcome!
> 
> 
> - James
> 
Why do we care about the policy type?  Policy type is a fairly
meaningless object.  If you are trying to figure out if the host machine
is valid to run a virtual machine you should just check whether the type
is valid on the machine,  That way if I define minimum policy with virt
support on one host and targeted policy with virt support on another
machine, both would work.  Finally I think it might be ok for the
administrator to request that this virtual machine would only run on a
machine with SELinux in enforcing mode. For example if you had a fairly
untrusted virtual machine you would want to ensure that the machine was
enforcing SELinux before it got started.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
