Date: Wed, 3 Jul 2002 12:48:26 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: udp receive
In-Reply-To: <1025714377.3620.18.camel@phobos>
Message-ID: <Pine.GSO.4.33.0207031237310.29509-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 3 Jul 2002, Timothy Wood wrote:

> avc:  denied  { recvfrom } for  pid=1791 exe=/usr/sbin/rpc.rquotad
> saddr=127.0.0.1 source=696 daddr=127.0.0.1 dest=111 netif=lo
> scontext=system_u:system_r:portmap_t tcontext=root:sysadm_r:sysadm_t
> tclass=udp_socket
<snip>
> It looks to me like it's loopback between the rpc quota daemon and the
> portmapper.

In this case, the current process information is unreliable, since this
check is performed during network input processing.  You can see from the
pair of contexts that rpc.rquotad isn't truly the relevant process, since
neither context has the rpcd_t type.  What you really want to add is
can_udp_send($1_t, portmap_t) to macros/user_macros.te.

> Is there a template I could use or could someone please explain how to
> go about creating a new domain?  I understand how to do some basic
> modifications so far but I'm no expert yet.  Thanks

The Configuring the SELinux Policy report includes a very brief
introduction to creating new domains in the Creating a New Domain
subsection of the Customizing the Policy section.  The easiest approach is
to use one of the existing domains as a template.  You may want to use
Russell Coker's daemon_domain macro (in global_macros.te) to get started.
The recently posted samba domains were reworked to use that macro, as you
can see from Ryan Bergauer's postings.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
