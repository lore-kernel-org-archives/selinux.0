Date: Wed, 29 Oct 2008 08:42:17 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Daniel J Walsh <dwalsh@redhat.com>, libvir-list@redhat.com,
        "Daniel P. Berrange" <berrange@redhat.com>,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
In-Reply-To: <200810230805.39558.paul.moore@hp.com>
Message-ID: <alpine.LRH.1.10.0810290836010.25230@tundra.namei.org>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <48FDDFBB.8020005@redhat.com> <alpine.LRH.1.10.0810221858300.19361@tundra.namei.org> <200810230805.39558.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 23 Oct 2008, Paul Moore wrote:

> However, may I suggest that instead of representing the DOI as a string 
> we use a 32bit integer?  I know that may sound a bit odd, but in the 
> networking world most DOI values are represented as integers and when 
> security labels are involved they tend to be 32bits.  I understand that 
> using a plain integer is much more abstract than a human readable 
> string but it should make it easier to leverage existing and future* 
> DOI frameworks.

I'd prefer to use string, which can be managed freely by the user, and be 
human-readable.  Unlike IP layer networking, we're not constrained by e.g. 
having to fit in the IP options, and can simply convey the DOI as-is.

This will also not prevent users from utilizing integers as the DOI if 
desired.

In the common non-DoD case, people should be able to configure the DOI as 
simply as editing a configuration file to set the DOI to a domain name or 
arbitrary realm name.


> *An informal group/list just formed to start discussing DOI management 
> issues such as DOI formats, negotiation and translation.

URL ?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
