Message-ID: <48BA1943.4090508@redhat.com>
Date: Sun, 31 Aug 2008 14:08:35 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Introduction" review
References: <48B4EAE2.302@redhat.com> <1219842715.5708.63.camel@moss-spartans.epoch.ncsc.mil> <48B63BAE.6030806@redhat.com> <alpine.LRH.1.10.0808281906300.22283@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0808281906300.22283@tundra.namei.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Thu, 28 Aug 2008, Murray McAllister wrote:
> 
>>>> * Help limit the damage done by configuration mistakes. An administrator
>>>> may forget to limit zone transfers when running ISC BIND; however, the
>>>> default SELinux context for zone files does not allow them to be updated
>>>> by zone transfers, or written to by named, the ISC BIND daemon, and other
>>>> subjects.
>> Someone mentioned "What is ISC BIND". I need to change this to a more simple
>> example.
> 
> You could use "DNS server", perhaps with a reference/link to an 
> explanation of what it is.

How about:

Help limit the damage done by configuration mistakes. Domain Name System 
(DNS)[1] servers can replicate information between each other. This is 
known as a zone transfer. Attackers can use zone transfers to update DNS 
servers with false information. When running the Berkeley Internet Name 
Domain (BIND)[2] DNS server on Fedora 10, even if an administrator 
forgets to limit which servers can perform a zone transfer, the default 
SELinux policy prevents zone files[3] from being updated by zone 
transfers, the BIND named daemon, and any other subjects.

>> SELinux is a Linux security module that is built into the Linux kernel. Part
>> of this module is the SELinux security server. The security server is driven
> 
> IMHO, "security server" is unnecessary jargon in a general explanation 
> context.  (The server part will likely confuse all who are not also 
> familiar microkernel design and related Flask/Flux history).
> 
> I tend to explain it along the lines of: security policy is loaded into 
> the kernel, and consulted when a security-relevant access is taking place.  
> SELinux will veto the access if it is not allowed by policy.
> 
> 
>> by loadable policy rules that define what access is allowed. When a subject
>> attempts to interact with an object, for example, a process opening a file, a
>> hook in the Linux kernel intercepts the system call the process makes to open
>> the file. The hook calls the security server to check if access...
> 
> Make it more concrete, e.g. when a process attempts to open a file, this 
> operation is intercepted in the kernel by SELinux.  If the operation is 
> allowed by policy, it is allowed to proceed, otherwise, it is blocked and 
> the application receives an error.
> 
> Generally, removing jargon and uncessary abstractions is the way to go.  
> There is already plenty of detailed technical documentation for those that 
> need to understand the internals.

How about:

SELinux is a Linux security module that is built into the Linux kernel. 
SELinux is driven by loadable policy rules. When security-relevant 
access is taking place, such as when a subject attempts to open an 
object, the operation is intercepted in the kernel by SELinux. If an 
SELinux policy rule allows the operation, it continues, otherwise, the 
operation is blocked and the subject receives an error.

SELinux decisions, such as allowing or disallowing access, are cached. 
This cache is known as the Access Vector Cache (AVC). This decreases how 
often SELinux policy rules need to be checked, which increases 
performance. SELinux policy rules have no affect if DAC rules deny 
access first.

Thanks for your help.

[1] http://en.wikipedia.org/wiki/Domain_Name_System
[2] http://www.isc.org/index.pl?/sw/bind/index.php
[3] Text files that include information, such as hostname to IP address 
mappings, that are used by DNS servers.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
