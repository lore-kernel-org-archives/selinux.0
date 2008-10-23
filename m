From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC] sVirt v0.10 - initial prototype
Date: Thu, 23 Oct 2008 08:05:39 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>, libvir-list@redhat.com,
        "Daniel P. Berrange" <berrange@redhat.com>,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <48FDDFBB.8020005@redhat.com> <alpine.LRH.1.10.0810221858300.19361@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810221858300.19361@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810230805.39558.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 22 October 2008 5:23:45 am James Morris wrote:
> On Tue, 21 Oct 2008, Daniel J Walsh wrote:
> > Why do we care about the policy type?  Policy type is a fairly
> > meaningless object.  If you are trying to figure out if the host
> > machine is valid to run a virtual machine you should just check
> > whether the type is valid on the machine,  That way if I define
> > minimum policy with virt support on one host and targeted policy
> > with virt support on another machine, both would work.
>
> We need a way to indicate how to interpret the meaning of labels,
> which may vary depending on how policy has been implemented and
> deployed within a specific administrative boundary.  Keep in mind
> also that this API needs to be useable with non-SELinux security
> schemes, although, in any case, just because a label is technically
> valid on a system, doesn't mean that the meaning is understood.  e.g.
> "virt_image_t:s0" on a targeted system could mean something radically
> different to "virt_image_t:s0" on an MLS system, where, say, "s0"
> might mean "top secret" instead of "nothing".
>
> Perhaps we should call this element "doi" (Domain of Interpretation)
> instead of "policytype", in keeping with existing similar security
> labeling, and not tied in name to the SELinux polictype configuration
> variable.
>
> I thought the SELinux policytype in this case would be a useful
> starting point for the DOI, although the truth is that this needs to
> be entirely administratively managed.  We can't predict where
> administrative security boundaries will be or how the user will
> represent them.  Possibile DOI schemes include domain name, policy
> package+version names, existing kerberos realms etc.

I like the concept of a DOI field instead of policy type; considering 
the portability of guest images this seems like a good solution based 
on the relative success of DOIs in other distributed applications.

However, may I suggest that instead of representing the DOI as a string 
we use a 32bit integer?  I know that may sound a bit odd, but in the 
networking world most DOI values are represented as integers and when 
security labels are involved they tend to be 32bits.  I understand that 
using a plain integer is much more abstract than a human readable 
string but it should make it easier to leverage existing and future* 
DOI frameworks.

*An informal group/list just formed to start discussing DOI management 
issues such as DOI formats, negotiation and translation.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
