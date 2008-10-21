Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9UCZmth012015
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 08:35:48 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9UCZmXV000653
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 12:35:48 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2) with ESMTP id m9UCZjn7021175
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 08:35:45 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2/Submit) id m9UCZj9H021173
	for selinux@tycho.nsa.gov; Thu, 30 Oct 2008 08:35:45 -0400
Date: Tue, 21 Oct 2008 18:17:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: libvir-list@redhat.com, Daniel Veillard <veillard@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
Message-ID: <20081021171722.GP16442@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 21, 2008 at 01:06:17PM +1100, James Morris wrote:
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

As I mentioned in my reply to Dan Walsh's comments, I thing that the
policy type & its state (disabled, permissive, enforcing) is really a
property of the host, rather than the VM, and so should live in the
host capabilities XML document.

> Currently, the idea is to attach the security labeling driver to the virt 
> driver, rather than implement it independently as a top-level component as 
> in the case of other types of drivers (e.g. storage).  This is because 
> process-based security labeling is highly dependent on the kind of 
> virtualization in use, and may not make sense at all in some cases (e.g. 
> when using a non-Linux hypervisor, or containers).

Makes sense - the choice of hypervisor driver in libvirt determines
what security model has to be applied to the storage/network sub-drivers
in libvirt. So, eg if we activate Xen backend, we need to have an XSM
based implementation for the security model of both the Xen driver
and the storage backend.

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

That all makes sense to me - you'll also likely need to expose the
hypervisor driver's active security driver, to the storage & network
drivers. For that I reckon extending the 'virDriverPtr' struct to
add a internal only method

   virSecLabelDriverPtr (*getSecLabelDriver)(void);

would be a suitable approach. This would avoid the storage/network
drivers needing to know about the internal state of the HV driver.

> Note that the security labeling framework in this release is always 
> built-in -- it can be made a compile-time option later if desired.

As long as we can turn off the specific security model backends
that is sufficient - no need to be able to turn off the entire
security framework within libvirt - assuming of course everything
handles a 'NULL' secLabelDriver.

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

Looking at it from a libvirt architecture POV, i think its all basically
a sane approach. It appears, so far, to be generic enough that we could 
plug into an alternate XSM based impl for the Xen world, or delegate
to whatever APIs something like VMWare / Hyper-V might provide.

> diff --git a/include/libvirt/libvirt.h b/include/libvirt/libvirt.h
> index 35b80d0..58ded58 100644
> --- a/include/libvirt/libvirt.h
> +++ b/include/libvirt/libvirt.h
> @@ -111,6 +111,53 @@ typedef enum {
>  } virDomainCreateFlags;
>  
>  /**
> + * VIR_SECLABEL_LABEL_BUFLEN:
> + *
> + * Macro providing the maximum length of the virDomainSecLabel
> + * label string.  Note that this value is based on that used
> + * by Labeled NFS.
> + */
> +#define VIR_SECLABEL_LABEL_BUFLEN (4096 + 1)
> +
> +/**
> + * VIR_SECLABEL_MODEL_BUFLEN:
> + *
> + * Macro providing the maximum length of the virDomainSecLabel
> + * model string.
> + */
> +#define VIR_SECLABEL_MODEL_BUFLEN (256 + 1)
> +
> +/**
> + * VIR_SECLABEL_POLICYTYPE_BUFLEN:
> + *
> + * Macro providing the maximum length of the virDomainSecLabel
> + * policy string.
> + */
> +#define VIR_SECLABEL_POLICYTYPE_BUFLEN (256 + 1)
> +
> +/**
> + * virDomainSecLabel:
> + *
> + * a virDomainSecLabel is a structure filled by virDomainGetSecLabel(),
> + * providing the security label and associated attributes for the specified
> + * domain.
> + *
> + */
> +typedef struct _virDomainSecLabel {
> +    char model[VIR_SECLABEL_MODEL_BUFLEN];              /* name of security labeling model */
> +    char label[VIR_SECLABEL_LABEL_BUFLEN];              /* security label string */
> +    char policytype[VIR_SECLABEL_POLICYTYPE_BUFLEN];    /* policy type */
> +    int enforcing;                                      /* 1 if security policy is being enforced for domain */
> +} virDomainSecLabel;

The policytype/model would seem redundant here as per-host attributes ?

I guess since SELinux gained ability to specify that individual security 
domains are permissive, we do arguably still need an explicit flag 
'enforcing' flag here, independantly of the global per-host 'enforcing' 
vs 'permissive' flag.

Daniel
-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
