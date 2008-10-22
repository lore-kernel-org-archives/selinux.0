Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9UCZmhX012012
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 08:35:48 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9UCYFhH027521
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 12:34:15 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2) with ESMTP id m9UCZjGe021183
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 08:35:45 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2/Submit) id m9UCZj4I021182
	for selinux@tycho.nsa.gov; Thu, 30 Oct 2008 08:35:45 -0400
Date: Wed, 22 Oct 2008 11:03:57 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, libvir-list@redhat.com,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
Message-ID: <20081022100357.GB24340@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <48FDDFBB.8020005@redhat.com> <20081021162217.GN16442@redhat.com> <alpine.LRH.1.10.0810222025070.19361@tundra.namei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.1.10.0810222025070.19361@tundra.namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 22, 2008 at 08:50:19PM +1100, James Morris wrote:
> On Tue, 21 Oct 2008, Daniel P. Berrange wrote:
> 
> > I should note that the domain XML format is representative of the config
> > for a particular deployment of a virtual machine onto a host. 
> > 
> > It is not a generic interchange format for 'appliances'. If you were
> > distributing an appliance, then the virt-image XML format would be used,
> > and this encodes information on pre-requisites for host capabilities. 
> > 
> > When an appliance is deployed as a virtual domain, the virt-image tool,
> > validate the virt-image XML pre-requisites, against the host capabilites
> > XML to determine if the host is suitable.
> 
> As you mention in a later email, enforcing mode can be set on a 
> per-process (domain) basis, so for the case of domain labeling, the 
> current enforcing status needs to be bound to the domain.
> 
> In terms of migration and provisioning, we need to consider several issues 
> in more detail (some perhaps later), e.g.:
> 
> - It should be possible to migrate an "isolated" domain between different 
>   types of security models if each supports it (e.g. from Smack to 
>   SELinux);
> 
> - How do we handle different types of virtualization running on the same 
>   host, e.g. qemu domains running inside containers?

The data in the host capability XML is interpreted wrt the hypervisor 
connection URI you gave to virConnectPtr.

So if you open two libvirt connections, one with qemu:///system and
one with 'xen:///' on the same physical host, it is expected you will
see alternative views of that host. 

As just one example, if you opened 'qemu:///system' on a Xen enabled
host you'd only see a view of the world that covers the hardware 
available to Domain-0. This can be a subset of the hardware seen by
the hypervisor itself. If you opened 'xen:///' then you'd see the
full view.

So, what this means for security models - if you opened 'qemu:///system'
on a Xen enabled host you'd likely see a SELinux security model, whereas
'xen:///' would likely show you an XSM security model.

That said in normal circumstances we don't expect that people will 
use multiple different virtualization technologies within the context
of a single OS instance. You may however see nested virtualization,
eg, a Fedora 9 KVM host, runs a RHEL-5 xen guest, which runs a 
Windows guest.  There are even patches for KVM to let it expose
SVM hardware virt to the guests.

libvirt does not try to track this nesting explicitly - its viewpoint
is always limited to a single hypervisor connection. The intent is
that libvirt provides enough metadata, to allow an external mgmt
application to build up a complete 'world view' of all its data 
center, correlating guests & hosts, primarily via the UUID.

> - Policy for import and export of domains, including translation of 
>   labels when imported.
> 
> Initially, though, perhaps just stick with the simplest case of listing 
> which security models and DOIs are supported, and I think we should stick 
> with 'seclabel' rather than introduce 'secpolicy'.
> 
>   <host>
>      ...
>      <seclabel model='selinux'>
>        <doi>engineering.example.com.</doi>
>        <!-- any other supported DOIs... -->
>        <enforcing>yes</enforcing>
>      </seclabel>
> 
>      <!-- any other active security labeling models ... -->
> 
>   </host>

I think to start with we probably just assume a single security
labelling model per hypervisor connection. If a single host
happened to have multiple models, I believe each model would
likely be scoped to a specific hypervisor on the host.

Regards,
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
