Date: Wed, 22 Oct 2008 20:50:19 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
cc: Daniel J Walsh <dwalsh@redhat.com>, libvir-list@redhat.com,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
In-Reply-To: <20081021162217.GN16442@redhat.com>
Message-ID: <alpine.LRH.1.10.0810222025070.19361@tundra.namei.org>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <48FDDFBB.8020005@redhat.com> <20081021162217.GN16442@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Oct 2008, Daniel P. Berrange wrote:

> I should note that the domain XML format is representative of the config
> for a particular deployment of a virtual machine onto a host. 
> 
> It is not a generic interchange format for 'appliances'. If you were
> distributing an appliance, then the virt-image XML format would be used,
> and this encodes information on pre-requisites for host capabilities. 
> 
> When an appliance is deployed as a virtual domain, the virt-image tool,
> validate the virt-image XML pre-requisites, against the host capabilites
> XML to determine if the host is suitable.

As you mention in a later email, enforcing mode can be set on a 
per-process (domain) basis, so for the case of domain labeling, the 
current enforcing status needs to be bound to the domain.

In terms of migration and provisioning, we need to consider several issues 
in more detail (some perhaps later), e.g.:

- It should be possible to migrate an "isolated" domain between different 
  types of security models if each supports it (e.g. from Smack to 
  SELinux);

- How do we handle different types of virtualization running on the same 
  host, e.g. qemu domains running inside containers?

- Policy for import and export of domains, including translation of 
  labels when imported.

Initially, though, perhaps just stick with the simplest case of listing 
which security models and DOIs are supported, and I think we should stick 
with 'seclabel' rather than introduce 'secpolicy'.

  <host>
     ...
     <seclabel model='selinux'>
       <doi>engineering.example.com.</doi>
       <!-- any other supported DOIs... -->
       <enforcing>yes</enforcing>
     </seclabel>

     <!-- any other active security labeling models ... -->

  </host>




-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
