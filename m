Date: Thu, 30 Oct 2008 08:51:03 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
cc: Daniel J Walsh <dwalsh@redhat.com>, libvir-list@redhat.com,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
In-Reply-To: <20081021162217.GN16442@redhat.com>
Message-ID: <alpine.LRH.1.10.0810300845290.3314@tundra.namei.org>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <48FDDFBB.8020005@redhat.com> <20081021162217.GN16442@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Oct 2008, Daniel P. Berrange wrote:

> eg perhaps something like
> 
> # virsh capabilities 
> <capabilities>
> 
>   <host>
>     <cpu>
>       <arch>i686</arch>
>     </cpu>
>     <secpolicy model='selinux'>
>        <type>targetted</type>
>        <state>enforcing</state>
>     </secpolicy>
>   </host>
> 
>   .... snip rest of XML...

I don't think the endforcing state for the host will be useful, as this 
can change between API calls, and it really needs to be enforced on the 
host at the time of domain instantiation.

> Is there any meaningful / useful policy version information that can
> be included here ? Or policy feature bits

Possibly, although I think we should leave the configuration of DOI to the 
admin, rather than trying to figure out what might be useful in advance.  
In some cases, the admin may wish to use an RPM package+version string, 
and others, a domain name could indicate that each system is managed 
within an boundary with consistent label semantics.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
