Date: Thu, 30 Oct 2008 18:40:01 +0900
From: Atsushi SAKAI <sakaia@jp.fujitsu.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: libvir-list@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [libvirt] [RFC] sVirt v0.10 - initial prototype
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org>
Message-Id: <20081030094005.29012480001@m024.s.css.fujitsu.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, James

I have a question just for interest.

The security context stores like
/etc/selinux/targeted/contexts/files/file_contexts.

But you are storeing the domain security label on libvirt specific XML.
Of course, this is good for libvirt POV.

Is it permitted for SELinux policy POV?


By the way, I want to see the further discussion of the Requirements.
> Requirements not yet addressed include:

Thanks
Atsushi SAKAI



James Morris <jmorris@namei.org> wrote:

[snip]
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
> -- 
> James Morris
> <jmorris@namei.org>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
