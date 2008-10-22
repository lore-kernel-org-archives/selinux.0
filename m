Date: Wed, 22 Oct 2008 21:01:29 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
cc: libvir-list@redhat.com, Daniel Veillard <veillard@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
In-Reply-To: <20081021171722.GP16442@redhat.com>
Message-ID: <alpine.LRH.1.10.0810222052520.19361@tundra.namei.org>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <20081021171722.GP16442@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Oct 2008, Daniel P. Berrange wrote:

> As I mentioned in my reply to Dan Walsh's comments, I thing that the
> policy type & its state (disabled, permissive, enforcing) is really a
> property of the host, rather than the VM, and so should live in the
> host capabilities XML document.

I think we need to differentiate between what the host is capable of 
supporting (e.g. multiple virt schemes with different security models, or 
even emulating/translating other security models), and what the current 
label on the domain actually is.  In the latter case, we need to bind the 
DOI, enforcing state and security model to the domain security label.

> That all makes sense to me - you'll also likely need to expose the
> hypervisor driver's active security driver, to the storage & network
> drivers. For that I reckon extending the 'virDriverPtr' struct to
> add a internal only method
> 
>    virSecLabelDriverPtr (*getSecLabelDriver)(void);
> 
> would be a suitable approach. This would avoid the storage/network
> drivers needing to know about the internal state of the HV driver.

Ok, I need to investigate this further.


> > +typedef struct _virDomainSecLabel {
> > +    char model[VIR_SECLABEL_MODEL_BUFLEN];              /* name of security labeling model */
> > +    char label[VIR_SECLABEL_LABEL_BUFLEN];              /* security label string */
> > +    char policytype[VIR_SECLABEL_POLICYTYPE_BUFLEN];    /* policy type */
> > +    int enforcing;                                      /* 1 if security policy is being enforced for domain */
> > +} virDomainSecLabel;
> 
> The policytype/model would seem redundant here as per-host attributes ?

As mentioned, I think we need to differentiate host capabilities from 
specific security labeling state for a domain on that host.

> I guess since SELinux gained ability to specify that individual security 
> domains are permissive, we do arguably still need an explicit flag 
> 'enforcing' flag here, independantly of the global per-host 'enforcing' 
> vs 'permissive' flag.

Yep.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
