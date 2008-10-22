Date: Wed, 22 Oct 2008 20:23:45 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Daniel J Walsh <dwalsh@redhat.com>
cc: libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
In-Reply-To: <48FDDFBB.8020005@redhat.com>
Message-ID: <alpine.LRH.1.10.0810221858300.19361@tundra.namei.org>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <48FDDFBB.8020005@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Oct 2008, Daniel J Walsh wrote:

> Why do we care about the policy type?  Policy type is a fairly
> meaningless object.  If you are trying to figure out if the host machine
> is valid to run a virtual machine you should just check whether the type
> is valid on the machine,  That way if I define minimum policy with virt
> support on one host and targeted policy with virt support on another
> machine, both would work.  

We need a way to indicate how to interpret the meaning of labels, which 
may vary depending on how policy has been implemented and deployed within 
a specific administrative boundary.  Keep in mind also that this API needs 
to be useable with non-SELinux security schemes, although, in any case, 
just because a label is technically valid on a system, doesn't mean that 
the meaning is understood.  e.g. "virt_image_t:s0" on a targeted system 
could mean something radically different to "virt_image_t:s0" on an MLS 
system, where, say, "s0" might mean "top secret" instead of "nothing".

Perhaps we should call this element "doi" (Domain of Interpretation) 
instead of "policytype", in keeping with existing similar security 
labeling, and not tied in name to the SELinux polictype configuration 
variable.

I thought the SELinux policytype in this case would be a useful starting 
point for the DOI, although the truth is that this needs to be entirely 
administratively managed.  We can't predict where administrative security 
boundaries will be or how the user will represent them.  Possibile DOI 
schemes include domain name, policy package+version names, existing 
kerberos realms etc.

As this will be a long-lasting API, we need to build support for DOI in 
now, and annotate where the DOI should be considered.  e.g.

- A server should only launch a domain if the domain's label is bound to a 
  an appropriate DOI;

- When displaying security labels remotely, the DOI bound to the label 
  should be displayed with the label (or translate the label, if
  appropriate).

For a default value, I suggest we use the string "local", which means that 
the label only has significance on the local system where the domain is 
running.  Anything beyond that needs to be explicitly configured by the 
admin.

> Finally I think it might be ok for the administrator to request that 
> this virtual machine would only run on a machine with SELinux in 
> enforcing mode. For example if you had a fairly untrusted virtual 
> machine you would want to ensure that the machine was enforcing SELinux 
> before it got started.

Ok, so the domain configuration could have an element like:

  <enforce>yes</enforce>

which means that label security policy must be applied.

The security label for the domain would now look like:

  <seclabel model='selinux'>
    <label>system_u:system_r:virtd_t:s0</label>
    <doi>local</doi>
    <enforce>no</enforce>
  </seclabel>



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
