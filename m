Date: Mon, 15 Dec 2008 11:17:30 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
cc: libvir-list@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt 0.20
In-Reply-To: <20081211205431.GI4604@redhat.com>
Message-ID: <alpine.LRH.1.10.0812151112460.8366@tundra.namei.org>
References: <alpine.LRH.1.10.0812111548490.23768@tundra.namei.org> <20081211205431.GI4604@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 11 Dec 2008, Daniel P. Berrange wrote:


> >   * a virNodeInfo is a structure filled by virNodeGetInfo() and providing
> > @@ -504,6 +567,10 @@ int                     virDomainSetMaxMemory   (virDomainPtr domain,
> >  int                     virDomainSetMemory      (virDomainPtr domain,
> >                                                   unsigned long memory);
> >  int                     virDomainGetMaxVcpus    (virDomainPtr domain);
> > +int                     virDomainGetSecLabel	(virDomainPtr domain,
> > +                                                 virDomainSecLabelPtr seclabel);
> > +int                     virDomainGetSecModel	(virDomainPtr domain,
> > +                                                virDomainSecModelPtr secmodel);
> 
> I'm leaning two ways on this. On the one hand I could see the
> virDomainGetSecModel being done against the node to match the
> fact that we record it in the node capabilities XML, so perhaps
> virNodeGetSecurityModel(virConnectPtr).

Actually, this is a call to get the node information, so I think the name 
should be changed.

> On the other hand, we already have this info against the node,

Which came from the above call.

> and conceivably you could have a domain configured with a model
> that doesn't match the node's model, so an explicit per-domain
> call is right. In that scenario, could we just put the security
> model data into the security label struct and have a single API

The domain doesn't have a security label until it's running, and then it 
must match the node's model, so I'm not sure we need to change anything 
except the name of virDomainGetSecModel (to virNodeGetSecurityMode).


- James
-- 
James Morris 
<jmorris@namei.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
