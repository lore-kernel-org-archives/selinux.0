Date: Wed, 22 Oct 2008 21:05:37 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
cc: Daniel J Walsh <dwalsh@redhat.com>, libvir-list@redhat.com,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
In-Reply-To: <20081022100357.GB24340@redhat.com>
Message-ID: <alpine.LRH.1.10.0810222105110.19361@tundra.namei.org>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <48FDDFBB.8020005@redhat.com> <20081021162217.GN16442@redhat.com> <alpine.LRH.1.10.0810222025070.19361@tundra.namei.org> <20081022100357.GB24340@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 22 Oct 2008, Daniel P. Berrange wrote:


> I think to start with we probably just assume a single security
> labelling model per hypervisor connection. If a single host
> happened to have multiple models, I believe each model would
> likely be scoped to a specific hypervisor on the host.

I would expect that, too.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
